<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:pow="http://metalx.org/Pc/Vesa/Power/State">
  <xsl:output method="xml" indent="yes" />
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="pow:Ready">
    <xsl:element name="hex">0000</xsl:element>
  </xsl:template>
  <xsl:template match="pow:Standby">
    <xsl:element name="hex">0001</xsl:element>
  </xsl:template>
  <xsl:template match="pow:Suspend">
    <xsl:element name="hex">0002</xsl:element>
  </xsl:template>
  <xsl:template match="pow:Off">
    <xsl:element name="hex">0003</xsl:element>
  </xsl:template>
  <xsl:template match="pow:LastRequestNotification">
    <xsl:element name="hex">0004</xsl:element>
  </xsl:template>
  <xsl:template match="pow:LastRequestRejected">
    <xsl:element name="hex">0005</xsl:element>
  </xsl:template>
</xsl:stylesheet>