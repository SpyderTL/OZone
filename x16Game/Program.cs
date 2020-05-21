using OZone.Programs;
using OZone.Programs.Compilers;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace x16Game
{
	internal class Program
	{
		internal static void Main()
		{
			var transformFiles = new KeyValuePair<string, string>[]
			{
				new KeyValuePair<string, string>("http://metalx.org/Commodore64/Petscii", "../../../OZone/Platforms/Commodore/C64/Petscii.xslt"),
				new KeyValuePair<string, string>("http://metalx.org/6502/Functions/Short", "../../../OZone/Functions/6502/Short.xslt"),
				new KeyValuePair<string, string>("http://metalx.org/6502/Functions/Integer", "../../../OZone/Functions/6502/Integer.xslt"),
				new KeyValuePair<string, string>("http://metalx.org/Variable", "../../../OZone/Structures/6502/Variable.xslt"),
				new KeyValuePair<string, string>("http://metalx.org/Mos/6502/Operators", "../../../OZone/Platforms/Mos/6502/Operators.xslt")
			};

			var sourceFiles = new string[]
			{
				"../../x16Program.xml",
				"../../x16Game.xml",
				"../../Modules/Controller.xml",
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
				"../../Modules/Video.xml",
			};

			var resources = new string[]
			{
				"../../Resources/Player.bmp",
				"../../Resources/Projectile.bmp",
				"../../Resources/EnemyA.bmp",
				"../../Resources/EnemyA2.bmp",
				"../../Resources/EnemyB.bmp",
				"../../Resources/EnemyB2.bmp",
				"../../Resources/EnemyC.bmp",
				"../../Resources/EnemyC2.bmp",
				"../../Resources/Projectile2.bmp",
				"../../Resources/PlayerExplosion.bmp",
				"../../Resources/PlayerExplosion2.bmp",
				"../../Resources/PlayerExplosion3.bmp",
				"../../Resources/PlayerExplosion4.bmp",
				"../../Resources/EnemyExplosion.bmp",
				"../../Resources/EnemyExplosion2.bmp",
				"../../Resources/EnemyExplosion3.bmp",
				"../../Resources/EnemyExplosion4.bmp",
				"../../Resources/EnemyExplosion5.bmp",
			};

			var compiler = new BinaryCompiler();
			var address = new MemoryAddress { Offset = 0x07ff };

			using (Stream stream = File.Create("x16game.prg"))
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
