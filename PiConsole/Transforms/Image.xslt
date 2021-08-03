<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://metalx.org/Program" xmlns:img="http://metalx.org/Image">
	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="img:image">
		<scope>
			<xsl:element name="label">
				<xsl:attribute name="id">Resources.Images.<xsl:value-of select="@name"/></xsl:attribute>
				<xsl:attribute name="export">Resources.Images.<xsl:value-of select="@name"/></xsl:attribute>
			</xsl:element>
			<int>
				<xsl:value-of select="@width"/>
			</int>
			<int>
				<xsl:value-of select="@height"/>
			</int>
			<xsl:for-each select="img:pixel">
				<byte>
					<xsl:value-of select="@blue"/>
				</byte>
				<byte>
					<xsl:value-of select="@green"/>
				</byte>
				<byte>
					<xsl:value-of select="@red"/>
				</byte>
				<byte>
					<xsl:value-of select="@alpha"/>
				</byte>
			</xsl:for-each>
		</scope>
	</xsl:template>
</xsl:stylesheet>
