using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OZone.Programs;

namespace OZone.Projects
{
	public class Project
	{
		public string Name;
		public List<string> Paths = new List<string>();
		public List<ProjectTransform> Transforms = new List<ProjectTransform>();
		public List<ProjectFile> Files = new List<ProjectFile>();
	}
}
