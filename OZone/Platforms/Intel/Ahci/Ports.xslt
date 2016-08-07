<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:ns="http://metalx.org/Intel/Ahci/Ports" xmlns:prg="http://metalx.org/Program" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" indent="yes" />
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="ns:CommandListAddressLow">
    <xsl:element name="prg:hex">00</xsl:element>
  </xsl:template>
  <xsl:template match="ns:CommandListAddressHigh">
    <xsl:element name="prg:hex">04</xsl:element>
  </xsl:template>
  <xsl:template match="ns:FrameAddressLow">
    <xsl:element name="prg:hex">08</xsl:element>
  </xsl:template>
  <xsl:template match="ns:FrameAddressHight">
    <xsl:element name="prg:hex">0c</xsl:element>
  </xsl:template>
  <xsl:template match="ns:InterruptStatus">
    <xsl:element name="prg:hex">10</xsl:element>
  </xsl:template>
  <xsl:template match="ns:InterruptEnable">
    <xsl:element name="prg:hex">14</xsl:element>
  </xsl:template>
  <xsl:template match="ns:CommandAndStatus">
    <xsl:element name="prg:hex">18</xsl:element>
  </xsl:template>
  <xsl:template match="ns:TaskFileData">
    <xsl:element name="prg:hex">20</xsl:element>
  </xsl:template>
  <xsl:template match="ns:Signature">
    <xsl:element name="prg:hex">24</xsl:element>
  </xsl:template>
  <xsl:template match="ns:SerialAtaStatus">
    <xsl:element name="prg:hex">28</xsl:element>
  </xsl:template>
  <xsl:template match="ns:SerialAtaControl">
    <xsl:element name="prg:hex">2c</xsl:element>
  </xsl:template>
  <xsl:template match="ns:SerialAtaError">
    <xsl:element name="prg:hex">30</xsl:element>
  </xsl:template>
  <xsl:template match="ns:SerialAtaActive">
    <xsl:element name="prg:hex">34</xsl:element>
  </xsl:template>
  <xsl:template match="ns:CommandIssue">
    <xsl:element name="prg:hex">38</xsl:element>
  </xsl:template>
  <xsl:template match="ns:SerialAtaNotification">
    <xsl:element name="prg:hex">3c</xsl:element>
  </xsl:template>
  <xsl:template match="ns:FrameBasedSwitchingControl">
    <xsl:element name="prg:hex">40</xsl:element>
  </xsl:template>
  <xsl:template match="ns:VendorSpecific">
    <xsl:element name="prg:hex">70</xsl:element>
  </xsl:template>
</xsl:stylesheet>