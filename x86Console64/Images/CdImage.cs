using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using OZone.Programs;

namespace x86Console64
{
	public class CdImage
	{
		private List<DiskImageProgram> _programs = new List<DiskImageProgram>();
		private int _block = 21;
		private MemoryAddress _address = new MemoryAddress(0x0000, 0x10000);
		//private const int _startupAddress = 0x10000;
		//private const int _catalogAddress = 0x5000;
		private const int _blockLength = 2048;
		private const int _blockCount = 355990;
		private const int _diskLength = _blockLength * _blockCount;
		//private static readonly int[] _diskInfoBlocks = new int[] { 1, 2 };

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
			var now = DateTime.UtcNow;
			var catalog = _block;

			using(MemoryStream memory = new MemoryStream())
			using(BinaryWriter writer = new BinaryWriter(memory))
			{
				writer.BaseStream.Position = 2048 * 16;

				// Write CD Primary Volume Descriptor

				// Type
				writer.Write((byte)1);
				// Identifier
				writer.Write(Encoding.ASCII.GetBytes("CD001"));
				// Version
				writer.Write((byte)1);

				// Reserved
				writer.Write((byte)0);
				// System ID
				writer.Write(Encoding.ASCII.GetBytes("OZONE                           "));
				// Volume ID
				writer.Write(Encoding.ASCII.GetBytes("x86Console64                    "));
				// Reserved
				writer.Write(new byte[8]);
				// Logical Block Count
				writer.Write((int)355990);
				// Logical Block Count (Big Endian)
				writer.Write(BitConverter.GetBytes((int)355990).Reverse().ToArray());
				// Reserved
				writer.Write(new byte[32]);
				// Disk Count
				writer.Write((short)1);
				// Disk Count (Big Endian)
				writer.Write(BitConverter.GetBytes((short)1).Reverse().ToArray());
				// Disk Number
				writer.Write((short)1);
				// Disk  Number (Big Endian)
				writer.Write(BitConverter.GetBytes((short)1).Reverse().ToArray());
				// Logical Block Length
				writer.Write((short)2048);
				// Logical Block Length (Big Endian)
				writer.Write(BitConverter.GetBytes((short)2048).Reverse().ToArray());
				// Path Table Length
				writer.Write((int)0);
				// Path Table Length (Big Endian)
				writer.Write(BitConverter.GetBytes((int)0).Reverse().ToArray());
				// Type-L Path Table Block
				writer.Write((short)0);
				// Type-L Path Table Block (Big Endian)
				writer.Write(BitConverter.GetBytes((short)0).Reverse().ToArray());
				// Optional Type-L Path Table Block
				writer.Write((short)0);
				// Optional Type-L Path Table Block (Big Endian)
				writer.Write(BitConverter.GetBytes((short)0).Reverse().ToArray());
				// Type-M Path Table Block
				writer.Write((short)0);
				// Type-M Path Table Block (Big Endian)
				writer.Write(BitConverter.GetBytes((short)0).Reverse().ToArray());
				// Optional Type-M Path Table Block
				writer.Write((short)0);
				// Optional Type-M Path Table Block (Big Endian)
				writer.Write(BitConverter.GetBytes((short)0).Reverse().ToArray());

				// Root Directory

				// Record Length
				writer.Write((byte)34);
				// Extended Attribute Length
				writer.Write((byte)0);
				// Root Directory Block
				writer.Write((int)35);
				// Root Directory Block (Big Endian)
				writer.Write(BitConverter.GetBytes((int)32).Reverse().ToArray());
				// Root Directory Length
				writer.Write((int)2048);
				// Root Directory Length (Big Endian)
				writer.Write(BitConverter.GetBytes((int)2048).Reverse().ToArray());
				// Record Year
				writer.Write((byte)now.Year);
				// Record Month
				writer.Write((byte)now.Month);
				// Record Day
				writer.Write((byte)now.Day);
				// Record Hour
				writer.Write((byte)now.Hour);
				// Record Minute
				writer.Write((byte)now.Minute);
				// Record Second
				writer.Write((byte)now.Second);
				// Record Time Zone
				writer.Write((sbyte)0);
				// Flags
				writer.Write((byte)2);
				// Interleaved Unit Size
				writer.Write((byte)0);
				// Interleaved Gap Size
				writer.Write((byte)0);
				// Volume Number
				writer.Write((short)1);
				// Volume Number (Big Endian)
				writer.Write(BitConverter.GetBytes((short)1).Reverse().ToArray());
				// Name Length
				writer.Write((byte)1);
				// Name
				writer.Write('\\');

				// Set ID
				writer.Write(Encoding.ASCII.GetBytes(new string(' ', 128)));
				// Publisher ID
				writer.Write(Encoding.ASCII.GetBytes(new string(' ', 128)));
				// Data Preparer ID
				writer.Write(Encoding.ASCII.GetBytes(new string(' ', 128)));
				// Application ID
				writer.Write(Encoding.ASCII.GetBytes(new string(' ', 128)));
				// Copyright File Name
				writer.Write(Encoding.ASCII.GetBytes(new string(' ', 38)));
				// Abstract File Name
				writer.Write(Encoding.ASCII.GetBytes(new string(' ', 36)));
				// Bibliographic File Name
				writer.Write(Encoding.ASCII.GetBytes(new string(' ', 37)));

				// Date Created
				writer.Write(Encoding.ASCII.GetBytes(now.ToString("yyyyMMddhhmmss00")));
				// Date Created Time Zone
				writer.Write((sbyte)0);
				// Date Modified
				writer.Write(Encoding.ASCII.GetBytes(now.ToString("yyyyMMddhhmmss00")));
				// Date Modified Time Zone
				writer.Write((sbyte)0);
				// Date Expired
				writer.Write(new byte[16]);
				// Date Expired Time Zone
				writer.Write((byte)0);
				// Date Effective
				writer.Write(new byte[16]);
				// Date Effective Time Zone
				writer.Write((byte)0);
				// File Structure Version
				writer.Write((byte)1);
				// Reserved
				writer.Write((byte)0);
				// Application Data
				writer.Write(new byte[512]);
				// Reserved
				writer.Write(new byte[653]);

				// Write Boot Record Descriptor

				// Type
				writer.Write((byte)0);
				// Identifier
				writer.Write(Encoding.ASCII.GetBytes("CD001"));
				// Version
				writer.Write((byte)1);

				// Boot System ID
				writer.Write(Encoding.ASCII.GetBytes("EL TORITO SPECIFICATION\0\0\0\0\0\0\0\0\0"));
				// Reserved
				writer.Write(new byte[32]);
				// Boot Catalog Block
				writer.Write((int)20);
				writer.Write(new byte[1973]);

				// Write Supplementary Volume Descriptor

				// Type
				writer.Write((byte)2);
				// Identifier
				writer.Write(Encoding.ASCII.GetBytes("CD001"));
				// Version
				writer.Write((byte)1);

				// Reserved
				writer.Write((byte)0);
				// System ID
				writer.Write(Encoding.BigEndianUnicode.GetBytes("OZone           "));
				// Volume ID
				writer.Write(Encoding.BigEndianUnicode.GetBytes("x86Console64    "));
				// Reserved
				writer.Write(new byte[8]);
				// Logical Block Count
				writer.Write((int)_blockCount);
				// Logical Block Count (Big Endian)
				writer.Write(BitConverter.GetBytes((int)_blockCount).Reverse().ToArray());
				// Reserved
				writer.Write(new byte[32]);
				// Disk Count
				writer.Write((short)1);
				// Disk Count (Big Endian)
				writer.Write(BitConverter.GetBytes((short)1).Reverse().ToArray());
				// Disk Number
				writer.Write((short)1);
				// Disk  Number (Big Endian)
				writer.Write(BitConverter.GetBytes((short)1).Reverse().ToArray());
				// Logical Block Length
				writer.Write((short)2048);
				// Logical Block Length (Big Endian)
				writer.Write(BitConverter.GetBytes((short)2048).Reverse().ToArray());
				// Path Table Length
				writer.Write((int)0);
				// Path Table Length (Big Endian)
				writer.Write(BitConverter.GetBytes((int)0).Reverse().ToArray());
				// Type-L Path Table Block
				writer.Write((short)0);
				// Type-L Path Table Block (Big Endian)
				writer.Write(BitConverter.GetBytes((short)0).Reverse().ToArray());
				// Optional Type-L Path Table Block
				writer.Write((short)0);
				// Optional Type-L Path Table Block (Big Endian)
				writer.Write(BitConverter.GetBytes((short)0).Reverse().ToArray());
				// Type-M Path Table Block
				writer.Write((short)0);
				// Type-M Path Table Block (Big Endian)
				writer.Write(BitConverter.GetBytes((short)0).Reverse().ToArray());
				// Optional Type-M Path Table Block
				writer.Write((short)0);
				// Optional Type-M Path Table Block (Big Endian)
				writer.Write(BitConverter.GetBytes((short)0).Reverse().ToArray());

				// Root Directory

				// Record Length
				writer.Write((byte)34);
				// Extended Attribute Length
				writer.Write((byte)0);
				// Root Directory Block
				writer.Write((int)0);
				// Root Directory Block (Big Endian)
				writer.Write(BitConverter.GetBytes((int)0).Reverse().ToArray());
				// Root Directory Length
				writer.Write((int)0);
				// Root Directory Length (Big Endian)
				writer.Write(BitConverter.GetBytes((int)0).Reverse().ToArray());
				// Record Year
				writer.Write((byte)now.Year);
				// Record Month
				writer.Write((byte)now.Month);
				// Record Day
				writer.Write((byte)now.Day);
				// Record Hour
				writer.Write((byte)now.Hour);
				// Record Minute
				writer.Write((byte)now.Minute);
				// Record Second
				writer.Write((byte)now.Second);
				// Record Time Zone
				writer.Write((sbyte)0);
				// Flags
				writer.Write((byte)0);
				// Interleaved Unit Size
				writer.Write((byte)0);
				// Interleaved Gap Size
				writer.Write((byte)0);
				// Volume Number
				writer.Write((short)1);
				// Volume Number (Big Endian)
				writer.Write(BitConverter.GetBytes((short)1).Reverse().ToArray());
				// Name Length
				writer.Write((byte)1);
				// Name
				writer.Write('\\');

				// Set ID
				writer.Write(Encoding.BigEndianUnicode.GetBytes(new string(' ', 64)));
				// Publisher ID
				writer.Write(Encoding.BigEndianUnicode.GetBytes(new string(' ', 64)));
				// Data Preparer ID
				writer.Write(Encoding.BigEndianUnicode.GetBytes(new string(' ', 64)));
				// Application ID
				writer.Write(Encoding.BigEndianUnicode.GetBytes(new string(' ', 64)));
				// Copyright File Name
				writer.Write(Encoding.BigEndianUnicode.GetBytes(new string(' ', 19)));
				// Abstract File Name
				writer.Write(Encoding.BigEndianUnicode.GetBytes(new string(' ', 18)));
				// Bibliographic File Name
				writer.Write(Encoding.BigEndianUnicode.GetBytes(new string(' ', 18)));

				writer.Write((byte)0);

				// Date Created
				writer.Write(Encoding.ASCII.GetBytes(now.ToString("yyyyMMddhhmmss00")));
				// Date Created Time Zone
				writer.Write((sbyte)0);
				// Date Modified
				writer.Write(Encoding.ASCII.GetBytes(now.ToString("yyyyMMddhhmmss00")));
				// Date Modified Time Zone
				writer.Write((sbyte)0);
				// Date Expired
				writer.Write(new byte[16]);
				// Date Expired Time Zone
				writer.Write((byte)0);
				// Date Effective
				writer.Write(new byte[16]);
				// Date Effective Time Zone
				writer.Write((byte)0);
				// File Structure Version
				writer.Write((byte)1);
				// Reserved
				writer.Write((byte)0);
				// Application Data
				writer.Write(new byte[512]);
				// Reserved
				writer.Write(new byte[653]);

				// Write Descriptor Terminator

				// Type
				writer.Write((byte)255);
				// Identifier
				writer.Write(Encoding.ASCII.GetBytes("CD001"));
				// Version
				writer.Write((byte)1);

				// Write Boot Descriptor
				writer.BaseStream.Position = 2048 * 20;

				// Write Validation Entry

				// Header ID
				writer.Write((byte)1);
				// Platform ID
				writer.Write((byte)0);
				// Reserved
				writer.Write(new byte[2]);
				// ID
				writer.Write(new byte[24]);
				// Checksum
				writer.Write((short)21930);
				// Key
				writer.Write((byte)0x55);
				writer.Write((byte)0xaa);

				// Write Default Entry

				// Boot Indicator
				writer.Write((byte)0x88);
				// Boot Media Type
				writer.Write((byte)0);
				// Load Segment
				writer.Write((short)0);
				// System Type
				writer.Write((byte)0);
				// Reserved
				writer.Write((byte)0);
				// Sector Count
				writer.Write((short)1);
				// First Block
				writer.Write((int)0);
				// Reserved
				writer.Write(new byte[20]);

				// Write Header Terminator
				writer.Write((byte)0);

				// Write Programs
				foreach(var program in _programs)
				{
					memory.Position = program.Block * _blockLength;
					ProgramCompiler.Compile(program.Program, program.Address, writer);
				}

				//// Write Program List
				//int programs = _block++;
				//_block++;
				//_block++;
				//_block++;
				//int classes = _block++;
				//_block++;
				//_block++;
				//_block++;
				//int objects = _block++;
				//int indexes = _block++;
				//int name = _block++;

				//memory.Position = programs * _blockLength;

				//writer.Write((uint)(_programs.Count));

				//foreach(var program in _programs.Skip(1))
				//{
				//    writer.Write((uint)program.Block);
				//    writer.Write((uint)program.Length);
				//    writer.Write((uint)program.Address.Offset);
				//}

				//writer.Write((uint)classes);
				//writer.Write((uint)4);
				//writer.Write((uint)_catalogAddress);

				//// Write Class List
				//memory.Position = classes * _blockLength;

				//writer.Write((uint)(_programs.Count - 6));

				//foreach(var program in _programs.Skip(6))
				//    writer.Write((uint)program.Address.Offset);

				//// Write Object List
				//memory.Position = objects * _blockLength;

				//writer.Write((uint)0);

				//// Write Index List
				//memory.Position = indexes * _blockLength;

				//writer.Write((uint)0);

				//// Write Disk Name
				//memory.Position = name * _blockLength;

				//var diskName = new StringValue("OZone Operating System v1.0");
				//writer.Write(diskName.GetLength());
				//diskName.Write(writer);

				//// Write Disk Info Blocks
				//foreach(int block in _diskInfoBlocks)
				//{
				//    memory.Position = block * _blockLength;

				//    // Signature
				//    writer.Write("HD14".ToCharArray());

				//    // Version
				//    writer.Write((uint)0);

				//    // Name
				//    writer.Write((uint)name);
				//    writer.Write((uint)1);

				//    // Programs
				//    writer.Write((uint)programs);
				//    writer.Write((uint)4);

				//    // Classes
				//    writer.Write((uint)classes);
				//    writer.Write((uint)4);

				//    // Objects
				//    writer.Write((uint)objects);
				//    writer.Write((uint)1);

				//    // Indexes
				//    writer.Write((uint)indexes);
				//    writer.Write((uint)1);

				//    // Next Block
				//    writer.Write((uint)_block);

				//    writer.Write((uint)_startupAddress);
				//}

				//memory.SetLength(_diskLength);
				memory.SetLength(_block * _blockLength);

				//byte[] data = memory.GetBuffer();

				byte[] data = memory.ToArray();

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
