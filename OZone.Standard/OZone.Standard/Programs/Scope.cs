using System.Collections.Generic;
using System.Xml.Linq;

namespace OZone.Programs
{
	public class Scope : ProgramSegment
	{
		public ProgramSegment[] Segments;

		public override uint GetLength()
		{
			var length = 0u;

			foreach (var segment in Segments)
				length += segment.GetLength();

			return length;
		}

		public override void Write(System.IO.BinaryWriter writer)
		{
			foreach (var segment in Segments)
				segment.Write(writer);
		}
	}
}
