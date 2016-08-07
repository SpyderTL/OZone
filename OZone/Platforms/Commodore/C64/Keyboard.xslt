<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://metalx.org/Program"
	xmlns:key="http://metalx.org/Commodore64/Keyboard">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="key:Enter">
		<xsl:element name="hex">0D</xsl:element>
	</xsl:template>
	<xsl:template match="key:Escape">
		<xsl:element name="hex">03</xsl:element>
	</xsl:template>
	<xsl:template match="key:Backspace">
		<xsl:element name="hex">14</xsl:element>
	</xsl:template>
</xsl:stylesheet>