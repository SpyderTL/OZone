using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using OZone.Programs;

namespace GbaGame
{
	class Program
	{
		static void Main(string[] args)
		{
			using(var stream = File.Create("GbaGame.gba"))
			using(var writer = new BinaryWriter(stream))
			{
				Console.WriteLine("Building GbaGame.xml");

				var header = ProgramBuilder.Build(
					"../../Header.xml",
					"../../../OZone/Platforms/Arm/Arm7/Operators.xslt");

				ProgramCompiler.Compile(header, new MemoryAddress(0x0000, 0x800000), writer);

				Console.WriteLine("Building GbaGame.xml");

				var program = ProgramBuilder.Build(
					"../../GbaGame.xml",
					"../../../OZone/Platforms/Arm/Arm7/Operators.xslt");

				ProgramCompiler.Compile(program, new MemoryAddress(0x0000, 0x8000c0), writer);

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