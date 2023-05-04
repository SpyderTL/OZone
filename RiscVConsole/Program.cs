﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Xml.Linq;
using OZone.Programs;
using OZone.Programs.Compilers;

namespace RiscVConsole
{
	class Program
	{
		static void Main(string[] args)
		{
			var compiler = new BinaryCompiler();

			using (var stream = File.Create("RiscVConsole.bin"))
			using (var writer = new BinaryWriter(stream))
			{
				var address = new MemoryAddress { Offset = 0x80000000 };

				ProgramBuilder.Build(
					"../../../RiscVConsole.xml",
					"RiscVConsole.xml",
					new KeyValuePair<string, string>[]
					{
						new KeyValuePair<string, string>("http://metalx.org/Berkeley/RiscV/Operators", "../../../../OZone/Platforms/Berkeley/RiscV/Operators.xslt"),
						new KeyValuePair<string, string>("http://metalx.org/Variable", "../../../../OZone/Structures/RiscV/Variable.xslt")
					});

				XDocument document = XDocument.Load("RiscVConsole.xml");

				var program = ProgramReader.Read(document);

				compiler.Compile(program, address);
				compiler.Link(program, new Dictionary<string, Label>());

				UpdateElements(program.Segments);

				document.Save("RiscVConsole.xml");

				address = new MemoryAddress { Offset = 0x80000000 };

				program = ProgramBuilder.Build(
					"RiscVConsole.xml",
					new KeyValuePair<string, string>[]
					{
						new KeyValuePair<string, string>("http://metalx.org/Berkeley/RiscV/ReferenceOperators", "../../../../OZone/Platforms/Berkeley/RiscV/ReferenceOperators.xslt")
					});

				compiler.Compile(program, address);
				compiler.Link(program, new Dictionary<string, Label>());

				compiler.Write(program, writer);

				Console.WriteLine(writer.BaseStream.Position);

				using (var writer2 = File.CreateText("labels.txt"))
					ExportLabels(program.Segments, writer2);

				//binaryWriter.BaseStream.SetLength(1024 * 16);
			}
		}

		private static void ExportLabels(IEnumerable<ProgramSegment> segments, StreamWriter writer)
		{
			foreach (var segment in segments)
			{
				if (segment is Label label)
				{
					writer.WriteLine($"{label.Address.Offset.ToString("X8")}\t{label.Id}");
				}
				else if (segment is Scope scope)
				{
					ExportLabels(scope.Segments, writer);
				}
			}
		}

		private static void UpdateElements(IEnumerable<ProgramSegment> segments)
		{
			foreach (var segment in segments)
			{
				if (segment is CustomProgramSegment customProgramSegment)
				{
					customProgramSegment.Element.SetAttributeValue("{http://metalx.org/Program}address", segment.Address.Offset);
					customProgramSegment.Element.SetAttributeValue("{http://metalx.org/Program}hexAddress", segment.Address.Offset.ToString("X8"));

					if (customProgramSegment.Reference != null)
					{
						customProgramSegment.Element.SetAttributeValue("{http://metalx.org/Program}refAddress", customProgramSegment.Segment.Address.Offset);
						customProgramSegment.Element.SetAttributeValue("{http://metalx.org/Program}hexRefAddress", customProgramSegment.Segment.Address.Offset.ToString("X8"));
					}
				}
				else if (segment is Scope scope)
				{
					UpdateElements(scope.Segments);
				}
			}
		}
	}
}
