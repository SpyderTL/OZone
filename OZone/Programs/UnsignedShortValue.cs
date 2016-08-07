namespace OZone.Programs
{
	public class UnsignedShortValue : ProgramSegment
	{
		public ushort Value;

		public UnsignedShortValue(ushort value)
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
