<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:ns="http://metalx.org/Intel/Ahci/Registers" xmlns:prg="http://metalx.org/Program" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" indent="yes" />
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="ns:Capabilities">
    <xsl:element name="prg:hex">00</xsl:element>
  </xsl:template>
  <xsl:template match="ns:Control">
    <xsl:element name="prg:hex">04</xsl:element>
  </xsl:template>
  <xsl:template match="ns:InterruptStatus">
    <xsl:element name="prg:hex">08</xsl:element>
  </xsl:template>
  <xsl:template match="ns:PortsImplemented">
    <xsl:element name="prg:hex">0c</xsl:element>
  </xsl:template>
  <xsl:template match="ns:Version">
    <xsl:element name="prg:hex">10</xsl:element>
  </xsl:template>
  <xsl:template match="ns:CommandCompleteControl">
    <xsl:element name="prg:hex">14</xsl:element>
  </xsl:template>
  <xsl:template match="ns:CommandCompletePorts">
    <xsl:element name="prg:hex">18</xsl:element>
  </xsl:template>
  <xsl:template match="ns:EnclosureManagementLocation">
    <xsl:element name="prg:hex">1c</xsl:element>
  </xsl:template>
  <xsl:template match="ns:EnclosureManagementControl">
    <xsl:element name="prg:hex">20</xsl:element>
  </xsl:template>
  <xsl:template match="ns:ExtendedCapabilities">
    <xsl:element name="prg:hex">24</xsl:element>
  </xsl:template>
  <xsl:template match="ns:BiosControlAndStatus">
    <xsl:element name="prg:hex">28</xsl:element>
  </xsl:template>
  <xsl:template match="ns:VendorSpecific">
    <xsl:element name="prg:hex">a0</xsl:element>
  </xsl:template>
  <xsl:template match="ns:PortControlRegisters">
    <xsl:element name="prg:hex">0100</xsl:element>
  </xsl:template>
</xsl:stylesheet>