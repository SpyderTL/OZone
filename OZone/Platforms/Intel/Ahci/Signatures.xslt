<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:ns="http://metalx.org/Intel/Ahci/Signatures" xmlns:prg="http://metalx.org/Program" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" indent="yes" />
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="ns:Sata">
    <xsl:element name="prg:hex">00000101</xsl:element>
  </xsl:template>
  <xsl:template match="ns:SataPacket">
    <xsl:element name="prg:hex">EB140101</xsl:element>
  </xsl:template>
  <xsl:template match="ns:EnclosureManagementBridge">
    <xsl:element name="prg:hex">C33C0101</xsl:element>
  </xsl:template>
  <xsl:template match="ns:PortMultiplier">
    <xsl:element name="prg:hex">96690101</xsl:element>
  </xsl:template>
</xsl:stylesheet>