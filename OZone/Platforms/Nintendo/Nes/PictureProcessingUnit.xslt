<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:ppu="http://metalx.org/Nintendo/Nes/PictureProcessingUnit"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="xml" indent="yes" />

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="ppu:PatternTable0">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@label" />
			</xsl:attribute>
			<xsl:attribute name="offset">0000</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ppu:PatternTable1">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@label" />
			</xsl:attribute>
			<xsl:attribute name="offset">1000</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ppu:NameTable0">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@label" />
			</xsl:attribute>
			<xsl:attribute name="offset">2000</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ppu:AttributeTable0">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@label" />
			</xsl:attribute>
			<xsl:attribute name="offset">23c0</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ppu:NameTable1">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@label" />
			</xsl:attribute>
			<xsl:attribute name="offset">2400</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ppu:AttributeTable1">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@label" />
			</xsl:attribute>
			<xsl:attribute name="offset">27c0</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ppu:NameTable2">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@label" />
			</xsl:attribute>
			<xsl:attribute name="offset">2800</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ppu:AttributeTable2">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@label" />
			</xsl:attribute>
			<xsl:attribute name="offset">2bc0</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ppu:NameTable3">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@label" />
			</xsl:attribute>
			<xsl:attribute name="offset">2c00</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ppu:AttributeTable3">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@label" />
			</xsl:attribute>
			<xsl:attribute name="offset">2fc0</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ppu:BackgroundColor">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@label" />
			</xsl:attribute>
			<xsl:attribute name="offset">3f00</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ppu:BackgroundPalette0">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@label" />
			</xsl:attribute>
			<xsl:attribute name="offset">3f01</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ppu:BackgroundPalette1">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@label" />
			</xsl:attribute>
			<xsl:attribute name="offset">3f05</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ppu:BackgroundPalette2">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@label" />
			</xsl:attribute>
			<xsl:attribute name="offset">3f09</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ppu:BackgroundPalette3">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@label" />
			</xsl:attribute>
			<xsl:attribute name="offset">3f0d</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ppu:SpritePalette0">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@label" />
			</xsl:attribute>
			<xsl:attribute name="offset">3f11</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ppu:SpritePalette1">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@label" />
			</xsl:attribute>
			<xsl:attribute name="offset">3f15</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ppu:SpritePalette2">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@label" />
			</xsl:attribute>
			<xsl:attribute name="offset">3f19</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ppu:SpritePalette3">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@label" />
			</xsl:attribute>
			<xsl:attribute name="offset">3f1d</xsl:attribute>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>