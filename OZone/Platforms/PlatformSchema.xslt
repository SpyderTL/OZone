<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns:xsd="http://www.w3.org/2001/XMLSchema"
	xmlns:p="http://metalx.org/Platform"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="p:platform">
		<xsl:element name="xsd:schema">
			<xsl:attribute name="targetNamespace">
				<xsl:value-of select="@namespace"/>
			</xsl:attribute>
			<xsl:attribute name="elementFormDefault">qualified</xsl:attribute>
			<xsl:for-each select="p:processor/p:operation">
				<xsl:element name="xsd:element">
					<xsl:attribute name="name">
						<xsl:value-of select="@name"/>
					</xsl:attribute>
					<xsl:element name="xsd:annotation">
						<xsl:element name="xsd:documentation">
							&lt;hex&gt;<xsl:value-of select="@value"/>&lt;/hex&gt;
							<xsl:value-of select="text()"/>
						</xsl:element>
					</xsl:element>
					<xsl:element name="xsd:complexType"/>
				</xsl:element>
			</xsl:for-each>
			<xsl:for-each select="p:memory/p:address">
				<xsl:element name="xsd:element">
					<xsl:attribute name="name">
						<xsl:value-of select="@name"/>
					</xsl:attribute>
					<xsl:element name="xsd:complexType"/>
				</xsl:element>
			</xsl:for-each>
			<xsl:for-each select="p:constants/p:constant">
				<xsl:element name="xsd:element">
					<xsl:attribute name="name">
						<xsl:value-of select="@name"/>
					</xsl:attribute>
					<xsl:element name="xsd:annotation">
						<xsl:element name="xsd:documentation">
							&lt;hex&gt;<xsl:value-of select="@value"/>&lt;/hex&gt;
							<xsl:value-of select="text()"/>
						</xsl:element>
					</xsl:element>
					<xsl:element name="xsd:complexType"/>
				</xsl:element>
			</xsl:for-each>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
