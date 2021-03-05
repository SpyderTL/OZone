namespace OZone.Programs
{
	public class StringValue : ProgramSegment
	{
		public string Value;

		public StringValue(string value)
		{
			Value = value;
		}

		public override uint GetLength()
		{
			return (uint)Value.Length;
		}

		public override void Write(System.IO.BinaryWriter writer)
		{
			writer.Write(Value.ToCharArray());
		}
	}
}
