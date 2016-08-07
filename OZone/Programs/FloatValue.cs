namespace OZone.Programs
{
	public class FloatValue : ProgramSegment
	{
		public float Value;

		public FloatValue(float value)
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
