<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:imm="http://metalx.org/Intel/8086/Immediate"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" indent="yes" />
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="imm:CopyImmediateToBXSIAddress">
    <xsl:element name="hex">00</xsl:element>
  </xsl:template>
  <xsl:template match="imm:CopyImmediateToBXDIAddress">
    <xsl:element name="hex">01</xsl:element>
  </xsl:template>
  <xsl:template match="imm:CopyImmediateToBPSIAddress">
    <xsl:element name="hex">02</xsl:element>
  </xsl:template>
  <xsl:template match="imm:CopyImmediateToBPDIAddress">
    <xsl:element name="hex">03</xsl:element>
  </xsl:template>
  <xsl:template match="imm:CopyImmediateToSIAddress">
    <xsl:element name="hex">04</xsl:element>
  </xsl:template>
  <xsl:template match="imm:CopyImmediateToDIAddress">
    <xsl:element name="hex">05</xsl:element>
  </xsl:template>
  <xsl:template match="imm:CopyImmediateToImmediate16Address">
    <xsl:element name="hex">06</xsl:element>
  </xsl:template>
  <xsl:template match="imm:CopyImmediateToBXAddress">
    <xsl:element name="hex">07</xsl:element>
  </xsl:template>
  <xsl:template match="imm:CopyImmediateToBXSIAddressPlusImmediate8">
    <xsl:element name="hex">40</xsl:element>
  </xsl:template>
  <xsl:template match="imm:CopyImmediateToBXDIAddressPlusImmediate8">
    <xsl:element name="hex">41</xsl:element>
  </xsl:template>
  <xsl:template match="imm:CopyImmediateToBPSIAddressPlusImmediate8">
    <xsl:element name="hex">42</xsl:element>
  </xsl:template>
  <xsl:template match="imm:CopyImmediateToBPDIAddressPlusImmediate8">
    <xsl:element name="hex">43</xsl:element>
  </xsl:template>
  <xsl:template match="imm:CopyImmediateToSIAddressPlusImmediate8">
    <xsl:element name="hex">44</xsl:element>
  </xsl:template>
  <xsl:template match="imm:CopyImmediateToDIAddressPlusImmediate8">
    <xsl:element name="hex">45</xsl:element>
  </xsl:template>
  <xsl:template match="imm:CopyImmediateToBPAddressPlusImmediate8">
    <xsl:element name="hex">46</xsl:element>
  </xsl:template>
  <xsl:template match="imm:CopyImmediateToBXAddressPlusImmediate8">
    <xsl:element name="hex">47</xsl:element>
  </xsl:template>
  <xsl:template match="imm:CopyImmediateToBXSIAddressPlusImmediate16">
    <xsl:element name="hex">80</xsl:element>
  </xsl:template>
  <xsl:template match="imm:CopyImmediateToBXDIAddressPlusImmediate16">
    <xsl:element name="hex">81</xsl:element>
  </xsl:template>
  <xsl:template match="imm:CopyImmediateToBPSIAddressPlusImmediate16">
    <xsl:element name="hex">82</xsl:element>
  </xsl:template>
  <xsl:template match="imm:CopyImmediateToBPDIAddressPlusImmediate16">
    <xsl:element name="hex">83</xsl:element>
  </xsl:template>
  <xsl:template match="imm:CopyImmediateToSIAddressPlusImmediate16">
    <xsl:element name="hex">84</xsl:element>
  </xsl:template>
  <xsl:template match="imm:CopyImmediateToDIAddressPlusImmediate16">
    <xsl:element name="hex">85</xsl:element>
  </xsl:template>
  <xsl:template match="imm:CopyImmediateToBPAddressPlusImmediate16">
    <xsl:element name="hex">86</xsl:element>
  </xsl:template>
  <xsl:template match="imm:CopyImmediateToBXAddressPlusImmediate16">
    <xsl:element name="hex">87</xsl:element>
  </xsl:template>
  <xsl:template match="imm:CopyImmediateToAL">
    <xsl:element name="hex">C0</xsl:element>
  </xsl:template>
  <xsl:template match="imm:CopyImmediateToCL">
    <xsl:element name="hex">C1</xsl:element>
  </xsl:template>
  <xsl:template match="imm:CopyImmediateToDL">
    <xsl:element name="hex">C2</xsl:element>
  </xsl:template>
  <xsl:template match="imm:CopyImmediateToBL">
    <xsl:element name="hex">C3</xsl:element>
  </xsl:template>
  <xsl:template match="imm:CopyImmediateToAH">
    <xsl:element name="hex">C4</xsl:element>
  </xsl:template>
  <xsl:template match="imm:CopyImmediateToCH">
    <xsl:element name="hex">C5</xsl:element>
  </xsl:template>
  <xsl:template match="imm:CopyImmediateToDH">
    <xsl:element name="hex">C6</xsl:element>
  </xsl:template>
  <xsl:template match="imm:CopyImmediateToBH">
    <xsl:element name="hex">C7</xsl:element>
  </xsl:template>
  <xsl:template match="imm:CopyImmediateToAX">
    <xsl:element name="hex">C0</xsl:element>
  </xsl:template>
  <xsl:template match="imm:CopyImmediateToCX">
    <xsl:element name="hex">C1</xsl:element>
  </xsl:template>
  <xsl:template match="imm:CopyImmediateToDX">
    <xsl:element name="hex">C2</xsl:element>
  </xsl:template>
  <xsl:template match="imm:CopyImmediateToBX">
    <xsl:element name="hex">C3</xsl:element>
  </xsl:template>
  <xsl:template match="imm:CopyImmediateToSP">
    <xsl:element name="hex">C4</xsl:element>
  </xsl:template>
  <xsl:template match="imm:CopyImmediateToBP">
    <xsl:element name="hex">C5</xsl:element>
  </xsl:template>
  <xsl:template match="imm:CopyImmediateToSI">
    <xsl:element name="hex">C6</xsl:element>
  </xsl:template>
  <xsl:template match="imm:CopyImmediateToDI">
    <xsl:element name="hex">C7</xsl:element>
  </xsl:template>
</xsl:stylesheet>