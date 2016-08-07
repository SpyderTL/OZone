<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:ns="http://metalx.org/Usb/Ohci/Registers" xmlns:prg="http://metalx.org/Program" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="ns:Revision">
		<xsl:element name="prg:hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Control">
		<xsl:element name="prg:hex">04</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CommandStatus">
		<xsl:element name="prg:hex">08</xsl:element>
	</xsl:template>
	<xsl:template match="ns:InterruptStatus">
		<xsl:element name="prg:hex">0c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:InterruptEnable">
		<xsl:element name="prg:hex">10</xsl:element>
	</xsl:template>
	<xsl:template match="ns:InterruptDisable">
		<xsl:element name="prg:hex">14</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CommunicationArea">
		<xsl:element name="prg:hex">18</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CurrentPeriodicEndpointDescriptorAddress">
		<xsl:element name="prg:hex">1c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:HeadControlEndpointDescriptorAddress">
		<xsl:element name="prg:hex">20</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CurrentControlEndpointDescriptorAddress">
		<xsl:element name="prg:hex">24</xsl:element>
	</xsl:template>
	<xsl:template match="ns:HeadBulkEndpointDescriptorAddress">
		<xsl:element name="prg:hex">28</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CurrentBulkEndpointDescriptorAddress">
		<xsl:element name="prg:hex">2c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:HeadDoneTransferDescriptorAddress">
		<xsl:element name="prg:hex">30</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FrameInterval">
		<xsl:element name="prg:hex">34</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FrameTimeRemaining">
		<xsl:element name="prg:hex">38</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FrameNumber">
		<xsl:element name="prg:hex">3c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PeriodicStartTime">
		<xsl:element name="prg:hex">40</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LowSpeedThreshold">
		<xsl:element name="prg:hex">44</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RootHubDescriptorA">
		<xsl:element name="prg:hex">48</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RootHubDescriptorB">
		<xsl:element name="prg:hex">4c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RootHubStatus">
		<xsl:element name="prg:hex">50</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RootHubPortStatus">
		<xsl:element name="prg:hex">54</xsl:element>
	</xsl:template>
</xsl:stylesheet>