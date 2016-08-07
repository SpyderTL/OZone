<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:str="http://metalx.org/i286/Structures/String">
    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

	<xsl:template match="str:string">
		<short>
			<xsl:value-of select="string-length(text())"/>
		</short>
		<string>
			<xsl:value-of select="text()"/>
		</string>
	</xsl:template>

</xsl:stylesheet>
