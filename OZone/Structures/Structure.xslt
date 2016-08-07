<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:var="http://metalx.org/Variable">
	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="var:string">
		<xsl:if test="@id">
			<xsl:element name="label">
				<xsl:attribute name="id">
					<xsl:value-of select="@id"/>
				</xsl:attribute>
			</xsl:element>
		</xsl:if>
		<int>
			<xsl:value-of select="string-length(node())"/>
		</int>
		<string>
			<xsl:value-of select="node()"/>
		</string>
	</xsl:template>

	<xsl:template match="var:integer">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id"/>
			</xsl:attribute>
		</xsl:element>
		<int>
			<xsl:value-of select="node()"/>
		</int>
	</xsl:template>

	<xsl:template match="var:hexadecimal">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id"/>
			</xsl:attribute>
		</xsl:element>
		<hex>
			<xsl:value-of select="node()"/>
		</hex>
	</xsl:template>

</xsl:stylesheet>
