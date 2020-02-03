using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using OZone.Programs;
using OZone.Programs.Compilers;

namespace GbaGame
{
	class Program
	{
		static void Main(string[] args)
		{
			var compiler = new BinaryCompiler();

			using (var stream = File.Create("GbaGame.gba"))
			using(var writer = new BinaryWriter(stream))
			{
				Console.WriteLine("Building GbaGame.xml");

				var header = ProgramBuilder.Build(
					"../../Header.xml",
					"../../../OZone/Platforms/Arm/Arm7/Operators.xslt");

				compiler.Compile(header, new MemoryAddress { Offset = 0x800000 });
				compiler.Write(header, writer);

				Console.WriteLine("Building GbaGame.xml");

				var program = ProgramBuilder.Build(
					"../../GbaGame.xml",
					"../../../OZone/Platforms/Arm/Arm7/Operators.xslt");

				compiler.Compile(program, new MemoryAddress { Offset = 0x8000c0 });
				compiler.Write(program, writer);

				int checksum = 0;

				stream.Position = 0xa0;

				while(stream.Position <= 0xbc)
				{
					checksum -= stream.ReadByte();
				}

				checksum -= 0x19;

				checksum &= 0xff;

				stream.Position = 0xbd;

				writer.Write((byte)checksum);

				stream.SetLength(0x800000);
			}
		}
	}
}