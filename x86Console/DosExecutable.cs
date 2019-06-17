using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OZone.Programs;
using System.IO;
using OZone.Programs.Compilers;

namespace x86Console
{
	public class DosExecutable
	{
		private List<DosExecutableProgram> _programs = new List<DosExecutableProgram>();
		private MemoryAddress _address = new MemoryAddress { Offset = 0x1000 };
		private MemoryAddress _baseAddress = new MemoryAddress { Offset = 0x0100 };

		public void Add(OZone.Programs.Program program)
		{
			_programs.Add(
				new DosExecutableProgram
				{
					Address = new MemoryAddress
					{
						Offset = _address.Offset,
						Segment = _address.Segment
					},
					Program = program
				});

			_address.Offset += (uint)program.Segments.Sum(p => p.GetLength());
		}

		public void Add(OZone.Programs.Program program, MemoryAddress address)
		{
			_programs.Add(
				new DosExecutableProgram
				{
					Address = new MemoryAddress
					{
						Offset = address.Offset,
						Segment = address.Segment
					},
					Program = program
				});
		}

		public void Save(Stream stream)
		{
			var compiler = new BinaryCompiler();

			using (BinaryWriter writer = new BinaryWriter(stream))
			{
				// Write Programs
				foreach(var program in _programs)
				{
					stream.Position = program.Address.Offset - _baseAddress.Offset;
					compiler.Compile(program.Program, program.Address, writer);

					writer.Flush();
				}

				// Write Catalog
				stream.Position = 0x500 - _baseAddress.Offset;

				writer.Write((short)(_programs.Count - 2));

				foreach(var program in _programs.Skip(2))
					writer.Write((short)program.Address.Offset);

				writer.Flush();
			}
		}

		private struct DosExecutableProgram
		{
			public MemoryAddress Address;
			public OZone.Programs.Program Program;
		}
	}
}
