<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:ns="http://metalx.org/Pc/Memory"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="xml" indent="yes" />

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match="ns:InterruptVectorTable">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="page">0000</xsl:attribute>
			<xsl:attribute name="offset">0000</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BiosData">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="page">0000</xsl:attribute>
			<xsl:attribute name="offset">0400</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LowMemory">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="page">0000</xsl:attribute>
			<xsl:attribute name="offset">0500</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExtendedBiosData">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="page">9000</xsl:attribute>
			<xsl:attribute name="offset">FC00</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:VideoRam">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="page">A000</xsl:attribute>
			<xsl:attribute name="offset">0000</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:VideoBios">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="page">C000</xsl:attribute>
			<xsl:attribute name="offset">0000</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:HighMemory">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="page">C000</xsl:attribute>
			<xsl:attribute name="offset">8000</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SystemBios">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="page">F000</xsl:attribute>
			<xsl:attribute name="offset">0000</xsl:attribute>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>