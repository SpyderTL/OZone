using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using OZone.Programs;
using System.IO;

namespace x86Desktop
{
	public class DiskImage
	{
		private List<DiskImageProgram> _programs = new List<DiskImageProgram>();
		private int _block;
		private MemoryAddress _address = new MemoryAddress(0x0000, 0x1000);
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
					Address = _address,
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
					Address = address,
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
					Address = address,
					Program = program
				});
		}

		public void Save(Stream stream)
		{
			int catalog = _block;

			using(MemoryStream memory = new MemoryStream(_diskLength))
			using(BinaryWriter writer = new BinaryWriter(memory))
			{
				// Write Programs
				foreach(var program in _programs)
				{
					memory.Position = program.Block * _blockLength;
					ProgramCompiler.Compile(program.Program, program.Address, writer);
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
					writer.Write((short)0x500);

					foreach(var program in _programs.Skip(1))
					{
						writer.Write((short)program.Block);
						writer.Write((short)program.Length);
						writer.Write((short)program.Address.Offset);
					}

					writer.Write((short)0x1000);
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

		//private class DiskInfoProgram : OZone.Programs.Program
		//{
		//    public DiskInfoProgram(string diskName)
		//    {
		//        StringValue diskName2 = new StringValue(diskName);

		//        Add(new ShortValue(0x4452));
		//        Add(new ShortValue(1));
		//        ShortValue checksum = new ShortValue(0);
		//        Add(checksum);
		//        Add(new AddressOf(diskName2, ReferenceType.Absolute));

		//        Add(diskName2);
		//    }
		//}
	}
}
