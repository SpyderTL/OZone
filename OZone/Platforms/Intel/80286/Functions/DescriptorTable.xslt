<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns="http://metalx.org/Program" xmlns:ari="http://metalx.org/Intel/80286/DescriptorTable" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="ari:CopyImmediate16AddressToGlobalDescriptorTableRegister">
		<xsl:element name="hex">16</xsl:element>
	</xsl:template>
	<xsl:template match="ari:CopyImmediate16AddressToInterruptDescriptorTableRegister">
		<xsl:element name="hex">1E</xsl:element>
	</xsl:template>
</xsl:stylesheet>