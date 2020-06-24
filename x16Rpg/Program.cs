using OZone.Programs;
using OZone.Programs.Compilers;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace x16Rpg
{
	internal class Program
	{
		internal static void Main()
		{
			var transformFiles = new KeyValuePair<string, string>[]
			{
				new KeyValuePair<string, string>("http://metalx.org/Commodore64/Petscii", "../../../OZone/Platforms/Commodore/C64/Petscii.xslt"),
				new KeyValuePair<string, string>("http://metalx.org/65C02/Functions/Short", "../../../OZone/Functions/65C02/Short.xslt"),
				new KeyValuePair<string, string>("http://metalx.org/65C02/Functions/Integer", "../../../OZone/Functions/65C02/Integer.xslt"),
				new KeyValuePair<string, string>("http://metalx.org/Variable", "../../../OZone/Structures/6502/Variable.xslt"),
				new KeyValuePair<string, string>("http://metalx.org/Wdc/65C02/Operators", "../../../OZone/Platforms/Wdc/65C02/Operators.xslt")
			};

			var sourceFiles = new string[]
			{
				"../../x16Program.xml",
				"../../x16Rpg.xml",
				"../../Modules/Controller.xml",
				"../../Modules/Dialog.xml",
				"../../Modules/Formation.xml",
				"../../Modules/Graphics.xml",
				"../../Modules/Level.xml",
				"../../Modules/Logic.xml",
				"../../Modules/MemoryReader.xml",
				"../../Modules/Object.xml",
				"../../Modules/Random.xml",
				"../../Modules/Screen.xml",
				"../../Modules/Sprite.xml",
				"../../Modules/System.xml",
				"../../Modules/Vera.xml",
			};

			var resources = new string[]
			{
				"../../Resources/Characters/character_0.bmp",
				"../../Resources/Characters/character_1.bmp",
				"../../Resources/Characters/character_2.bmp",
				"../../Resources/Characters/character_3.bmp",
				"../../Resources/Characters/character_4.bmp",
				"../../Resources/Characters/character_5.bmp",
				"../../Resources/Characters/character_6.bmp",
				"../../Resources/Characters/character_7.bmp",
				"../../Resources/Characters/character_8.bmp",
				"../../Resources/Characters/character_9.bmp",
				"../../Resources/Characters/character_10.bmp",
				"../../Resources/Characters/character_11.bmp",
				"../../Resources/Characters/character_12.bmp",
				"../../Resources/Characters/character_13.bmp",
				"../../Resources/Characters/character_14.bmp",
				"../../Resources/Characters/character_15.bmp",
				"../../Resources/Characters/character_16.bmp",
				"../../Resources/Characters/character_17.bmp",
				"../../Resources/Characters/character_18.bmp",
				"../../Resources/Characters/character_19.bmp",
				"../../Resources/Characters/character_20.bmp",
				"../../Resources/Characters/character_21.bmp",
				"../../Resources/Characters/character_22.bmp",
				"../../Resources/Characters/character_23.bmp",
				"../../Resources/Characters/character_24.bmp",
				"../../Resources/Characters/character_25.bmp",
				"../../Resources/Characters/character_26.bmp",
				"../../Resources/Characters/character_27.bmp",
				"../../Resources/Characters/character_28.bmp",
				"../../Resources/Characters/character_29.bmp",
				"../../Resources/Characters/character_30.bmp",
				"../../Resources/Characters/character_31.bmp",
				"../../Resources/Characters/character_32.bmp",
				"../../Resources/Characters/character_33.bmp",
				"../../Resources/Characters/character_34.bmp",
				"../../Resources/Characters/character_35.bmp",
				"../../Resources/Characters/character_36.bmp",
				"../../Resources/Characters/character_37.bmp",
				"../../Resources/Characters/character_38.bmp",
				"../../Resources/Characters/character_39.bmp",
				"../../Resources/Characters/character_40.bmp",
				"../../Resources/Characters/character_41.bmp",
				"../../Resources/Characters/character_42.bmp",
				"../../Resources/Characters/character_43.bmp",
				"../../Resources/Characters/character_44.bmp",
				"../../Resources/Characters/character_45.bmp",
				"../../Resources/Characters/character_46.bmp",
				"../../Resources/Characters/character_47.bmp",
				"../../Resources/Characters/character_48.bmp",
				"../../Resources/Characters/character_49.bmp",
				"../../Resources/Characters/character_50.bmp",
				"../../Resources/Characters/character_51.bmp",
				"../../Resources/Characters/character_52.bmp",
				"../../Resources/Characters/character_53.bmp",
				"../../Resources/Characters/character_54.bmp",
				"../../Resources/Characters/character_55.bmp",
				"../../Resources/Characters/character_56.bmp",
				"../../Resources/Characters/character_57.bmp",
				"../../Resources/Characters/character_58.bmp",
				"../../Resources/Characters/character_59.bmp",
				"../../Resources/Characters/character_60.bmp",
				"../../Resources/Characters/character_61.bmp",
				"../../Resources/Characters/character_62.bmp",
				"../../Resources/Characters/character_63.bmp",
				"../../Resources/Characters/character_64.bmp",
				"../../Resources/Characters/character_65.bmp",
				"../../Resources/Characters/character_66.bmp",
				"../../Resources/Characters/character_67.bmp",
				"../../Resources/Characters/character_68.bmp",
				"../../Resources/Characters/character_69.bmp",
				"../../Resources/Characters/character_70.bmp",
				"../../Resources/Characters/character_71.bmp",
				"../../Resources/Characters/character_72.bmp",
				"../../Resources/Characters/character_73.bmp",
				"../../Resources/Characters/character_74.bmp",
				"../../Resources/Characters/character_75.bmp",
				"../../Resources/Characters/character_76.bmp",
				"../../Resources/Characters/character_77.bmp",
				"../../Resources/Characters/character_78.bmp",
				"../../Resources/Characters/character_79.bmp",
				"../../Resources/Characters/character_80.bmp",
				"../../Resources/Characters/character_81.bmp",
				"../../Resources/Characters/character_82.bmp",
				"../../Resources/Characters/character_83.bmp",
				"../../Resources/Characters/character_84.bmp",
				"../../Resources/Characters/character_85.bmp",
				"../../Resources/Characters/character_86.bmp",
				"../../Resources/Characters/character_87.bmp",
				"../../Resources/Characters/character_88.bmp",
				"../../Resources/Characters/character_89.bmp",
				"../../Resources/Characters/character_90.bmp",
				"../../Resources/Characters/character_91.bmp",
				"../../Resources/Characters/character_92.bmp",
				"../../Resources/Characters/character_93.bmp",
				"../../Resources/Characters/character_94.bmp",
				"../../Resources/Characters/character_95.bmp",
				"../../Resources/Characters/character_96.bmp",
				"../../Resources/Characters/character_97.bmp",
				"../../Resources/Characters/character_98.bmp",
				"../../Resources/Characters/character_99.bmp",
				"../../Resources/Characters/character_100.bmp",
				"../../Resources/Characters/character_101.bmp",
				"../../Resources/Characters/character_102.bmp",
				"../../Resources/Characters/character_103.bmp",
				"../../Resources/Characters/character_104.bmp",
				"../../Resources/Characters/character_105.bmp",
				"../../Resources/Characters/character_106.bmp",
				"../../Resources/Characters/character_107.bmp",
				"../../Resources/Characters/character_108.bmp",
				"../../Resources/Characters/character_109.bmp",
				"../../Resources/Characters/character_110.bmp",
				"../../Resources/Characters/character_111.bmp",
				"../../Resources/Characters/character_112.bmp",
				"../../Resources/Characters/character_113.bmp",
				"../../Resources/Characters/character_114.bmp",
				"../../Resources/Characters/character_115.bmp",
				"../../Resources/Characters/character_116.bmp",
				"../../Resources/Characters/character_117.bmp",
				"../../Resources/Characters/character_118.bmp",
				"../../Resources/Characters/character_119.bmp",
				"../../Resources/Characters/character_120.bmp",
				"../../Resources/Characters/character_121.bmp",
				"../../Resources/Characters/character_122.bmp",
				"../../Resources/Characters/character_123.bmp",
				"../../Resources/Characters/character_124.bmp",
				"../../Resources/Characters/character_125.bmp",
				"../../Resources/Characters/character_126.bmp",
				//"../../Resources/Characters/character_127.bmp",
				"../../Resources/Backgrounds/background_0_character_0.bmp",
				"../../Resources/Battle/pointer.bmp",
			};

			var compiler = new BinaryCompiler();
			var address = new MemoryAddress { Offset = 0x07ff };

			using (Stream stream = File.Create("x16rpg.prg"))
			using (BinaryWriter writer = new BinaryWriter(stream))
			{
				var programs = new List<OZone.Programs.Program>();
				var exports = new Dictionary<string, Label>();

				// Compile Programs
				foreach (var sourceFile in sourceFiles)
				{
					var program = ProgramBuilder.Build(sourceFile, transformFiles);

					var length = compiler.Compile(program, address);

					address.Offset += length;

					programs.Add(program);

					foreach (var label in program.Segments.OfType<Label>())
						if (label.Export != null)
							exports[label.Export] = label;
				}

				// Compile Resources
				foreach (var resource in resources)
				{
					var program = ResourceBuilder.Build(resource);

					var length = compiler.Compile(program, address);

					exports["Resources." + Path.GetFileNameWithoutExtension(resource)] = new Label { Address = new MemoryAddress { Offset = address.Offset } };

					address.Offset += length;

					programs.Add(program);
				}

				foreach (var program2 in programs)
					compiler.Link(program2, exports);

				foreach (var program2 in programs)
					compiler.Write(program2, writer);

				writer.Flush();

				System.Diagnostics.Debug.WriteLine(writer.BaseStream.Position);
			}
		}
	}
}
