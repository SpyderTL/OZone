namespace OZone.Programs
{
	public class SignedByteValue : ProgramSegment
	{
		public sbyte Value;

		public SignedByteValue(sbyte value)
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
