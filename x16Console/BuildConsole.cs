using OZone.Programs;
using OZone.Programs.Compilers;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace x16Console
{
	class BuildConsole
	{
		static void Main(string[] args)
		{
			var compiler = new BinaryCompiler();

			var program = ProgramBuilder.Build("../../x16Program.xml");

			var address = new MemoryAddress { Offset = 0x07ff };

			using (Stream stream = File.Create("x16Console.prg"))
			using (BinaryWriter writer = new BinaryWriter(stream))
			{
				compiler.Compile(program, address);
				compiler.Write(program, writer);

				program = ProgramBuilder.Build(
					"../../x16Console.xml",
					new KeyValuePair<string, string>[]
					{
						//new KeyValuePair<string, string>("http://metalx.org/C64Console/Functions/Screen", "../../Functions/Screen.xslt"),
						//new KeyValuePair<string, string>("http://metalx.org/C64Console/Functions/System", "../../Functions/System.xslt"),
						new KeyValuePair<string, string>("http://metalx.org/6502/Functions/Class", "../../../OZone/Functions/6502/Class.xslt"),
						new KeyValuePair<string, string>("http://metalx.org/6502/Functions/String", "../../../OZone/Functions/6502/String.xslt"),
						//new KeyValuePair<string, string>("http://metalx.org/6502/Functions/Memory", "../../../OZone/Functions/6502/Memory.xslt"),
						new KeyValuePair<string, string>("http://metalx.org/6502/Functions/MemoryManager", "../../../OZone/Functions/6502/MemoryManager.xslt"),
						//new KeyValuePair<string, string>("http://metalx.org/Commodore64/Kernel", "../../../OZone/Platforms/Commodore/C64/Kernel.xslt"),
						//new KeyValuePair<string, string>("http://metalx.org/Commodore64/Keyboard", "../../../OZone/Platforms/Commodore/C64/Keyboard.xslt"),
						//new KeyValuePair<string, string>("http://metalx.org/Commodore64/System", "../../../OZone/Platforms/Commodore/C64/System.xslt"),
						//new KeyValuePair<string, string>("http://metalx.org/Commodore64/Video", "../../../OZone/Platforms/Commodore/C64/Video.xslt"),
						//new KeyValuePair<string, string>("http://metalx.org/Commodore64/Petscii", "../../../OZone/Platforms/Commodore/C64/Petscii.xslt"),
						//new KeyValuePair<string, string>("http://metalx.org/Commodore64/Color", "../../../OZone/Platforms/Commodore/C64/Color.xslt"),
						new KeyValuePair<string, string>("http://metalx.org/Ansi/Ascii", "../../../OZone/Platforms/Ansi/Ascii/Ascii.xslt"),
						new KeyValuePair<string, string>("http://metalx.org/Variable", "../../../OZone/Structures/6502/Variable.xslt"),
						new KeyValuePair<string, string>("http://metalx.org/Class", "../../../OZone/Structures/6502/Class.xslt"),
						new KeyValuePair<string, string>("http://metalx.org/Mos/6502/Operators", "../../../OZone/Platforms/Mos/6502/Operators.xslt")
					});

				address.Offset = 0x810;

				compiler.Compile(program, address);
				compiler.Write(program, writer);

				writer.Flush();

				Console.WriteLine(writer.BaseStream.Position);
			}
		}
	}
}
