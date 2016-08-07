using System;
using System.IO;
using System.Xml.Linq;
using OZone.Programs;
using OZone.Projects;
using Microsoft.Win32.SafeHandles;

namespace x86Console32
{
	internal static class BuildFloppyDisk
	{
		internal static void Main(string[] args)
		{
			var project = ProjectReader.Read("../../Projects/ProjectFd.xml");

			//ProjectBuilder.Clean(project);

			ProjectBuilder.Build(project);

			var image = new FloppyDiskImage();

			foreach(var file in project.Files)
			{
				var filename = file.OutputPath;

				if(file.Address == MemoryAddress.Zero)
					image.Add(ProgramReader.Read(XDocument.Load(filename)));
				else if(file.Block == null)
					image.Add(ProgramReader.Read(XDocument.Load(filename)), file.Address);
				else
					image.Add(ProgramReader.Read(XDocument.Load(filename)), file.Address, file.Block.Value);
			}

			// Write Image To Disk
			Console.WriteLine("Writing x86Console32 To Floppy Drive A:");

			using(SafeFileHandle fileHandle = Kernel32.CreateFile(@"\\.\A:", Kernel32.EFileAccess.GenericWrite, Kernel32.EFileShare.None, IntPtr.Zero, Kernel32.ECreationDisposition.OpenExisting, Kernel32.EFileAttributes.Device, IntPtr.Zero))
			using(FileStream stream = new FileStream(fileHandle, FileAccess.Write))
				image.Save(stream);
		}
	}
}
