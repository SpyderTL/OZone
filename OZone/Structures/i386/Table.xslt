<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:tab="http://metalx.org/Table">
	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="tab:Table">
		<scope>
			<int>
				<xsl:value-of select="count(row)"/>
			</int>
			<xsl:for-each select="row">
				<xsl:variable name="rowPosition" select="position()"/>
				<xsl:for-each select="cell">
					<xsl:choose>
						<xsl:when test="@type='offset'">
							<addressOf ref="_row_{$rowPosition}_cell_{position()}" type="Relative32" offset="0"/>
						</xsl:when>
						<xsl:when test="@type='address'">
							<addressOf ref="_row_{$rowPosition}_cell_{position()}" type="Absolute32"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:copy-of select="@* | node()"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</xsl:for-each>
			<xsl:for-each select="row">
				<xsl:variable name="rowPosition" select="position()"/>
				<xsl:for-each select="cell">
					<xsl:if test="@type='offset' or @type='address'">
						<label id="_row_{$rowPosition}_cell_{position()}"/>
						<xsl:copy-of select="@* | node()"/>
					</xsl:if>
				</xsl:for-each>
			</xsl:for-each>
		</scope>
	</xsl:template>
</xsl:stylesheet>
