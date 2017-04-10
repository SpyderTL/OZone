using System;
using System.IO;
using System.Xml.Linq;
using OZone.Programs;
using OZone.Projects;

namespace x86Console32
{
	internal static class BuildFloppyDiskImage
	{
		internal static void Main(string[] args)
		{
			var project = ProjectReader.Read("../../Projects/ProjectFd.xml");

			//ProjectBuilder.Clean(project);

			ProjectBuilder.Build(project);
				
			var image = new FloppyDiskImage();

			foreach (var file in project.Files)
			{
				var filename = file.OutputPath;

				try
				{
					var document = XDocument.Load(filename, LoadOptions.SetLineInfo);

					var program = ProgramReader.Read(document);

					program.Name = file.Path;

					if (file.Address == null)
						image.Add(program);
					else if (file.Block == null)
						image.Add(program, file.Address);
					else
						image.Add(program, file.Address, file.Block.Value);
				}
				catch (Exception e)
				{
					throw new Exception("Error Reading File: " + filename + "\r\n" + e.Message, e);
				}
			}

			// Save Disk Image
			Console.WriteLine("Writing x86Console32.img");

			using(Stream stream = File.Create("x86Console32.img"))
				image.Save(stream);
		}
	}
}
