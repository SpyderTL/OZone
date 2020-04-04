using OZone.Programs;
using OZone.Programs.Compilers;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace x16Console
{
	class BuildAudio
	{
		static void Main(string[] args)
		{
			var transformFiles = new KeyValuePair<string, string>[]
			{
				new KeyValuePair<string, string>("http://metalx.org/6502/Functions/Class", "../../../OZone/Functions/6502/Class.xslt"),
				new KeyValuePair<string, string>("http://metalx.org/6502/Functions/String", "../../../OZone/Functions/6502/String.xslt"),
				new KeyValuePair<string, string>("http://metalx.org/6502/Functions/MemoryManager", "../../../OZone/Functions/6502/MemoryManager.xslt"),
				new KeyValuePair<string, string>("http://metalx.org/Ansi/Ascii", "../../../OZone/Platforms/Ansi/Ascii/Ascii.xslt"),
				new KeyValuePair<string, string>("http://metalx.org/Variable", "../../../OZone/Structures/6502/Variable.xslt"),
				new KeyValuePair<string, string>("http://metalx.org/Class", "../../../OZone/Structures/6502/Class.xslt"),
				new KeyValuePair<string, string>("http://metalx.org/Mos/6502/Operators", "../../../OZone/Platforms/Mos/6502/Operators.xslt")
			};

			var compiler = new BinaryCompiler();
			var address = new MemoryAddress { Offset = 0x07ff };

			using (Stream stream = File.Create("x16Audio.prg"))
			using (BinaryWriter writer = new BinaryWriter(stream))
			{
				var programs = new List<Program>();
				var exports = new Dictionary<string, Label>();

				var program = ProgramBuilder.Build("../../x16Program.xml");

				var length = compiler.Compile(program, address);

				address.Offset += length;

				programs.Add(program);

				foreach (var label in program.Segments.OfType<Label>())
					if (label.Export != null)
						exports[label.Export] = label;

				program = ProgramBuilder.Build(
					"../../x16Audio.xml",
					transformFiles);

				length = compiler.Compile(program, address);

				address.Offset += length;

				programs.Add(program);

				foreach (var label in program.Segments.OfType<Label>())
					if (label.Export != null)
						exports[label.Export] = label;

				program = ProgramBuilder.Build(
					"../../Modules/File.xml",
					transformFiles);

				length = compiler.Compile(program, address);

				address.Offset += length;

				programs.Add(program);

				foreach (var label in program.Segments.OfType<Label>())
					if (label.Export != null)
						exports[label.Export] = label;

				program = ProgramBuilder.Build(
					"../../Modules/Console.xml",
					transformFiles);

				length = compiler.Compile(program, address);

				address.Offset += length;

				programs.Add(program);

				foreach (var label in program.Segments.OfType<Label>())
					if (label.Export != null)
						exports[label.Export] = label;

				program = ProgramBuilder.Build(
					"../../Modules/System.xml",
					transformFiles);

				length = compiler.Compile(program, address);

				address.Offset += length;

				programs.Add(program);

				foreach (var label in program.Segments.OfType<Label>())
					if (label.Export != null)
						exports[label.Export] = label;

				foreach (var program2 in programs)
					compiler.Link(program2, exports);

				foreach (var program2 in programs)
					compiler.Write(program2, writer);

				writer.Flush();

				System.Diagnostics.Debug.WriteLine(writer.BaseStream.Position);
			}
		}
	}
}
