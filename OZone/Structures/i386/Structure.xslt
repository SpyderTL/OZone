<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:struct="http://metalx.org/Structure">
	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="struct:structure">
		<xsl:element name="xsl:stylesheet">
			<xsl:attribute name="version">1.0</xsl:attribute>
			<xsl:attribute name="xmlns-ns">
				<xsl:value-of select="@namespace"/>
			</xsl:attribute>
			<xsl:attribute name="xmlns-prg">http://metalx.org/Program</xsl:attribute>
			<xsl:element name="xsl:output">
				<xsl:attribute name="method">xml</xsl:attribute>
				<xsl:attribute name="indent">yes</xsl:attribute>
			</xsl:element>
			<xsl:element name="xsl:template">
				<xsl:attribute name="match">@* | node()</xsl:attribute>
				<xsl:element name="xsl:copy">
					<xsl:element name="xsl:apply-templates">
						<xsl:attribute name="select">@* | node()</xsl:attribute>
					</xsl:element>
				</xsl:element>
			</xsl:element>
			<xsl:for-each select="p:processor/p:operation">
				<xsl:element name="xsl:template">
					<xsl:attribute name="match">
						<xsl:text>ns:</xsl:text>
						<xsl:value-of select="@name"/>
					</xsl:attribute>
					<xsl:element name="xsl:element">
						<xsl:attribute name="name">prg:hex</xsl:attribute>
						<xsl:value-of select="@value"/>
					</xsl:element>
				</xsl:element>
			</xsl:for-each>
			<xsl:for-each select="p:memory/p:address">
				<xsl:element name="xsl:template">
					<xsl:attribute name="match">
						<xsl:text>ns:</xsl:text>
						<xsl:value-of select="@name"/>
					</xsl:attribute>
					<xsl:element name="xsl:element">
						<xsl:attribute name="name">label</xsl:attribute>
						<xsl:element name="xsl:attribute">
							<xsl:attribute name="name">id</xsl:attribute>
							<xsl:element name="xsl:value-of">
								<xsl:attribute name="select">@id</xsl:attribute>
							</xsl:element>
						</xsl:element>
						<xsl:if test="@page">
							<xsl:element name="xsl:attribute">
								<xsl:attribute name="name">page</xsl:attribute>
								<xsl:value-of select="@page"/>
							</xsl:element>
						</xsl:if>
						<xsl:element name="xsl:attribute">
							<xsl:attribute name="name">offset</xsl:attribute>
							<xsl:value-of select="@offset"/>
						</xsl:element>
					</xsl:element>
				</xsl:element>
			</xsl:for-each>
			<xsl:for-each select="p:constants/p:constant">
				<xsl:element name="xsl:template">
					<xsl:attribute name="match">
						<xsl:text>ns:</xsl:text>
						<xsl:value-of select="@name"/>
					</xsl:attribute>
					<xsl:element name="xsl:element">
						<xsl:attribute name="name">prg:hex</xsl:attribute>
						<xsl:value-of select="@value"/>
					</xsl:element>
				</xsl:element>
			</xsl:for-each>
			<xsl:for-each select="p:structures/p:structure">
				<xsl:element name="xsl:template">
					<xsl:attribute name="match">
						<xsl:text>ns:</xsl:text>
						<xsl:value-of select="@name"/>
					</xsl:attribute>
					<xsl:element name="prg:empty">
						<xsl:attribute name="length">
							<xsl:value-of select="sum(p:field/@length)"/>
						</xsl:attribute>
					</xsl:element>
				</xsl:element>
				<xsl:for-each select="p:field">
					<xsl:element name="xsl:template">
						<xsl:attribute name="match">
							<xsl:text>ns:</xsl:text>
							<xsl:value-of select="../@name"/>.<xsl:value-of select="@name"/>
						</xsl:attribute>
						<xsl:element name="prg:byte">
							<xsl:value-of select="sum(preceding-sibling::p:field/@length)"/>
						</xsl:element>
					</xsl:element>
				</xsl:for-each>
			</xsl:for-each>
		</xsl:element>

	</xsl:template>
</xsl:stylesheet>
