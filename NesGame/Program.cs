using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using OZone.Programs;

namespace NesGame
{
	class Program
	{
		static void Main(string[] args)
		{
			using(Stream stream = File.Create("NesGame.nes"))
			using(BinaryWriter binaryWriter = new BinaryWriter(stream))
			{
				Console.WriteLine("Writing iNes Header");

				binaryWriter.Write(new char[] { 'N', 'E', 'S', (char)0x1a });
				binaryWriter.Write(new Byte[] { 
					2, 0, 0, 0,
					0, 0, 0, 0,
					0, 0, 0, 0});

				Console.WriteLine("Building Game.xml");

				OZone.Programs.Program program = ProgramBuilder.Build(
					"../../Game.xml",
					"../../../OZone/Platforms/Nintendo/Nes/Registers.xslt",
					"../../../OZone/Platforms/Nintendo/Nes/PictureProcessingUnit.xslt",
					"../../../OZone/Platforms/Mos/6502/Operators.xslt");

				MemoryAddress address = new MemoryAddress { Offset = 0x8000 };

				ProgramCompiler.Compile(program, address, binaryWriter);

				binaryWriter.Seek(0x7ffc + 16, SeekOrigin.Begin);

				binaryWriter.Write((ushort)0x0000);
				binaryWriter.Write((ushort)0x8000);
				binaryWriter.Write((ushort)0x0000);
			}
		}
	}
}
