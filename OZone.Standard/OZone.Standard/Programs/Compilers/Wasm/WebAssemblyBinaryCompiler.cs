using System.IO;
using System.Linq;
using System.Diagnostics;
using System;
using System.Collections.Generic;

namespace OZone.Programs.Compilers
{
	public class WebAssemblyBinaryCompiler : BinaryCompiler
	{
		public override uint Compile(Program program, MemoryAddress baseAddress)
		{
			// Assign memory addresses
			MemoryAddress position = new MemoryAddress { Segment = baseAddress.Segment, Offset = baseAddress.Offset };

			return Compile(program.Segments, position);
		}

		private uint Compile(IEnumerable<ProgramSegment> segments, MemoryAddress position)
		{
			var length = 0U;

			foreach (ProgramSegment segment in segments)
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
			foreach (ProgramSegment segment in program.Segments)
			{
				if (segment is IntValue)
				{
					writer.Write((byte)((uint)(((IntValue)segment).Value & 0x7f) | 0x80));
					writer.Write((byte)((uint)((((IntValue)segment).Value >> 7)) & 0x7f | 0x80));
					writer.Write((byte)((uint)((((IntValue)segment).Value >> 14)) & 0x7f | 0x80));
					writer.Write((byte)((uint)((((IntValue)segment).Value >> 21)) & 0x7f | 0x80));
					writer.Write((byte)((uint)(((IntValue)segment).Value >> 28) & 0x7f));
				}
				else if (segment is UnsignedIntValue)
				{
					writer.Write((byte)(((UnsignedIntValue)segment).Value & 0x7f | 0x80));
					writer.Write((byte)((((UnsignedIntValue)segment).Value >> 7) & 0x7f | 0x80));
					writer.Write((byte)((((UnsignedIntValue)segment).Value >> 14) & 0x7f | 0x80));
					writer.Write((byte)((((UnsignedIntValue)segment).Value >> 21) & 0x7f | 0x80));
					writer.Write((byte)(((UnsignedIntValue)segment).Value >> 28));
				}
				else
					segment.Write(writer);
			}
		}

		public override uint GetLength(ProgramSegment segment)
		{
			if (segment is IntValue)
				return 5;
			else if (segment is UnsignedIntValue)
				return 5;
			else
				return segment.GetLength();
		}
	}
}