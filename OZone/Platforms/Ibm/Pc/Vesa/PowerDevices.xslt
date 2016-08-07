<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:pd="http://metalx.org/Pc/Vesa/Power/Devices"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" indent="yes" />
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="pd:SystemBios">
    <xsl:element name="hex">0000</xsl:element>
  </xsl:template>
  <xsl:template match="pd:AllBiosDevices">
    <xsl:element name="hex">0001</xsl:element>
  </xsl:template>
  <xsl:template match="pd:Display">
    <xsl:element name="hex">0100</xsl:element>
  </xsl:template>
  <xsl:template match="pd:Storage">
    <xsl:element name="hex">0200</xsl:element>
  </xsl:template>
  <xsl:template match="pd:ParallelPort">
    <xsl:element name="hex">0300</xsl:element>
  </xsl:template>
  <xsl:template match="pd:SerialPort">
    <xsl:element name="hex">0400</xsl:element>
  </xsl:template>
  <xsl:template match="pd:NetworkAdapter">
    <xsl:element name="hex">0500</xsl:element>
  </xsl:template>
  <xsl:template match="pd:PCMCIASocket">
    <xsl:element name="hex">0600</xsl:element>
  </xsl:template>
  <xsl:template match="pd:Battery">
    <xsl:element name="hex">8000</xsl:element>
  </xsl:template>
  <xsl:template match="pd:OEM">
    <xsl:element name="hex">E000</xsl:element>
  </xsl:template>
  <xsl:template match="pd:AllDevices">
    <xsl:element name="hex">00FF</xsl:element>
  </xsl:template>
</xsl:stylesheet>