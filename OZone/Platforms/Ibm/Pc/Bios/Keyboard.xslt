<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:key="http://metalx.org/Pc/Bios/Keyboard"
	xmlns="http://metalx.org/Program">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="key:ReadCharacter">
		<xsl:element name="hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="key:ReadInputStatus">
		<xsl:element name="hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="key:ReadKeyboardShiftStatus">
		<xsl:element name="hex">02</xsl:element>
	</xsl:template>
	<xsl:template match="key:ReadCharacterExtended">
		<xsl:element name="hex">10</xsl:element>
	</xsl:template>
	<xsl:template match="key:ReadInputStatusExtended">
		<xsl:element name="hex">11</xsl:element>
	</xsl:template>
	<xsl:template match="key:ReadKeyboardShiftStatusExtended">
		<xsl:element name="hex">12</xsl:element>
	</xsl:template>
</xsl:stylesheet>