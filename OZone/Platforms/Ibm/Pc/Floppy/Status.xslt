<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ns="http://metalx.org/Pc/Floppy/Status" xmlns:prg="http://metalx.org/Program">
  <xsl:output method="xml" indent="yes" />
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="ns:Drive0Busy">
    <xsl:element name="prg:hex">01</xsl:element>
  </xsl:template>
  <xsl:template match="ns:Drive1Busy">
    <xsl:element name="prg:hex">02</xsl:element>
  </xsl:template>
  <xsl:template match="ns:Drive2Busy">
    <xsl:element name="prg:hex">04</xsl:element>
  </xsl:template>
  <xsl:template match="ns:Drive3Busy">
    <xsl:element name="prg:hex">08</xsl:element>
  </xsl:template>
  <xsl:template match="ns:CommandReceived">
    <xsl:element name="prg:hex">10</xsl:element>
  </xsl:template>
  <xsl:template match="ns:ExecutingCommand">
    <xsl:element name="prg:hex">20</xsl:element>
  </xsl:template>
  <xsl:template match="ns:DataAvailable">
    <xsl:element name="prg:hex">40</xsl:element>
  </xsl:template>
  <xsl:template match="ns:WaitingForData">
    <xsl:element name="prg:hex">80</xsl:element>
  </xsl:template>
</xsl:stylesheet>