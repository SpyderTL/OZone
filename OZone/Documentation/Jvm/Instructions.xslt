<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://ozone.org/Platform">
	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="/table">
		<platform>
			<processor>
				<xsl:for-each select="tr[td[position()=2] != '']">
					<xsl:sort select="td[position()=3]"/>
					<xsl:element name="operation">
						<xsl:attribute name="name">
							<xsl:value-of select="td[position()=1]"/>
						</xsl:attribute>
						<xsl:attribute name="value">
							<xsl:value-of select="td[position()=3]"/>
						</xsl:attribute>
					</xsl:element>
				</xsl:for-each>
			</processor>
		</platform>
	</xsl:template>
</xsl:stylesheet>
