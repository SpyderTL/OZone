<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:pcn="http://metalx.org/Amd/PcNet/Ports"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:output method="xml" indent="yes" />
	
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="pcn:RegisterData">
		<xsl:element name="hex">10</xsl:element>
	</xsl:template>
	<xsl:template match="pcn:RegisterAccess">
		<xsl:element name="hex">12</xsl:element>
	</xsl:template>
	<xsl:template match="pcn:ResetRegister">
		<xsl:element name="hex">14</xsl:element>
	</xsl:template>
	<xsl:template match="pcn:BusData">
		<xsl:element name="hex">16</xsl:element>
	</xsl:template>
</xsl:stylesheet>