using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Diagnostics;

namespace OZone.Programs
{
	public class AddressOf : ProgramSegment
	{
		public string Reference;
		public ProgramSegment Segment;
		public ReferenceType Type;
		public int Offset;
		public int Stride;
		public int Mask;

		public override uint GetLength()
		{
			switch(Type)
			{
				case ReferenceType.Absolute16High8:
				case ReferenceType.Absolute24High8:
				case ReferenceType.Absolute32High8:
				case ReferenceType.Absolute40High8:
				case ReferenceType.Absolute48High8:
				case ReferenceType.Absolute56High8:
				case ReferenceType.Absolute64High8:
				case ReferenceType.Absolute8:
				case ReferenceType.Relative8:
					return 1;

				case ReferenceType.Relative24:
				case ReferenceType.Absolute24:
					return 3;

				case ReferenceType.Pointer16:
				case ReferenceType.Absolute32:
				case ReferenceType.Relative32:
					return 4;

				case ReferenceType.Absolute64:
				case ReferenceType.Relative64:
					return 8;

				default:
					return 2;
			}
		}

		public override void Write(System.IO.BinaryWriter writer)
		{
			switch(Type)
			{
				case ReferenceType.Pointer16:
					writer.Write((ushort)(Segment.Address.Offset + Offset));
					writer.Write((ushort)Segment.Address.Segment);
					break;

				case ReferenceType.Segment16:
					writer.Write((ushort)Segment.Address.Segment);
					break;

				case ReferenceType.Absolute16:
					writer.Write((ushort)(Segment.Address.Offset + Offset));
					break;

				case ReferenceType.Absolute32:
					writer.Write((uint)(Segment.Address.Offset + Offset));
					break;

				case ReferenceType.Absolute64:
					writer.Write((ulong)(Segment.Address.Offset + Offset));
					break;

				case ReferenceType.Absolute8:
					writer.Write((byte)((Segment.Address.Offset + Offset) & 0xff));
					break;

				case ReferenceType.Absolute16High8:
					writer.Write((byte)(((Segment.Address.Offset + Offset) & 0xff00) >> 8));
					break;

				case ReferenceType.Absolute24High8:
					writer.Write((byte)(((Segment.Address.Offset + Offset) & 0xff0000) >> 16));
					break;

				case ReferenceType.Absolute32High8:
					writer.Write((byte)(((Segment.Address.Offset + Offset) & 0xff000000) >> 24));
					break;

				case ReferenceType.Absolute40High8:
					writer.Write((byte)(((Segment.Address.Offset + Offset) & 0xff00000000) >> 32));
					break;

				case ReferenceType.Absolute48High8:
					writer.Write((byte)(((Segment.Address.Offset + Offset) & 0xff0000000000) >> 40));
					break;

				case ReferenceType.Absolute56High8:
					writer.Write((byte)(((Segment.Address.Offset + Offset) & 0xff000000000000) >> 48));
					break;

				case ReferenceType.Absolute64High8:
					writer.Write((byte)(((ulong)(Segment.Address.Offset + Offset) & 0xff00000000000000) >> 56));
					break;

				case ReferenceType.Relative8:
					{
						long offset = ((long)Segment.Address.Offset - (long)Address.Offset + (long)Offset) / (long)Stride;

						if(offset > sbyte.MaxValue || offset < sbyte.MinValue)
							throw new Exception("Relative8 reference out of range.\r" + Source);

						writer.Write((byte)offset);
					}
					break;

				case ReferenceType.Relative16:
					{
						long offset = ((long)Segment.Address.Offset - (long)Address.Offset + (long)Offset) / (long)Stride;

						if(offset > short.MaxValue || offset < short.MinValue)
							throw new Exception("Relative16 reference out of range");

						writer.Write((short)offset);
					}
					break;

				case ReferenceType.Relative24:
					{
						long offset = ((long)Segment.Address.Offset - (long)Address.Offset + (long)Offset) / (long)Stride;

						//if(offset > short.MaxValue || offset < short.MinValue)
						//    throw new Exception("Relative16 reference out of range");

						writer.Write((byte)((offset >> 0) & 0xff));
						writer.Write((byte)((offset >> 8) & 0xff));
						writer.Write((byte)((offset >> 16) & 0xff));
					}
					break;

				case ReferenceType.Relative32:
					{
						long offset = ((long)Segment.Address.Offset - (long)Address.Offset + (long)Offset) / (long)Stride;

						if(offset > int.MaxValue || offset < int.MinValue)
							throw new Exception("Relative32 reference out of range");

						writer.Write((int)offset);
					}
					break;

				case ReferenceType.Relative64:
					{
						long offset = ((long)Segment.Address.Offset - (long)Address.Offset + (long)Offset) / (long)Stride;

						if(offset > long.MaxValue || offset < long.MinValue)
							throw new Exception("Relative64 reference out of range");

						writer.Write((long)offset);
					}
					break;

				default:
					throw new Exception("Unknown Reference Type");
			}
		}
	}
}
