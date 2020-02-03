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
	class BuildDemo
	{
		static void Main(string[] args)
		{
			var compiler = new BinaryCompiler();

			var program = ProgramBuilder.Build("../../x16Program.xml");

			var address = new MemoryAddress { Offset = 0x07ff };

			using (Stream stream = File.Create("x16Demo.prg"))
			using (BinaryWriter writer = new BinaryWriter(stream))
			{
				compiler.Compile(program, address);
				compiler.Link(program, new Dictionary<string, Label>());
				compiler.Write(program, writer);

				program = ProgramBuilder.Build(
					"../../x16Demo21.xml",
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
				compiler.Link(program, new Dictionary<string, Label>());
				compiler.Write(program, writer);

				writer.Flush();

				Console.WriteLine(writer.BaseStream.Position);

				//var delta = 1.0 / 255.0;

				//for (var x = 0; x < 256; x++)
				//{
				//System.Diagnostics.Debug.WriteLine("<hex>" + ((byte)((Math.Sin(x * delta) * 128) + 128)).ToString("X2") + "</hex>");
				//System.Diagnostics.Debug.WriteLine(Math.Asin(x * delta));
				//System.Diagnostics.Debug.WriteLine("<hex>" + ((byte)((Math.Asin(x * delta) * 128) + 128)).ToString("X2") + "</hex>");
				//}

				var reader = new BinaryReader(File.OpenRead(@"..\..\commander-x16-2.ico"));

				var reserved = reader.ReadUInt16();
				var type = reader.ReadUInt16();
				var imageCount = reader.ReadUInt16();

				for (var image = 0; image < imageCount; image++)
				{
					var width = reader.ReadByte();
					var height = reader.ReadByte();
					var paletteSize = reader.ReadByte();
					var reserved2 = reader.ReadByte();
					var planeCount = reader.ReadUInt16();
					var bitsPerPixel = reader.ReadUInt16();
					var size = reader.ReadUInt32();
					var offset = reader.ReadUInt32();
				}

				//reader.BaseStream.Position = 17558;
				//reader.BaseStream.Position = 0x4496;
				reader.BaseStream.Position = 0x44be;

				for (var entry = 0; entry < 16; entry++)
				{
					var blue = reader.ReadByte();
					var green = reader.ReadByte();
					var red = reader.ReadByte();
					var alpha = reader.ReadByte();

					System.Diagnostics.Debug.WriteLine("<hex>" + ((blue >> 4) | (green & 0xf0)).ToString("X2") + "</hex>");
					System.Diagnostics.Debug.WriteLine("<hex>" + (red >> 4).ToString("X2") + "</hex>");
				}

				reader.BaseStream.Position = 16750;

				var lines = new List<string>();

				for (var row = 0; row < 92; row++)
				{
					var line = string.Empty;

					for (var column = 0; column < 46; column++)
					{
						var data = reader.ReadByte();

						//System.Diagnostics.Debug.WriteLine("<hex>" + (data >> 4).ToString("X2") + "</hex>");
						//System.Diagnostics.Debug.WriteLine("<hex>" + (data & 0x0f).ToString("X2") + "</hex>");

						line += "<hex>" + (data >> 4).ToString("X2") + "</hex>" + "\r\n";
						line += "<hex>" + (data & 0x0f).ToString("X2") + "</hex>" + "\r\n";
					}

					reader.ReadBytes(2);

					lines.Add(line);
				}

				lines.Reverse();

				foreach (var line in lines)
				{
					//System.Diagnostics.Debug.Write(line);
				}
			}
		}
	}
}
