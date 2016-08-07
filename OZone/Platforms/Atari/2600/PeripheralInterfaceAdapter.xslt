<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:pia="http://metalx.org/Atari/2600/PeripheralInterfaceAdapter"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="xml" indent="yes" />

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="pia:PortAData">
		<xsl:element name="hex">0280</xsl:element>
	</xsl:template>
	<xsl:template match="pia:PortADirection">
		<xsl:element name="hex">0281</xsl:element>
	</xsl:template>
	<xsl:template match="pia:PortBData">
		<xsl:element name="hex">0282</xsl:element>
	</xsl:template>
	<xsl:template match="pia:PortBDirection">
		<xsl:element name="hex">0283</xsl:element>
	</xsl:template>
	<xsl:template match="pia:TimerValue">
		<xsl:element name="hex">0284</xsl:element>
	</xsl:template>
	<xsl:template match="pia:SetTimer1">
		<xsl:element name="hex">0294</xsl:element>
	</xsl:template>
	<xsl:template match="pia:SetTimer8">
		<xsl:element name="hex">0295</xsl:element>
	</xsl:template>
	<xsl:template match="pia:SetTimer64">
		<xsl:element name="hex">0296</xsl:element>
	</xsl:template>
	<xsl:template match="pia:SetTimer1024">
		<xsl:element name="hex">0297</xsl:element>
	</xsl:template>
</xsl:stylesheet>