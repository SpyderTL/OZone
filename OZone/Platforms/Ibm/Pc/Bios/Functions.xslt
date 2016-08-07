<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:bios="http://metalx.org/Pc/Bios/Functions">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="bios:VideoFunctions">
		<xsl:element name="hex">10</xsl:element>
	</xsl:template>
	<xsl:template match="bios:GetEquipment">
		<xsl:element name="hex">11</xsl:element>
	</xsl:template>
	<xsl:template match="bios:GetMemorySize">
		<xsl:element name="hex">12</xsl:element>
	</xsl:template>
	<xsl:template match="bios:DiskFunctions">
		<xsl:element name="hex">13</xsl:element>
	</xsl:template>
	<xsl:template match="bios:SerialPortFunctions">
		<xsl:element name="hex">14</xsl:element>
	</xsl:template>
	<xsl:template match="bios:SystemFunctions">
		<xsl:element name="hex">15</xsl:element>
	</xsl:template>
	<xsl:template match="bios:KeyboardFunctions">
		<xsl:element name="hex">16</xsl:element>
	</xsl:template>
	<xsl:template match="bios:PrintFunctions">
		<xsl:element name="hex">17</xsl:element>
	</xsl:template>
	<xsl:template match="bios:ExecuteBasic">
		<xsl:element name="hex">18</xsl:element>
	</xsl:template>
	<xsl:template match="bios:LoadOperatingSystem">
		<xsl:element name="hex">19</xsl:element>
	</xsl:template>
	<xsl:template match="bios:ClockFunctions">
		<xsl:element name="hex">1A</xsl:element>
	</xsl:template>
	<xsl:template match="bios:PciFunctions">
		<xsl:element name="hex">1A</xsl:element>
	</xsl:template>
	<xsl:template match="bios:PnpFunctions">
		<xsl:element name="hex">1A</xsl:element>
	</xsl:template>
	<xsl:template match="bios:UserTimer">
		<xsl:element name="hex">1C</xsl:element>
	</xsl:template>
	<xsl:template match="bios:VideoParameters">
		<xsl:element name="hex">1D</xsl:element>
	</xsl:template>
	<xsl:template match="bios:DisketteParameters">
		<xsl:element name="hex">1E</xsl:element>
	</xsl:template>
	<xsl:template match="bios:CharacterData">
		<xsl:element name="hex">1F</xsl:element>
	</xsl:template>
	<xsl:template match="bios:Harddrive1Parameters">
		<xsl:element name="hex">41</xsl:element>
	</xsl:template>
	<xsl:template match="bios:Harddrive2Parameters">
		<xsl:element name="hex">46</xsl:element>
	</xsl:template>
	<xsl:template match="bios:Alarm">
		<xsl:element name="hex">4A</xsl:element>
	</xsl:template>
	<xsl:template match="bios:ClockFunctionsExtended">
		<xsl:element name="hex">70</xsl:element>
	</xsl:template>
	<xsl:template match="bios:IdePrimaryControllerFunctions">
		<xsl:element name="hex">76</xsl:element>
	</xsl:template>
	<xsl:template match="bios:IdeSecondaryControllerFunctions">
		<xsl:element name="hex">77</xsl:element>
	</xsl:template>
</xsl:stylesheet>