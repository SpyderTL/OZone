namespace OZone.Programs
{
	public class RealValue : ProgramSegment
	{
		public double Value;

		public RealValue(double value)
		{
			Value = value;
		}

		public override uint GetLength()
		{
			return 10;
		}

		public override void Write(System.IO.BinaryWriter writer)
		{
			writer.Write(Value);
		}
	}
}
