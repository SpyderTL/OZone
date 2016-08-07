<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ns="http://metalx.org/Pc/Video/Ports" xmlns:prg="http://metalx.org/Program">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="ns:CrtRegisterIndex">
		<xsl:element name="prg:hex">03d4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CrtRegisterData">
		<xsl:element name="prg:hex">03d5</xsl:element>
	</xsl:template>
</xsl:stylesheet>