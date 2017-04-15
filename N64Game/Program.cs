using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using OZone.Programs;
using OZone.IO;
using OZone.Programs.Compilers;

namespace N64Game
{
	class Program
	{
		static void Main(string[] args)
		{
			//using(var output = File.CreateText("output.txt"))
			//using(var stream = File.OpenRead(@"X:\Projects\OZone\OZone\Documentation\N64\Star Fox 64.z64"))
			//{
			//    stream.Position = 0x40;

			//    while(stream.Position < 0x1000)
			//    {
			//        output.WriteLine("<hex>" + stream.ReadByte().ToString("x2") + "</hex>");
			//    }

			//    output.Flush();
			//}

			var compiler = new BinaryCompiler();

			using (var stream = File.Open("N64Game.z64", FileMode.Create, FileAccess.ReadWrite, FileShare.None))
			using(var writer = new BigEndianBinaryWriter(stream))
			{
				Console.WriteLine("Building Header.xml");

				var header = ProgramBuilder.Build(
					"../../Header.xml",
					"../../../OZone/Platforms/Mips/Mips3/Instructions.xslt");

				compiler.Compile(header, new MemoryAddress { Offset = 0x80000000 }, writer);

				Console.WriteLine("Building BootCode6501.xml");

				var bootCode = ProgramBuilder.Build(
					"../../BootCode6501.xml",
					"../../../OZone/Platforms/Mips/Mips3/Instructions.xslt");

				compiler.Compile(bootCode, new MemoryAddress { Offset = 0x80000040 }, writer);

				Console.WriteLine("Building N64Game.xml");

				var program = ProgramBuilder.Build(
					"../../N64Game.xml",
					"../../../OZone/Platforms/Mips/Mips3/Instructions.xslt");

				compiler.Compile(program, new MemoryAddress { Offset = 0x80001000 }, writer);

				stream.SetLength(0x800000);

				Console.WriteLine("Calculating Checksum");

				// Setup Checksum Table
				uint[] checksumTable = new uint[256];
				uint checksum;

				uint poly = 0xedb88320;

				for(int i = 0; i < 256; i++)
				{
					checksum = (uint)i;

					for(int j = 8; j > 0; j--)
					{
						if((checksum & 1) != 0)
							checksum = (checksum >> 1) ^ poly;
						else
							checksum = checksum >> 1;
					}

					checksumTable[i] = checksum;
				}

				// Find Boot Chip
				stream.Position = 0x40;
				checksum = ~(uint)0;

				for(int i = 0; i < 0x1000 - 0x40; i++)
					checksum = (checksum >> 8) ^ checksumTable[(checksum ^ (byte)stream.ReadByte()) & 0xff];

				checksum = ~checksum;

				switch(checksum)
				{
					case 0x6170A4A1:
					case 0x90BB6CB5:
						checksum = Checksum.Cic6102;
						break;
					case 0x0B050EE0:
						checksum = Checksum.Cic6103;
						break;
					case 0xACC8580A:
						checksum = Checksum.Cic6106;
						break;
					default:
						checksum = Checksum.Cic6105;
						break;
				}

				// Calculate Checksum
				uint[] registers = new uint[9] { 0, checksum, checksum, checksum, checksum, checksum, checksum, 0, 0 };

				stream.Position = 0x1000;

				while(stream.Position < 0x101000)
				{
					registers[0] = 0;
					registers[0] = registers[0] | ((uint)stream.ReadByte() << 24);
					registers[0] = registers[0] | ((uint)stream.ReadByte() << 16);
					registers[0] = registers[0] | ((uint)stream.ReadByte() << 8);
					registers[0] = registers[0] | ((uint)stream.ReadByte() << 0);

					if((registers[6] + registers[0]) < registers[6])
						registers[4]++;

					registers[6] += registers[0];
					registers[3] ^= registers[0];
					// (((i) << (b)) | ((i) >> (32 - (b))))

					registers[7] = registers[0] & 0x1f;
					registers[8] = ((registers[0] << (byte)registers[7]) | (registers[0] >> ((byte)32 - (byte)registers[7])));

					registers[5] += registers[8];

					if(registers[2] > registers[0])
						registers[2] ^= registers[8];
					else
						registers[2] ^= (registers[6] ^ registers[0]);

					if(checksum == Checksum.Cic6105)
						throw new NotSupportedException();
					else
						registers[1] += (registers[5] ^ registers[0]);
				}

				stream.Position = 0x10;

				if(checksum == Checksum.Cic6103)
				{
					throw new NotSupportedException();
				}
				else if(checksum == Checksum.Cic6106)
				{
					throw new NotSupportedException();
				}
				else
				{
					writer.Write((uint)(registers[6] ^ registers[4] ^ registers[3]));
					writer.Write((uint)(registers[5] ^ registers[2] ^ registers[1]));
				}

				writer.Flush();
			}
		}
	}

	public class Checksum
	{
		public const uint Cic6102 = 0xF8CA4DDC;
		public const uint Cic6103 = 0xA3886759;
		public const uint Cic6105 = 0xDF26F436;
		public const uint Cic6106 = 0x1FEA617A;
	}
}
