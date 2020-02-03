using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OZone.Programs;
using System.IO;
using OZone.Programs.Compilers;

namespace x86Server32
{
	public class FloppyDiskImage
	{
		private List<DiskImageProgram> _programs = new List<DiskImageProgram>();
		private int _block;
		private MemoryAddress _address = new MemoryAddress { Offset = 0x10000 };
		private const int _startupAddress = 0x10000;
		private const int _catalogAddress = 0x2000;
		private const int _blockLength = 512;
		private const int _blockCount = 2880;
		private const int _diskLength = _blockLength * _blockCount;
		private static readonly int[] _diskInfoBlocks = new int[] { 2878, 2879 };

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
			var compiler = new BinaryCompiler();

			using (var memory = new MemoryStream((int)_diskLength))
			using(var writer = new BinaryWriter(memory))
			{
				// Write Programs
				foreach(var program in _programs)
				{
					memory.Position = program.Block * _blockLength;
					compiler.Compile(program.Program, program.Address);
					compiler.Write(program.Program, writer);
				}

				// Write Program List
				int programs = _block++;
				int classes = _block++;
				int objects = _block++;
				int indexes = _block++;
				int name = _block++;

				memory.Position = programs * _blockLength;

				writer.Write((uint)(_programs.Count));

				foreach(var program in _programs.Skip(1))
				{
					writer.Write((uint)program.Block);
					writer.Write((uint)program.Length);
					writer.Write((uint)program.Address.Offset);
				}

				writer.Write((uint)classes);
				writer.Write((uint)1);
				writer.Write((uint)_catalogAddress);

				// Write Class List
				memory.Position = classes * _blockLength;

				writer.Write((uint)(_programs.Count - 5));

				foreach(var program in _programs.Skip(5))
					writer.Write((uint)program.Address.Offset);

				// Write Object List
				memory.Position = objects * _blockLength;

				writer.Write((uint)0);

				// Write Index List
				memory.Position = indexes * _blockLength;

				writer.Write((uint)0);

				// Write Disk Name
				memory.Position = indexes * _blockLength;

				var diskName = new StringValue("OZone Operating System v1.0");
				writer.Write(diskName.GetLength());
				diskName.Write(writer);

				// Write Disk Info Blocks
				foreach(int block in _diskInfoBlocks)
				{
					memory.Position = block * _blockLength;

					// Signature
					writer.Write("FD14".ToCharArray());

					// Version
					writer.Write((uint)0);

					// Name
					writer.Write((uint)name);
					writer.Write((uint)1);

					// Programs
					writer.Write((uint)programs);
					writer.Write((uint)1);

					// Classes
					writer.Write((uint)classes);
					writer.Write((uint)1);

					// Objects
					writer.Write((uint)objects);
					writer.Write((uint)1);

					// Indexes
					writer.Write((uint)indexes);
					writer.Write((uint)1);

					// Next Block
					writer.Write((uint)_block);

					writer.Write((uint)_startupAddress);
				}

				memory.SetLength(_diskLength);

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
