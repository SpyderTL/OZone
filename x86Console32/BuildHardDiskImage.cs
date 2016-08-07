using System;
using System.IO;
using System.Xml.Linq;
using OZone.Programs;
using OZone.Projects;

namespace x86Console32
{
	internal static class BuildHardDiskImage
	{
		internal static void Main(string[] args)
		{
			var project = ProjectReader.Read("../../Projects/ProjectHd.xml");

			//ProjectBuilder.Clean(project);

			ProjectBuilder.Build(project);

			var image = new HardDiskImage();

			foreach(var file in project.Files)
			{
				var filename = file.OutputPath;

				try
				{
					var document = XDocument.Load(filename, LoadOptions.SetLineInfo);

					var program = ProgramReader.Read(document);

					program.Name = file.Path;

					if(file.Address == MemoryAddress.Zero)
						image.Add(program);
					else if(file.Block == null)
						image.Add(program, file.Address);
					else
						image.Add(program, file.Address, file.Block.Value);
				}
				catch(Exception e)
				{
					throw new Exception("Error Reading File: " + filename + "\r\n" + e.Message, e);
				}
			}

			// Save Disk Image
			Console.WriteLine("Writing x86Console32.hdd");

			using(Stream stream = File.Create("x86Console32.hdd"))
				image.Save(stream);
		}
	}
}
