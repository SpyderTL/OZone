<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ns="http://metalx.org/Pc/Floppy/DataRate" xmlns:prg="http://metalx.org/Program">
  <xsl:output method="xml" indent="yes" />
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="ns:DataRate500Kbps">
    <xsl:element name="prg:hex">00</xsl:element>
  </xsl:template>
  <xsl:template match="ns:DataRate300Kbps">
    <xsl:element name="prg:hex">01</xsl:element>
  </xsl:template>
  <xsl:template match="ns:DataRate250Kbps">
    <xsl:element name="prg:hex">02</xsl:element>
  </xsl:template>
  <xsl:template match="ns:DataRate1Mbps">
    <xsl:element name="prg:hex">03</xsl:element>
  </xsl:template>
</xsl:stylesheet>