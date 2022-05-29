<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="map">
		<scope>
			<xsl:for-each select="row">
				<addressOf ref="row_{@index}" type="Absolute8"/>
			</xsl:for-each>
			<xsl:for-each select="row">
				<addressOf ref="row_{@index}" type="Absolute16High8"/>
			</xsl:for-each>
			<xsl:for-each select="row">
				<label id="row_{@index}"/>
				<xsl:for-each select="segment">
					<xsl:choose>
						<xsl:when test="@count = 1">
							<byte>
								<xsl:value-of select="@tile"/>
							</byte>
						</xsl:when>
						<xsl:when test="@count = 256">
							<byte>
								<xsl:value-of select="@tile"/>
							</byte>
							<byte>0</byte>
						</xsl:when>
						<xsl:otherwise>
							<byte>
								<xsl:value-of select="@tile + 128"/>
							</byte>
							<byte>
								<xsl:value-of select="@count"/>
							</byte>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</xsl:for-each>
		</scope>
	</xsl:template>
</xsl:stylesheet>