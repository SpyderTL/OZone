using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using OZone.Programs;

namespace AtariGame
{
	class Program
	{
		static void Main(string[] args)
		{
			using(Stream stream = File.Create("AtariGame.bin"))
			using(BinaryWriter binaryWriter = new BinaryWriter(stream))
			{
				Console.WriteLine("Building Game.xml");

				OZone.Programs.Program program = ProgramBuilder.Build(
					"../../Game.xml",
					"../../../OZone/Platforms/Mos/6502/Operators.xslt",
					"../../../OZone/Platforms/Atari/2600/TelevisionInterfaceAdapter.xslt",
					"../../../OZone/Platforms/Atari/2600/PeripheralInterfaceAdapter.xslt");

				MemoryAddress address = new MemoryAddress { Offset = 0xf000 };

				ProgramCompiler.Compile(program, address, binaryWriter);

				binaryWriter.Seek(0x0ffc, SeekOrigin.Begin);

				binaryWriter.Write((ushort)0xf000);
				binaryWriter.Write((ushort)0xf000);
			}
		}
	}
}
