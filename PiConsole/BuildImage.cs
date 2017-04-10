using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Xml.Linq;
using OZone.Programs;
using OZone.Projects;

namespace PiConsole
{
	internal class BuildImage
	{
		internal static void Main(string[] args)
		{
			var project = ProjectReader.Read("../../Project.xml");

			//ProjectBuilder.Clean(project);

			ProjectBuilder.Build(project);

			var image = new KernelImage();

			foreach(var program in project.Files)
			{
				//var filename = Path.Combine(project.Name, Path.GetFileName(program.Path) + ".program");
				var filename = program.OutputPath;

				try
				{
					if(program.Address == null)
						image.Add(ProgramReader.Read(XDocument.Load(filename, LoadOptions.SetLineInfo)));
					else if(program.Block == null)
						image.Add(ProgramReader.Read(XDocument.Load(filename, LoadOptions.SetLineInfo)), program.Address);
				}
				catch(Exception e)
				{
					throw new Exception("Error Reading File: " + filename + "\r\n" + e.Message, e);
				}
			}

			// Save Disk Image
			Console.WriteLine("Writing kernel.img");

			using(Stream stream = File.Create("kernel.img"))
				image.Save(stream);
		}
	}
}
