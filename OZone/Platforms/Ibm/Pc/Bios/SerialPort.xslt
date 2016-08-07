<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" indent="yes" />
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="SerialPortInitialization">
    <xsl:element name="hex">00</xsl:element>
  </xsl:template>
  <xsl:template match="TransmitCharacter">
    <xsl:element name="hex">01</xsl:element>
  </xsl:template>
  <xsl:template match="ReceiveCharacter">
    <xsl:element name="hex">02</xsl:element>
  </xsl:template>
  <xsl:template match="Status">
    <xsl:element name="hex">03</xsl:element>
  </xsl:template>
</xsl:stylesheet>