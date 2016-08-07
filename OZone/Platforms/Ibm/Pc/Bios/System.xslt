<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns="http://metalx.org/Program" xmlns:sys="http://metalx.org/Pc/Bios/System" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="sys:KeyboardIntercept">
		<xsl:element name="hex">4F</xsl:element>
	</xsl:template>
	<xsl:template match="sys:EventWait">
		<xsl:element name="hex">83</xsl:element>
	</xsl:template>
	<xsl:template match="sys:ReadJoystick">
		<xsl:element name="hex">84</xsl:element>
	</xsl:template>
	<xsl:template match="sys:SysReqKeyCallout">
		<xsl:element name="hex">85</xsl:element>
	</xsl:template>
	<xsl:template match="sys:Wait">
		<xsl:element name="hex">86</xsl:element>
	</xsl:template>
	<xsl:template match="sys:MoveBlock">
		<xsl:element name="hex">87</xsl:element>
	</xsl:template>
	<xsl:template match="sys:GetExtendedMemorySize">
		<xsl:element name="hex">88</xsl:element>
	</xsl:template>
	<xsl:template match="sys:GetSystemParameters">
		<xsl:element name="hex">C0</xsl:element>
	</xsl:template>
	<xsl:template match="sys:GetExtendedBiosDataAreaSegment">
		<xsl:element name="hex">C1</xsl:element>
	</xsl:template>
	<xsl:template match="sys:PointingDeviceFunctions">
		<xsl:element name="hex">C2</xsl:element>
	</xsl:template>
	<xsl:template match="sys:GetExtendedMemorySizeEx">
		<xsl:element name="hex">E8</xsl:element>
	</xsl:template>
	<xsl:template match="sys:DisableA20Gate">
		<xsl:element name="hex">2400</xsl:element>
	</xsl:template>
	<xsl:template match="sys:EnableA20Gate">
		<xsl:element name="hex">2401</xsl:element>
	</xsl:template>
	<xsl:template match="sys:GetA20GateStatus">
		<xsl:element name="hex">2402</xsl:element>
	</xsl:template>
	<xsl:template match="sys:QueryA20GateSupport">
		<xsl:element name="hex">2403</xsl:element>
	</xsl:template>
	<xsl:template match="sys:GetMemoryMap">
		<xsl:element name="hex">E820</xsl:element>
	</xsl:template>
</xsl:stylesheet>