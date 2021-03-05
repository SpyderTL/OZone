using System.IO;
using System.Linq;
using System.Diagnostics;
using System;
using System.Collections.Generic;

namespace OZone.Programs.Compilers
{
	public class BinaryCompiler : ProgramCompiler
	{
		public override uint Compile(Program program, MemoryAddress baseAddress)
		{
			// Assign memory addresses
			MemoryAddress position = new MemoryAddress { Segment = baseAddress.Segment, Offset = baseAddress.Offset };

			return Compile(program.Segments, position);
		}

		private uint Compile(IEnumerable<ProgramSegment> segments, MemoryAddress position)
		{
			uint length = 0;

			foreach(var segment in segments)
			{
				if (segment.Address == null)
					segment.Address = new MemoryAddress
					{
						Offset = position.Offset,
						Segment = position.Segment
					};

				if (segment is Scope scope)
					length += Compile(scope.Segments, position);
				else
				{
					var length2 = GetLength(segment);

					length += length2;
					position.Offset += length2;
				}
			}

			return length;
		}

		public override void Write(Program program, BinaryWriter writer)
		{
			// Compile program bytes
			foreach (ProgramSegment segment in program.Segments)
				segment.Write(writer);
		}

		public override uint GetLength(ProgramSegment segment)
		{
			return segment.GetLength();
		}
	}
}