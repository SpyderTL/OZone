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

			foreach(var file in project.Files)
			{
				var filename = file.OutputPath;

				if(file.Address == MemoryAddress.Zero)
					image.Add(ProgramReader.Read(XDocument.Load(filename)));
				else if(file.Block == null)
					image.Add(ProgramReader.Read(XDocument.Load(filename)), file.Address);
				else
					image.Add(ProgramReader.Read(XDocument.Load(filename)), file.Address, file.Block.Value);
			}

			// Save Disk Image
			Console.WriteLine("Writing x86Console32.img");

			using(Stream stream = File.Create("x86Console32.img"))
				image.Save(stream);
		}
	}
}
