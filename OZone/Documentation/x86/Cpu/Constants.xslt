<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://ozone.org/Platform"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="table">
		<platform>
			<constants>
				<xsl:for-each select="tr">
					<xsl:element name="constant">
						<xsl:attribute name="name">
							<xsl:value-of select="td[position()=3]"/>
						</xsl:attribute>
						<xsl:attribute name="value">
							<xsl:value-of select="td[position()=2]"/>
						</xsl:attribute>
					</xsl:element>
				</xsl:for-each>
			</constants>
		</platform>
	</xsl:template>
</xsl:stylesheet>
