using OZone.Projects;
using OZone.Programs.Compilers;
using OZone.Programs;
using System.Xml.Linq;

namespace Win64Console
{
	internal class Program
	{
		static void Main(string[] args)
		{
			var project = ProjectReader.Read("../../../Project.xml");

			ProjectBuilder.Clean(project);

			ProjectBuilder.Build(project);

			// Save Executable
			Console.WriteLine("Writing Win64Console.exe");

			var compiler = new BinaryCompiler();
			var position = new MemoryAddress { Offset = 0x00400000 };

			using (Stream stream = File.Create("Console.exe"))
			using (BinaryWriter writer = new BinaryWriter(stream))
			{
				var programs = new List<OZone.Programs.Program>();
				var exports = new Dictionary<string, Label>();

				exports["Project.Start"] = new Label { Address = new MemoryAddress { Offset = position.Offset } };

				foreach (var file in project.Files)
				{
					var program = ProgramReader.Read(XDocument.Load(file.OutputPath));
					program.Name = Path.GetFileName(file.Path);

					if (file.Address == null)
						file.Address = position;

					compiler.Compile(
						program,
						file.Address);

					position.Offset += (uint)program.Segments.Sum(x => compiler.GetLength(x));

					programs.Add(program);

					foreach (var label in program.Segments.OfType<Label>())
						if (label.Export != null)
							exports[label.Export] = label;
				}

				exports["Project.End"] = new Label { Address = new MemoryAddress { Offset = position.Offset } };

				foreach (var program in programs)
					compiler.Link(program, exports);

				// TODO: Write Out XML Files w/ Addresses
				// TODO: Transform XML Files

				foreach (var program in programs)
					compiler.Write(program, writer);

				foreach (var program in programs)
				{
					var segments = GetProgramSegments(program.Segments);

					File.WriteAllLines($"{program.Name}_Labels.txt", segments.OfType<Label>().Select(x => $"{x.Address.Offset:X8}\t{x.Id}")); 
				}

				File.WriteAllLines("Exports.txt", exports.Select(x => $"{x.Value.Address.Offset:X8}\t{x.Key}"));
			}
		}

		private static IEnumerable<ProgramSegment> GetProgramSegments(IEnumerable<ProgramSegment> segments)
		{
			foreach (var segment in segments)
			{
				yield return segment;

				if (segment is Scope scope)
				{
					foreach (var segment2 in GetProgramSegments(scope.Segments))
						yield return segment2;
				}
			}
		}
	}
}