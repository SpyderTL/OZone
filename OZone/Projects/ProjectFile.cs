using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OZone.Programs;
using System.IO;

namespace OZone.Projects
{
	public class ProjectFile
	{
		public ProjectFileType Type;
		public MemoryAddress Address;
		public int? Block;
		public string Path;
		public string OutputPath;
	}
}
