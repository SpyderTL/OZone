using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using OZone.Programs;
using System.Xml;

namespace x86Console
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
					x86Console.Transforms),
				new MemoryAddress(0x0000, 0x0100));

			// Programs
			foreach(var program in x86Console.Programs)
			{
				Console.WriteLine("Building " + Path.GetFileName(program));

				image.Add(
					ProgramBuilder.Build(
						new XmlTextReader(program),
						x86Console.Transforms));
			}

			// Save Disk Image
			Console.WriteLine("Writing x86Console.com");

			using(Stream stream = File.Create("x86Console.com"))
				image.Save(stream);

			System.Diagnostics.Process.Start("x86Console.com");
		}
	}
}
	