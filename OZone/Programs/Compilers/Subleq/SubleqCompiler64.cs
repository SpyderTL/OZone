using System.IO;
using System.Linq;
using System.Diagnostics;
using OZone.Programs;

namespace OZone.Programs.Compilers.Subleq
{
	public class SubleqCompiler64 : ProgramCompiler
	{
		public override uint Compile(Program program, MemoryAddress baseAddress)
		{
			var length = 0U;

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

				var length2 = GetLength(segment);

				length += length2;
				position.Offset += length2;
			}

			return length;
		}

		public override void Write(Program program, BinaryWriter writer)
		{
			// Compile program bytes
			foreach (ProgramSegment segment in program.Segments)
			{
				if (segment is StringValue)
					foreach (var character in ((StringValue)segment).Value)
						writer.Write((long)character);
				else if (segment is LongValue)
					writer.Write((long)((LongValue)segment).Value);
				else if (segment is AddressOf)
					writer.Write((long)((AddressOf)segment).Segment.Address.Offset);
			}
		}

		public override uint GetLength(ProgramSegment segment)
		{
			if (segment is StringValue)
				return (uint)(((StringValue)segment).Value.Length * 8);
			else if (segment is Label)
				return 0;
			else
				return 8;
		}
	}
}