using System.Collections.Generic;
using System.Linq;

namespace OZone.Programs
{
	public class Program
	{
		public string Name;

		public List<ProgramSegment> Segments = new List<ProgramSegment>();

		public ProgramSegment AppendRoutine(IEnumerable<ProgramSegment> routine)
		{
			List<ProgramSegment> segments = routine.ToList();

			Segments.AddRange(segments);

			return segments[0];
		}

		public ProgramSegment Append(ProgramSegment segment)
		{
			Segments.Add(segment);

			return segment;
		}

		public ProgramSegment Append(byte value)
		{
			return this.Append(new ByteValue(value));
		}

		public ProgramSegment Append(sbyte value)
		{
			return this.Append(new SignedByteValue(value));
		}

		public ProgramSegment Append(short value)
		{
			return this.Append(new ShortValue(value));
		}

		public ProgramSegment Append(ushort value)
		{
			return this.Append(new UnsignedShortValue(value));
		}

		public ProgramSegment Append(int value)
		{
			return this.Append(new IntValue(value));
		}

		public ProgramSegment Append(uint value)
		{
			return this.Append(new UnsignedIntValue(value));
		}

		public ProgramSegment Append(long value)
		{
			return this.Append(new LongValue(value));
		}

		public ProgramSegment Append(ulong value)
		{
			return this.Append(new UnsignedLongValue(value));
		}

		public ProgramSegment Append(char value)
		{
			return this.Append(new ByteValue((byte)value));
		}

		public ProgramSegment Append(string value)
		{
			return this.Append(new StringValue(value));
		}

		public ProgramSegment AppendReference(ProgramSegment segment, ReferenceType type)
		{
			return this.Append(new AddressOf { Segment = segment, Type = type });
		}

		public ProgramSegment AppendReference(ProgramSegment segment, ReferenceType type, int offset)
		{
			return this.Append(new AddressOf { Segment = segment, Type = type, Offset = offset });
		}

		public Label AppendLabel()
		{
			Label label = new Label();
			this.Append(label);

			return label;
		}

		public Label AppendLabel(Label label)
		{
			this.Append(label);
			return label;
		}
	}
}
