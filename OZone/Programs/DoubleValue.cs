namespace OZone.Programs
{
	public class DoubleValue : ProgramSegment
	{
		public double Value;

		public DoubleValue(double value)
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
