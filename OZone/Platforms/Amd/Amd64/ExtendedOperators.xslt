<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns="http://metalx.org/Program" xmlns:ex="http://metalx.org/Amd/Amd64/ExtendedOperators" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="ex:DescriptorTableFunction">
		<xsl:element name="hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="ex:CopyControlRegisterToRegister">
		<xsl:element name="hex">20</xsl:element>
	</xsl:template>
	<xsl:template match="ex:CopyRegisterToControlRegister">
		<xsl:element name="hex">22</xsl:element>
	</xsl:template>
	<xsl:template match="ex:CopyAXDXToCXModelSpecificRegister">
		<xsl:element name="hex">30</xsl:element>
	</xsl:template>
	<xsl:template match="ex:CopyCXModelSpecificRegisterToAXDX">
		<xsl:element name="hex">32</xsl:element>
	</xsl:template>
	<xsl:template match="ex:GetCpuInformation">
		<xsl:element name="hex">A2</xsl:element>
	</xsl:template>
</xsl:stylesheet>