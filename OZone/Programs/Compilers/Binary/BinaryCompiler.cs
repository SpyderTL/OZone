using System.IO;
using System.Linq;
using System.Diagnostics;
using System;

namespace OZone.Programs.Compilers
{
	public class BinaryCompiler : ProgramCompiler
	{
		public override void Compile(Program program, MemoryAddress baseAddress, BinaryWriter writer)
		{
			// Assign memory addresses
			MemoryAddress position = new MemoryAddress { Segment = baseAddress.Segment, Offset = baseAddress.Offset };

			foreach(ProgramSegment segment in program.Segments)
			{
				if (segment.Address == null)
					segment.Address = new MemoryAddress
					{
						Offset = position.Offset,
						Segment = position.Segment
					};

				position.Offset += segment.GetLength();
			}

			// Compile program bytes
			foreach(ProgramSegment segment in program.Segments)
				segment.Write(writer);
		}

		public override uint GetLength(ProgramSegment segment)
		{
			return segment.GetLength();
		}
	}
}