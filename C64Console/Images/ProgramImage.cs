using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OZone.Programs;
using System.IO;
using OZone.Programs.Compilers;

namespace C64Console
{
	public class ProgramImage
	{
		private List<ProgramImageProgram> _programs = new List<ProgramImageProgram>();
		private int _block = 3;
		private MemoryAddress _address = new MemoryAddress { Offset = 0x100000 };
		private const int _startupAddress = 0x100000;
		private const int _catalogAddress = 0x5000;
		private const int _blockLength = 512;
		private const int _blockCount = 2880;
		private const int _diskLength = _blockLength * _blockCount;
		private static readonly int[] _diskInfoBlocks = new int[] { 1, 2 };
		private const int _bootLoaderCount = 8;

		public void Add(Program program, bool catalog)
		{
			int length = (int)program.Segments.Sum(p => p.GetLength());
			int blocks = (int)Math.Ceiling((decimal)length / (decimal)_blockLength);

			_programs.Add(
				new ProgramImageProgram
				{
					Block = _block,
					Length = blocks,
					Address = new MemoryAddress { Segment = _address.Segment, Offset = _address.Offset },
					Program = program,
					Catalog = catalog
				});

			_block += blocks;
			_address.Offset += (uint)blocks * (uint)_blockLength;
		}

		public void Add(Program program, MemoryAddress address, bool catalog)
		{
			int length = (int)program.Segments.Sum(p => p.GetLength());
			int blocks = length / _blockLength;

			if (length % _blockLength != 0)
				blocks++;

			_programs.Add(
				new ProgramImageProgram
				{
					Block = _block,
					Length = blocks,
					Address = new MemoryAddress
					{
						Offset = address.Offset,
						Segment = address.Segment
					},
					Program = program,
					Catalog = catalog
				});

			_block += blocks;
		}

		public void Add(Program program, MemoryAddress address, int block, bool catalog)
		{
			int length = (int)program.Segments.Sum(p => p.GetLength());
			int blocks = length / _blockLength;

			if (length % _blockLength != 0)
				blocks++;

			_programs.Add(
				new ProgramImageProgram
				{
					Block = block,
					Length = blocks,
					Address = new MemoryAddress
					{
						Offset = address.Offset,
						Segment = address.Segment
					},
					Program = program,
					Catalog = catalog
				});
		}

		public void Save(Stream stream)
		{
			var compiler = new BinaryCompiler();

			using (var memory = new MemoryStream((int)_diskLength))
			using (var writer = new BinaryWriter(memory))
			{
				// Write Programs
				foreach (var program in _programs)
				{
					memory.Position = program.Block * _blockLength;
					compiler.Compile(program.Program, program.Address, writer);
				}

				// Write Program List
				int programs = _block;
				int programsLength = (int)Math.Ceiling((((decimal)_programs.Count * 12.0m) + 4.0m) / (decimal)_blockLength);

				_block += programsLength;

				int catalog = _block;
				int catalogLength = (int)Math.Ceiling(((decimal)(_programs.Count(p => p.Catalog)) * 4.0m) / (decimal)_blockLength);

				_block += catalogLength;

				int objects = _block++;
				int indexes = _block++;
				int name = _block++;

				memory.Position = programs * _blockLength;

				writer.Write((uint)(_programs.Count));

				foreach (var program in _programs.Skip(1))
				{
					writer.Write((uint)program.Block);
					writer.Write((uint)program.Length);
					writer.Write((uint)program.Address.Offset);
				}

				writer.Write((uint)catalog);
				writer.Write((uint)catalogLength);
				writer.Write((uint)_catalogAddress);

				// Write Catalog
				memory.Position = catalog * _blockLength;

				writer.Write((uint)(_programs.Count(p => p.Catalog)));

				foreach (var program in _programs.Where(p => p.Catalog).OrderBy(p => Path.GetFileName(p.Program.Name)))
					writer.Write((uint)program.Address.Offset);

				// Write Object List
				memory.Position = objects * _blockLength;

				writer.Write((uint)0);

				// Write Index List
				memory.Position = indexes * _blockLength;

				writer.Write((uint)0);

				// Write Disk Name
				memory.Position = name * _blockLength;

				var diskName = new StringValue("OZone Operating System v1.0");
				writer.Write(diskName.GetLength());
				diskName.Write(writer);

				// Write Disk Info Blocks
				foreach (int block in _diskInfoBlocks)
				{
					memory.Position = block * _blockLength;

					// Signature
					writer.Write("HD14".ToCharArray());

					// Version
					writer.Write((uint)0);

					// Name
					writer.Write((uint)name);
					writer.Write((uint)1);

					// Programs
					writer.Write((uint)programs);
					writer.Write((uint)programsLength);

					// Catalog
					writer.Write((uint)catalog);
					writer.Write((uint)catalogLength);

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

		private struct ProgramImageProgram
		{
			public int Block;
			public int Length;
			public MemoryAddress Address;
			public Program Program;
			public bool Catalog;
		}
	}
}
