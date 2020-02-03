using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using OZone.Programs;
using OZone.Programs.Compilers;

namespace NesGame
{
	class Program
	{
		static void Main(string[] args)
		{
			var compiler = new BinaryCompiler();

			using (Stream stream = File.Create("NesGame.nes"))
			using(BinaryWriter writer = new BinaryWriter(stream))
			{
				Console.WriteLine("Writing iNes Header");

				writer.Write(new char[] { 'N', 'E', 'S', (char)0x1a });
				writer.Write(new Byte[] { 
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

				compiler.Compile(program, address);
				compiler.Link(program, new Dictionary<string, Label>());
				compiler.Write(program, writer);

				writer.Seek(0x7ffc + 16, SeekOrigin.Begin);

				writer.Write((ushort)0x0000);
				writer.Write((ushort)0x8000);
				writer.Write((ushort)0x0000);
			}
		}
	}
}
