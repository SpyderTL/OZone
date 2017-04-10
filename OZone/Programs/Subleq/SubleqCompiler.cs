using System.IO;
using System.Linq;
using System.Diagnostics;
using OZone.Programs;

namespace OZone.Programs.Subleq
{
	public static class SubleqCompiler
	{
		public static void Compile(Program program, MemoryAddress baseAddress, BinaryWriter writer)
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
	}
}
