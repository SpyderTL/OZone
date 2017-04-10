<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:ns="http://metalx.org/Commodore64/Video" xmlns:prg="http://metalx.org/Program" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" indent="yes" />
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="ns:BorderColor">
    <xsl:element name="prg:label">
      <xsl:attribute name="id">
        <xsl:value-of select="@id" />
      </xsl:attribute>
      <xsl:attribute name="offset">D020</xsl:attribute>
    </xsl:element>
  </xsl:template>
  <xsl:template match="ns:BackgroundColor0">
    <xsl:element name="prg:label">
      <xsl:attribute name="id">
        <xsl:value-of select="@id" />
      </xsl:attribute>
      <xsl:attribute name="offset">D021</xsl:attribute>
    </xsl:element>
  </xsl:template>
  <xsl:template match="ns:BackgroundColor1">
    <xsl:element name="prg:label">
      <xsl:attribute name="id">
        <xsl:value-of select="@id" />
      </xsl:attribute>
      <xsl:attribute name="offset">D022</xsl:attribute>
    </xsl:element>
  </xsl:template>
  <xsl:template match="ns:BackgroundColor2">
    <xsl:element name="prg:label">
      <xsl:attribute name="id">
        <xsl:value-of select="@id" />
      </xsl:attribute>
      <xsl:attribute name="offset">D023</xsl:attribute>
    </xsl:element>
  </xsl:template>
  <xsl:template match="ns:BackgroundColor3">
    <xsl:element name="prg:label">
      <xsl:attribute name="id">
        <xsl:value-of select="@id" />
      </xsl:attribute>
      <xsl:attribute name="offset">D024</xsl:attribute>
    </xsl:element>
  </xsl:template>
  <xsl:template match="ns:CharacterSettings">
    <xsl:element name="prg:label">
      <xsl:attribute name="id">
        <xsl:value-of select="@id" />
      </xsl:attribute>
      <xsl:attribute name="offset">D018</xsl:attribute>
    </xsl:element>
  </xsl:template>
</xsl:stylesheet>