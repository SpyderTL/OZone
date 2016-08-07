<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:clk="http://metalx.org/Pc/Bios/Clock">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="clk:ReadRealTimeClock">
		<xsl:element name="hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="clk:SetRealTimeClock">
		<xsl:element name="hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="clk:ReadRealTimeClockTime">
		<xsl:element name="hex">02</xsl:element>
	</xsl:template>
	<xsl:template match="clk:SetRealTimeClockTime">
		<xsl:element name="hex">03</xsl:element>
	</xsl:template>
	<xsl:template match="clk:ReadRealTimeClockDate">
		<xsl:element name="hex">04</xsl:element>
	</xsl:template>
	<xsl:template match="clk:SetRealTimeClockDate">
		<xsl:element name="hex">05</xsl:element>
	</xsl:template>
	<xsl:template match="clk:SetRealTimeClockAlarm">
		<xsl:element name="hex">06</xsl:element>
	</xsl:template>
	<xsl:template match="clk:ResetRealTimeClockAlarm">
		<xsl:element name="hex">07</xsl:element>
	</xsl:template>
</xsl:stylesheet>