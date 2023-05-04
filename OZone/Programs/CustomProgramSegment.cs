using System;
using System.IO;
using System.Xml.Linq;

namespace OZone.Programs
{
	public class CustomProgramSegment : ProgramSegment
	{
		public string Reference;
		public ProgramSegment Segment;
		public uint Length;

		public override uint GetLength()
		{
			return Length;
		}

		public override void Write(BinaryWriter writer)
		{
			throw new Exception("Cannot write custom program segment.  Use post-link transform instead.");
		}
	}
}
