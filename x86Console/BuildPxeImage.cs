using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using OZone.Programs;
using System.Xml.Xsl;
using System.Xml;

namespace x86Console
{
	internal static class BuildPxeImage
	{
		internal static void Main(string[] args)
		{
			var image = new PxeImage();

			// Boot Loader
			Console.WriteLine("Building BootLoaderPxe.xml");

			image.Add(
				ProgramBuilder.Build(
					new XmlTextReader("../../BootLoaderPxe.xml"),
					x86Console.Transforms));

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
			Console.WriteLine("Writing OZone.pxe");

			using(Stream stream = File.Create("OZone.pxe"))
				image.Save(stream);
		}
	}
}
