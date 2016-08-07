<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:ns="http://metalx.org/Pc/Cmos/Registers" xmlns:prg="http://metalx.org/Program" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="ns:Seconds">
		<xsl:element name="prg:hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Minutes">
		<xsl:element name="prg:hex">02</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Hours">
		<xsl:element name="prg:hex">04</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DayOfMonth">
		<xsl:element name="prg:hex">07</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Month">
		<xsl:element name="prg:hex">08</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Year">
		<xsl:element name="prg:hex">09</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FloppyDrives">
		<xsl:element name="prg:hex">10</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Status">
		<xsl:element name="prg:hex">0a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Diagnostics">
		<xsl:element name="prg:hex">0e</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Shutdown">
		<xsl:element name="prg:hex">0f</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Century">
		<xsl:element name="prg:hex">32</xsl:element>
	</xsl:template>
</xsl:stylesheet>