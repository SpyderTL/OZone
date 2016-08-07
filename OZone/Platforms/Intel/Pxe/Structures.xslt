<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:ns="http://metalx.org/Intel/Pxe/Structures" xmlns:prg="http://metalx.org/Program" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="ns:Pxenv">
		<prg:empty length="14" xmlns:prg="http://metalx.org/Program" />
	</xsl:template>
	<xsl:template match="ns:Pxenv.Signature">
		<prg:byte xmlns:prg="http://metalx.org/Program">0</prg:byte>
	</xsl:template>
	<xsl:template match="ns:Pxenv.Version">
		<prg:byte xmlns:prg="http://metalx.org/Program">6</prg:byte>
	</xsl:template>
	<xsl:template match="ns:Pxenv.Length">
		<prg:byte xmlns:prg="http://metalx.org/Program">8</prg:byte>
	</xsl:template>
	<xsl:template match="ns:Pxenv.Checksum">
		<prg:byte xmlns:prg="http://metalx.org/Program">9</prg:byte>
	</xsl:template>
	<xsl:template match="ns:Pxenv.EntryPointOffset">
		<prg:byte xmlns:prg="http://metalx.org/Program">10</prg:byte>
	</xsl:template>
	<xsl:template match="ns:Pxenv.EntryPointSegment">
		<prg:byte xmlns:prg="http://metalx.org/Program">12</prg:byte>
	</xsl:template>
</xsl:stylesheet>