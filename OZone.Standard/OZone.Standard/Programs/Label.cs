using System.Collections.Generic;
using System.Xml.Linq;

namespace OZone.Programs
{
	public class Label : ProgramSegment
	{
		public string Id;
		public string Export;

		public override uint GetLength()
		{
			return 0;
		}

		public override void Write(System.IO.BinaryWriter writer)
		{
		}
	}
}
