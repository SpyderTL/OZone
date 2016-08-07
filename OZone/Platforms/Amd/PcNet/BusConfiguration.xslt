<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:pnb="http://metalx.org/Amd/PcNet/BusConfiguration"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:output method="xml" indent="yes" />
	
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="pnb:MiscellaneousConfiguration">
		<xsl:element name="hex">02</xsl:element>
	</xsl:template>
	<xsl:template match="pnb:Led0Status">
		<xsl:element name="hex">04</xsl:element>
	</xsl:template>
	<xsl:template match="pnb:Led1Status">
		<xsl:element name="hex">05</xsl:element>
	</xsl:template>
	<xsl:template match="pnb:Led2Status">
		<xsl:element name="hex">06</xsl:element>
	</xsl:template>
	<xsl:template match="pnb:Led3Status">
		<xsl:element name="hex">07</xsl:element>
	</xsl:template>
	<xsl:template match="pnb:FullDuplex">
		<xsl:element name="hex">09</xsl:element>
	</xsl:template>
	<xsl:template match="pnb:BusControl">
		<xsl:element name="hex">12</xsl:element>
	</xsl:template>
	<xsl:template match="pnb:Eeprom">
		<xsl:element name="hex">13</xsl:element>
	</xsl:template>
	<xsl:template match="pnb:SoftwareStyle">
		<xsl:element name="hex">14</xsl:element>
	</xsl:template>
	<xsl:template match="pnb:PciLatency">
		<xsl:element name="hex">16</xsl:element>
	</xsl:template>
	<xsl:template match="pnb:PciSubsystemID">
		<xsl:element name="hex">17</xsl:element>
	</xsl:template>
	<xsl:template match="pnb:PciSubsystemVendorID">
		<xsl:element name="hex">18</xsl:element>
	</xsl:template>
	<xsl:template match="pnb:SramSize">
		<xsl:element name="hex">19</xsl:element>
	</xsl:template>
	<xsl:template match="pnb:SramBoundary">
		<xsl:element name="hex">1a</xsl:element>
	</xsl:template>
	<xsl:template match="pnb:SramInterface">
		<xsl:element name="hex">1b</xsl:element>
	</xsl:template>
	<xsl:template match="pnb:ExpansionBusLower">
		<xsl:element name="hex">1c</xsl:element>
	</xsl:template>
	<xsl:template match="pnb:ExpansionBusUpper">
		<xsl:element name="hex">1d</xsl:element>
	</xsl:template>
	<xsl:template match="pnb:ExpansionBusData">
		<xsl:element name="hex">1e</xsl:element>
	</xsl:template>
	<xsl:template match="pnb:SoftwareTimer">
		<xsl:element name="hex">1f</xsl:element>
	</xsl:template>
	<xsl:template match="pnb:PhyControlAndStatus">
		<xsl:element name="hex">20</xsl:element>
	</xsl:template>
	<xsl:template match="pnb:PhyAddress">
		<xsl:element name="hex">21</xsl:element>
	</xsl:template>
	<xsl:template match="pnb:PhyManagementData">
		<xsl:element name="hex">22</xsl:element>
	</xsl:template>
	<xsl:template match="pnb:PciVendorID">
		<xsl:element name="hex">23</xsl:element>
	</xsl:template>
	<xsl:template match="pnb:PciPowerManagementCapabilities">
		<xsl:element name="hex">24</xsl:element>
	</xsl:template>
	<xsl:template match="pnb:PciData0">
		<xsl:element name="hex">25</xsl:element>
	</xsl:template>
	<xsl:template match="pnb:PciData1">
		<xsl:element name="hex">26</xsl:element>
	</xsl:template>
	<xsl:template match="pnb:PciData2">
		<xsl:element name="hex">27</xsl:element>
	</xsl:template>
	<xsl:template match="pnb:PciData3">
		<xsl:element name="hex">28</xsl:element>
	</xsl:template>
	<xsl:template match="pnb:PciData4">
		<xsl:element name="hex">29</xsl:element>
	</xsl:template>
	<xsl:template match="pnb:PciData5">
		<xsl:element name="hex">2a</xsl:element>
	</xsl:template>
	<xsl:template match="pnb:PciData6">
		<xsl:element name="hex">2b</xsl:element>
	</xsl:template>
	<xsl:template match="pnb:PciData7">
		<xsl:element name="hex">2c</xsl:element>
	</xsl:template>
	<xsl:template match="pnb:PatternMatching1">
		<xsl:element name="hex">2d</xsl:element>
	</xsl:template>
	<xsl:template match="pnb:PatternMatching2">
		<xsl:element name="hex">2e</xsl:element>
	</xsl:template>
	<xsl:template match="pnb:PatternMatching3">
		<xsl:element name="hex">2f</xsl:element>
	</xsl:template>
</xsl:stylesheet>