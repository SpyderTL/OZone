namespace OZone.Programs
{
	public class Align : ProgramSegment
	{
		public uint Bytes;

		public Align(uint bytes)
		{
			Bytes = bytes;
		}

		public override uint GetLength()
		{
			return (Bytes - (Address.Offset % Bytes)) % Bytes;
		}

		public override void Write(System.IO.BinaryWriter writer)
		{
			writer.Write(new byte[GetLength()]);
		}
	}
}
