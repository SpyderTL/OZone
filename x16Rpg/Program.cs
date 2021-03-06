﻿using OZone.Programs;
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
				new KeyValuePair<string, string>("http://metalx.org/65C02/Functions/Short", "../../../OZone/Functions/65C02/Short.xslt"),
				new KeyValuePair<string, string>("http://metalx.org/65C02/Functions/Integer", "../../../OZone/Functions/65C02/Integer.xslt"),
				new KeyValuePair<string, string>("http://metalx.org/Variable", "../../../OZone/Structures/6502/Variable.xslt"),
				new KeyValuePair<string, string>("http://metalx.org/Wdc/65C02/Operators", "../../../OZone/Platforms/Wdc/65C02/Operators.xslt"),
				new KeyValuePair<string, string>("http://metalx.org/Commodore64/Petscii", "../../../OZone/Platforms/Commodore/C64/Petscii.xslt")
			};

			var sourceFiles = new string[]
			{
				"../../x16Program.xml",
				"../../x16Rpg.xml",
				"../../Modules/Camera.xml",
				"../../Modules/Console.xml",
				"../../Modules/Controller.xml",
				"../../Modules/ControllerMenu.xml",
				"../../Modules/ControllerWorld.xml",
				"../../Modules/Dialog.xml",
				"../../Modules/Effect.xml",
				"../../Modules/EffectGenerator.xml",
				"../../Modules/File.xml",
				"../../Modules/Formation.xml",
				"../../Modules/Graphics.xml",
				"../../Modules/Level.xml",
				"../../Modules/Logic.xml",
				"../../Modules/MemoryReader.xml",
				"../../Modules/Menu.xml",
				"../../Modules/MenuPointer.xml",
				"../../Modules/MusicGenerator.xml",
				"../../Modules/MusicPlayer.xml",
				"../../Modules/Object.xml",
				"../../Modules/Random.xml",
				"../../Modules/Screen.xml",
				"../../Modules/SoundGenerator.xml",
				"../../Modules/Sprite.xml",
				"../../Modules/String.xml",
				"../../Modules/System.xml",
				"../../Modules/Vera.xml",
				"../../Modules/World.xml",
				"../../Modules/WorldScreen.xml",
				"../../Modules/WorldSprite.xml"
			};

			var resources = new string[]
			{
				"../../Resources/Battle/pointer.bmp",
				"../../Resources/Songs/song_0.bin",
				"../../Resources/Songs/song_1.bin",
				"../../Resources/Songs/song_2.bin",
				"../../Resources/Songs/song_3.bin",
				"../../Resources/Songs/song_4.bin",
				"../../Resources/Songs/song_5.bin",
				"../../Resources/Songs/song_6.bin",
				"../../Resources/Songs/song_7.bin",
				"../../Resources/Songs/song_8.bin",
				"../../Resources/Songs/song_9.bin",
				"../../Resources/Songs/song_10.bin",
				"../../Resources/Songs/song_11.bin",
				"../../Resources/Songs/song_12.bin",
				"../../Resources/Songs/song_13.bin",
				"../../Resources/Songs/song_14.bin",
				"../../Resources/Songs/song_15.bin",
				"../../Resources/Songs/song_16.bin",
				"../../Resources/Songs/song_17.bin",
				"../../Resources/Songs/song_18.bin",
				"../../Resources/Songs/song_19.bin",
				"../../Resources/Songs/song_20.bin",
				"../../Resources/Songs/song_21.bin",
				"../../Resources/Songs/song_22.bin",
				"../../Resources/Songs/song_23.bin",
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

			// Bank 1
			resources = new string[]
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
			};

			using (Stream stream = File.Create("x16rpg1.prg"))
			using (BinaryWriter writer = new BinaryWriter(stream))
			{
				writer.Write((short)0);

				var programs = new List<OZone.Programs.Program>();

				// Compile Resources
				foreach (var resource in resources)
				{
					var program = ResourceBuilder.Build(resource);

					var length = compiler.Compile(program, address);

					//exports["Resources." + Path.GetFileNameWithoutExtension(resource)] = new Label { Address = new MemoryAddress { Offset = address.Offset } };

					address.Offset += length;

					programs.Add(program);
				}

				//foreach (var program2 in programs)
				//	compiler.Link(program2, exports);

				foreach (var program2 in programs)
					compiler.Write(program2, writer);

				writer.Flush();

				System.Diagnostics.Debug.WriteLine(writer.BaseStream.Position - 2);
			}

			// Bank 2
			resources = new string[]
			{
			"../../Resources/World/world_0.bmp",
				"../../Resources/World/world_1.bmp",
				"../../Resources/World/world_2.bmp",
				"../../Resources/World/world_3.bmp",
				"../../Resources/World/world_4.bmp",
				"../../Resources/World/world_5.bmp",
				"../../Resources/World/world_6.bmp",
				"../../Resources/World/world_7.bmp",
				"../../Resources/World/world_8.bmp",
				"../../Resources/World/world_9.bmp",
				"../../Resources/World/world_10.bmp",
				"../../Resources/World/world_11.bmp",
				"../../Resources/World/world_12.bmp",
				"../../Resources/World/world_13.bmp",
				"../../Resources/World/world_14.bmp",
				"../../Resources/World/world_15.bmp",
				"../../Resources/World/world_16.bmp",
				"../../Resources/World/world_17.bmp",
				"../../Resources/World/world_18.bmp",
				"../../Resources/World/world_19.bmp",
				"../../Resources/World/world_20.bmp",
				"../../Resources/World/world_21.bmp",
				"../../Resources/World/world_22.bmp",
				"../../Resources/World/world_23.bmp",
				"../../Resources/World/world_24.bmp",
				"../../Resources/World/world_25.bmp",
				"../../Resources/World/world_26.bmp",
				"../../Resources/World/world_27.bmp",
				"../../Resources/World/world_28.bmp",
				"../../Resources/World/world_29.bmp",
				"../../Resources/World/world_30.bmp",
				"../../Resources/World/world_31.bmp",
				"../../Resources/World/world_32.bmp",
				"../../Resources/World/world_33.bmp",
				"../../Resources/World/world_34.bmp",
				"../../Resources/World/world_35.bmp",
				"../../Resources/World/world_36.bmp",
				"../../Resources/World/world_37.bmp",
				"../../Resources/World/world_38.bmp",
				"../../Resources/World/world_39.bmp",
				"../../Resources/World/world_40.bmp",
				"../../Resources/World/world_41.bmp",
				"../../Resources/World/world_42.bmp",
				"../../Resources/World/world_43.bmp",
				"../../Resources/World/world_44.bmp",
				"../../Resources/World/world_45.bmp",
				"../../Resources/World/world_46.bmp",
				"../../Resources/World/world_47.bmp",
				"../../Resources/World/world_48.bmp",
				"../../Resources/World/world_49.bmp",
				"../../Resources/World/world_50.bmp",
				"../../Resources/World/world_51.bmp",
				"../../Resources/World/world_52.bmp",
				"../../Resources/World/world_53.bmp",
				"../../Resources/World/world_54.bmp",
				"../../Resources/World/world_55.bmp",
				"../../Resources/World/world_56.bmp",
				"../../Resources/World/world_57.bmp",
				"../../Resources/World/world_58.bmp",
				"../../Resources/World/world_59.bmp",
				"../../Resources/World/world_60.bmp",
				"../../Resources/World/world_61.bmp",
				"../../Resources/World/world_62.bmp",
				"../../Resources/World/world_63.bmp",
				"../../Resources/World/world_64.bmp",
				"../../Resources/World/world_65.bmp",
				"../../Resources/World/world_66.bmp",
				"../../Resources/World/world_67.bmp",
				"../../Resources/World/world_68.bmp",
				"../../Resources/World/world_69.bmp",
				"../../Resources/World/world_70.bmp",
				"../../Resources/World/world_71.bmp",
				"../../Resources/World/world_72.bmp",
				"../../Resources/World/world_73.bmp",
				"../../Resources/World/world_74.bmp",
				"../../Resources/World/world_75.bmp",
				"../../Resources/World/world_76.bmp",
				"../../Resources/World/world_77.bmp",
				"../../Resources/World/world_78.bmp",
				"../../Resources/World/world_79.bmp",
				"../../Resources/World/world_80.bmp",
				"../../Resources/World/world_81.bmp",
				"../../Resources/World/world_82.bmp",
				"../../Resources/World/world_83.bmp",
				"../../Resources/World/world_84.bmp",
				"../../Resources/World/world_85.bmp",
				"../../Resources/World/world_86.bmp",
				"../../Resources/World/world_87.bmp",
				"../../Resources/World/world_88.bmp",
				"../../Resources/World/world_89.bmp",
				"../../Resources/World/world_90.bmp",
				"../../Resources/World/world_91.bmp",
				"../../Resources/World/world_92.bmp",
				"../../Resources/World/world_93.bmp",
				"../../Resources/World/world_94.bmp",
				"../../Resources/World/world_95.bmp",
				"../../Resources/World/world_96.bmp",
				"../../Resources/World/world_97.bmp",
				"../../Resources/World/world_98.bmp",
				"../../Resources/World/world_99.bmp",
				"../../Resources/World/world_100.bmp",
				"../../Resources/World/world_101.bmp",
				"../../Resources/World/world_102.bmp",
				"../../Resources/World/world_103.bmp",
				"../../Resources/World/world_104.bmp",
				"../../Resources/World/world_105.bmp",
				"../../Resources/World/world_106.bmp",
				"../../Resources/World/world_107.bmp",
				"../../Resources/World/world_108.bmp",
				"../../Resources/World/world_109.bmp",
				"../../Resources/World/world_110.bmp",
				"../../Resources/World/world_111.bmp",
				"../../Resources/World/world_112.bmp",
				"../../Resources/World/world_113.bmp",
				"../../Resources/World/world_114.bmp",
				"../../Resources/World/world_115.bmp",
				"../../Resources/World/world_116.bmp",
				"../../Resources/World/world_117.bmp",
				"../../Resources/World/world_118.bmp",
				"../../Resources/World/world_119.bmp",
				"../../Resources/World/world_120.bmp",
				"../../Resources/World/world_121.bmp",
				"../../Resources/World/world_122.bmp",
				"../../Resources/World/world_123.bmp",
				"../../Resources/World/world_124.bmp",
				"../../Resources/World/world_125.bmp",
				"../../Resources/World/world_126.bmp",
				"../../Resources/World/world_127.bmp",
				"../../Resources/World/world_128.bmp",
				"../../Resources/World/world_129.bmp",
				"../../Resources/World/world_130.bmp",
				"../../Resources/World/world_131.bmp",
				"../../Resources/World/world_132.bmp",
				"../../Resources/World/world_133.bmp",
				"../../Resources/World/world_134.bmp",
				"../../Resources/World/world_135.bmp",
				"../../Resources/World/world_136.bmp",
				"../../Resources/World/world_137.bmp",
				"../../Resources/World/world_138.bmp",
				"../../Resources/World/world_139.bmp",
				"../../Resources/World/world_140.bmp",
				"../../Resources/World/world_141.bmp",
				"../../Resources/World/world_142.bmp",
				"../../Resources/World/world_143.bmp",
				"../../Resources/World/world_144.bmp",
				"../../Resources/World/world_145.bmp",
				"../../Resources/World/world_146.bmp",
				"../../Resources/World/world_147.bmp",
				"../../Resources/World/world_148.bmp",
				"../../Resources/World/world_149.bmp",
				"../../Resources/World/world_150.bmp",
				"../../Resources/World/world_151.bmp",
				"../../Resources/World/world_152.bmp",
				"../../Resources/World/world_153.bmp",
				"../../Resources/World/world_154.bmp",
				"../../Resources/World/world_155.bmp",
				"../../Resources/World/world_156.bmp",
				"../../Resources/World/world_157.bmp",
				"../../Resources/World/world_158.bmp",
				"../../Resources/World/world_159.bmp",
				"../../Resources/World/world_160.bmp",
				"../../Resources/World/world_161.bmp",
				"../../Resources/World/world_162.bmp",
				"../../Resources/World/world_163.bmp",
				"../../Resources/World/world_164.bmp",
				"../../Resources/World/world_165.bmp",
				"../../Resources/World/world_166.bmp",
				"../../Resources/World/world_167.bmp",
				"../../Resources/World/world_168.bmp",
				"../../Resources/World/world_169.bmp",
				"../../Resources/World/world_170.bmp",
				"../../Resources/World/world_171.bmp",
				"../../Resources/World/world_172.bmp",
				"../../Resources/World/world_173.bmp",
				"../../Resources/World/world_174.bmp",
				"../../Resources/World/world_175.bmp",
				"../../Resources/World/world_176.bmp",
				"../../Resources/World/world_177.bmp",
				"../../Resources/World/world_178.bmp",
				"../../Resources/World/world_179.bmp",
				"../../Resources/World/world_180.bmp",
				"../../Resources/World/world_181.bmp",
				"../../Resources/World/world_182.bmp",
				"../../Resources/World/world_183.bmp",
				"../../Resources/World/world_184.bmp",
				"../../Resources/World/world_185.bmp",
				"../../Resources/World/world_186.bmp",
				"../../Resources/World/world_187.bmp",
				"../../Resources/World/world_188.bmp",
				"../../Resources/World/world_189.bmp",
				"../../Resources/World/world_190.bmp",
				"../../Resources/World/world_191.bmp",
				"../../Resources/World/world_192.bmp",
				"../../Resources/World/world_193.bmp",
				"../../Resources/World/world_194.bmp",
				"../../Resources/World/world_195.bmp",
				"../../Resources/World/world_196.bmp",
				"../../Resources/World/world_197.bmp",
				"../../Resources/World/world_198.bmp",
				"../../Resources/World/world_199.bmp",
				"../../Resources/World/world_200.bmp",
				"../../Resources/World/world_201.bmp",
				"../../Resources/World/world_202.bmp",
				"../../Resources/World/world_203.bmp",
				"../../Resources/World/world_204.bmp",
				"../../Resources/World/world_205.bmp",
				"../../Resources/World/world_206.bmp",
				"../../Resources/World/world_207.bmp",
				"../../Resources/World/world_208.bmp",
				"../../Resources/World/world_209.bmp",
				"../../Resources/World/world_210.bmp",
				"../../Resources/World/world_211.bmp",
				"../../Resources/World/world_212.bmp",
				"../../Resources/World/world_213.bmp",
				"../../Resources/World/world_214.bmp",
				"../../Resources/World/world_215.bmp",
				"../../Resources/World/world_216.bmp",
				"../../Resources/World/world_217.bmp",
				"../../Resources/World/world_218.bmp",
				"../../Resources/World/world_219.bmp",
				"../../Resources/World/world_220.bmp",
				"../../Resources/World/world_221.bmp",
				"../../Resources/World/world_222.bmp",
				"../../Resources/World/world_223.bmp",
				"../../Resources/World/world_224.bmp",
				"../../Resources/World/world_225.bmp",
				"../../Resources/World/world_226.bmp",
				"../../Resources/World/world_227.bmp",
				"../../Resources/World/world_228.bmp",
				"../../Resources/World/world_229.bmp",
				"../../Resources/World/world_230.bmp",
				"../../Resources/World/world_231.bmp",
				"../../Resources/World/world_232.bmp",
				"../../Resources/World/world_233.bmp",
				"../../Resources/World/world_234.bmp",
				"../../Resources/World/world_235.bmp",
				"../../Resources/World/world_236.bmp",
				"../../Resources/World/world_237.bmp",
				"../../Resources/World/world_238.bmp",
				"../../Resources/World/world_239.bmp",
				"../../Resources/World/world_240.bmp",
				"../../Resources/World/world_241.bmp",
				"../../Resources/World/world_242.bmp",
				"../../Resources/World/world_243.bmp",
				"../../Resources/World/world_244.bmp",
				"../../Resources/World/world_245.bmp",
				"../../Resources/World/world_246.bmp",
				"../../Resources/World/world_247.bmp",
				"../../Resources/World/world_248.bmp",
				"../../Resources/World/world_249.bmp",
				"../../Resources/World/world_250.bmp",
				"../../Resources/World/world_251.bmp",
				"../../Resources/World/world_252.bmp",
				"../../Resources/World/world_253.bmp",
				"../../Resources/World/world_254.bmp",
				"../../Resources/World/world_255.bmp",
			};

			using (Stream stream = File.Create("x16rpg2.prg"))
			using (BinaryWriter writer = new BinaryWriter(stream))
			{
				writer.Write((short)0);

				var programs = new List<OZone.Programs.Program>();

				// Compile Resources
				foreach (var resource in resources)
				{
					var program = ResourceBuilder.Build(resource);

					var length = compiler.Compile(program, address);

					//exports["Resources." + Path.GetFileNameWithoutExtension(resource)] = new Label { Address = new MemoryAddress { Offset = address.Offset } };

					address.Offset += length;

					programs.Add(program);
				}

				//foreach (var program2 in programs)
				//	compiler.Link(program2, exports);

				foreach (var program2 in programs)
					compiler.Write(program2, writer);

				writer.Flush();

				System.Diagnostics.Debug.WriteLine(writer.BaseStream.Position - 2);
			}
			
			// Bank 3
			resources = new string[]
			{
				"../../Resources/Sprites/sprite_0.bmp",
				"../../Resources/Sprites/sprite_1.bmp",
				"../../Resources/Sprites/sprite_2.bmp",
				"../../Resources/Sprites/sprite_3.bmp",
				"../../Resources/Sprites/sprite_4.bmp",
				"../../Resources/Sprites/sprite_5.bmp",
				"../../Resources/Sprites/sprite_6.bmp",
				"../../Resources/Sprites/sprite_7.bmp",
				"../../Resources/Sprites/sprite_8.bmp",
				"../../Resources/Sprites/sprite_9.bmp",
				"../../Resources/Sprites/sprite_10.bmp",
				"../../Resources/Sprites/sprite_11.bmp",
				"../../Resources/Sprites/sprite_12.bmp",
				"../../Resources/Sprites/sprite_13.bmp",
				"../../Resources/Sprites/sprite_14.bmp",
				"../../Resources/Sprites/sprite_15.bmp",
				"../../Resources/Sprites/sprite_16.bmp",
				"../../Resources/Sprites/sprite_17.bmp",
				"../../Resources/Sprites/sprite_18.bmp",
				"../../Resources/Sprites/sprite_19.bmp",
				"../../Resources/Sprites/sprite_20.bmp",
				"../../Resources/Sprites/sprite_21.bmp",
				"../../Resources/Sprites/sprite_22.bmp",
				"../../Resources/Sprites/sprite_23.bmp",
				"../../Resources/Sprites/sprite_24.bmp",
				"../../Resources/Sprites/sprite_25.bmp",
				"../../Resources/Sprites/sprite_26.bmp",
				"../../Resources/Sprites/sprite_27.bmp",
				"../../Resources/Sprites/sprite_28.bmp",
				"../../Resources/Sprites/sprite_29.bmp",
				"../../Resources/Sprites/sprite_30.bmp",
				"../../Resources/Sprites/sprite_31.bmp",
				"../../Resources/Sprites/sprite_32.bmp",
				"../../Resources/Sprites/sprite_33.bmp",
				"../../Resources/Sprites/sprite_34.bmp",
				"../../Resources/Sprites/sprite_35.bmp",
				"../../Resources/Sprites/sprite_36.bmp",
				"../../Resources/Sprites/sprite_37.bmp",
				"../../Resources/Sprites/sprite_38.bmp",
				"../../Resources/Sprites/sprite_39.bmp",
				"../../Resources/Sprites/sprite_40.bmp",
				"../../Resources/Sprites/sprite_41.bmp",
				"../../Resources/Sprites/sprite_42.bmp",
				"../../Resources/Sprites/sprite_43.bmp",
				"../../Resources/Sprites/sprite_44.bmp",
				"../../Resources/Sprites/sprite_45.bmp",
				"../../Resources/Sprites/sprite_46.bmp",
				"../../Resources/Sprites/sprite_47.bmp",
				"../../Resources/Sprites/sprite_48.bmp",
				"../../Resources/Sprites/sprite_49.bmp",
				"../../Resources/Sprites/sprite_50.bmp",
				"../../Resources/Sprites/sprite_51.bmp",
				"../../Resources/Sprites/sprite_52.bmp",
				"../../Resources/Sprites/sprite_53.bmp",
				"../../Resources/Sprites/sprite_54.bmp",
				"../../Resources/Sprites/sprite_55.bmp",
				"../../Resources/Sprites/sprite_56.bmp",
				"../../Resources/Sprites/sprite_57.bmp",
				"../../Resources/Sprites/sprite_58.bmp",
				"../../Resources/Sprites/sprite_59.bmp",
				"../../Resources/Sprites/sprite_60.bmp",
				"../../Resources/Sprites/sprite_61.bmp",
				"../../Resources/Sprites/sprite_62.bmp",
				"../../Resources/Sprites/sprite_63.bmp"
			};

			using (Stream stream = File.Create("x16rpg3.prg"))
			using (BinaryWriter writer = new BinaryWriter(stream))
			{
				writer.Write((short)0);

				var programs = new List<OZone.Programs.Program>();

				// Compile Resources
				foreach (var resource in resources)
				{
					var program = ResourceBuilder.Build(resource);

					var length = compiler.Compile(program, address);

					//exports["Resources." + Path.GetFileNameWithoutExtension(resource)] = new Label { Address = new MemoryAddress { Offset = address.Offset } };

					address.Offset += length;

					programs.Add(program);
				}

				//foreach (var program2 in programs)
				//	compiler.Link(program2, exports);

				foreach (var program2 in programs)
					compiler.Write(program2, writer);

				writer.Flush();

				System.Diagnostics.Debug.WriteLine(writer.BaseStream.Position - 2);
			}
		}
	}
}