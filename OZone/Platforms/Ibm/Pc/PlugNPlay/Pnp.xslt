<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:pnp="http://metalx.org/Pc/System/Pnp"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" indent="yes" />
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="pnp:InstallationCheck">
    <xsl:element name="hex">B400</xsl:element>
  </xsl:template>
  <xsl:template match="pnp:GetDefaultConfigTable">
    <xsl:element name="hex">B401</xsl:element>
  </xsl:template>
  <xsl:template match="pnp:CopyAndVerifyConfigTable">
    <xsl:element name="hex">B402</xsl:element>
  </xsl:template>
  <xsl:template match="pnp:StoreEscdTableInNonVolatileRam">
    <xsl:element name="hex">B403</xsl:element>
  </xsl:template>
  <xsl:template match="pnp:GetAvailableIrqs">
    <xsl:element name="hex">B404</xsl:element>
  </xsl:template>
  <xsl:template match="pnp:GetPciIrqRoutingTable">
    <xsl:element name="hex">B406</xsl:element>
  </xsl:template>
</xsl:stylesheet>