<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:kbd="http://metalx.org/Pc/Keyboard">

	<xsl:output method="xml" indent="yes" />

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="kbd:DataPort">
		<xsl:element name="hex">60</xsl:element>
	</xsl:template>
	<xsl:template match="kbd:ControlPort">
		<xsl:element name="hex">64</xsl:element>
	</xsl:template>
	<xsl:template match="kbd:StatusPort">
		<xsl:element name="hex">64</xsl:element>
	</xsl:template>
	<xsl:template match="kbd:ResetCpu">
		<xsl:element name="hex">FE</xsl:element>
	</xsl:template>
</xsl:stylesheet>