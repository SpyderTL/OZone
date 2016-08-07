<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:ns="http://metalx.org/Pc/Ports" xmlns:prg="http://metalx.org/Program" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="ns:A20GateControl">
		<xsl:element name="prg:hex">01F8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BusMousePort1">
		<xsl:element name="prg:hex">023C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BusMousePort2">
		<xsl:element name="prg:hex">0238</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CgaRegisters">
		<xsl:element name="prg:hex">03D0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ChipsetRegisters">
		<xsl:element name="prg:hex">0022</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Cmos">
		<xsl:element name="prg:hex">0070</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Diagnostics">
		<xsl:element name="prg:hex">0080</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DirectMemoryAccessController1">
		<xsl:element name="prg:hex">0000</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DirectMemoryAccessController2">
		<xsl:element name="prg:hex">00C0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DirectMemoryAccessRegisters">
		<xsl:element name="prg:hex">0080</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GraphicsAdapterRegisters">
		<xsl:element name="prg:hex">03C0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:EideController1">
		<xsl:element name="prg:hex">01E8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:EideController2">
		<xsl:element name="prg:hex">0168</xsl:element>
	</xsl:template>
	<xsl:template match="ns:EisaBusMaster">
		<xsl:element name="prg:hex">0464</xsl:element>
	</xsl:template>
	<xsl:template match="ns:EisaDmaControl">
		<xsl:element name="prg:hex">04D4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:EisaDmaController">
		<xsl:element name="prg:hex">0401</xsl:element>
	</xsl:template>
	<xsl:template match="ns:EisaDmaCounters">
		<xsl:element name="prg:hex">04C6</xsl:element>
	</xsl:template>
	<xsl:template match="ns:EisaDmaPages">
		<xsl:element name="prg:hex">0481</xsl:element>
	</xsl:template>
	<xsl:template match="ns:EisaDmaStop">
		<xsl:element name="prg:hex">04E0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:EisaInterrupts">
		<xsl:element name="prg:hex">04D0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:EisaNonmaskableInterrupts">
		<xsl:element name="prg:hex">0461</xsl:element>
	</xsl:template>
	<xsl:template match="ns:EisaSystemBoardID">
		<xsl:element name="prg:hex">0C80</xsl:element>
	</xsl:template>
	<xsl:template match="ns:EnhanceGraphicsAdapter">
		<xsl:element name="prg:hex">02C0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:EthernetAdapter">
		<xsl:element name="prg:hex">0300</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FixedDiskController1">
		<xsl:element name="prg:hex">01F0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FixedDiskController1Control">
		<xsl:element name="prg:hex">03F4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FixedDiskController2">
		<xsl:element name="prg:hex">0170</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FixedDiskController2Control">
		<xsl:element name="prg:hex">0374</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FloppyDiskController1">
		<xsl:element name="prg:hex">03F0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FloppyDiskController2">
		<xsl:element name="prg:hex">0370</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GamePort">
		<xsl:element name="prg:hex">0200</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SoundCard1">
		<xsl:element name="prg:hex">0220</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SoundCard2">
		<xsl:element name="prg:hex">0240</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SoundCard3">
		<xsl:element name="prg:hex">0260</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SoundCard4">
		<xsl:element name="prg:hex">0280</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Midi">
		<xsl:element name="prg:hex">0330</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Synthesizer">
		<xsl:element name="prg:hex">0388</xsl:element>
	</xsl:template>
	<xsl:template match="ns:KeyboardController">
		<xsl:element name="prg:hex">0060</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MathCoprocessor">
		<xsl:element name="prg:hex">00F0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MonochromeDisplayAdapter">
		<xsl:element name="prg:hex">03B0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ParallelPrinterPort1">
		<xsl:element name="prg:hex">0278</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ParallelPrinterPort2">
		<xsl:element name="prg:hex">0378</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ParallelPrinterPort3">
		<xsl:element name="prg:hex">03BC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PciConfiguration1">
		<xsl:element name="prg:hex">0CF8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PciConfiguration2">
		<xsl:element name="prg:hex">C000</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PcNetworkAdapter1">
		<xsl:element name="prg:hex">0620</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PcNetworkAdapter2">
		<xsl:element name="prg:hex">0628</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PlugAndPlayConfiguration">
		<xsl:element name="prg:hex">0279</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PlugAndPlayWriteData">
		<xsl:element name="prg:hex">0A79</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PowerManagement">
		<xsl:element name="prg:hex">0178</xsl:element>
	</xsl:template>
	<xsl:template match="ns:InterruptController1">
		<xsl:element name="prg:hex">0020</xsl:element>
	</xsl:template>
	<xsl:template match="ns:InterruptController2">
		<xsl:element name="prg:hex">00A0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ProgrammableIntervalTimer">
		<xsl:element name="prg:hex">0040</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SerialPort1">
		<xsl:element name="prg:hex">03F8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SerialPort2">
		<xsl:element name="prg:hex">02F8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SerialPort3">
		<xsl:element name="prg:hex">03E8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SerialPort4">
		<xsl:element name="prg:hex">02E8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ScsiController">
		<xsl:element name="prg:hex">0340</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ScsiController2">
		<xsl:element name="prg:hex">0140</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Timer">
		<xsl:element name="prg:hex">0078</xsl:element>
	</xsl:template>
	<xsl:template match="ns:VideoGraphicsAdapter1">
		<xsl:element name="prg:hex">03C6</xsl:element>
	</xsl:template>
	<xsl:template match="ns:VideoGraphicsAdapter2">
		<xsl:element name="prg:hex">02C6</xsl:element>
	</xsl:template>
	<xsl:template match="ns:WatchdogTimer">
		<xsl:element name="prg:hex">0352</xsl:element>
	</xsl:template>
	<xsl:template match="ns:NetworkAdapter1">
		<xsl:element name="prg:hex">0240</xsl:element>
	</xsl:template>
	<xsl:template match="ns:NetworkAdapter2">
		<xsl:element name="prg:hex">0260</xsl:element>
	</xsl:template>
	<xsl:template match="ns:NetworkAdapter3">
		<xsl:element name="prg:hex">0280</xsl:element>
	</xsl:template>
	<xsl:template match="ns:NetworkAdapter4">
		<xsl:element name="prg:hex">02A0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:NetworkAdapter5">
		<xsl:element name="prg:hex">0300</xsl:element>
	</xsl:template>
	<xsl:template match="ns:NetworkAdapter6">
		<xsl:element name="prg:hex">0320</xsl:element>
	</xsl:template>
	<xsl:template match="ns:NetworkAdapter7">
		<xsl:element name="prg:hex">0340</xsl:element>
	</xsl:template>
	<xsl:template match="ns:NetworkAdapter8">
		<xsl:element name="prg:hex">0360</xsl:element>
	</xsl:template>
</xsl:stylesheet>