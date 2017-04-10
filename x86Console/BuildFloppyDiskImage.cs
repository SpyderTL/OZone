using System;
using System.IO;
using System.Xml;
using OZone.Programs;
using OZone.Projects;
using System.Xml.Linq;

namespace x86Console
{
	internal static class BuildFloppyDiskImage
	{
		internal static void Main(string[] args)
		{
			var project = ProjectReader.Read("../../ProjectFd.xml");

			ProjectBuilder.Clean(project);

			ProjectBuilder.Build(project);

			var image = new FloppyDiskImage();

			foreach(var program in project.Files)
			{
				if(program.Address == null)
					image.Add(ProgramReader.Read(XDocument.Load(program.OutputPath)));
				else if(program.Block == null)
					image.Add(ProgramReader.Read(XDocument.Load(program.OutputPath)), program.Address);
				else
					image.Add(ProgramReader.Read(XDocument.Load(program.OutputPath)), program.Address, program.Block.Value);
			}

			// Save Disk Image
			Console.WriteLine("Writing x86Console.img");

			using(Stream stream = File.Create("x86Console.img"))
				image.Save(stream);
		}
	}
}
