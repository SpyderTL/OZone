using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Xsl;
using System.Xml;

namespace x86Console
{
	public static class x86Console
	{
		public static XslCompiledTransform[] Transforms = new XslCompiledTransform[]
		{
			LoadTransform("../../../OZone/Structures/i286/Class.xslt"),
			LoadTransform("../../../OZone/Structures/i286/String.xslt"),
			LoadTransform("../../../OZone/Functions/i286/Address.xslt"),
			LoadTransform("../../../OZone/Functions/i286/Boolean.xslt"),
			LoadTransform("../../../OZone/Functions/i286/Disk.xslt"),
			LoadTransform("../../../OZone/Functions/i286/Short.xslt"),
			LoadTransform("../../../OZone/Functions/i286/Hexadecimal.xslt"),
			LoadTransform("../../../OZone/Functions/i286/String.xslt"),
			LoadTransform("../../../OZone/Functions/i286/Stream.xslt"),
			LoadTransform("../../../OZone/Functions/i286/Date.xslt"),
			LoadTransform("../../../OZone/Functions/i286/Time.xslt"),
			LoadTransform("../../../OZone/Functions/i286/Collection.xslt"),
			LoadTransform("../../../OZone/Functions/i286/Table.xslt"),
			LoadTransform("../../../OZone/Functions/i286/Version.xslt"),
			LoadTransform("../../../OZone/Functions/i286/List.xslt"),
			LoadTransform("../../../OZone/Functions/i286/Catalog.xslt"),
			LoadTransform("../../../OZone/Functions/i286/List.xslt"),
			LoadTransform("../../../OZone/Functions/i286/Class.xslt"),
			LoadTransform("../../../OZone/Functions/i286/Object.xslt"),
			LoadTransform("../../../OZone/Functions/i286/Debug.xslt"),
			LoadTransform("../../../OZone/Functions/i286/Console.xslt"),
			LoadTransform("../../../OZone/Functions/i286/MemoryManager.xslt"),
			LoadTransform("../../../OZone/Functions/i286/System.xslt"),
			LoadTransform("../../../OZone/Platforms/Amd/PcNet/Ports.xslt"),
			LoadTransform("../../../OZone/Platforms/Amd/PcNet/ControlStatus.xslt"),
			LoadTransform("../../../OZone/Platforms/Amd/PcNet/BusConfiguration.xslt"),
			LoadTransform("../../../OZone/Platforms/Ansi/Ascii/Ascii.xslt"),
			LoadTransform("../../../OZone/Platforms/Creative/SoundBlaster/Ports.xslt"),
			LoadTransform("../../../OZone/Platforms/Creative/SoundBlaster/Commands.xslt"),
			LoadTransform("../../../OZone/Platforms/Ibm/Pc/Bios/Clock.xslt"),
			LoadTransform("../../../OZone/Platforms/Ibm/Pc/Bios/Disk.xslt"),
			LoadTransform("../../../OZone/Platforms/Ibm/Pc/Bios/Keyboard.xslt"),
			LoadTransform("../../../OZone/Platforms/Ibm/Pc/Bios/Video.xslt"),
			LoadTransform("../../../OZone/Platforms/Ibm/Pc/Bios/Functions.xslt"),
			LoadTransform("../../../OZone/Platforms/Ibm/Pc/Keyboard/Keyboard.xslt"),
			LoadTransform("../../../OZone/Platforms/Ibm/Pc/Ports.xslt"),
			LoadTransform("../../../OZone/Platforms/Ibm/Pc/Pci/Configuration.xslt"),
			LoadTransform("../../../OZone/Platforms/Ibm/Pc/Pci/Functions.xslt"),
			LoadTransform("../../../OZone/Platforms/Ibm/Pc/PlugNPlay/Pnp.xslt"),
			LoadTransform("../../../OZone/Platforms/Ibm/Pc/Vesa/Power.xslt"),
			LoadTransform("../../../OZone/Platforms/Ibm/Pc/Vesa/PowerState.xslt"),
			LoadTransform("../../../OZone/Platforms/Ibm/Pc/Vesa/PowerDevices.xslt"),
			LoadTransform("../../../OZone/Platforms/Ibm/Pc/Vesa/SuperVga.xslt"),
			LoadTransform("../../../OZone/Platforms/Ibm/Pc/Vesa/SuperVgaMode.xslt"),
			LoadTransform("../../../OZone/Platforms/Ibm/Pc/Vesa/SuperVgaInformation.xslt"),
			LoadTransform("../../../OZone/Platforms/Intel/80286/ExtendedOperators.xslt"),
			LoadTransform("../../../OZone/Platforms/Intel/80286/Operands.xslt"),
			LoadTransform("../../../OZone/Platforms/Intel/80286/Operators.xslt"),
			LoadTransform("../../../OZone/Platforms/Intel/80286/Functions/Math.xslt"),
			LoadTransform("../../../OZone/Platforms/Intel/80286/Functions/Increment.xslt"),
			LoadTransform("../../../OZone/Platforms/Intel/80286/Functions/Immediate.xslt"),
			LoadTransform("../../../OZone/Platforms/Intel/80286/Functions/Shift.xslt"),
			LoadTransform("../../../OZone/Platforms/Intel/80286/Functions/Arithmetic.xslt"),
			LoadTransform("../../../OZone/Platforms/Intel/80286/Functions/Logic.xslt"),
			LoadTransform("../../../OZone/Platforms/Intel/80286/Operators.xslt"),
			LoadTransform("../../../OZone/Platforms/Intel/80286/Operands.xslt"),
			LoadTransform("../../../OZone/Platforms/Intel/80286/Segments.xslt"),
			LoadTransform("../../../OZone/Platforms/Intel/Pxe/Operators.xslt"),
			LoadTransform("../../../OZone/Platforms/Intel/Pxe/Structures.xslt"),
			LoadTransform("../../../OZone/Platforms/Intel/Ac97/BusMaster/BusMaster.xslt"),
			LoadTransform("../../../OZone/Platforms/Intel/Ac97/BusMaster/Control.xslt"),
			LoadTransform("../../../OZone/Platforms/Intel/Ac97/BusMaster/GlobalControl.xslt"),
			LoadTransform("../../../OZone/Platforms/Intel/Ac97/BusMaster/GlobalStatus.xslt"),
			LoadTransform("../../../OZone/Platforms/Intel/Ac97/Mixer/Mixer.xslt"),
		};

		public static string[] Programs = new string[]
		{
			"../../Console.xml",
			//"../../../OZone/Classes/i286/Address.xml",
			//"../../../OZone/Classes/i286/Audio.xml",
			"../../../OZone/Classes/i286/Boolean.xml",
			//"../../../OZone/Classes/i286/Class.xml",
			//"../../../OZone/Classes/i286/Collection.xml",
			"../../../OZone/Classes/i286/Date.xml",
			//"../../../OZone/Classes/i286/Debug.xml",
			//"../../../OZone/Classes/i286/Dictionary.xml",
			"../../../OZone/Classes/i286/Hexadecimal.xml",
			//"../../../OZone/Classes/i286/List.xml",
			//"../../../OZone/Classes/i286/Mouse.xml",
			//"../../../OZone/Classes/i286/Network.xml",
			//"../../../OZone/Classes/i286/PciDevice.xml",
			//"../../../OZone/Classes/i286/Power.xml",
			//"../../../OZone/Classes/i286/Processor.xml",
			"../../../OZone/Classes/i286/Short.xml",
			//"../../../OZone/Classes/i286/Stream.xml",
			"../../../OZone/Classes/i286/String.xml",
			"../../../OZone/Classes/i286/System.xml",
			//"../../../OZone/Classes/i286/Table.xml",
			//"../../../OZone/Classes/i286/Text.xml",
			"../../../OZone/Classes/i286/Time.xml",
			"../../../OZone/Classes/i286/Version.xml",
			//"../../../OZone/Classes/i286/Video.xml",
			//"../../../OZone/Classes/i286/VideoMode.xml",
		};
		
		private static XslCompiledTransform LoadTransform(string fileName)
		{
			XslCompiledTransform transform = new XslCompiledTransform();
			transform.Load(fileName);
			return transform;
		}
	}
}
