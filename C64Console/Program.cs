using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using OZone.Programs;

namespace C64Console
{
	class Program
	{
		static void Main(string[] args)
		{
			var program = ProgramBuilder.Build(
				"../../C64Cartridge.xml");

			var address = new MemoryAddress(0x0000, 0x8000);

			using(Stream stream = File.Create("C64Console.bin"))
			using(BinaryWriter binaryWriter = new BinaryWriter(stream))
			{
				ProgramCompiler.Compile(program, address, binaryWriter);

				program = ProgramBuilder.Build(
					"../../C64Console.xml",
					"../../../OZone/Functions/C64/Class.xslt",
					"../../../OZone/Functions/C64/String.xslt",
					"../../../OZone/Functions/C64/MemoryManager.xslt",
					"../../../OZone/Platforms/Commodore/C64/Memory.xslt",
					"../../../OZone/Platforms/Commodore/C64/Keyboard.xslt",
					"../../../OZone/Platforms/Mos/6502/Operators.xslt");

				address.Offset = (uint)binaryWriter.BaseStream.Position + 0x8000;

				ProgramCompiler.Compile(program, address, binaryWriter);

				binaryWriter.BaseStream.SetLength(8192);
			}
		}
	}
}
