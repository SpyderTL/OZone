using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using OZone.Programs;
using OZone.Programs.Compilers;

namespace WasmConsole
{
	class Program
	{
		static void Main(string[] args)
		{
			var compiler = new WebAssemblyBinaryCompiler();

			var program = ProgramBuilder.Build(
				"../../Console.xml",
				"../../../OZone/Structures/Wasm/Module.xslt",
				"../../../OZone/Platforms/W3c/Wasm/Operators.xslt");

			var address = new MemoryAddress { Offset = 0x0000 };

			using (Stream stream = File.Create("Console.wasm"))
			using (BinaryWriter binaryWriter = new BinaryWriter(stream))
			{
				compiler.Compile(program, address, binaryWriter);
			}
		}
	}
}
