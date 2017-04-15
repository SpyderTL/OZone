using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;
using OZone.Programs;
using OZone.Programs.Compilers;
using OZone.Programs.Compilers.Subleq;
using OZone.Projects;
using SubleqConsole.Images;

namespace SubleqConsole
{
	class BuildFloppyDiskImage
	{
		static void Main(string[] args)
		{
			var project = ProjectReader.Read("../../Projects/ProjectFd.xml");

			ProjectBuilder.Clean(project);

			ProjectBuilder.Build(project);

			var image = new FloppyDiskImage();

			ProgramCompiler binaryCompiler = new BinaryCompiler();
			ProgramCompiler subleqCompiler = new SubleqCompiler32();

			foreach (var file in project.Files)
			{
				var filename = file.OutputPath;

				try
				{
					var document = XDocument.Load(filename, LoadOptions.SetLineInfo);

					var program = ProgramReader.Read(document);

					program.Name = file.Path;

					var compiler = file.Compiler == "Subleq" ? subleqCompiler : binaryCompiler;

					if (file.Address == null)
						image.Add(program, compiler);
					else if (file.Block == null)
						image.Add(program, compiler, file.Address);
					else
						image.Add(program, compiler, file.Address, file.Block.Value);
				}
				catch (Exception e)
				{
					throw new Exception("Error Reading File: " + filename + "\r\n" + e.Message, e);
				}
			}

			// Save Disk Image
			Console.WriteLine("Writing SubleqConsole.img");

			using (var stream = File.Create("SubleqConsole.img"))
				image.Save(stream);
		}
	}
}