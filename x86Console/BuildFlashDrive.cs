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
using OZone.Projects;
using System.Xml.Linq;

namespace x86Console
{
	internal static class BuildFlashDrive
	{
		internal static void Main(string[] args)
		{
			var project = ProjectReader.Read("../../../ProjectFlash.xml");

			//ProjectBuilder.Clean(project);

			ProjectBuilder.Build(project);

			var image = new FlashImage();

			foreach(var program in project.Files)
			{
				var filename = Path.Combine(project.Name, Path.GetFileName(program.Path) + ".program");

				if(program.Address == null)
					image.Add(ProgramReader.Read(XDocument.Load(filename)));
				else if(program.Block == null)
					image.Add(ProgramReader.Read(XDocument.Load(filename)), program.Address);
				else
					image.Add(ProgramReader.Read(XDocument.Load(filename)), program.Address, program.Block.Value);
			}

			// Save Disk Image
			Console.WriteLine("Writing x86Console To Flash Drive E:");

			//using(SafeFileHandle fileHandle = Kernel32.CreateFile(@"\\.\PhysicalDrive1", Kernel32.EFileAccess.GenericWrite, Kernel32.EFileShare.None, IntPtr.Zero, Kernel32.ECreationDisposition.OpenExisting, Kernel32.EFileAttributes.Device, IntPtr.Zero))
			//using(SafeFileHandle fileHandle = Kernel32.CreateFile(@"\\.\PhysicalDrive3", Kernel32.EFileAccess.GenericWrite, Kernel32.EFileShare.None, IntPtr.Zero, Kernel32.ECreationDisposition.OpenExisting, Kernel32.EFileAttributes.Device, IntPtr.Zero))
			//using(FileStream stream = new FileStream(fileHandle, FileAccess.Write))
			//    image.Save(stream);
		}
	}
}
