<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="/table">
		<xsl:for-each select="tr">
			<xsl:element name="operation">
				<xsl:attribute name="name">
					<xsl:value-of select="td[1]" disable-output-escaping="no"/>
				</xsl:attribute>
				<xsl:attribute name="value">
					<xsl:value-of select="td[2]" disable-output-escaping="no"/>
				</xsl:attribute>
			</xsl:element>
		</xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
