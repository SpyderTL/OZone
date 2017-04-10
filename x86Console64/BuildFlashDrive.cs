using System;
using System.IO;
using System.Xml.Linq;
using Microsoft.Win32.SafeHandles;
using OZone.Programs;
using OZone.Projects;

namespace x86Console64
{
	internal static class BuildFlashDrive
	{
		internal static void Main(string[] args)
		{
			var project = ProjectReader.Read("../../Projects/ProjectFlash.xml");

			//ProjectBuilder.Clean(project);

			ProjectBuilder.Build(project);

			var image = new FlashImage();

			foreach(var file in project.Files)
			{
				var filename = file.OutputPath;

				try
				{
					if(file.Address == null)
						image.Add(ProgramReader.Read(XDocument.Load(filename, LoadOptions.SetLineInfo)));
					else if(file.Block == null)
						image.Add(ProgramReader.Read(XDocument.Load(filename, LoadOptions.SetLineInfo)), file.Address);
					else
						image.Add(ProgramReader.Read(XDocument.Load(filename, LoadOptions.SetLineInfo)), file.Address, file.Block.Value);
				}
				catch(Exception e)
				{
					throw new Exception("Error Reading File: " + filename + "\r\n" + e.Message, e);
				}
			}

			// Save Disk Image
			Console.WriteLine("Writing x86Console64 To Flash Drive E:");

			//using(SafeFileHandle fileHandle = Kernel32.CreateFile(@"\\.\PhysicalDrive1", Kernel32.EFileAccess.GenericWrite, Kernel32.EFileShare.None, IntPtr.Zero, Kernel32.ECreationDisposition.OpenExisting, Kernel32.EFileAttributes.Device, IntPtr.Zero))
			//using(SafeFileHandle fileHandle = Kernel32.CreateFile(@"\\.\PhysicalDrive3", Kernel32.EFileAccess.GenericWrite, Kernel32.EFileShare.None, IntPtr.Zero, Kernel32.ECreationDisposition.OpenExisting, Kernel32.EFileAttributes.Device, IntPtr.Zero))
			//using(FileStream stream = new FileStream(fileHandle, FileAccess.Write))
			//    image.Save(stream);
		}
	}
}
