<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:lst="http://metalx.org/List">
	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="lst:list">
		<scope>
			<int>
				<xsl:value-of select="count(item)"/>
			</int>
			<xsl:choose>
				<xsl:when test="@type='Relative16'">
					<xsl:for-each select="item">
						<addressOf ref="_item_{position()}" type="Relative16" offset="0"/>
					</xsl:for-each>
					<xsl:for-each select="item">
						<label id="_item_{position()}"/>
						<xsl:copy-of select="@* | node()"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="@type='Relative32'">
					<xsl:for-each select="item">
						<addressOf ref="_item_{position()}" type="Relative32" offset="0"/>
					</xsl:for-each>
					<xsl:for-each select="item">
						<label id="_item_{position()}"/>
						<xsl:copy-of select="@* | node()"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="@type='Absolute16'">
					<xsl:for-each select="item">
						<addressOf ref="_item_{position()}" type="Absolute16"/>
					</xsl:for-each>
					<xsl:for-each select="item">
						<label id="_item_{position()}"/>
						<xsl:copy-of select="@* | node()"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:when test="@type='Absolute32'">
					<xsl:for-each select="item">
						<addressOf ref="_item_{position()}" type="Absolute32"/>
					</xsl:for-each>
					<xsl:for-each select="item">
						<label id="_item_{position()}"/>
						<xsl:copy-of select="@* | node()"/>
					</xsl:for-each>
				</xsl:when>
				<xsl:otherwise>
					<xsl:for-each select="item">
						<xsl:copy-of select="@* | node()"/>
					</xsl:for-each>
				</xsl:otherwise>
			</xsl:choose>
		</scope>
	</xsl:template>
</xsl:stylesheet>
