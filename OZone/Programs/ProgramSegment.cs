using System.IO;
using System.Xml.Linq;

namespace OZone.Programs
{
	public abstract class ProgramSegment
	{
		public MemoryAddress Address;
		public string Source;
		public XElement Element;

		public abstract uint GetLength();
		public abstract void Write(BinaryWriter writer);
	}
}
