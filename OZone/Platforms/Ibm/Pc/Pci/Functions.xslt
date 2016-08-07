<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:pci="http://metalx.org/Pc/Pci/Functions"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
  <xsl:output method="xml" indent="yes" />
	
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="pci:InstallationCheck">
    <xsl:element name="hex">B101</xsl:element>
  </xsl:template>
  <xsl:template match="pci:FindPciDevice">
    <xsl:element name="hex">B102</xsl:element>
  </xsl:template>
  <xsl:template match="pci:FindPciClassCode">
    <xsl:element name="hex">B103</xsl:element>
  </xsl:template>
  <xsl:template match="pci:PciBusOperation">
    <xsl:element name="hex">B106</xsl:element>
  </xsl:template>
  <xsl:template match="pci:ReadConfigurationByte">
    <xsl:element name="hex">B108</xsl:element>
  </xsl:template>
  <xsl:template match="pci:ReadConfigurationShort">
    <xsl:element name="hex">B109</xsl:element>
  </xsl:template>
  <xsl:template match="pci:ReadConfigurationInteger">
    <xsl:element name="hex">B10A</xsl:element>
  </xsl:template>
  <xsl:template match="pci:WriteConfigurationByte">
    <xsl:element name="hex">B10B</xsl:element>
  </xsl:template>
  <xsl:template match="pci:WriteConfigurationShort">
    <xsl:element name="hex">B10C</xsl:element>
  </xsl:template>
  <xsl:template match="pci:WriteConfigurationInteger">
    <xsl:element name="hex">B10D</xsl:element>
  </xsl:template>
  <xsl:template match="pci:GetIrqRoutingInformation">
    <xsl:element name="hex">B10E</xsl:element>
  </xsl:template>
  <xsl:template match="pci:SetPciIrq">
    <xsl:element name="hex">B10F</xsl:element>
  </xsl:template>
</xsl:stylesheet>