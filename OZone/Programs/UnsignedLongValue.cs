namespace OZone.Programs
{
	public class UnsignedLongValue : ProgramSegment
	{
		public ulong Value;

		public UnsignedLongValue(ulong value)
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
