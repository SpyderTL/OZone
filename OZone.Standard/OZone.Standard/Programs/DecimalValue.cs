namespace OZone.Programs
{
	public class DecimalValue : ProgramSegment
	{
		public decimal Value;

		public DecimalValue(decimal value)
		{
			Value = value;
		}

		public override uint GetLength()
		{
			return 16;
		}

		public override void Write(System.IO.BinaryWriter writer)
		{
			writer.Write(Value);
		}
	}
}
