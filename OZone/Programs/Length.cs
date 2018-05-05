using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Diagnostics;

namespace OZone.Programs
{
	public class Length : ProgramSegment
	{
		public ProgramSegment Start;
		public ProgramSegment End;

		public override uint GetLength()
		{
			return 1;
		}

		public override void Write(System.IO.BinaryWriter writer)
		{
			writer.Write((byte)(End.Address.Offset - Start.Address.Offset));
		}
	}
}
