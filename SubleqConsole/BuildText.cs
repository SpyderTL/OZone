using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;
using OZone.Programs;
using OZone.Programs.Compilers.Subleq;
using OZone.Projects;

namespace SubleqConsole
{
	class BuildText
	{
		static void Main(string[] args)
		{
			var project = ProjectReader.Read("../../Projects/ProjectText.xml");

			ProjectBuilder.Clean(project);

			ProjectBuilder.Build(project);

			var image = new List<OZone.Programs.Program>();

			foreach (var file in project.Files)
			{
				var filename = file.OutputPath;

				try
				{
					var document = XDocument.Load(filename, LoadOptions.SetLineInfo);

					var program = ProgramReader.Read(document);

					program.Name = file.Path;

					image.Add(program);
				}
				catch (Exception e)
				{
					throw new Exception("Error Reading File: " + filename + "\r\n" + e.Message, e);
				}
			}

			// Save Disk Image
			Console.WriteLine("Writing SubleqConsole.txt");

			using (var stream = File.Create("SubleqConsole.txt"))
			using (var writer = new StreamWriter(stream))
				foreach (var program in image)
					SubleqTextCompiler.Compile(program, new MemoryAddress(), writer);
		}
	}
}
