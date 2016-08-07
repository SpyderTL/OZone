using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

namespace OZone.IO
{
	public class BigEndianBinaryWriter : BinaryWriter
	{
		public BigEndianBinaryWriter(Stream output)
			: base(output)
		{
		}

		public override void Write(int value)
		{
			base.Write(BitConverter.GetBytes(value).Reverse().ToArray());
		}

		public override void Write(long value)
		{
			base.Write(BitConverter.GetBytes(value).Reverse().ToArray());
		}

		public override void Write(short value)
		{
			base.Write(BitConverter.GetBytes(value).Reverse().ToArray());
		}

		public override void Write(uint value)
		{
			base.Write(BitConverter.GetBytes(value).Reverse().ToArray());
		}

		public override void Write(ulong value)
		{
			base.Write(BitConverter.GetBytes(value).Reverse().ToArray());
		}

		public override void Write(ushort value)
		{
			base.Write(BitConverter.GetBytes(value).Reverse().ToArray());
		}
	}
}
