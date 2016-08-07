<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:vesa="http://metalx.org/Pc/Vesa/SuperVga">
	
  <xsl:output method="xml" indent="yes" />
	
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="vesa:GetSuperVgaInformation">
    <xsl:element name="hex">4F00</xsl:element>
  </xsl:template>
  <xsl:template match="vesa:GetVideoModeInformation">
    <xsl:element name="hex">4F01</xsl:element>
  </xsl:template>
  <xsl:template match="vesa:SetVideoMode">
    <xsl:element name="hex">4F02</xsl:element>
  </xsl:template>
  <xsl:template match="vesa:GetCurrentVideoMode">
    <xsl:element name="hex">4F03</xsl:element>
  </xsl:template>
  <xsl:template match="vesa:VideoState">
    <xsl:element name="hex">4F04</xsl:element>
  </xsl:template>
  <xsl:template match="vesa:VideoWindow">
    <xsl:element name="hex">4F05</xsl:element>
  </xsl:template>
  <xsl:template match="vesa:VideoScanLine">
    <xsl:element name="hex">4F06</xsl:element>
  </xsl:template>
  <xsl:template match="vesa:VideoDisplay">
    <xsl:element name="hex">4F07</xsl:element>
  </xsl:template>
  <xsl:template match="vesa:VideoPalette">
    <xsl:element name="hex">4F08</xsl:element>
  </xsl:template>
  <xsl:template match="vesa:VideoPaletteEntry">
    <xsl:element name="hex">4F09</xsl:element>
  </xsl:template>
  <xsl:template match="vesa:GetProtectedModeInterface">
    <xsl:element name="hex">4F0A</xsl:element>
  </xsl:template>
  <xsl:template match="vesa:GetNearestPixelClock">
    <xsl:element name="hex">4F0B</xsl:element>
  </xsl:template>
</xsl:stylesheet>