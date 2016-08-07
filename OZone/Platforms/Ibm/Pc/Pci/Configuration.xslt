<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:ns="http://metalx.org/Pc/Pci/Configuration" xmlns:prg="http://metalx.org/Program" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="ns:VendorID">
		<xsl:element name="prg:hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DeviceID">
		<xsl:element name="prg:hex">02</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CommandRegister">
		<xsl:element name="prg:hex">04</xsl:element>
	</xsl:template>
	<xsl:template match="ns:StatusRegister">
		<xsl:element name="prg:hex">06</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RevisionID">
		<xsl:element name="prg:hex">08</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ClassCode">
		<xsl:element name="prg:hex">0a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CacheLineSize">
		<xsl:element name="prg:hex">0c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LatencyTimer">
		<xsl:element name="prg:hex">0d</xsl:element>
	</xsl:template>
	<xsl:template match="ns:HeaderType">
		<xsl:element name="prg:hex">0e</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BuiltInSelfTest">
		<xsl:element name="prg:hex">0f</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BaseAddress0">
		<xsl:element name="prg:hex">10</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BaseAddress1">
		<xsl:element name="prg:hex">14</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BaseAddress2">
		<xsl:element name="prg:hex">18</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BaseAddress3">
		<xsl:element name="prg:hex">1c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BaseAddress4">
		<xsl:element name="prg:hex">20</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BaseAddress5">
		<xsl:element name="prg:hex">24</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CardBusCisPointer">
		<xsl:element name="prg:hex">28</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubsystemVendorID">
		<xsl:element name="prg:hex">2c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubsystemDeviceID">
		<xsl:element name="prg:hex">2e</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExpansionRomBaseAddress">
		<xsl:element name="prg:hex">30</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CapabilityListOffset">
		<xsl:element name="prg:hex">34</xsl:element>
	</xsl:template>
	<xsl:template match="ns:InterruptLine">
		<xsl:element name="prg:hex">3c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:InterruptPin">
		<xsl:element name="prg:hex">3d</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BusMasterOwnershipTime">
		<xsl:element name="prg:hex">3e</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BusMasterMaximumLatency">
		<xsl:element name="prg:hex">3f</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BridgePrimaryBusNumber">
		<xsl:element name="prg:hex">18</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BridgeSecondaryBusNumber">
		<xsl:element name="prg:hex">19</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BridgeSubordinateBusNumber">
		<xsl:element name="prg:hex">1a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BridgeSecondaryLatencyTimer">
		<xsl:element name="prg:hex">1b</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BridgeIOBaseLow">
		<xsl:element name="prg:hex">1c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BridgeIOLimitLow">
		<xsl:element name="prg:hex">1d</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BridgeSecondaryStatus">
		<xsl:element name="prg:hex">1e</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BridgeMemoryBase">
		<xsl:element name="prg:hex">20</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BridgeMemoryLimit">
		<xsl:element name="prg:hex">20</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BridgePrefetchableMemoryBaseLow">
		<xsl:element name="prg:hex">24</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BridgePrefetchableMemoryLimitLow">
		<xsl:element name="prg:hex">24</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BridgePrefetchableMemoryBaseHigh">
		<xsl:element name="prg:hex">28</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BridgePrefetchableMemoryLimitHigh">
		<xsl:element name="prg:hex">2c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BridgeIOBaseHigh">
		<xsl:element name="prg:hex">30</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BridgeIOLimitHigh">
		<xsl:element name="prg:hex">32</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BridgeControl">
		<xsl:element name="prg:hex">3c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CardBusSocketBaseAddress">
		<xsl:element name="prg:hex">10</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CardBusCapabilityListOffset">
		<xsl:element name="prg:hex">14</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CardBusSecondaryStatus">
		<xsl:element name="prg:hex">16</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CardBusPciBusNumber">
		<xsl:element name="prg:hex">18</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CardBusBusNumber">
		<xsl:element name="prg:hex">19</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CardBusSubordinateBusNumber">
		<xsl:element name="prg:hex">1a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CardBusLatencyTimer">
		<xsl:element name="prg:hex">1b</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CardBusMemoryBase0">
		<xsl:element name="prg:hex">1c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CardBusMemoryLimit0">
		<xsl:element name="prg:hex">20</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CardBusMemoryBase1">
		<xsl:element name="prg:hex">24</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CardBusMemoryLimit1">
		<xsl:element name="prg:hex">28</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CardBusIOBase0">
		<xsl:element name="prg:hex">2c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CardBusIOLimit0">
		<xsl:element name="prg:hex">30</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CardBusIOBase1">
		<xsl:element name="prg:hex">34</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CardBusIOLimit1">
		<xsl:element name="prg:hex">38</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CardBusSubsystemVendorID">
		<xsl:element name="prg:hex">40</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CardBusSubsystemDeviceID">
		<xsl:element name="prg:hex">42</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CardBusLegacyBaseAddress">
		<xsl:element name="prg:hex">44</xsl:element>
	</xsl:template>
</xsl:stylesheet>