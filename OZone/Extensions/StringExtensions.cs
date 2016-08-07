using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Globalization;

namespace System
{
	public static class StringExtensions
	{
		public static byte ToByte(this string value)
		{
			return byte.Parse(value);
		}

		public static sbyte ToSignedByte(this string value)
		{
			return sbyte.Parse(value);
		}

		public static byte ToBinaryByte(this string value)
		{
			byte result = 0;

			foreach(char bit in value)
			{
				result *= 2;

				if(bit == '1')
					result += 1;
			}

			return result;
		}

		public static byte ToHexByte(this string value)
		{
			return byte.Parse(value, NumberStyles.HexNumber);
		}

		public static short ToShort(this string value)
		{
			return short.Parse(value);
		}

		public static ushort ToBinaryShort(this string value)
		{
			ushort result = 0;

			foreach(char bit in value)
			{
				result *= 2;

				if(bit == '1')
					result += 1;
			}

			return result;
		}

		public static ushort ToHexShort(this string value)
		{
			return ushort.Parse(value, NumberStyles.HexNumber);
		}

		public static ushort ToUnsignedShort(this string value)
		{
			return ushort.Parse(value);
		}

		public static int ToInt(this string value)
		{
			return int.Parse(value);
		}

		public static uint ToUnsignedInt(this string value)
		{
			return uint.Parse(value);
		}

		public static uint ToBinaryInt(this string value)
		{
			uint result = 0;

			foreach(char bit in value)
			{
				result *= 2;

				if(bit == '1')
					result += 1;
			}

			return result;
		}

		public static uint ToHexInt(this string value)
		{
			return uint.Parse(value, NumberStyles.HexNumber);
		}

		public static long ToLong(this string value)
		{
			return long.Parse(value);
		}

		public static ulong ToUnsignedLong(this string value)
		{
			return ulong.Parse(value);
		}

		public static float ToFloat(this string value)
		{
			return float.Parse(value);
		}

		public static double ToDouble(this string value)
		{
			return double.Parse(value);
		}

		public static double ToReal(this string value)
		{
			return double.Parse(value);
		}

		public static decimal ToDecimal(this string value)
		{
			return decimal.Parse(value);
		}

		public static ulong ToBinaryLong(this string value)
		{
			ulong result = 0;

			foreach(char bit in value)
			{
				result *= 2;

				if(bit == '1')
					result += 1;
			}

			return result;
		}

		public static ulong ToHexLong(this string value)
		{
			return ulong.Parse(value, NumberStyles.HexNumber);
		}
	}
}
