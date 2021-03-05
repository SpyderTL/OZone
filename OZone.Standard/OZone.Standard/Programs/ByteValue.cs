namespace OZone.Programs
{
	public class ByteValue : ProgramSegment
	{
		public byte Value;

		public ByteValue(byte value)
		{
			Value = value;
		}

		public override uint GetLength()
		{
			return 1;
		}

		public override void Write(System.IO.BinaryWriter writer)
		{
			writer.Write(Value);
		}
	}
}
