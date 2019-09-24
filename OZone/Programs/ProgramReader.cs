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

			program.Segments.AddRange(ReadSegments(document.Root, new Dictionary<string, Label>()));

			return program;
		}

		private static IEnumerable<ProgramSegment> ReadSegments(XElement scope, Dictionary<string, Label> labels)
		{
			foreach(var label in scope.Elements("{http://metalx.org/Program}label"))
				labels[label.Attribute("id").Value] = new Label();

			foreach(XElement element in scope.Elements())
			{
				switch(element.Name.LocalName)
				{
					case "binary":
						switch(element.Value.Length)
						{
							case 8:
								yield return new ByteValue(element.Value.ToBinaryByte());
								break;

							case 16:
								yield return new UnsignedShortValue(element.Value.ToBinaryShort());
								break;

							case 32:
								yield return new UnsignedIntValue(element.Value.ToBinaryInt());
								break;

							case 64:
								yield return new UnsignedLongValue(element.Value.ToBinaryLong());
								break;

							default:
								throw new Exception("Invalid Binary Value: " + element.Value);
						}
						break;

					case "hex":
						switch(element.Value.Length)
						{
							case 2:
								yield return new ByteValue(element.Value.ToHexByte());
								break;

							case 4:
								yield return new UnsignedShortValue(element.Value.ToHexShort());
								break;

							case 8:
								yield return new UnsignedIntValue(element.Value.ToHexInt());
								break;

							case 16:
								yield return new UnsignedLongValue(element.Value.ToHexLong());
								break;

							default:
								throw new Exception("Invalid Hex Value: " + element.Value);
						}
						break;

					case "byte":
						yield return new ByteValue(element.Value.ToByte());
						break;

					case "sbyte":
						yield return new SignedByteValue(element.Value.ToSignedByte());
						break;

					case "short":
						yield return new ShortValue(element.Value.ToShort());
						break;

					case "ushort":
						yield return new UnsignedShortValue(element.Value.ToUnsignedShort());
						break;

					case "int":
						yield return new IntValue(element.Value.ToInt());
						break;

					case "uint":
						yield return new UnsignedIntValue(element.Value.ToUnsignedInt());
						break;

					case "long":
						yield return new LongValue(element.Value.ToLong());
						break;

					case "ulong":
						yield return new UnsignedLongValue(element.Value.ToUnsignedLong());
						break;

					case "float":
						yield return new FloatValue(element.Value.ToFloat());
						break;

					case "double":
						yield return new DoubleValue(element.Value.ToDouble());
						break;

					case "real":
						yield return new RealValue(element.Value.ToReal());
						break;

					case "decimal":
						yield return new DecimalValue(element.Value.ToDecimal());
						break;

					case "string":
						yield return new StringValue(element.Value.Replace("\n", "\r\n"));
						break;

					case "empty":
						yield return new EmptyValue(uint.Parse(element.Attribute("length").Value));
						break;

					case "align":
						yield return new Align(uint.Parse(element.Attribute("bytes").Value));
						break;

					case "label":
						Label label = labels[element.Attribute("id").Value];

						if (element.Attributes("page").Any() ||
							element.Attributes("offset").Any())
						{
							label.Address = new MemoryAddress();

							if (element.Attributes("page").Any())
								label.Address.Segment = element.Attribute("page").Value.ToHexInt();

							if (element.Attributes("offset").Any())
								label.Address.Offset = element.Attribute("offset").Value.ToHexInt();
						}

						yield return label;

						foreach(ProgramSegment programSegment in ReadSegments(element, new Dictionary<string, Label>(labels)))
							yield return programSegment;

						break;

					case "addressOf":
						Label segment = null;

						if(labels.ContainsKey(element.Attribute("ref").Value))
							segment = labels[element.Attribute("ref").Value];
						else
							throw new Exception("Label reference not found.\r\n\r\n" + element.ToString());

						var addressOf = new AddressOf { Segment = segment, Type = (ReferenceType)Enum.Parse(typeof(ReferenceType),element.Attribute("type").Value) };

						var offset = element.Attribute("offset");

						if(offset != null)
							addressOf.Offset = offset.Value.ToInt();
						else
						{
							switch(addressOf.Type)
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

						if(stride != null)
							addressOf.Stride = stride.Value.ToInt();
						else
							addressOf.Stride = 1;

						addressOf.Source = element.ToString();

						yield return addressOf;

						break;

					case "scope":
						foreach (var programSegment in ReadSegments(element, new Dictionary<string, Label>(labels)))
							yield return programSegment;
						break;

					case "length":
						ProgramSegment start = null;
						ProgramSegment end = null;

						if (labels.ContainsKey(element.Attribute("start").Value))
							start = labels[element.Attribute("start").Value];
						else
							throw new Exception("Label reference not found.\r\n\r\n" + element.ToString());

						if (labels.ContainsKey(element.Attribute("end").Value))
							end = labels[element.Attribute("end").Value];
						else
							throw new Exception("Label reference not found.\r\n\r\n" + element.ToString());

						var length = new Length { Start = start, End = end };

						yield return length;

						break;

					default:
						if(((IXmlLineInfo)element).HasLineInfo())
							throw new Exception("Unknown Tag on Line " + ((IXmlLineInfo)element).LineNumber + ": " + element.ToString());

						throw new Exception("Unknown Tag: " + element.ToString());
				}
			}
		}
	}
}
