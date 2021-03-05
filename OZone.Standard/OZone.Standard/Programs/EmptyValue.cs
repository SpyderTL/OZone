namespace OZone.Programs
{
	public class EmptyValue : ProgramSegment
	{
		public uint Length;

		public EmptyValue(uint length)
		{
			Length = length;
		}

		public override uint GetLength()
		{
			return Length;
		}

		public override void Write(System.IO.BinaryWriter writer)
		{
			var data = new byte[Length];

			writer.Write(data);
		}
	}
}
