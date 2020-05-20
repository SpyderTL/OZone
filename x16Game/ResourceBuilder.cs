using OZone.Programs;
using System;
using System.Collections.Generic;
using System.IO;

namespace x16Game
{
	internal class ResourceBuilder
	{
		internal static OZone.Programs.Program Build(string path)
		{
			switch (Path.GetExtension(path).ToLower())
			{
				case ".bmp":
					return BuildBmp(path);
			}

			return null;
		}

		private static OZone.Programs.Program BuildBmp(string path)
		{
			BitmapFile.Load(path);
			BitmapImage.LoadImage();

			var segments = new List<OZone.Programs.ProgramSegment>();

			var value = 0;

			for (var value2 = 0; value2 < Image.Values.Length >> 1; value2++)
			{
				var value3 = (byte)(Image.Values[value++] << 4 | Image.Values[value++]);

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