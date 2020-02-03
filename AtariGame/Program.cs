using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using OZone.Programs;
using OZone.Programs.Compilers;

namespace AtariGame
{
	class Program
	{
		static void Main(string[] args)
		{
			var compiler = new BinaryCompiler();

			using(Stream stream = File.Create("AtariGame.bin"))
			using(BinaryWriter writer = new BinaryWriter(stream))
			{
				Console.WriteLine("Building Game.xml");

				OZone.Programs.Program program = ProgramBuilder.Build(
					"../../Game.xml",
					"../../../OZone/Platforms/Mos/6502/Operators.xslt",
					"../../../OZone/Platforms/Atari/2600/TelevisionInterfaceAdapter.xslt",
					"../../../OZone/Platforms/Atari/2600/PeripheralInterfaceAdapter.xslt");

				MemoryAddress address = new MemoryAddress { Offset = 0xf000 };

				compiler.Compile(program, address);
				compiler.Link(program, new Dictionary<string, Label>());
				compiler.Write(program, writer);

				writer.Seek(0x0ffc, SeekOrigin.Begin);

				writer.Write((ushort)0xf000);
				writer.Write((ushort)0xf000);
			}
		}
	}
}
