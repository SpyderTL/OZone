<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" indent="yes" />
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="PrintCharacterToPrinter">
    <xsl:element name="hex">00</xsl:element>
  </xsl:template>
  <xsl:template match="InitializePrinter">
    <xsl:element name="hex">01</xsl:element>
  </xsl:template>
  <xsl:template match="CheckPrinterStatus">
    <xsl:element name="hex">02</xsl:element>
  </xsl:template>
</xsl:stylesheet>