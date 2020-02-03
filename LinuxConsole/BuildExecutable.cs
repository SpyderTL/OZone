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
using OZone.Programs.Compilers;

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

			var compiler = new BinaryCompiler();
			var position = new MemoryAddress { Offset = 0x00400000 };

			using (Stream stream = File.Create("test.exe"))
			using (BinaryWriter writer = new BinaryWriter(stream))
			{
				var programs = new List<Program>();
				var exports = new Dictionary<string, Label>();

				exports["Project.Start"] = new Label { Address = new MemoryAddress { Offset = position.Offset } };

				foreach (var file in project.Files)
				{
					var program = ProgramReader.Read(XDocument.Load(file.OutputPath));

					if (file.Address == null)
						file.Address = position;

					compiler.Compile(
						program,
						file.Address);

					compiler.Link(program, new Dictionary<string, Label>());

					position.Offset += (uint)program.Segments.Sum(x => compiler.GetLength(x));

					programs.Add(program);

					foreach (var label in program.Segments.OfType<Label>())
						if (label.Export != null)
							exports[label.Export] = label;
				}

				exports["Project.End"] = new Label { Address = new MemoryAddress { Offset = position.Offset } };

				foreach (var program in programs)
					compiler.Link(program, exports);

				foreach (var program in programs)
					compiler.Write(program, writer);
			}
		}
	}
}
