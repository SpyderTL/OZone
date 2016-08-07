<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns="http://metalx.org/Program" xmlns:ari="http://metalx.org/Amd/Amd64/DescriptorTable" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="ari:CopyImmediateAddressToGlobalDescriptorTableRegister">
		<xsl:element name="hex">15</xsl:element>
	</xsl:template>
	<xsl:template match="ari:CopyImmediateAddressToInterruptDescriptorTableRegister">
		<xsl:element name="hex">1d</xsl:element>
	</xsl:template>
</xsl:stylesheet>