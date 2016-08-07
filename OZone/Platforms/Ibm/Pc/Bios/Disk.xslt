<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:dsk="http://metalx.org/Pc/Bios/Disk">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="dsk:ResetDiskDrives">
		<xsl:element name="hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="dsk:CheckDriveStatus">
		<xsl:element name="hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="dsk:ReadSectorsFromDrive">
		<xsl:element name="hex">02</xsl:element>
	</xsl:template>
	<xsl:template match="dsk:WriteSectorsToDrive">
		<xsl:element name="hex">03</xsl:element>
	</xsl:template>
	<xsl:template match="dsk:VerifySectorsOnDrive">
		<xsl:element name="hex">04</xsl:element>
	</xsl:template>
	<xsl:template match="dsk:FormatTrackOnDrive">
		<xsl:element name="hex">05</xsl:element>
	</xsl:template>
	<xsl:template match="dsk:GetDriveParameters">
		<xsl:element name="hex">08</xsl:element>
	</xsl:template>
	<xsl:template match="dsk:InitializeFixedDriveParameters">
		<xsl:element name="hex">07</xsl:element>
	</xsl:template>
	<xsl:template match="dsk:SeekToSpecifiedTrack">
		<xsl:element name="hex">0C</xsl:element>
	</xsl:template>
	<xsl:template match="dsk:ResetFixedDiskController">
		<xsl:element name="hex">0E</xsl:element>
	</xsl:template>
	<xsl:template match="dsk:GetDriveType">
		<xsl:element name="hex">15</xsl:element>
	</xsl:template>
	<xsl:template match="dsk:GetFloppyDriveMediaChangeStatus">
		<xsl:element name="hex">16</xsl:element>
	</xsl:template>
</xsl:stylesheet>