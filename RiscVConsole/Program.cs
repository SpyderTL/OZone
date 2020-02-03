using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using OZone.Programs;
using OZone.Programs.Compilers;

namespace RiscVConsole
{
	class Program
	{
		static void Main(string[] args)
		{
			var compiler = new BinaryCompiler();

			using (var stream = File.Create("RiscVConsole.bin"))
			using (var writer = new BinaryWriter(stream))
			{
				var address = new MemoryAddress();

				var program = ProgramBuilder.Build(
					"../../RiscVConsole.xml",
					new KeyValuePair<string, string>[]
					{
						new KeyValuePair<string, string>("http://metalx.org/Berkeley/RiscV/Operators", "../../../OZone/Platforms/Berkeley/RiscV/Operators.xslt")
					});

				compiler.Compile(program, address);
				compiler.Write(program, writer);

				Console.WriteLine(writer.BaseStream.Position);

				//binaryWriter.BaseStream.SetLength(1024 * 16);
			}
		}
	}
}
