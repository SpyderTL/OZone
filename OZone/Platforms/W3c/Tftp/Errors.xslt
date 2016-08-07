<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:ns="http://metalx.org/W3c/Tftp/Errors" xmlns:prg="http://metalx.org/Program" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="ns:Undefined">
		<xsl:element name="prg:hex">0000</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FileNotFound">
		<xsl:element name="prg:hex">0001</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AccessViolation">
		<xsl:element name="prg:hex">0002</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DiskFull">
		<xsl:element name="prg:hex">0003</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IllegalOperation">
		<xsl:element name="prg:hex">0004</xsl:element>
	</xsl:template>
	<xsl:template match="ns:UnknownTransferID">
		<xsl:element name="prg:hex">0005</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FileAlreadyExists">
		<xsl:element name="prg:hex">0006</xsl:element>
	</xsl:template>
	<xsl:template match="ns:NoSuchUser">
		<xsl:element name="prg:hex">0007</xsl:element>
	</xsl:template>
</xsl:stylesheet>