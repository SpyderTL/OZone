using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using OZone.Programs;
using OZone.Programs.Compilers;

namespace C64Audio
{
	class Program
	{
		static void Main(string[] args)
		{
			var transformFiles = new KeyValuePair<string, string>[]
			{
				new KeyValuePair<string, string>("http://metalx.org/Ansi/Ascii", "../../../OZone/Platforms/Ansi/Ascii/Ascii.xslt"),
				new KeyValuePair<string, string>("http://metalx.org/Commodore64/Color", "../../../OZone/Platforms/Commodore/C64/Color.xslt"),
				new KeyValuePair<string, string>("http://metalx.org/Commodore64/Kernel", "../../../OZone/Platforms/Commodore/C64/Kernel.xslt"),
				new KeyValuePair<string, string>("http://metalx.org/Commodore64/Petscii", "../../../OZone/Platforms/Commodore/C64/Petscii.xslt"),
				new KeyValuePair<string, string>("http://metalx.org/Commodore64/Vic", "../../../OZone/Platforms/Commodore/C64/Vic.xslt"),
				new KeyValuePair<string, string>("http://metalx.org/Commodore64/Video", "../../../OZone/Platforms/Commodore/C64/Video.xslt"),
				//new KeyValuePair<string, string>("http://metalx.org/Variable", "../../../OZone/Structures/6502/Variable.xslt"),
				new KeyValuePair<string, string>("http://metalx.org/Mos/6502/Operators", "../../../OZone/Platforms/Mos/6502/Operators.xslt")
			};

			var sourceFiles = new string[]
			{
				"../../C64Program.xml",
				"../../C64Audio.xml",
				"../../Modules/GeneratorScreen.xml",
				"../../Modules/Hexadecimal.xml",
				"../../Modules/MemoryReader.xml",
				"../../Modules/MemoryWriter.xml",
				"../../Modules/Screen.xml",
				"../../Modules/Short.xml",
				"../../Modules/Sid.xml",
				"../../Modules/SidGenerator.xml",
				"../../Modules/SidScreen.xml",
				"../../Modules/SoundGenerator.xml",
			};

			var compiler = new BinaryCompiler();
			var address = new MemoryAddress { Offset = 0x07ff };

			using (Stream stream = File.Create("c64audio.prg"))
			using (BinaryWriter writer = new BinaryWriter(stream))
			{
				var programs = new List<OZone.Programs.Program>();
				var exports = new Dictionary<string, Label>();

				foreach (var sourceFile in sourceFiles)
				{
					var program = ProgramBuilder.Build(sourceFile, transformFiles);

					var length = compiler.Compile(program, address);

					address.Offset += length;

					programs.Add(program);

					foreach (var label in program.Segments.OfType<Label>())
						if (label.Export != null)
							exports[label.Export] = label;
				}

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
