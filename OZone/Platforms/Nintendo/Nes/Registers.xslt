<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:nes="http://metalx.org/Nintendo/Nes/Registers"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="xml" indent="yes" />

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="nes:PpuControl0">
		<xsl:element name="hex">2000</xsl:element>
	</xsl:template>
	<xsl:template match="nes:PpuControl1">
		<xsl:element name="hex">2001</xsl:element>
	</xsl:template>
	<xsl:template match="nes:PpuStatus">
		<xsl:element name="hex">2002</xsl:element>
	</xsl:template>
	<xsl:template match="nes:SpriteAddress">
		<xsl:element name="hex">2003</xsl:element>
	</xsl:template>
	<xsl:template match="nes:SpriteData">
		<xsl:element name="hex">2004</xsl:element>
	</xsl:template>
	<xsl:template match="nes:ScreenScroll">
		<xsl:element name="hex">2005</xsl:element>
	</xsl:template>
	<xsl:template match="nes:PpuAddress">
		<xsl:element name="hex">2006</xsl:element>
	</xsl:template>
	<xsl:template match="nes:PpuData">
		<xsl:element name="hex">2007</xsl:element>
	</xsl:template>
	<xsl:template match="nes:Square0VolumeAndDecay">
		<xsl:element name="hex">4000</xsl:element>
	</xsl:template>
	<xsl:template match="nes:Square1VolumeAndDecay">
		<xsl:element name="hex">4004</xsl:element>
	</xsl:template>
	<xsl:template match="nes:NoiseVolumeAndDecay">
		<xsl:element name="hex">400c</xsl:element>
	</xsl:template>
	<xsl:template match="nes:TriangleVolumeAndDecay">
		<xsl:element name="hex">4008</xsl:element>
	</xsl:template>
	<xsl:template match="nes:Square0Sweep">
		<xsl:element name="hex">4001</xsl:element>
	</xsl:template>
	<xsl:template match="nes:Square1Sweep">
		<xsl:element name="hex">4005</xsl:element>
	</xsl:template>
	<xsl:template match="nes:Square0Frequency">
		<xsl:element name="hex">4002</xsl:element>
	</xsl:template>
	<xsl:template match="nes:Square1Frequency">
		<xsl:element name="hex">4006</xsl:element>
	</xsl:template>
	<xsl:template match="nes:NoiseSampleRate">
		<xsl:element name="hex">400e</xsl:element>
	</xsl:template>
	<xsl:template match="nes:TriangleFrequency">
		<xsl:element name="hex">400a</xsl:element>
	</xsl:template>
	<xsl:template match="nes:Square0Length">
		<xsl:element name="hex">4003</xsl:element>
	</xsl:template>
	<xsl:template match="nes:Square1Length">
		<xsl:element name="hex">4007</xsl:element>
	</xsl:template>
	<xsl:template match="nes:NoiseLength">
		<xsl:element name="hex">400f</xsl:element>
	</xsl:template>
	<xsl:template match="nes:TriangleLength">
		<xsl:element name="hex">400b</xsl:element>
	</xsl:template>
	<xsl:template match="nes:DmaSpriteTransfer">
		<xsl:element name="hex">4014</xsl:element>
	</xsl:template>
	<xsl:template match="nes:SoundChannel">
		<xsl:element name="hex">4015</xsl:element>
	</xsl:template>
	<xsl:template match="nes:Joystick1">
		<xsl:element name="hex">4016</xsl:element>
	</xsl:template>
	<xsl:template match="nes:Joystick2">
		<xsl:element name="hex">4017</xsl:element>
	</xsl:template>
</xsl:stylesheet>