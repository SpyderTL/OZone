<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:pic="http://metalx.org/Pc/Pic/Commands"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="xml" indent="yes" />

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="pic:Initialize">
		<xsl:element name="hex">10</xsl:element>
	</xsl:template>
	<xsl:template match="pic:InitializeForEnvironment">
		<xsl:element name="hex">11</xsl:element>
	</xsl:template>
	<xsl:template match="pic:Environment8086Mode">
		<xsl:element name="hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="pic:EndOfInterrupt">
		<xsl:element name="hex">20</xsl:element>
	</xsl:template>
</xsl:stylesheet>