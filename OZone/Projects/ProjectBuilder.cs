using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Xml.Xsl;
using OZone.Programs;
using System.Xml;
using System.Drawing;
using System.Xml.XPath;

namespace OZone.Projects
{
	public static class ProjectBuilder
	{
		public static void Clean(Project project)
		{
			if(Directory.Exists(project.Name))
				Directory.Delete(project.Name, true);
		}

		public static void Build(Project project)
		{
			var build = new List<ProjectFile>();

			// Find Files
			foreach(var transform in project.Transforms)
			{
				if(!File.Exists(transform.Path))
				{
					foreach(var path in project.Paths.Select(p => Path.Combine(p, transform.Path)))
					{
						if(File.Exists(path))
						{
							transform.Path = path;

							break;
						}
					}
				}
			}

			foreach(var file in project.Files)
			{
				if(!File.Exists(file.Path))
				{
					foreach(var path in project.Paths.Select(p => Path.Combine(p, file.Path)))
					{
						if(File.Exists(path))
						{
							file.Path = path;

							break;
						}
					}
				}
			}

			var transformTimestamp = project.Transforms.Max(t => File.GetLastWriteTime(t.Path));

			foreach(var file in project.Files)
			{
				if(File.Exists(file.OutputPath))
				{
					var sourceTimestamp = File.GetLastWriteTime(file.Path);
					var outputTimestamp = File.GetLastWriteTime(file.OutputPath);

					if(outputTimestamp >= transformTimestamp &&
						outputTimestamp >= sourceTimestamp)
						continue;
				}

				build.Add(file);
			}

			if(build.Count != 0)
			{
				var settings = new XmlWriterSettings
				{
					Indent = true,
					IndentChars = "\t",
				};

				// Build Files
				var transforms = project.Transforms.Select(t => new Tuple<ProjectTransform, XslCompiledTransform>(t, LoadTransform(t.Path)))
					.ToLookup(t => t.Item1.Namespace, t => t.Item2);

				var buildErrors = new List<Tuple<string, Exception>>();

				build.AsParallel().ForAll(file =>
				{
					var folder = Path.GetDirectoryName(file.OutputPath);

					if(!Directory.Exists(folder))
						Directory.CreateDirectory(folder);

					switch(file.Type)
					{
						case ProjectFileType.Program:
						case ProjectFileType.Class:
							Console.WriteLine("Building " + Path.GetFileName(file.Path));

							using(var reader = XmlReader.Create(file.Path))
							using (var writer = XmlWriter.Create(file.OutputPath, settings))
							{
								try
								{
									ProgramBuilder.Build(reader, writer, transforms);
								}
								catch (Exception e)
								{
									writer.Close();

									File.Delete(file.OutputPath);

									buildErrors.Add(new Tuple<string, Exception>(Path.GetFileName(file.Path), e));
								}
							}

							break;
							
						case ProjectFileType.Image:
							Console.WriteLine("Building " + Path.GetFileName(file.Path));

							Bitmap bitmap = new Bitmap(Image.FromFile(file.Path, true));

							using(var memory = new MemoryStream())
							using(var writer = XmlWriter.Create(memory))
							{
								writer.WriteStartElement("image", "http://metalx.org/Image");
								writer.WriteAttributeString("name", Path.GetFileName(file.Path));
								writer.WriteAttributeString("width", bitmap.Width.ToString());
								writer.WriteAttributeString("height", bitmap.Height.ToString());

								for(int y = 0; y < bitmap.Height; y++)
								{
									for(int x = 0; x < bitmap.Width; x++)
									{
										var pixel = bitmap.GetPixel(x, y);

										writer.WriteStartElement("pixel");

										writer.WriteAttributeString("red", pixel.R.ToString());
										writer.WriteAttributeString("green", pixel.G.ToString());
										writer.WriteAttributeString("blue", pixel.B.ToString());
										writer.WriteAttributeString("alpha", pixel.A.ToString());

										writer.WriteEndElement();
									}
								}
								
								writer.WriteEndElement();
								writer.Flush();
								writer.Close();

								//writer.WriteStartElement("scope", "http://metalx.org/Program");

								//writer.WriteElementString("int", bitmap.Width.ToString());
								//writer.WriteElementString("int", bitmap.Height.ToString());

								//for(int y = 0; y < bitmap.Height; y++)
								//{
								//    for(int x = 0; x < bitmap.Width; x++)
								//    {
								//        var pixel = bitmap.GetPixel(x, y);

								//        writer.WriteElementString("byte", pixel.B.ToString());
								//        writer.WriteElementString("byte", pixel.G.ToString());
								//        writer.WriteElementString("byte", pixel.R.ToString());
								//        writer.WriteElementString("byte", pixel.A.ToString());
								//    }
								//}

								//writer.WriteEndElement();

								memory.Position = 0;

								using(var reader = XmlReader.Create(memory))
								using(var writer2 = XmlWriter.Create(file.OutputPath, settings))
									ProgramBuilder.Build(reader, writer2, transforms);
							}

							break;
					}
				});

				if (buildErrors.Any())
					throw new Exception(string.Join("\r\n", buildErrors.Select(e => e.Item1 + " : " + e.Item2.Message)));
			}
		}

		private static XslCompiledTransform LoadTransform(string path)
		{
			var compiledTransform = new XslCompiledTransform(false);

			compiledTransform.Load(path);

			return compiledTransform;
		}

		private static XmlDocument LoadDocument(string path)
		{
			var document = new XmlDocument();

			document.Load(path);

			return document;
		}

		private static XslCompiledTransform LoadTransform(XmlDocument document)
		{
			var compiledTransform = new XslCompiledTransform(false);

			compiledTransform.Load(document.CreateNavigator());

			return compiledTransform;
		}
	}
}
