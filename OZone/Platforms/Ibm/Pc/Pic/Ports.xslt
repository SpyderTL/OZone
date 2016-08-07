<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:pic="http://metalx.org/Pc/Pic/Ports"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="xml" indent="yes" />

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="pic:MasterCommand">
		<xsl:element name="hex">20</xsl:element>
	</xsl:template>
	<xsl:template match="pic:MasterData">
		<xsl:element name="hex">21</xsl:element>
	</xsl:template>
	<xsl:template match="pic:SlaveCommand">
		<xsl:element name="hex">a0</xsl:element>
	</xsl:template>
	<xsl:template match="pic:SlaveData">
		<xsl:element name="hex">a1</xsl:element>
	</xsl:template>
</xsl:stylesheet>