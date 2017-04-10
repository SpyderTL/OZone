using System;
using System.IO;
using System.Xml.Linq;
using OZone.Programs;
using OZone.Projects;

namespace x86Server32
{
	internal static class BuildHardDiskImage
	{
		internal static void Main(string[] args)
		{
			var project = ProjectReader.Read("../../ProjectHd.xml");

			//ProjectBuilder.Clean(project);

			ProjectBuilder.Build(project);

			var image = new HardDiskImage();

			foreach(var program in project.Files)
			{
				var filename = Path.Combine(project.Name, Path.GetFileName(program.Path) + ".program");

				if(program.Address == null)
					image.Add(ProgramReader.Read(XDocument.Load(filename)));
				else if(program.Block == null)
					image.Add(ProgramReader.Read(XDocument.Load(filename)), program.Address);
				else
					image.Add(ProgramReader.Read(XDocument.Load(filename)), program.Address, program.Block.Value);
			}

			// Save Disk Image
			Console.WriteLine("Writing x86Server32.hdd");

			using(Stream stream = File.Create("x86Server32.hdd"))
				image.Save(stream);
		}
	}
}
