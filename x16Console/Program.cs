﻿using OZone.Programs;
using OZone.Programs.Compilers;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace x16Console
{
	class Program
	{
		static void Main()
		{
			var sourceFiles = new string[]
			{
				"../../x16Program.xml",
				"../../x16Console.xml",
				"../../Modules/Command.xml",
				"../../Modules/Dictionary32.xml",
				"../../Modules/Function.xml",
				"../../Modules/Integer.xml",
				"../../Modules/MemoryManager32.xml",
				"../../Modules/MemoryReader.xml",
				"../../Modules/MemoryReader32.xml",
				"../../Modules/MemoryWriter32.xml",
				"../../Modules/Object32.xml",
				"../../Modules/String32.xml",
				"../../Modules/System.xml",
				"../../Classes/System.xml",
			};

			var transformFiles = new KeyValuePair<string, string>[]
			{
				new KeyValuePair<string, string>("http://metalx.org/65C02/Functions/Class", "../../../OZone/Functions/65C02/Class.xslt"),
				new KeyValuePair<string, string>("http://metalx.org/65C02/Functions/String", "../../../OZone/Functions/65C02/String.xslt"),
				new KeyValuePair<string, string>("http://metalx.org/65C02/Functions/Integer", "../../../OZone/Functions/65C02/Integer.xslt"),
				new KeyValuePair<string, string>("http://metalx.org/65C02/Functions/MemoryManager", "../../../OZone/Functions/65C02/MemoryManager.xslt"),
				new KeyValuePair<string, string>("http://metalx.org/Ansi/Ascii", "../../../OZone/Platforms/Ansi/Ascii/Ascii.xslt"),
				new KeyValuePair<string, string>("http://metalx.org/Commodore64/Petscii", "../../../OZone/Platforms/Commodore/C64/Petscii.xslt"),
				new KeyValuePair<string, string>("http://metalx.org/Variable", "../../../OZone/Structures/6502/Variable.xslt"),
				new KeyValuePair<string, string>("http://metalx.org/Class", "../../../OZone/Structures/6502/Class.xslt"),
				new KeyValuePair<string, string>("http://metalx.org/Wdc/65C02/Operators", "../../../OZone/Platforms/Wdc/65C02/Operators.xslt")
			};

			var compiler = new BinaryCompiler();
			var address = new MemoryAddress { Offset = 0x07ff };

			using (Stream stream = File.Create("x16Console.prg"))
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
