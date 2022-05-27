using OZone.Programs;
using OZone.Programs.Compilers;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml;

namespace x16Player
{
	class Program2
	{
		static void Main()
		{
			using (Stream stream = File.Create("Frequencies.xml"))
			using (XmlWriter writer = XmlWriter.Create(stream))
			{
				writer.WriteStartElement("label");

				for (int note = 0; note < 128; note++)
				{
					writer.WriteComment("Note " + note);

					for (int pitch = 0; pitch < 32; pitch++)
					{
						var frequency = 440.0f * (float)Math.Pow(2, (((note - 69) * 32) + pitch) / (12.0f * 32.0f));

						var value = frequency / (48828.125f / ((float)Math.Pow(2, 17)));

						writer.WriteElementString("hex", ((int)value).ToString("X4"));
					}

					writer.WriteRaw("\r\n\r\n");
				}

				writer.WriteEndElement();

				writer.Flush();
			}
		}
	}
}
