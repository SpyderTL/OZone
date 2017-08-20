<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:ns="http://metalx.org/Commodore64/Color" xmlns:prg="http://metalx.org/Program" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="ns:Black">
		<xsl:element name="prg:hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="ns:White">
		<xsl:element name="prg:hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Red">
		<xsl:element name="prg:hex">02</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Cyan">
		<xsl:element name="prg:hex">03</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Violet">
		<xsl:element name="prg:hex">04</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Green">
		<xsl:element name="prg:hex">05</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Blue">
		<xsl:element name="prg:hex">06</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Yellow">
		<xsl:element name="prg:hex">07</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Orange">
		<xsl:element name="prg:hex">08</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Brown">
		<xsl:element name="prg:hex">09</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LightRed">
		<xsl:element name="prg:hex">0a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DarkGray">
		<xsl:element name="prg:hex">0b</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Gray">
		<xsl:element name="prg:hex">0c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LightGreen">
		<xsl:element name="prg:hex">0d</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LightBlue">
		<xsl:element name="prg:hex">0e</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LightGray">
		<xsl:element name="prg:hex">0f</xsl:element>
	</xsl:template>
</xsl:stylesheet>