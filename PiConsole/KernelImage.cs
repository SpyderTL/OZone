using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using OZone.Programs;

namespace PiConsole
{
	public class KernelImage
	{
		private List<KernelImageProgram> _programs = new List<KernelImageProgram>();
		private MemoryAddress _address = new MemoryAddress { Offset = 0x8000 };

		public void Add(OZone.Programs.Program program)
		{
			var address = _address;

			foreach(var segment in program.Segments)
			{
				segment.Address = new MemoryAddress
				{
					Offset = address.Offset,
					Segment = address.Segment
				};

				address.Offset += segment.GetLength();
			}

			int length = (int)program.Segments.Sum(p => p.GetLength());

			_programs.Add(
				new KernelImageProgram
				{
					Length = length,
					Address = new MemoryAddress
					{
						Offset = _address.Offset,
						Segment = _address.Segment
					},
					Program = program
				});

			_address.Offset += (uint)length;
		}

		public void Add(OZone.Programs.Program program, MemoryAddress address)
		{
			foreach(var segment in program.Segments)
			{
				segment.Address = new MemoryAddress
				{
					Offset = address.Offset,
					Segment = address.Segment
				};

				address.Offset += segment.GetLength();
			}

			int length = (int)program.Segments.Sum(p => p.GetLength());

			_programs.Add(
				new KernelImageProgram
				{
					Length = length,
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
			using(BinaryWriter writer = new BinaryWriter(stream))
			{
				foreach(var program in _programs)
					ProgramCompiler.Compile(program.Program, program.Address, writer);

				writer.Flush();
			}
		}

		private struct KernelImageProgram
		{
			//public int Block;
			public int Length;
			public MemoryAddress Address;
			public OZone.Programs.Program Program;
		}
	}
}
