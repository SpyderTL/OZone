namespace OZone.Programs
{
	public class IntValue : ProgramSegment
	{
		public int Value;

		public IntValue(int value)
		{
			Value = value;
		}

		public override uint GetLength()
		{
			return 4;
		}

		public override void Write(System.IO.BinaryWriter writer)
		{
			writer.Write(Value);
		}
	}
}
