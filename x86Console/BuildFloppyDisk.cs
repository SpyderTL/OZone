using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using OZone.Programs;
using System.Runtime.InteropServices;
using Microsoft.Win32.SafeHandles;
using System.ComponentModel;
using System.Xml;

namespace x86Console
{
	internal static class BuildFloppyDisk
	{
		internal static void Main(string[] args)
		{
			FloppyDiskImage image = new FloppyDiskImage();

			// Boot Loader
			Console.WriteLine("Building BootLoaderFd.xml");

			image.Add(
				ProgramBuilder.Build(
					new XmlTextReader("../../BootLoaderFd.xml"),
					x86Console.Transforms),
				new MemoryAddress { Offset = 0x7c00 } );

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
			Console.WriteLine("Writing x86Console To Floppy Drive A:");
			
			using(SafeFileHandle fileHandle = Kernel32.CreateFile(@"\\.\A:", Kernel32.EFileAccess.GenericWrite, Kernel32.EFileShare.None, IntPtr.Zero, Kernel32.ECreationDisposition.OpenExisting, Kernel32.EFileAttributes.Device, IntPtr.Zero))
			using(FileStream stream = new FileStream(fileHandle, FileAccess.Write))
				image.Save(stream);
		}
	}
}
