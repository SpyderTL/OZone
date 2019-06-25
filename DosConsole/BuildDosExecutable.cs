using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using OZone.Programs;
using System.Xml;

namespace DosConsole
{
	internal static class BuildDosExecutable
	{
		internal static void Main(string[] args)
		{
			DosExecutable image = new DosExecutable();

			// Boot Strap
			Console.WriteLine("Building BootLoaderDos.xml");

			image.Add(
				ProgramBuilder.Build(
					new XmlTextReader("../../BootLoaderDos.xml"),
					DosConsole.Transforms),
				new MemoryAddress { Offset = 0x0100 });

			// Programs
			foreach(var program in DosConsole.Programs)
			{
				Console.WriteLine("Building " + Path.GetFileName(program));

				image.Add(
					ProgramBuilder.Build(
						new XmlTextReader(program),
						DosConsole.Transforms));
			}

			// Save Disk Image
			Console.WriteLine("Writing Console.com");

			using(Stream stream = File.Create("Console.com"))
				image.Save(stream);

			//System.Diagnostics.Process.Start("Console.com");
		}
	}
}
	