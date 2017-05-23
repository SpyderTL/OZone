using System;
using System.IO;
using System.Xml;
using OZone.Programs;
using OZone.Projects;
using System.Xml.Linq;

namespace x86Console32
{
	internal static class BuildCdImage
	{
		internal static void Main(string[] args)
		{
			var project = ProjectReader.Read("../../Projects/ProjectCd.xml");

			//ProjectBuilder.Clean(project);

			ProjectBuilder.Build(project);

			var image = new CdImage();

			foreach(var file in project.Files)
			{
				var filename = file.OutputPath;

				try
				{
                    var document = XDocument.Load(filename, LoadOptions.SetLineInfo);

                    var program = ProgramReader.Read(document);

					program.Name = file.Path;

					if(file.Address == null)
						image.Add(program, file.Type == ProjectFileType.Class);
					else if(file.Block == null)
						image.Add(program, file.Address, file.Type == ProjectFileType.Class);
					else
						image.Add(program, file.Address, file.Block.Value, file.Type == ProjectFileType.Class);
				}
				catch(Exception e)
				{
					throw new Exception("Error Reading File: " + filename + "\r\n" + e.Message, e);
				}
			}

			// Save Disk Image
			Console.WriteLine("Writing x86Console32.iso");

			using(var stream = File.Create("x86Console32.iso"))
				image.Save(stream);
		}
	}
}
