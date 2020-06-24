using System;
using System.Linq;
using System.Text;

namespace x16Rpg
{
	internal class BitmapImage
	{
		internal static void LoadImage()
		{
			Image.Width = (uint)Math.Abs((long)BitmapFile.Width);
			Image.Height = (uint)Math.Abs((long)BitmapFile.Height);

			if (BitmapFile.Palette == null || BitmapFile.Palette.Length == 0)
			{

			}
			else
			{
				Image.Colors = BitmapFile.Palette;

				Image.Values = new byte[Image.Width * Image.Height];

				switch (BitmapFile.BitsPerPixel)
				{
					case 4:
						LoadImage4Bpp();
						break;

					case 8:
						LoadImage8Bpp();
						break;

					default:
						throw new NotSupportedException();
				}
			}
		}

		internal static void SaveImage()
		{
			BitmapFile.Width = (int)Image.Width;
			BitmapFile.Height = -(int)Image.Height;

			if (Image.Values == null || Image.Values.Length == 0)
			{

			}
			else
			{
				switch (Image.Colors.Length)
				{
					case 2:
						break;

					case 4:
						SaveImage2Bpp();
						break;

					case 16:
						SaveImage4Bpp();
						break;
				}
			}
		}

		private static void SaveImage2Bpp()
		{
			BitmapFile.BitsPerPixel = 2;
			BitmapFile.Palette = Image.Colors;
			BitmapFile.PixelData = Enumerable.Range(0, Image.Values.Length >> 2).Select(x => (byte)((Image.Values[(x * 4) + 0] << 6) | (Image.Values[(x * 4) + 1] << 4) | (Image.Values[(x * 4) + 2] << 2) | (Image.Values[(x * 4) + 3] << 0))).ToArray();
		}

		private static void SaveImage4Bpp()
		{
			BitmapFile.BitsPerPixel = 4;
			BitmapFile.Palette = Image.Colors;
			BitmapFile.PixelData = Enumerable.Range(0, Image.Values.Length >> 1).Select(x => (byte)((Image.Values[(x * 2) + 0] << 4) | (Image.Values[(x * 2) + 1] << 0))).ToArray();
		}

		internal static void LoadImage4Bpp()
		{
			var pixel = 0;
			var position = 0;

			var stride = (((BitmapFile.BitsPerPixel * BitmapFile.Width) + 31) >> 5) << 2;

			if (BitmapFile.Height < 0)
			{
				while (position < BitmapFile.PixelData.Length)
				{
					var position2 = position;

					for (var x = 0; x < (BitmapFile.Width >> 1); x++)
					{
						Image.Values[pixel++] = (byte)(BitmapFile.PixelData[position] >> 4);
						Image.Values[pixel++] = (byte)(BitmapFile.PixelData[position] & 0x0f);

						position++;
					}

					position = position2 + stride;
				}
			}
			else
			{
				for (var y = (int)Image.Height - 1; y >= 0; y--)
				{
					var position2 = position;

					pixel = y * (int)Image.Width;

					for (var x = 0; x < ((int)Image.Width >> 1); x++)
					{
						Image.Values[pixel++] = (byte)(BitmapFile.PixelData[position] >> 4);
						Image.Values[pixel++] = (byte)(BitmapFile.PixelData[position] & 0x0f);

						position++;
					}

					position = position2 + stride;
				}
			}
		}

		internal static void LoadImage8Bpp()
		{
			var pixel = 0;
			var position = 0;

			var stride = (((BitmapFile.BitsPerPixel * BitmapFile.Width) + 31) >> 5) << 2;

			if (BitmapFile.Height < 0)
			{
				while (position < BitmapFile.PixelData.Length)
				{
					var position2 = position;

					for (var x = 0; x < (BitmapFile.Width); x++)
					{
						Image.Values[pixel++] = BitmapFile.PixelData[position];

						position++;
					}

					position = position2 + stride;
				}
			}
			else
			{
				for (var y = (int)Image.Height - 1; y >= 0; y--)
				{
					var position2 = position;

					pixel = y * (int)Image.Width;

					for (var x = 0; x < ((int)Image.Width); x++)
					{
						Image.Values[pixel++] = BitmapFile.PixelData[position];

						position++;
					}

					position = position2 + stride;
				}
			}
		}
	}
}