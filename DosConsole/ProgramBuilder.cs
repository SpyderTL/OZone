using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Xml.Linq;
using System.Diagnostics;
using System.Xml;
using System.Xml.Xsl;
using OZone.Programs;

namespace DosConsole
{
	public static class ProgramBuilder
	{
		[DebuggerHidden]
		public static Program Build(string programFile, params string[] transformFiles)
		{
			MemoryStream input;
			MemoryStream output;

			XmlReader reader = XmlReader.Create(programFile);
			XmlWriter writer;

			XslCompiledTransform compiledTransform = new XslCompiledTransform();

			for(int transform = 0; transform < transformFiles.Length; transform++)
			{
				try
				{
					output = new MemoryStream();
					writer = XmlWriter.Create(output);

					compiledTransform.Load(transformFiles[transform]);
					compiledTransform.Transform(reader, writer);

					input = output;
					input.Position = 0;

					reader = XmlReader.Create(input);
				}
				catch(Exception e)
				{
					throw new Exception("Error transforming file: " + transformFiles[transform] + "\r\n" + e.Message, e);
				}
			}

			XDocument document = XDocument.Load(reader);
			
			return ProgramReader.Read(document);
		}

		public static Program Build(XmlReader reader, IEnumerable<XslCompiledTransform> transforms)
		{
			MemoryStream input;
			MemoryStream output;

			XmlWriter writer;

			foreach(var transform in transforms)
			{
				try
				{
					output = new MemoryStream();
					writer = XmlWriter.Create(output);

					transform.Transform(reader, writer);

					input = output;
					input.Position = 0;

					reader = XmlReader.Create(input);
				}
				catch(Exception e)
				{
					throw new Exception("Error transforming file:\r\n" + e.Message, e);
				}
			}

			XDocument document = XDocument.Load(reader);

			return ProgramReader.Read(document);
		}

		public static void Build(XmlReader reader, XmlWriter writer, IEnumerable<XslCompiledTransform> transforms)
		{
			MemoryStream input = null;
			MemoryStream output = null;

			XmlWriter writer2;

			foreach(var transform in transforms)
			{
				try
				{
					output = new MemoryStream();
					writer2 = XmlWriter.Create(output);

					transform.Transform(reader, writer2);

					if(input != null)
						input.Dispose();

					input = output;
					input.Position = 0;

					reader = XmlReader.Create(input);
				}
				catch(Exception e)
				{
					throw new Exception("Error transforming file:\r\n" + e.Message, e);
				}
			}

			XDocument.Load(reader).Save(writer);
		}
	}
}