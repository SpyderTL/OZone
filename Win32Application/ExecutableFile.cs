using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OZone.Programs;
using System.IO;

namespace Win32Application
{
	public class ExecutableFile
	{
		private List<ExecutableProgram> _programs = new List<ExecutableProgram>();
		private MemoryAddress _address = new MemoryAddress(0x0000, 0x400000);

		public void Add(OZone.Programs.Program program)
		{
			uint length = (uint)program.Segments.Sum(p => p.GetLength());

			_programs.Add(
				new ExecutableProgram
				{
					Length = length,
					Address = _address,
					Program = program
				});

			_address.Offset += length;
		}

		public void Add(OZone.Programs.Program program, MemoryAddress address)
		{
			uint length = (uint)program.Segments.Sum(p => p.GetLength());

			_programs.Add(
				new ExecutableProgram
				{
					Length = length,
					Address = address,
					Program = program
				});
		}

		public void Save(Stream stream)
		{
			using(var writer = new BinaryWriter(stream))
			{
				// Build Header
				var header = new Program();



				ProgramCompiler.Compile(header, MemoryAddress.Zero, writer);

				// Write Programs
				foreach(var program in _programs)
					ProgramCompiler.Compile(program.Program, program.Address, writer);
			}
		}

		private struct ExecutableProgram
		{
			public uint Length;
			public MemoryAddress Address;
			public OZone.Programs.Program Program;
		}
	}
}
