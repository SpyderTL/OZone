using System;
using System.IO;
using System.Xml;
using OZone.Programs;
using OZone.Projects;
using System.Xml.Linq;

namespace x86Console
{
	internal static class BuildCdImage
	{
		internal static void Main(string[] args)
		{
			var project = ProjectReader.Read("../../../ProjectCd.xml");

			//ProjectBuilder.Clean(project);

			ProjectBuilder.Build(project);

			var image = new CdImage();

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
			Console.WriteLine("Writing x86Console.iso");

			using(Stream stream = File.Create("x86Console.iso"))
				image.Save(stream);
		}
	}
}
