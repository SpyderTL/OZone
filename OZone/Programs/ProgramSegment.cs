using System.IO;
namespace OZone.Programs
{
	public abstract class ProgramSegment
	{
		public MemoryAddress Address;
		public string Source;

		public abstract uint GetLength();
		public abstract void Write(BinaryWriter writer);
	}
}
