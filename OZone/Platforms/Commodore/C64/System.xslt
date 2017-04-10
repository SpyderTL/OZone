<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:ns="http://metalx.org/Commodore64/System" xmlns:prg="http://metalx.org/Program" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" indent="yes" />
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" />
    </xsl:copy>
  </xsl:template>
	<xsl:template match="ns:CpuPortDirectionControl">
		<xsl:element name="prg:label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">0000</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CpuRomBankControl">
		<xsl:element name="prg:label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">0001</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CharacterColor">
		<xsl:element name="prg:label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">0286</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BackgroundCursorColor">
    <xsl:element name="prg:label">
      <xsl:attribute name="id">
        <xsl:value-of select="@id" />
      </xsl:attribute>
      <xsl:attribute name="offset">0287</xsl:attribute>
    </xsl:element>
  </xsl:template>
  <xsl:template match="ns:LowerCaseMode">
    <xsl:element name="prg:label">
      <xsl:attribute name="id">
        <xsl:value-of select="@id" />
      </xsl:attribute>
      <xsl:attribute name="offset">0291</xsl:attribute>
    </xsl:element>
  </xsl:template>
</xsl:stylesheet>