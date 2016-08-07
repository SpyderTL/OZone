<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:cmd="http://metalx.org/Pc/Pci/Commands"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="xml" indent="yes" />

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="cmd:IOAccessEnabled">
		<xsl:element name="hex">0001</xsl:element>
	</xsl:template>
	<xsl:template match="cmd:MemoryAccessEnabled">
		<xsl:element name="hex">0002</xsl:element>
	</xsl:template>
	<xsl:template match="cmd:BusMasterEnabled">
		<xsl:element name="hex">0004</xsl:element>
	</xsl:template>
	<xsl:template match="cmd:SpecialCycleRecognitionEnabled">
		<xsl:element name="hex">0008</xsl:element>
	</xsl:template>
	<xsl:template match="cmd:MemoryWriteAndInvalidateEnabled">
		<xsl:element name="hex">0010</xsl:element>
	</xsl:template>
	<xsl:template match="cmd:VgaPaletteSnoopEnabled">
		<xsl:element name="hex">0020</xsl:element>
	</xsl:template>
	<xsl:template match="cmd:ParityErrorResponseEnabled">
		<xsl:element name="hex">0040</xsl:element>
	</xsl:template>
	<xsl:template match="cmd:WaitCyclesEnabled">
		<xsl:element name="hex">0080</xsl:element>
	</xsl:template>
	<xsl:template match="cmd:SystemErrorEnabled">
		<xsl:element name="hex">0100</xsl:element>
	</xsl:template>
	<xsl:template match="cmd:FastTransactionsEnabled">
		<xsl:element name="hex">0200</xsl:element>
	</xsl:template>
</xsl:stylesheet>