<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:lsts="http://metalx.org/i286/Structures/List">
    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

	<xsl:template match="lsts:list">
		<scope>
			<short>
				<xsl:value-of select="count(lsts:item)"/>
			</short>
			<xsl:for-each select="lsts:item">
				<hex><xsl:value-of select="node()"/></hex>
			</xsl:for-each>
		</scope>
	</xsl:template>

</xsl:stylesheet>
