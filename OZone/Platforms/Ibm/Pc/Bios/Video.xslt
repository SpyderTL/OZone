<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:vid="http://metalx.org/Pc/Bios/Video">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="vid:SetVideoMode">
		<xsl:element name="hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="vid:SetCursorShape">
		<xsl:element name="hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="vid:SetCursorPosition">
		<xsl:element name="hex">02</xsl:element>
	</xsl:template>
	<xsl:template match="vid:GetCursorPosition">
		<xsl:element name="hex">03</xsl:element>
	</xsl:template>
	<xsl:template match="vid:ReadLightPenPosition">
		<xsl:element name="hex">04</xsl:element>
	</xsl:template>
	<xsl:template match="vid:SetActiveDisplayPage">
		<xsl:element name="hex">05</xsl:element>
	</xsl:template>
	<xsl:template match="vid:ScrollUpWindow">
		<xsl:element name="hex">06</xsl:element>
	</xsl:template>
	<xsl:template match="vid:ScrollDownWindow">
		<xsl:element name="hex">07</xsl:element>
	</xsl:template>
	<xsl:template match="vid:ReadFormattedCharacterAtCursorPosition">
		<xsl:element name="hex">08</xsl:element>
	</xsl:template>
	<xsl:template match="vid:WriteFormattedCharacterAtCursorPosition">
		<xsl:element name="hex">09</xsl:element>
	</xsl:template>
	<xsl:template match="vid:WriteCharacterAtCursorPosition">
		<xsl:element name="hex">0A</xsl:element>
	</xsl:template>
	<xsl:template match="vid:SetColor">
		<xsl:element name="hex">0B</xsl:element>
	</xsl:template>
	<xsl:template match="vid:WritePixel">
		<xsl:element name="hex">0C</xsl:element>
	</xsl:template>
	<xsl:template match="vid:ReadPixel">
		<xsl:element name="hex">0D</xsl:element>
	</xsl:template>
	<xsl:template match="vid:TeletypeOutput">
		<xsl:element name="hex">0E</xsl:element>
	</xsl:template>
	<xsl:template match="vid:GetVideoMode">
		<xsl:element name="hex">0F</xsl:element>
	</xsl:template>
	<xsl:template match="vid:WriteString">
		<xsl:element name="hex">13</xsl:element>
	</xsl:template>
</xsl:stylesheet>