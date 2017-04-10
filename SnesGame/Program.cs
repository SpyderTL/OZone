using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using OZone.Programs;

namespace SnesGame
{
	class Program
	{
		static void Main(string[] args)
		{
			using(var stream = File.Create("SnesGame.smc"))
			using(var writer = new BinaryWriter(stream))
			{
				// Header
				Console.WriteLine("Writing Snes Header");

				stream.Position = 0xffc0;

				var header = ProgramBuilder.Build("../../SnesHeader.xml");

				ProgramCompiler.Compile(header, null, writer);

				// Default Interrupt Handler
				stream.Position = 0x8000;

				Console.WriteLine("Building DefaultInterruptHandler.xml");

				OZone.Programs.Program defaultHandler = ProgramBuilder.Build(
					"../../DefaultInterruptHandler.xml",
					"../../../OZone/Platforms/Mos/65816/Operators.xslt");

				ProgramCompiler.Compile(defaultHandler, new MemoryAddress { Offset = 0x8000 }, writer);

				// Reset Handler
				stream.Position = 0x8001;

				Console.WriteLine("Building ResetHandler.xml");

				OZone.Programs.Program resetHandler = ProgramBuilder.Build(
					"../../ResetHandler.xml",
					"../../../OZone/Platforms/Mos/65816/Operators.xslt");

				ProgramCompiler.Compile(resetHandler, new MemoryAddress { Offset = 0x8001 }, writer);

				stream.SetLength(0x400000);
			}
		}
	}
}
