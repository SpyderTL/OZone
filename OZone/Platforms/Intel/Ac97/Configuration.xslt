<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:cfg="http://metalx.org/Intel/Ac97/Configuration"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="cfg:MixerBaseAddress">
		<xsl:element name="hex">10</xsl:element>
	</xsl:template>
	<xsl:template match="cfg:BusMasterBaseAddress">
		<xsl:element name="hex">14</xsl:element>
	</xsl:template>
</xsl:stylesheet>