using System.IO;
using System.Linq;
using System.Diagnostics;
using OZone.Programs;

namespace OZone.Programs.Compilers.Subleq
{
	public static class SubleqTextCompiler
	{
		public static void Compile(Program program, MemoryAddress baseAddress, TextWriter writer)
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
					position.Offset += (uint)((StringValue)segment).Value.Length;
				else if (segment is Label)
					continue;
				else
					position.Offset++;
			}

			// Compile program bytes
			foreach (ProgramSegment segment in program.Segments)
			{
				if (segment is StringValue)
					writer.WriteLine(string.Join(" ", ((StringValue)segment).Value.Select(c => (int)c)));
				else if (segment is EmptyValue)
					for(var line = 0; line < ((EmptyValue)segment).Length; line++)
						writer.WriteLine("0");
				else if (segment is LongValue)
					writer.WriteLine(((LongValue)segment).Value);
				else if (segment is AddressOf)
					writer.WriteLine(((AddressOf)segment).Segment.Address.Offset);
			}
		}
	}
}
