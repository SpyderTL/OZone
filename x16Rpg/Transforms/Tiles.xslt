<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="tiles">
		<label id="topLeftCharacters">
			<xsl:for-each select="tile">
				<byte>
					<xsl:value-of select="@topLeftCharacter"/>
				</byte>
			</xsl:for-each>
		</label>
		<label id="topRightCharacters">
			<xsl:for-each select="tile">
				<byte>
					<xsl:value-of select="@topRightCharacter"/>
				</byte>
			</xsl:for-each>
		</label>
		<label id="bottomLeftCharacters">
			<xsl:for-each select="tile">
				<byte>
					<xsl:value-of select="@bottomLeftCharacter"/>
				</byte>
			</xsl:for-each>
		</label>
		<label id="bottomRightCharacters">
			<xsl:for-each select="tile">
				<byte>
					<xsl:value-of select="@bottomRightCharacter"/>
				</byte>
			</xsl:for-each>
		</label>
		<label id="topLeftPalettes">
			<xsl:for-each select="tile">
				<byte>
					<xsl:value-of select="@topLeftPalette"/>
				</byte>
			</xsl:for-each>
		</label>
		<label id="topRightPalettes">
			<xsl:for-each select="tile">
				<byte>
					<xsl:value-of select="@topRightPalette"/>
				</byte>
			</xsl:for-each>
		</label>
		<label id="bottomLeftPalettes">
			<xsl:for-each select="tile">
				<byte>
					<xsl:value-of select="@bottomLeftPalette"/>
				</byte>
			</xsl:for-each>
		</label>
		<label id="bottomRightPalettes">
			<xsl:for-each select="tile">
				<byte>
					<xsl:value-of select="@bottomRightPalette"/>
				</byte>
			</xsl:for-each>
		</label>
	</xsl:template>
</xsl:stylesheet>