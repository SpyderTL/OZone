using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using OZone.Programs;
using OZone.Programs.Compilers;

namespace x86Console
{
	public class HardDiskImage
	{
		private List<DiskImageProgram> _programs = new List<DiskImageProgram>();
		private int _block = 3;
		private MemoryAddress _address = new MemoryAddress { Segment = 0x1000, Offset = 0x1000 };
		private const int _blockLength = 512;
		private const int _blockCount = 409248;
		private const int _diskLength = _blockLength * _blockCount;
		private static readonly int[] _diskInfoBlocks = new int[] { 1, 2 };

		public void Add(OZone.Programs.Program program)
		{
			int length = (int)program.Segments.Sum(p => p.GetLength());
			int blocks = (int)Math.Ceiling((decimal)length / (decimal)_blockLength);

			_programs.Add(
				new DiskImageProgram
				{
					Block = _block,
					Length = blocks,
					Address = new MemoryAddress
					{
						Offset = _address.Offset,
						Segment = _address.Segment
					},
					Program = program
				});

			_block += blocks;
			_address.Offset += (uint)blocks * (uint)_blockLength;
		}

		public void Add(OZone.Programs.Program program, MemoryAddress address)
		{
			int length = (int)program.Segments.Sum(p => p.GetLength());
			int blocks = length / _blockLength;

			if(length % _blockLength != 0)
				blocks++;

			_programs.Add(
				new DiskImageProgram
				{
					Block = _block,
					Length = blocks,
					Address = new MemoryAddress
					{
						Offset = address.Offset,
						Segment = address.Segment
					},
					Program = program
				});

			_block += blocks;
		}

		public void Add(OZone.Programs.Program program, MemoryAddress address, int block)
		{
			int length = (int)program.Segments.Sum(p => p.GetLength());
			int blocks = length / _blockLength;

			if(length % _blockLength != 0)
				blocks++;

			_programs.Add(
				new DiskImageProgram
				{
					Block = block,
					Length = blocks,
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
			int catalog = _block;

			var compiler = new BinaryCompiler();

			using(MemoryStream memory = new MemoryStream(_diskLength))
			using(BinaryWriter writer = new BinaryWriter(memory))
			{
				// Write Programs
				foreach(var program in _programs)
				{
					memory.Position = program.Block * _blockLength;
					compiler.Compile(program.Program, program.Address, writer);
				}

				// Write Catalog
				memory.Position = catalog * _blockLength;

				writer.Write((short)(_programs.Count - 2));

				foreach(var program in _programs.Skip(2))
					writer.Write((short)program.Address.Offset);

				// Write Disk Info Blocks
				foreach(int block in _diskInfoBlocks)
				{
					memory.Position = block * _blockLength;

					writer.Write((short)_programs.Count);

					writer.Write((short)catalog);
					writer.Write((short)1);
					writer.Write((short)0x0000);
					writer.Write((short)(0x1000));

					foreach(var program in _programs.Skip(1))
					{
						writer.Write((short)program.Block);
						writer.Write((short)program.Length);
						writer.Write((short)program.Address.Offset);
						writer.Write((short)(program.Address.Segment));
					}

					writer.Write((short)0x1000);
					writer.Write((short)0x1000);
				}

				byte[] data = memory.GetBuffer();

				data[510] = 0x55;
				data[511] = 0xaa;

				stream.Write(data, 0, data.Length);
			}
		}

		private struct DiskImageProgram
		{
			public int Block;
			public int Length;
			public MemoryAddress Address;
			public OZone.Programs.Program Program;
		}
	}
}
