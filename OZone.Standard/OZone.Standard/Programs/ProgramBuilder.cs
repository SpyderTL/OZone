using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Xml.Linq;
using System.Diagnostics;
using System.Xml;
using System.Xml.Xsl;
using System.Xml.XPath;

namespace OZone.Programs
{
	public static class ProgramBuilder
	{
		//[DebuggerHidden]
		public static Program Build(string programFile, params string[] transformFiles)
		{
			MemoryStream input;
			MemoryStream output;

			XmlReader reader = XmlReader.Create(programFile);
			XmlWriter writer;

			var compiledTransform = new XslCompiledTransform();
			var settings = new XmlWriterSettings
			{
				Indent = true,
				IndentChars = "\t",
			};

			for (int transform = 0; transform < transformFiles.Length; transform++)
			{
				try
				{
					output = new MemoryStream();
					writer = XmlWriter.Create(output, settings);

					compiledTransform.Load(transformFiles[transform]);
					compiledTransform.Transform(reader, writer);

					input = output;
					input.Position = 0;

					reader = XmlReader.Create(input);
				}
				catch (Exception e)
				{
					throw new Exception("Error transforming file: " + transformFiles[transform] + "\r\n" + e.Message, e);
				}
			}

			XDocument document = XDocument.Load(reader);

			return ProgramReader.Read(document);
		}

		private static XslCompiledTransform LoadTransform(string path)
		{
			var compiledTransform = new XslCompiledTransform(false);

			compiledTransform.Load(path);

			return compiledTransform;
		}

		public static Program Build(string programFile, IEnumerable<KeyValuePair<string, string>> transformFiles)
		{
			var source = new XmlDocument();
			source.Load(programFile);

			var transformNamespaces = transformFiles.Select(t => new KeyValuePair<string, XslCompiledTransform>(t.Key, LoadTransform(t.Value))).ToArray();

			var destination = source;

			var namespaces = FindNamespaces(source);

			var pass = 0;

			while (namespaces.Length != 0)
			{
				if (pass++ == 255)
					throw new Exception("Unhandled element (<" + FindUnhandledTags(source)[0] + ">)");

				foreach (var name in namespaces)
				{
					if (!transformNamespaces.Any(n => string.Equals(n.Key, name)))
						throw new Exception("Unrecognized namespace (" + name + ")");

					foreach (var transform in transformNamespaces.Where(n => string.Equals(n.Key, name)))
					{
						destination = new XmlDocument();

						using (var writer2 = destination.CreateNavigator().AppendChild())
						{
							transform.Value.Transform(source.CreateNavigator(), writer2);

							writer2.Flush();
						}

						source = destination;
					}
				}

				namespaces = FindNamespaces(source);
			}

			//source.Save(writer);

			//XDocument document = XDocument.Load(reader);

			var document = XDocument.Load(source.CreateNavigator().ReadSubtree());

			return ProgramReader.Read(document);
		}

		//[DebuggerHidden]
		//public static Program Build(XmlReader reader, IEnumerable<XslCompiledTransform> transforms)
		//{
		//	MemoryStream input;
		//	MemoryStream output;

		//	XmlWriter writer;
		//	var settings = new XmlWriterSettings
		//	{
		//		Indent = true,
		//		IndentChars = "\t",
		//	};

		//	foreach(var transform in transforms)
		//	{
		//		try
		//		{
		//			output = new MemoryStream();
		//			writer = XmlWriter.Create(output, settings);

		//			transform.Transform(reader, writer);

		//			input = output;
		//			input.Position = 0;

		//			reader = XmlReader.Create(input);
		//		}
		//		catch(Exception e)
		//		{
		//			throw new Exception("Error transforming file:\r\n" + e.Message, e);
		//		}
		//	}

		//	XDocument document = XDocument.Load(reader);

		//	return ProgramReader.Read(document);
		//}

		//[DebuggerHidden]
		//public static void Build(XmlReader reader, XmlWriter writer, IEnumerable<KeyValuePair<string, XslCompiledTransform>> transforms)
		//{
		//	MemoryStream input = null;
		//	MemoryStream output = null;

		//	XmlWriter writer2;
		//	var settings = new XmlWriterSettings
		//	{
		//		Indent = true,
		//		IndentChars = "\t",
		//	};

		//	foreach(var transform in transforms)
		//	{
		//		try
		//		{
		//			output = new MemoryStream();
		//			writer2 = XmlWriter.Create(output, settings);

		//			transform.Value.Transform(reader, writer2);

		//			if(input != null)
		//				input.Dispose();

		//			input = output;
		//			input.Position = 0;

		//			reader = XmlReader.Create(input);
		//		}
		//		catch(Exception e)
		//		{
		//			throw new Exception("Error transforming file: " + transform.Key + "\r\n" + e.Message, e);
		//		}
		//	}

		//	XDocument.Load(reader).Save(writer);
		//}

		//[DebuggerHidden]
		public static void Build(XmlReader reader, XmlWriter writer, ILookup<string, XslCompiledTransform> transformNamespaces)
		{
			var source = new XmlDocument();
			source.Load(reader);

			var destination = source;

			var namespaces = FindNamespaces(source);

			var pass = 0;

			while(namespaces.Length != 0)
			{
				if(pass++ == 255)
					throw new Exception("Unhandled element (<" + FindUnhandledTags(source)[0] + ">)");

				foreach(var name in namespaces)
				{
					if(!transformNamespaces.Contains(name))
						throw new Exception("Unrecognized namespace (" + name + ")");

					foreach(var transform in transformNamespaces[name])
					{
						destination = new XmlDocument();

						using(var writer2 = destination.CreateNavigator().AppendChild())
						{
							transform.Transform(source.CreateNavigator(), writer2);

							writer2.Flush();
						}

						source = destination;
					}
				}

				namespaces = FindNamespaces(source);
			}

			source.Save(writer);
		}

		private static string[] FindNamespaces(XmlDocument document)
		{
			//var nodes = document.SelectNodes("//*/namespace::*");

			//return nodes.Cast<XmlNode>().Select(n => n.Value)
			//    .Distinct()
			//    .Where(n => !string.Equals(n, "http://metalx.org/Program") &&
			//        !string.Equals(n, "http://www.w3.org/2000/xmlns/") &&
			//        !string.Equals(n, "http://www.w3.org/XML/1998/namespace")).ToArray();

			var names = new List<string>();

			var reader = new XmlNodeReader(document);

			while(reader.Read())
				if(!string.IsNullOrWhiteSpace(reader.NamespaceURI) &&
					!string.Equals(reader.NamespaceURI, "http://metalx.org/Program") &&
					!string.Equals(reader.NamespaceURI, "http://www.w3.org/2000/xmlns/") &&
					!string.Equals(reader.NamespaceURI, "http://www.w3.org/XML/1998/namespace"))
					if(!names.Contains(reader.NamespaceURI))
						names.Add(reader.NamespaceURI);

			return names.ToArray();
		}

		private static string[] FindUnhandledTags(XmlDocument document)
		{
			//var nodes = document.SelectNodes("//*/namespace::*");

			//return nodes.Cast<XmlNode>().Select(n => n.Value)
			//    .Distinct()
			//    .Where(n => !string.Equals(n, "http://metalx.org/Program") &&
			//        !string.Equals(n, "http://www.w3.org/2000/xmlns/") &&
			//        !string.Equals(n, "http://www.w3.org/XML/1998/namespace")).ToArray();

			var tags = new List<string>();

			var reader = new XmlNodeReader(document);

			while(reader.Read())
				if(!string.IsNullOrWhiteSpace(reader.NamespaceURI) &&
					!string.Equals(reader.NamespaceURI, "http://metalx.org/Program") &&
					!string.Equals(reader.NamespaceURI, "http://www.w3.org/2000/xmlns/") &&
					!string.Equals(reader.NamespaceURI, "http://www.w3.org/XML/1998/namespace"))
					if(!tags.Contains(reader.NamespaceURI))
						tags.Add(reader.Name);

			return tags.ToArray();
		}
	}
}