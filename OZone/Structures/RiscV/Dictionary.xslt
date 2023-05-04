<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:dic="http://metalx.org/Dictionary">
	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="dic:Dictionary">
		<scope>
			<int>
				<xsl:value-of select="count(entry)"/>
			</int>
			<xsl:for-each select="entry">
				<xsl:choose>
					<xsl:when test="../@keyType='Relative16'">
						<addressOf ref="_entry_{position()}_key" type="Relative16" offset="0"/>
					</xsl:when>
					<xsl:when test="../@keyType='Relative32'">
						<addressOf ref="_entry_{position()}_key" type="Relative32" offset="0"/>
					</xsl:when>
					<xsl:when test="../@keyType='Absolute16'">
						<addressOf ref="_entry_{position()}_key" type="Absolute16"/>
					</xsl:when>
					<xsl:when test="../@keyType='Absolute32'">
						<addressOf ref="_entry_{position()}_key" type="Absolute32"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:copy-of select="key/@* | node()"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="../@valueType='Relative16'">
						<addressOf ref="_entry_{position()}_value" type="Relative16" offset="0"/>
					</xsl:when>
					<xsl:when test="../@valueType='Relative32'">
						<addressOf ref="_entry_{position()}_value" type="Relative32" offset="0"/>
					</xsl:when>
					<xsl:when test="../@valueType='Absolute16'">
						<addressOf ref="_entry_{position()}_value" type="Absolute16"/>
					</xsl:when>
					<xsl:when test="../@valueType='Absolute32'">
						<addressOf ref="_entry_{position()}_value" type="Absolute32"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:copy-of select="value/@* | node()"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>
			<xsl:if test="@keyType='Relative16' or @keyType='Relative32' or @keyType='Absolute16' or @keyType='Absolute32'">
				<xsl:for-each select="entry">
					<label id="_entry_{position()}_key"/>
					<xsl:copy-of select="key/@* | node()"/>
				</xsl:for-each>
			</xsl:if>
			<xsl:if test="@valueType='Relative16' or @valueType='Relative32' or @valueType='Absolute16' or @valueType='Absolute32'">
				<xsl:for-each select="entry">
					<label id="_entry_{position()}_value"/>
					<xsl:copy-of select="value/@* | node()"/>
				</xsl:for-each>
			</xsl:if>
		</scope>
	</xsl:template>
</xsl:stylesheet>
