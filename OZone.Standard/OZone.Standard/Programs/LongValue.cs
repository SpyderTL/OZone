namespace OZone.Programs
{
	public class LongValue : ProgramSegment
	{
		public long Value;

		public LongValue(long value)
		{
			Value = value;
		}

		public override uint GetLength()
		{
			return 8;
		}

		public override void Write(System.IO.BinaryWriter writer)
		{
			writer.Write(Value);
		}
	}
}
