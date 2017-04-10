using System;
using System.IO;
using OZone.Programs;
using OZone.Projects;
using System.Xml.Linq;

namespace x86Console64
{
	internal static class BuildCdImage
	{
		internal static void Main(string[] args)
		{
			var project = ProjectReader.Read("../../Projects/ProjectCd.xml");

			ProjectBuilder.Clean(project);

			ProjectBuilder.Build(project);

			var image = new CdImage();

			foreach(var program in project.Files)
			{
				var filename = program.OutputPath;

				try
				{
					if(program.Address == null)
						image.Add(ProgramReader.Read(XDocument.Load(filename, LoadOptions.SetLineInfo)));
					else if(program.Block == null)
						image.Add(ProgramReader.Read(XDocument.Load(filename, LoadOptions.SetLineInfo)), program.Address);
					else
						image.Add(ProgramReader.Read(XDocument.Load(filename, LoadOptions.SetLineInfo)), program.Address, program.Block.Value);
				}
				catch(Exception e)
				{
					throw new Exception("Error Reading File: " + filename + "\r\n" + e.Message, e);
				}
			}

			// Save Disk Image
			Console.WriteLine("Writing x86Console64.iso");

			using(Stream stream = File.Create("x86Console64.iso"))
				image.Save(stream);
		}
	}
}
