using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;
using System.Diagnostics;
using System.Xml;

namespace OZone.Programs
{
	public class ProgramReader
	{
		public static Program Read(XDocument document)
		{
			Program program = new Program();

			program.Segments.AddRange(ReadSegments(document.Root));

			return program;
		}

		private static IEnumerable<ProgramSegment> ReadSegments(XElement scope)
		{
			foreach (XElement element in scope.Elements())
			{
				switch (element.Name.LocalName)
				{
					case "binary":
						switch (element.Value.Length)
						{
							case 8:
								yield return new ByteValue(element.Value.ToBinaryByte()) { Element = element };
								break;

							case 16:
								yield return new UnsignedShortValue(element.Value.ToBinaryShort()) { Element = element };
								break;

							case 32:
								yield return new UnsignedIntValue(element.Value.ToBinaryInt()) { Element = element };
								break;

							case 64:
								yield return new UnsignedLongValue(element.Value.ToBinaryLong()) { Element = element };
								break;

							default:
								throw new Exception("Invalid Binary Value: " + element.Value);
						}
						break;

					case "hex":
						switch (element.Value.Length)
						{
							case 2:
								yield return new ByteValue(element.Value.ToHexByte()) { Element = element };
								break;

							case 4:
								yield return new UnsignedShortValue(element.Value.ToHexShort()) { Element = element };
								break;

							case 8:
								yield return new UnsignedIntValue(element.Value.ToHexInt()) { Element = element };
								break;

							case 16:
								yield return new UnsignedLongValue(element.Value.ToHexLong()) { Element = element };
								break;

							default:
								throw new Exception("Invalid Hex Value: " + element.Value);
						}
						break;

					case "byte":
						yield return new ByteValue(element.Value.ToByte()) { Element = element };
						break;

					case "sbyte":
						yield return new SignedByteValue(element.Value.ToSignedByte()) { Element = element };
						break;

					case "short":
						yield return new ShortValue(element.Value.ToShort()) { Element = element };
						break;

					case "ushort":
						yield return new UnsignedShortValue(element.Value.ToUnsignedShort()) { Element = element };
						break;

					case "int":
						yield return new IntValue(element.Value.ToInt()) { Element = element };
						break;

					case "uint":
						yield return new UnsignedIntValue(element.Value.ToUnsignedInt()) { Element = element };
						break;

					case "long":
						yield return new LongValue(element.Value.ToLong()) { Element = element };
						break;

					case "ulong":
						yield return new UnsignedLongValue(element.Value.ToUnsignedLong());
						break;

					case "float":
						yield return new FloatValue(element.Value.ToFloat()) { Element = element };
						break;

					case "double":
						yield return new DoubleValue(element.Value.ToDouble()) { Element = element };
						break;

					case "real":
						yield return new RealValue(element.Value.ToReal()) { Element = element };
						break;

					case "decimal":
						yield return new DecimalValue(element.Value.ToDecimal()) { Element = element };
						break;

					case "string":
						yield return new StringValue(element.Value.Replace("\n", "\r\n")) { Element = element };
						break;

					case "empty":
						yield return new EmptyValue(uint.Parse(element.Attribute("length").Value)) { Element = element };
						break;

					case "align":
						yield return new Align(uint.Parse(element.Attribute("bytes").Value)) { Element = element };
						break;

					case "label":
						Label label = new Label { Id = element.Attribute("id").Value, Element = element };

						if (element.Attributes("page").Any() ||
							element.Attributes("offset").Any())
						{
							label.Address = new MemoryAddress();

							if (element.Attributes("page").Any())
								label.Address.Segment = element.Attribute("page").Value.ToHexInt();

							if (element.Attributes("offset").Any())
								label.Address.Offset = element.Attribute("offset").Value.ToHexInt();
						}

						foreach (var export in element.Attributes("export"))
							label.Export = export.Value;

						yield return label;

						foreach (ProgramSegment programSegment in ReadSegments(element))
							yield return programSegment;

						break;

					case "length":
						var length = new Length { From = element.Attribute("from").Value, To = element.Attribute("to").Value, Type = (LengthType)Enum.Parse(typeof(LengthType), element.Attribute("type").Value), Element = element };

						length.Source = element.ToString();

						yield return length;

						break;

					case "addressOf":
						var addressOf = new AddressOf { Reference = element.Attribute("ref").Value, Type = (ReferenceType)Enum.Parse(typeof(ReferenceType), element.Attribute("type").Value), Element = element };

						var offset = element.Attribute("offset");

						if (offset != null)
							addressOf.Offset = offset.Value.ToInt();
						else
						{
							switch (addressOf.Type)
							{
								case ReferenceType.Relative8:
									addressOf.Offset = -1;
									break;

								case ReferenceType.Relative16:
									addressOf.Offset = -2;
									break;

								case ReferenceType.Relative24:
									addressOf.Offset = -8;
									break;

								case ReferenceType.Relative32:
									addressOf.Offset = -4;
									break;

								case ReferenceType.Relative64:
									addressOf.Offset = -8;
									break;
							}
						}

						var stride = element.Attribute("stride");

						if (stride != null)
							addressOf.Stride = stride.Value.ToInt();
						else
							addressOf.Stride = 1;

						addressOf.Source = element.ToString();

						yield return addressOf;

						break;

					case "scope":
						yield return new Scope { Segments = ReadSegments(element).ToArray(), Element = element };
						break;

					default:
						if (string.Equals(element.Attribute("{http://metalx.org/Program}compile")?.Value, "false", StringComparison.OrdinalIgnoreCase))
						{
							yield return new CustomProgramSegment { Length = Convert.ToUInt32(element.Attribute("{http://metalx.org/Program}length").Value), Reference = element.Attribute("{http://metalx.org/Program}ref")?.Value, Element = element };
						}
						else
						{
							if (((IXmlLineInfo)element).HasLineInfo())
								throw new Exception("Unknown Tag on Line " + ((IXmlLineInfo)element).LineNumber + ": " + element.ToString());

							throw new Exception("Unknown Tag: " + element.ToString());
						}
						break;
				}
			}
		}
	}
}
