<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:sta="http://metalx.org/Pc/Pci/Status"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
  <xsl:output method="xml" indent="yes" />
	
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="sta:NewCapabilitiesListPresent">
    <xsl:element name="hex">0010</xsl:element>
  </xsl:template>
  <xsl:template match="sta:HighSpeedAvailable">
    <xsl:element name="hex">0020</xsl:element>
  </xsl:template>
  <xsl:template match="sta:UdfAvailable">
    <xsl:element name="hex">0040</xsl:element>
  </xsl:template>
  <xsl:template match="sta:FastTransactionsAvailable">
    <xsl:element name="hex">0080</xsl:element>
  </xsl:template>
  <xsl:template match="sta:ReportsParityErrors">
    <xsl:element name="hex">0100</xsl:element>
  </xsl:template>
  <xsl:template match="sta:DeviceSelectTiming">
    <xsl:element name="hex">0600</xsl:element>
  </xsl:template>
  <xsl:template match="sta:DeviceSelectTimingFast">
    <xsl:element name="hex">0000</xsl:element>
  </xsl:template>
  <xsl:template match="sta:DeviceSelectTimingMedium">
    <xsl:element name="hex">0200</xsl:element>
  </xsl:template>
  <xsl:template match="sta:DeviceSelectTimingSlow">
    <xsl:element name="hex">0400</xsl:element>
  </xsl:template>
  <xsl:template match="sta:SignaledTargetAbort">
    <xsl:element name="hex">0800</xsl:element>
  </xsl:template>
  <xsl:template match="sta:ReceivedTargetAbort">
    <xsl:element name="hex">1000</xsl:element>
  </xsl:template>
  <xsl:template match="sta:ReceivedMasterAbort">
    <xsl:element name="hex">2000</xsl:element>
  </xsl:template>
  <xsl:template match="sta:SignaledSystemError">
    <xsl:element name="hex">4000</xsl:element>
  </xsl:template>
  <xsl:template match="sta:DetectedParityError">
    <xsl:element name="hex">8000</xsl:element>
  </xsl:template>
</xsl:stylesheet>