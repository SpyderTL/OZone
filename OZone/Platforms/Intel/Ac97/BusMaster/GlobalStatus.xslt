<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:ns="http://metalx.org/Intel/Ac97/BusMaster/GlobalStatus" xmlns:prg="http://metalx.org/Program" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="ns:Multichannel6">
		<xsl:element name="prg:hex">20</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Multichannel4">
		<xsl:element name="prg:hex">10</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ModemPowerDownSemiphore">
		<xsl:element name="prg:hex">02</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AudioPowerDownSemiphore">
		<xsl:element name="prg:hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ReadComplete">
		<xsl:element name="prg:hex">8000</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SecondaryResumeInterrupt">
		<xsl:element name="prg:hex">0800</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PrimaryResumeInterrupt">
		<xsl:element name="prg:hex">0400</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SecondaryCodecReady">
		<xsl:element name="prg:hex">0200</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PrimaryCodecReady">
		<xsl:element name="prg:hex">0100</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MicrophoneInterrupt">
		<xsl:element name="prg:hex">80</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PcmOutInterrupt">
		<xsl:element name="prg:hex">40</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PcmInInterrupt">
		<xsl:element name="prg:hex">20</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ModemOutInterrupt">
		<xsl:element name="prg:hex">04</xsl:element>
	</xsl:template>
</xsl:stylesheet>