using System;
using System.Drawing;
using System.IO;
using System.Linq;

namespace x16Rpg
{
	internal class BitmapFile
	{
		internal static byte[] Signature;
		internal static uint Length;
		internal static byte[] Reserved;
		internal static uint PixelOffset;

		internal static uint HeaderLength;
		internal static int Width;
		internal static int Height;
		internal static ushort ColorPlanes;
		internal static ushort BitsPerPixel;
		internal static uint CompressionMethod;
		internal static uint PixelLength;
		internal static int HorizontalResolution;
		internal static int VerticalResolution;
		internal static uint PaletteEntries;
		internal static uint ImportantColors;

		internal static byte BitmaskRed;
		internal static byte BitmaskGreen;
		internal static byte BitmaskBlue;

		internal static Color[] Palette;

		internal static byte[] PixelData;

		internal static void Load(string path)
		{
			using (var stream = File.OpenRead(path))
			using (var reader = new BinaryReader(stream))
			{
				Signature = reader.ReadBytes(2);
				Length = reader.ReadUInt32();
				Reserved = reader.ReadBytes(4);
				PixelOffset = reader.ReadUInt32();

				HeaderLength = reader.ReadUInt32();
				Width = reader.ReadInt32();
				Height = reader.ReadInt32();
				ColorPlanes = reader.ReadUInt16();
				BitsPerPixel = reader.ReadUInt16();
				CompressionMethod = reader.ReadUInt32();
				PixelLength = reader.ReadUInt32();
				HorizontalResolution = reader.ReadInt32();
				VerticalResolution = reader.ReadInt32();
				PaletteEntries = reader.ReadUInt32();
				ImportantColors = reader.ReadUInt32();

				if (CompressionMethod == 3)
				{
					BitmaskRed = reader.ReadByte();
					BitmaskGreen = reader.ReadByte();
					BitmaskBlue = reader.ReadByte();
				}

				var paletteEntryCount = PaletteEntries;

				if (paletteEntryCount == 0)
					paletteEntryCount = (uint)Math.Pow(2, BitsPerPixel);

				Palette = new Color[paletteEntryCount];

				for (var x = 0; x < paletteEntryCount; x++)
				{
					int r = reader.ReadByte();
					int g = reader.ReadByte();
					int b = reader.ReadByte();
					int a = reader.ReadByte();

					Palette[x] = Color.FromArgb(a, r, g, b);
				}

				PixelData = reader.ReadBytes((int)PixelLength);
			}
		}

		internal static void Save(string path)
		{
			using (var stream = File.Create(path))
			using (var writer = new BinaryWriter(stream))
			{
				// File Header
				writer.Write(System.Text.Encoding.ASCII.GetBytes("BM"));
				var fileLengthPosition = stream.Position;
				writer.Write(0);
				writer.Write(0);
				var pixelOffsetPosition = stream.Position;
				writer.Write(0);

				// Bitmap Header
				writer.Write(40);
				writer.Write(Width);
				writer.Write(Height);
				writer.Write((short)1);
				writer.Write(BitsPerPixel);
				writer.Write(0);
				var pixelLengthPosition = stream.Position;
				writer.Write(0);
				writer.Write(3779);
				writer.Write(3779);
				writer.Write(0);
				writer.Write(0);

				// Palette Entries
				var entries = Math.Pow(2, BitsPerPixel);

				for (var entry = 0; entry < entries; entry++)
				{
					if (entry < Palette.Length)
					{
						writer.Write(Palette[entry].B);
						writer.Write(Palette[entry].G);
						writer.Write(Palette[entry].R);
						writer.Write(Palette[entry].A);
					}
					else
						writer.Write(0);
				}

				// Pixels
				var pixelPosition = stream.Position;
				writer.Write(PixelData);
				var endPosition = stream.Position;

				// Update Header
				stream.Position = fileLengthPosition;
				writer.Write((uint)endPosition);

				stream.Position = pixelOffsetPosition;
				writer.Write((uint)pixelPosition);

				stream.Position = pixelLengthPosition;
				writer.Write((uint)(endPosition - pixelPosition));

				writer.Flush();
			}
		}
	}
}