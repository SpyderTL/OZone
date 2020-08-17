using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using OZone.Programs;
using OZone.Programs.Compilers;

namespace PiConsole
{
	public class KernelImage
	{
		private List<KernelImageProgram> _programs = new List<KernelImageProgram>();
		private MemoryAddress _address = new MemoryAddress { Offset = 0x8000 };

		public void Add(OZone.Programs.Program program)
		{
			var address = new MemoryAddress { Offset = _address.Offset };

			foreach (var segment in program.Segments)
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
			foreach (var segment in program.Segments)
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
			var compiler = new BinaryCompiler();

			using (BinaryWriter writer = new BinaryWriter(stream))
			{
				var exports = new Dictionary<string, Label>();

				foreach (var program in _programs)
				{
					compiler.Compile(program.Program, program.Address);

					foreach (var label in program.Program.Segments.OfType<Label>())
					{
						if (label.Export != null)
							exports[label.Export] = label;
					}
				}

				foreach (var program in _programs)
				{
					compiler.Link(program.Program, exports);
				}

				foreach (var program in _programs)
				{
					compiler.Write(program.Program, writer);
				}

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
