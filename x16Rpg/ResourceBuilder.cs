using OZone.Programs;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace x16Rpg
{
	internal class ResourceBuilder
	{
		internal static OZone.Programs.Program Build(string path)
		{
			switch (Path.GetExtension(path).ToLower())
			{
				case ".bmp":
					if (path.Contains("/Battle/"))
						return BuildBmp4Bpp(path);
					else
						return BuildBmp2Bpp(path);

				case ".bin":
					return BuildRaw(path);
			}

			return null;
		}

		private static OZone.Programs.Program BuildRaw(string path)
		{
			var data = File.ReadAllBytes(path);

			var program = new OZone.Programs.Program();

			program.Segments.AddRange(data.Select(x => new ByteValue(x)));

			return program;
		}

		private static OZone.Programs.Program BuildBmp2Bpp(string path)
		{
			BitmapFile.Load(path);
			BitmapImage.LoadImage();

			var segments = new List<OZone.Programs.ProgramSegment>();

			var value = 0;

			for (var value2 = 0; value2 < Image.Values.Length >> 2; value2++)
			{
				var value3 = (byte)((Image.Values[value++] << 6) | (Image.Values[value++] << 4) | (Image.Values[value++] << 2) | Image.Values[value++]);

				segments.Add(new ByteValue(value3));
			}

			var program = new OZone.Programs.Program
			{
				Segments = segments
			};

			return program;
		}

		private static OZone.Programs.Program BuildBmp4Bpp(string path)
		{
			BitmapFile.Load(path);
			BitmapImage.LoadImage();

			var segments = new List<OZone.Programs.ProgramSegment>();

			var value = 0;

			for (var value2 = 0; value2 < Image.Values.Length >> 1; value2++)
			{
				var value3 = (byte)((Image.Values[value++] << 4) | Image.Values[value++]);

				segments.Add(new ByteValue(value3));
			}

			var program = new OZone.Programs.Program
			{
				Segments = segments
			};

			return program;
		}
	}
}