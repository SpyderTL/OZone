using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OZone.Programs;
using System.IO;

namespace x86Console
{
	public class DosExecutable
	{
		private List<DosExecutableProgram> _programs = new List<DosExecutableProgram>();
		private MemoryAddress _address = new MemoryAddress(0x0000, 0x1000);
		private MemoryAddress _baseAddress = new MemoryAddress(0x0000, 0x0100);

		public void Add(OZone.Programs.Program program)
		{
			_programs.Add(
				new DosExecutableProgram
				{
					Address = _address,
					Program = program
				});

			_address.Offset += (uint)program.Segments.Sum(p => p.GetLength());
		}

		public void Add(OZone.Programs.Program program, MemoryAddress address)
		{
			_programs.Add(
				new DosExecutableProgram
				{
					Address = address,
					Program = program
				});
		}

		public void Save(Stream stream)
		{
			using(BinaryWriter writer = new BinaryWriter(stream))
			{
				// Write Programs
				foreach(var program in _programs)
				{
					stream.Position = program.Address.Offset - _baseAddress.Offset;
					ProgramCompiler.Compile(program.Program, program.Address, writer);
				}

				// Write Catalog
				stream.Position = 0x500 - _baseAddress.Offset;

				writer.Write((short)(_programs.Count - 2));

				foreach(var program in _programs.Skip(2))
					writer.Write((short)program.Address.Offset);
			}
		}

		private struct DosExecutableProgram
		{
			public MemoryAddress Address;
			public OZone.Programs.Program Program;
		}
	}
}
