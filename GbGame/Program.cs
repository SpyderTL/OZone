using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using OZone.Programs;

namespace GbGame
{
	class Program
	{
		static void Main(string[] args)
		{
			using(var stream = File.Create("GbGame.gb"))
			using(var writer = new BinaryWriter(stream))
			{
				// Interrupt Handlers
				Console.WriteLine("Building InterruptHandlers.xml");

				var handlers = ProgramBuilder.Build(
					"../../InterruptHandlers.xml",
					"../../../OZone/Platforms/Nintendo/GameBoy/Operators.xslt");

				ProgramCompiler.Compile(handlers, MemoryAddress.Zero, writer);

				// Interrupt Handlers
				Console.WriteLine("Building Header.xml");

				stream.Position = 0x0100;

				var header = ProgramBuilder.Build(
					"../../Header.xml",
					"../../../OZone/Platforms/Nintendo/GameBoy/Operators.xslt");

				ProgramCompiler.Compile(header, MemoryAddress.Zero, writer);

				// Interrupt Handlers
				Console.WriteLine("Building GbGame.xml");

				stream.Position = 0x0150;

				var program = ProgramBuilder.Build(
					"../../GbGame.xml",
					"../../../OZone/Platforms/Nintendo/GameBoy/Operators.xslt");

				ProgramCompiler.Compile(program, new MemoryAddress(0x0000, 0x0150), writer);

				stream.Position = 0x0134;

				int checksum = 0;

				for(int index = 0; index < 25; index++)
					checksum += stream.ReadByte();

				checksum += 25;

				checksum &= 0xff;

				checksum = 256 - checksum;

				stream.Position = 0x014d;

				writer.Write((byte)checksum);

				stream.SetLength(0x8000);
			}
		}
	}
}