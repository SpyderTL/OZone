<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ns="http://metalx.org/Pc/Video/Registers" xmlns:prg="http://metalx.org/Program">
  <xsl:output method="xml" indent="yes" />
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="ns:HorizontalTotal">
    <xsl:element name="prg:hex">00</xsl:element>
  </xsl:template>
  <xsl:template match="ns:HorizontalDisplay">
    <xsl:element name="prg:hex">01</xsl:element>
  </xsl:template>
  <xsl:template match="ns:HorizontalSyncPosition">
    <xsl:element name="prg:hex">02</xsl:element>
  </xsl:template>
  <xsl:template match="ns:SyncPulseWidth">
    <xsl:element name="prg:hex">03</xsl:element>
  </xsl:template>
  <xsl:template match="ns:VerticalTotal">
    <xsl:element name="prg:hex">04</xsl:element>
  </xsl:template>
  <xsl:template match="ns:VerticalTotalAdjust">
    <xsl:element name="prg:hex">05</xsl:element>
  </xsl:template>
  <xsl:template match="ns:VerticalDisplay">
    <xsl:element name="prg:hex">06</xsl:element>
  </xsl:template>
  <xsl:template match="ns:VerticalSyncPulseWidth">
    <xsl:element name="prg:hex">07</xsl:element>
  </xsl:template>
  <xsl:template match="ns:InterlaceMode">
    <xsl:element name="prg:hex">08</xsl:element>
  </xsl:template>
  <xsl:template match="ns:MaximumScanLines">
    <xsl:element name="prg:hex">09</xsl:element>
  </xsl:template>
  <xsl:template match="ns:CursorStart">
    <xsl:element name="prg:hex">0a</xsl:element>
  </xsl:template>
  <xsl:template match="ns:CursorEnd">
    <xsl:element name="prg:hex">0b</xsl:element>
  </xsl:template>
  <xsl:template match="ns:AddressHigh">
    <xsl:element name="prg:hex">0c</xsl:element>
  </xsl:template>
  <xsl:template match="ns:AddressLow">
    <xsl:element name="prg:hex">0d</xsl:element>
  </xsl:template>
  <xsl:template match="ns:CursorPositionHigh">
    <xsl:element name="prg:hex">0e</xsl:element>
  </xsl:template>
  <xsl:template match="ns:CursorPositionLow">
    <xsl:element name="prg:hex">0f</xsl:element>
  </xsl:template>
  <xsl:template match="ns:VerticalRetraceStart">
    <xsl:element name="prg:hex">10</xsl:element>
  </xsl:template>
  <xsl:template match="ns:VerticalRetraceEnd">
    <xsl:element name="prg:hex">11</xsl:element>
  </xsl:template>
  <xsl:template match="ns:VerticalDisplayEnd">
    <xsl:element name="prg:hex">12</xsl:element>
  </xsl:template>
  <xsl:template match="ns:RowOffset">
    <xsl:element name="prg:hex">13</xsl:element>
  </xsl:template>
  <xsl:template match="ns:UnderlineLocation">
    <xsl:element name="prg:hex">14</xsl:element>
  </xsl:template>
  <xsl:template match="ns:VerticalBlankStart">
    <xsl:element name="prg:hex">15</xsl:element>
  </xsl:template>
  <xsl:template match="ns:VerticalBlankEnd">
    <xsl:element name="prg:hex">16</xsl:element>
  </xsl:template>
  <xsl:template match="ns:ModeControl">
    <xsl:element name="prg:hex">17</xsl:element>
  </xsl:template>
  <xsl:template match="ns:LineCompare">
    <xsl:element name="prg:hex">18</xsl:element>
  </xsl:template>
  <xsl:template match="ns:CpuLatchData">
    <xsl:element name="prg:hex">22</xsl:element>
  </xsl:template>
  <xsl:template match="ns:AttributeToggle">
    <xsl:element name="prg:hex">24</xsl:element>
  </xsl:template>
</xsl:stylesheet>