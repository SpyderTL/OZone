namespace OZone.Programs
{
	public class UnsignedIntValue : ProgramSegment
	{
		public uint Value;

		public UnsignedIntValue(uint value)
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
