<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ns="http://metalx.org/Pc/Pci/Classes" xmlns:prg="http://metalx.org/Program">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="ns:LegacyDevice">
		<xsl:element name="prg:hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MassStorageController">
		<xsl:element name="prg:hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="ns:NetworkController">
		<xsl:element name="prg:hex">02</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DisplayController">
		<xsl:element name="prg:hex">03</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultimediaDevice">
		<xsl:element name="prg:hex">04</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MemoryController">
		<xsl:element name="prg:hex">05</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BridgeDevice">
		<xsl:element name="prg:hex">06</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CommunicationController">
		<xsl:element name="prg:hex">07</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SystemPeripheral">
		<xsl:element name="prg:hex">08</xsl:element>
	</xsl:template>
	<xsl:template match="ns:InputDevice">
		<xsl:element name="prg:hex">09</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DockingStation">
		<xsl:element name="prg:hex">0a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Processor">
		<xsl:element name="prg:hex">0b</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SerialBusController">
		<xsl:element name="prg:hex">0c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LegacyNonVgaDevice">
		<xsl:element name="prg:hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LegacyVgaDevice">
		<xsl:element name="prg:hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ScsiController">
		<xsl:element name="prg:hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IdeController">
		<xsl:element name="prg:hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FloppyDiskController">
		<xsl:element name="prg:hex">02</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IpiController">
		<xsl:element name="prg:hex">03</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RaidController">
		<xsl:element name="prg:hex">04</xsl:element>
	</xsl:template>
	<xsl:template match="ns:EthernetController">
		<xsl:element name="prg:hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TokenRingController">
		<xsl:element name="prg:hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FddiController">
		<xsl:element name="prg:hex">02</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AtmController">
		<xsl:element name="prg:hex">03</xsl:element>
	</xsl:template>
	<xsl:template match="ns:VgaController">
		<xsl:element name="prg:hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="ns:XgaController">
		<xsl:element name="prg:hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="ns:VideoDevice">
		<xsl:element name="prg:hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AudioDevice">
		<xsl:element name="prg:hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RamController">
		<xsl:element name="prg:hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FlashMemoryController">
		<xsl:element name="prg:hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="ns:HostPciBridge">
		<xsl:element name="prg:hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PciIsaBridge">
		<xsl:element name="prg:hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PciEisaBridge">
		<xsl:element name="prg:hex">02</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PciMicroChannelBridge">
		<xsl:element name="prg:hex">03</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PciPciBridge">
		<xsl:element name="prg:hex">04</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PciPcmciaBridge">
		<xsl:element name="prg:hex">05</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PciNuBusBridge">
		<xsl:element name="prg:hex">06</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PciCardBusBridge">
		<xsl:element name="prg:hex">07</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SerialController">
		<xsl:element name="prg:hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ParallelController">
		<xsl:element name="prg:hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ProgrammableInterruptController">
		<xsl:element name="prg:hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DirectMemoryAccessController">
		<xsl:element name="prg:hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SystemTimer">
		<xsl:element name="prg:hex">02</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RealTimeClockController">
		<xsl:element name="prg:hex">03</xsl:element>
	</xsl:template>
	<xsl:template match="ns:KeyboardController">
		<xsl:element name="prg:hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DigitizerController">
		<xsl:element name="prg:hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MouseController">
		<xsl:element name="prg:hex">02</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Intel80386Processor">
		<xsl:element name="prg:hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Intel80486Processor">
		<xsl:element name="prg:hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IntelPentiumProcessor">
		<xsl:element name="prg:hex">02</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AlphaProcessor">
		<xsl:element name="prg:hex">10</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PowerPcProcessor">
		<xsl:element name="prg:hex">20</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Coprocessor">
		<xsl:element name="prg:hex">40</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FirewireBusController">
		<xsl:element name="prg:hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AccessBusController">
		<xsl:element name="prg:hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SsaBusController">
		<xsl:element name="prg:hex">02</xsl:element>
	</xsl:template>
	<xsl:template match="ns:UniversalSerialBusController">
		<xsl:element name="prg:hex">03</xsl:element>
	</xsl:template>
	<xsl:template match="ns:UnknownDevice">
		<xsl:element name="prg:hex">80</xsl:element>
	</xsl:template>
</xsl:stylesheet>