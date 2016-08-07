<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:mode="http://metalx.org/Pc/Vesa/SuperVga/Mode"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:output method="xml" indent="yes" />
	
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="mode:Attributes">
		<xsl:element name="hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="mode:WindowAttributesA">
		<xsl:element name="hex">02</xsl:element>
	</xsl:template>
	<xsl:template match="mode:WindowAttributesB">
		<xsl:element name="hex">03</xsl:element>
	</xsl:template>
	<xsl:template match="mode:WindowGranularity">
		<xsl:element name="hex">04</xsl:element>
	</xsl:template>
	<xsl:template match="mode:WindowSize">
		<xsl:element name="hex">06</xsl:element>
	</xsl:template>
	<xsl:template match="mode:WindowSegmentA">
		<xsl:element name="hex">08</xsl:element>
	</xsl:template>
	<xsl:template match="mode:WindowSegmentB">
		<xsl:element name="hex">0a</xsl:element>
	</xsl:template>
	<xsl:template match="mode:WindowPositionFunction">
		<xsl:element name="hex">0c</xsl:element>
	</xsl:template>
	<xsl:template match="mode:ScanLineSize">
		<xsl:element name="hex">10</xsl:element>
	</xsl:template>
	<xsl:template match="mode:Width">
		<xsl:element name="hex">12</xsl:element>
	</xsl:template>
	<xsl:template match="mode:Height">
		<xsl:element name="hex">14</xsl:element>
	</xsl:template>
	<xsl:template match="mode:BitsPerPixel">
		<xsl:element name="hex">19</xsl:element>
	</xsl:template>
	<xsl:template match="mode:LinearBufferAddress">
		<xsl:element name="hex">28</xsl:element>
	</xsl:template>
</xsl:stylesheet>