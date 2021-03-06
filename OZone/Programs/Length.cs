﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Diagnostics;

namespace OZone.Programs
{
	public class Length : ProgramSegment
	{
		public string From;
		public string To;
		public LengthType Type;

		public ProgramSegment FromSegment;
		public ProgramSegment ToSegment;

		public override uint GetLength()
		{
			switch (Type)
			{
				case LengthType.Absolute8:
					return 1;

				case LengthType.Absolute16:
					return 2;

				case LengthType.Absolute64:
					return 8;

				default:
					return 4;
			}
		}

		public override void Write(System.IO.BinaryWriter writer)
		{
			switch (Type)
			{
				case LengthType.Absolute8:
					writer.Write((byte)(ToSegment.Address.Offset - FromSegment.Address.Offset));
					break;

				case LengthType.Absolute16:
					writer.Write((short)(ToSegment.Address.Offset - FromSegment.Address.Offset));
					break;

				case LengthType.Absolute64:
					writer.Write((long)(ToSegment.Address.Offset - FromSegment.Address.Offset));
					break;

				default:
					writer.Write((int)(ToSegment.Address.Offset - FromSegment.Address.Offset));
					break;
			}
		}
	}
}
