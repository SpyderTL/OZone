using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OZone.Programs;
using System.Xml;
using System.IO;
using OZone.Projects;
using System.Xml.Linq;

namespace x86Desktop
{
	internal class Program
	{
		internal static void Main(string[] args)
		{
			var project = ProjectReader.Read("../../Project.xml");

			ProjectBuilder.Clean(project);

			ProjectBuilder.Build(project);

			DiskImage image = new DiskImage();

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
			Console.WriteLine("Writing x86Desktop.img");

			using(Stream stream = File.Create("x86Desktop.img"))
				image.Save(stream);
		}
	}
}
