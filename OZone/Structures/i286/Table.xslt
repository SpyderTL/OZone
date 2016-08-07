<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:tbl="http://metalx.org/i286/Structures/Table">
    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

	<xsl:template match="tbl:table">
		<scope>
			<short>
				<xsl:value-of select="count(tbl:row)"/>
			</short>
			<xsl:for-each select="tbl:row">
				<xsl:element name="addressOf">
					<xsl:attribute name="id"><xsl:value-of select="@key"/><xsl:text>_key</xsl:text></xsl:attribute>
				</xsl:element>
				<hex><xsl:value-of select="@value"/></hex>
			</xsl:for-each>
			<xsl:for-each select="tbl:row">
				<xsl:element name="label">
					<xsl:attribute name="id">
						<xsl:value-of select="@key"/>
						<xsl:text>_key</xsl:text>
					</xsl:attribute>
				</xsl:element>
				<short>
					<xsl:value-of select="string-length(@key)"/>
				</short>
				<string>
					<xsl:value-of select="@key"/>
				</string>
			</xsl:for-each>
		</scope>
	</xsl:template>

</xsl:stylesheet>
