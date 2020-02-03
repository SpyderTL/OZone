using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using OZone.Programs;
using System.Xml;
using OZone.Programs.Compilers;

namespace DosConsole
{
	internal static class BuildDemo
	{
		internal static void Main(string[] args)
		{
			var compiler = new BinaryCompiler();

			var program = ProgramBuilder.Build(
				new XmlTextReader("../../Demo.xml"),
				DosConsole.Transforms);

			// Save Disk Image
			Console.WriteLine("Writing Demo.com");

			using (var stream = File.Create("Demo.com"))
			using (var writer = new BinaryWriter(stream))
			{
				compiler.Compile(program, new MemoryAddress { Segment = 0x0000, Offset = 0x0100 });
				compiler.Write(program, writer);

				writer.Flush();
			}

			//System.Diagnostics.Process.Start("Console.com");
		}
	}
}
	