<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:ns="http://metalx.org/Usb/Ohci/Communication" xmlns:prg="http://metalx.org/Program" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="ns:InterruptEndpointDescriptorAddresses">
		<xsl:element name="prg:hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FrameNumber">
		<xsl:element name="prg:hex">80</xsl:element>
	</xsl:template>
	<xsl:template match="ns:HeadDoneTransferDescriptorAddress">
		<xsl:element name="prg:hex">84</xsl:element>
	</xsl:template>
</xsl:stylesheet>