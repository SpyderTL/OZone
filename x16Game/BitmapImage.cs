using System;

namespace x16Game
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

					default:
						throw new NotSupportedException();
				}
			}
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
	}
}