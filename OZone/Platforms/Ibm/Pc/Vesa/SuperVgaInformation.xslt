<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:info="http://metalx.org/Pc/Vesa/SuperVga/Information"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:output method="xml" indent="yes" />
	
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="info:Signature">
		<xsl:element name="hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="info:Version">
		<xsl:element name="hex">04</xsl:element>
	</xsl:template>
	<xsl:template match="info:OemNamePointer">
		<xsl:element name="hex">06</xsl:element>
	</xsl:template>
	<xsl:template match="info:Capabilities">
		<xsl:element name="hex">0a</xsl:element>
	</xsl:template>
	<xsl:template match="info:SupportedVideoModeListPointer">
		<xsl:element name="hex">0e</xsl:element>
	</xsl:template>
	<xsl:template match="info:TotalMemory">
		<xsl:element name="hex">12</xsl:element>
	</xsl:template>
	<xsl:template match="info:OemSoftwareVersion">
		<xsl:element name="hex">14</xsl:element>
	</xsl:template>
	<xsl:template match="info:VendorNamePointer">
		<xsl:element name="hex">16</xsl:element>
	</xsl:template>
	<xsl:template match="info:ProductNamePointer">
		<xsl:element name="hex">1a</xsl:element>
	</xsl:template>
	<xsl:template match="info:ProductRevisionPointer">
		<xsl:element name="hex">1e</xsl:element>
	</xsl:template>
	<xsl:template match="info:AccelerationVersion">
		<xsl:element name="hex">22</xsl:element>
	</xsl:template>
	<xsl:template match="info:AcceleratedVideoModeListPointer">
		<xsl:element name="hex">24</xsl:element>
	</xsl:template>
</xsl:stylesheet>