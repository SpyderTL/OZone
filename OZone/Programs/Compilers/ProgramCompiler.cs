using System.IO;
using System.Linq;
using System.Diagnostics;

namespace OZone.Programs.Compilers
{
	public abstract class ProgramCompiler
	{
		public abstract void Compile(Program program, MemoryAddress baseAddress, BinaryWriter writer);
		public abstract uint GetLength(ProgramSegment segment);
	}
}