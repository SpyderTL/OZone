using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Xml;
using System.Xml.Linq;
using OZone.Programs;
using OZone.Projects;
using x86Desktop32.Images;

namespace x86Desktop32
{
	internal static class BuildFloppyDiskImage
	{
		internal static void Main(string[] args)
		{
			var project = ProjectReader.Read("../../Projects/ProjectFd.xml");

			ProjectBuilder.Clean(project);

			var image = new FloppyDiskImage();

			ProjectBuilder.Build(project);

			foreach(var file in project.Files)
			{
				if(file.Address == MemoryAddress.Zero)
					image.Add(ProgramReader.Read(XDocument.Load(file.OutputPath)));
				else if(file.Block == null)
					image.Add(ProgramReader.Read(XDocument.Load(file.OutputPath)), file.Address);
				else
					image.Add(ProgramReader.Read(XDocument.Load(file.OutputPath)), file.Address, file.Block.Value);
			}

			// Save Disk Image
			Console.WriteLine("Writing x86Desktop32.img");

			using(Stream stream = File.Create("x86Desktop32.img"))
				image.Save(stream);
		}
	}
}