<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:ctrl="http://metalx.org/Intel/80286/Control">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="ctrl:AX-ControlRegister0">
		<xsl:element name="hex">c0</xsl:element>
	</xsl:template>
	<xsl:template match="ctrl:AX-ControlRegister2">
		<xsl:element name="hex">d0</xsl:element>
	</xsl:template>
	<xsl:template match="ctrl:AX-ControlRegister3">
		<xsl:element name="hex">d8</xsl:element>
	</xsl:template>
	<xsl:template match="ctrl:AX-ControlRegister4">
		<xsl:element name="hex">e0</xsl:element>
	</xsl:template>
</xsl:stylesheet>