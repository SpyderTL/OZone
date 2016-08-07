<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:ns="http://metalx.org/Pc/Pata/Commands" xmlns:prg="http://metalx.org/Program" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="ns:RegisterHostToDevice">
		<xsl:element name="prg:hex">27</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RegisterDeviceToHost">
		<xsl:element name="prg:hex">34</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DmaActivate">
		<xsl:element name="prg:hex">39</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DmaSetup">
		<xsl:element name="prg:hex">41</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Data">
		<xsl:element name="prg:hex">46</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BuiltInSelftTestActivate">
		<xsl:element name="prg:hex">58</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PioSetup">
		<xsl:element name="prg:hex">5F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetDeviceBits">
		<xsl:element name="prg:hex">A1</xsl:element>
	</xsl:template>
</xsl:stylesheet>