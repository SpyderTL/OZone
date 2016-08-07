<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:ns="http://metalx.org/Usb/Ohci/Transfer" xmlns:prg="http://metalx.org/Program" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="ns:Flags">
		<xsl:element name="prg:hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BufferStartAddress">
		<xsl:element name="prg:hex">04</xsl:element>
	</xsl:template>
	<xsl:template match="ns:NextTransferDescriptorAddress">
		<xsl:element name="prg:hex">08</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BufferEndAddress">
		<xsl:element name="prg:hex">0c</xsl:element>
	</xsl:template>
</xsl:stylesheet>