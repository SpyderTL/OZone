using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using OZone.Programs;
using OZone.Programs.Compilers;
using OZone.Projects;

namespace x86Kernel
{
	class Program
	{
		static void Main(string[] args)
		{
			var project = ProjectReader.Read("../../../Projects/ProjectFd.xml");

			var transforms = new List<KeyValuePair<string, string>>();

			foreach (var transform in project.Transforms)
			{
				foreach (var path in project.Paths)
				{
					if (File.Exists(Path.Combine(path, transform.Path)))
						transforms.Add(new KeyValuePair<string, string>(transform.Namespace, Path.Combine(path, transform.Path)));
				}
			}

			var compiler = new BinaryCompiler();
			var address = new MemoryAddress { Offset = 0x7c00 };

			using (Stream stream = File.Create("x86Kernel.img"))
			using (BinaryWriter writer = new BinaryWriter(stream))
			{
				var programs = new List<OZone.Programs.Program>();
				var exports = new Dictionary<string, Label>();

				foreach (var file in project.Files)
				{
					foreach (var path in project.Paths)
					{
						if (File.Exists(Path.Combine(path, file.Path)))
						{
							var program = ProgramBuilder.Build(Path.Combine(path, file.Path), transforms.ToArray());

							var length = compiler.Compile(program, address);

							address.Offset += length;

							programs.Add(program);

							foreach (var label in program.Segments.OfType<Label>())
								if (label.Export != null)
									exports[label.Export] = label;
						}
					}
				}

				foreach (var program2 in programs)
					compiler.Link(program2, exports);

				foreach (var program2 in programs)
					compiler.Write(program2, writer);

				writer.Flush();

				stream.SetLength(1474560);

				System.Diagnostics.Debug.WriteLine(writer.BaseStream.Position);
			}
		}
	}
}
