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

			var program = ProgramBuilder.Build(
				"../../C64Cartridge.xml");

			var address = new MemoryAddress { Offset = 0x8000 };

			using(Stream stream = File.Create("C64Console.bin"))
			using(BinaryWriter binaryWriter = new BinaryWriter(stream))
			{
				compiler.Compile(program, address, binaryWriter);

				program = ProgramBuilder.Build(
					"../../C64Console.xml",
					"../../../OZone/Functions/C64/Class.xslt",
					"../../../OZone/Functions/C64/String.xslt",
					"../../../OZone/Functions/C64/MemoryManager.xslt",
					"../../../OZone/Platforms/Commodore/C64/Kernel.xslt",
					"../../../OZone/Platforms/Commodore/C64/Keyboard.xslt",
					"../../../OZone/Platforms/Commodore/C64/System.xslt",
					"../../../OZone/Platforms/Commodore/C64/Video.xslt",
					"../../../OZone/Platforms/Mos/6502/Operators.xslt");

				address.Offset = (uint)binaryWriter.BaseStream.Position + 0x1000;

				compiler.Compile(program, address, binaryWriter);

				binaryWriter.BaseStream.SetLength(8192);
			}
		}
	}
}
