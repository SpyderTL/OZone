namespace OZone.Programs
{
	public class ShortValue : ProgramSegment
	{
		public short Value;

		public ShortValue(short value)
		{
			Value = value;
		}

		public override uint GetLength()
		{
			return 2;
		}

		public override void Write(System.IO.BinaryWriter writer)
		{
			writer.Write(Value);
		}
	}
}
