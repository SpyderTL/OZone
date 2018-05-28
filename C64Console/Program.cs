using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using OZone.Programs;
using OZone.Programs.Compilers;

namespace C64Console
{
	class Program
	{
		static void Main(string[] args)
		{
			var compiler = new BinaryCompiler();

			var program = ProgramBuilder.Build("../../C64Cartridge.xml");

			var address = new MemoryAddress { Offset = 0x8000 };

			using(Stream stream = File.Create("C64Console.bin"))
			using(BinaryWriter binaryWriter = new BinaryWriter(stream))
			{
				compiler.Compile(program, address, binaryWriter);

				program = ProgramBuilder.Build(
					"../../C64Console.xml",
					"../../Functions/Screen.xslt",
					"../../Functions/System.xslt",
					"../../../OZone/Functions/6502/Class.xslt",
					"../../../OZone/Functions/6502/String.xslt",
					"../../../OZone/Functions/6502/MemoryManager.xslt",
					"../../../OZone/Platforms/Commodore/C64/Kernel.xslt",
					"../../../OZone/Platforms/Commodore/C64/Keyboard.xslt",
					"../../../OZone/Platforms/Commodore/C64/System.xslt",
					"../../../OZone/Platforms/Commodore/C64/Video.xslt",
					"../../../OZone/Platforms/Commodore/C64/Petscii.xslt",
					"../../../OZone/Platforms/Commodore/C64/Color.xslt",
					"../../../OZone/Platforms/Ansi/Ascii/Ascii.xslt",
					"../../../OZone/Structures/6502/Variable.xslt",
					"../../../OZone/Structures/6502/Class.xslt",
					"../../../OZone/Platforms/Mos/6502/Operators.xslt");

				address.Offset = (uint)binaryWriter.BaseStream.Position + 0x8000;
				//address.Offset = (uint)binaryWriter.BaseStream.Position + 0x4000;

				compiler.Compile(program, address, binaryWriter);

				Console.WriteLine(binaryWriter.BaseStream.Position);

				binaryWriter.BaseStream.SetLength(1024 * 16);
			}
		}
	}
}
