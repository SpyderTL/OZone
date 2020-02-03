using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using OZone.Programs;
using OZone.Programs.Compilers;

namespace SnesGame
{
	class Program
	{
		static void Main(string[] args)
		{
			var compiler = new BinaryCompiler();

			using (var stream = File.Create("SnesGame.smc"))
			using(var writer = new BinaryWriter(stream))
			{
				// Header
				Console.WriteLine("Writing Snes Header");

				stream.Position = 0xffc0;

				var header = ProgramBuilder.Build("../../SnesHeader.xml");

				compiler.Compile(header, new MemoryAddress());
				compiler.Write(header, writer);


				// Default Interrupt Handler
				stream.Position = 0x8000;

				Console.WriteLine("Building DefaultInterruptHandler.xml");

				OZone.Programs.Program defaultHandler = ProgramBuilder.Build(
					"../../DefaultInterruptHandler.xml",
					"../../../OZone/Platforms/Mos/65816/Operators.xslt");

				compiler.Compile(defaultHandler, new MemoryAddress { Offset = 0x8000 });
				compiler.Write(defaultHandler, writer);

				// VBlank Handler
				stream.Position = 0x8100;

				Console.WriteLine("Building VBlankHandler.xml");

				OZone.Programs.Program vblankHandler = ProgramBuilder.Build(
					"../../VBlankHandler.xml",
					"../../../OZone/Platforms/Mos/65816/Operators.xslt");

				compiler.Compile(vblankHandler, new MemoryAddress { Offset = 0x8100 });
				compiler.Write(vblankHandler, writer);

				// Reset Handler
				stream.Position = 0x8200;

				Console.WriteLine("Building ResetHandler.xml");

				OZone.Programs.Program resetHandler = ProgramBuilder.Build(
					"../../ResetHandler.xml",
					"../../../OZone/Platforms/Mos/65816/Operators.xslt");

				compiler.Compile(resetHandler, new MemoryAddress { Offset = 0x8200 });
				compiler.Write(resetHandler, writer);

				stream.SetLength(0x400000);
			}
		}
	}
}
