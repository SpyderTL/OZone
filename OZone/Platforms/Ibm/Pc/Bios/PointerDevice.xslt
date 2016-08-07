<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:ptr="http://metalx.org/Pc/Bios/PointerDevice">
  <xsl:output method="xml" indent="yes" />
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="ptr:Enable">
    <xsl:element name="hex">C200</xsl:element>
  </xsl:template>
  <xsl:template match="ptr:Reset">
    <xsl:element name="hex">C201</xsl:element>
  </xsl:template>
  <xsl:template match="ptr:SetSampleRate">
    <xsl:element name="hex">C202</xsl:element>
  </xsl:template>
  <xsl:template match="ptr:SetResolution">
    <xsl:element name="hex">C203</xsl:element>
  </xsl:template>
  <xsl:template match="ptr:GetType">
    <xsl:element name="hex">C204</xsl:element>
  </xsl:template>
  <xsl:template match="ptr:Initialize">
    <xsl:element name="hex">C205</xsl:element>
  </xsl:template>
  <xsl:template match="ptr:ExtendedFunctions">
    <xsl:element name="hex">C206</xsl:element>
  </xsl:template>
  <xsl:template match="ptr:SetDeviceHandlerAddress">
    <xsl:element name="hex">C207</xsl:element>
  </xsl:template>
  <xsl:template match="ptr:WriteByte">
    <xsl:element name="hex">C208</xsl:element>
  </xsl:template>
  <xsl:template match="ptr:ReadByte">
    <xsl:element name="hex">C209</xsl:element>
  </xsl:template>
</xsl:stylesheet>