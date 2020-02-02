using System.IO;
using System.Linq;
using System.Diagnostics;
using OZone.Programs;
using System;

namespace OZone.Programs.Compilers.Subleq
{
	public class SubleqCompiler16 : ProgramCompiler
	{
		public override void Compile(Program program, MemoryAddress baseAddress)
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

				if (segment is StringValue)
					position.Offset += (uint)(((StringValue)segment).Value.Length * 2);
				else if (segment is Label)
					continue;
				else
					position.Offset += 2;
			}
		}

		public override void Write(Program program, BinaryWriter writer)
		{
			// Compile program bytes
			foreach (ProgramSegment segment in program.Segments)
			{
				if (segment is StringValue)
					foreach (var character in ((StringValue)segment).Value)
						writer.Write((short)character);
				else if (segment is LongValue)
					writer.Write((short)((LongValue)segment).Value);
				else if (segment is AddressOf)
					writer.Write((short)((AddressOf)segment).Segment.Address.Offset);
			}
		}

		public override uint GetLength(ProgramSegment segment)
		{
			if (segment is StringValue)
				return (uint)(((StringValue)segment).Value.Length * 2);
			else if (segment is Label)
				return 0;
			else
				return 2;
		}
	}
}