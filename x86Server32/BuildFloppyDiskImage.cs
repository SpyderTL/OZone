using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Xml;
using System.Xml.Linq;
using System.Xml.Xsl;
using OZone.Programs;
using OZone.Projects;

namespace x86Server32
{
	internal static class BuildFloppyDiskImage
	{
		internal static void Main(string[] args)
		{
			var project = ProjectReader.Read("../../Project.xml");

			ProjectBuilder.Clean(project);

			ProjectBuilder.Build(project);

			FloppyDiskImage image = new FloppyDiskImage();

			foreach(var program in project.Files)
			{
				var filename = program.OutputPath;

				if(program.Address == null)
					image.Add(ProgramReader.Read(XDocument.Load(filename)));
				else if(program.Block == null)
					image.Add(ProgramReader.Read(XDocument.Load(filename)), program.Address);
				else
					image.Add(ProgramReader.Read(XDocument.Load(filename)), program.Address, program.Block.Value);
			}

			// Save Disk Image
			Console.WriteLine("Writing x86Server32.img");

			using(Stream stream = File.Create("x86Server32.img"))
				image.Save(stream);
		}
	}
}
