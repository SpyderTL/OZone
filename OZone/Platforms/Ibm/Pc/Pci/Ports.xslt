<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:pci="http://metalx.org/Pc/Pci/Ports"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="xml" indent="yes" />

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="pci:ConfigurationAddress">
		<xsl:element name="hex">00000cf8</xsl:element>
	</xsl:template>
	<xsl:template match="pci:ConfigurationData">
		<xsl:element name="hex">00000cfc</xsl:element>
	</xsl:template>
</xsl:stylesheet>