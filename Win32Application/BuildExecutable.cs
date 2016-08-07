using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using OZone.Programs;
using System.Xml.Xsl;
using System.Xml;
using OZone.Projects;
using System.Xml.Linq;

namespace Win32Application
{
	internal static class BuildDiskImage
	{
		internal static void Main(string[] args)
		{
			var project = ProjectReader.Read("../../Project.xml");

			ProjectBuilder.Clean(project);

			ProjectBuilder.Build(project);

			// Save Executable
			Console.WriteLine("Writing test.exe");

			using(Stream stream = File.Create("test.exe"))
			using(BinaryWriter writer = new BinaryWriter(stream))
			{
				foreach(var program in project.Files)
				{
					//var filename = Path.Combine(project.Name, Path.GetFileName(program.Path) + ".program");

					ProgramCompiler.Compile(
						ProgramReader.Read(XDocument.Load(program.OutputPath)),
						program.Address,
						writer);
				}
			}
		}
	}
}
