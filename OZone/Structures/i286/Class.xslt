<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:cls="http://metalx.org/i286/Structures/Class">
	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="cls:class">
		<scope>
			<addressOf ref="className" type="Relative16" offset="0"/>
			<addressOf ref="classType" type="Relative16" offset="2"/>
			<addressOf ref="classFields" type="Relative16" offset="4"/>
			<addressOf ref="classMethods" type="Relative16" offset="6"/>
			<addressOf ref="classStaticMethods" type="Relative16" offset="8"/>
			<short>
				<xsl:choose>
					<xsl:when test="@static='true'">1</xsl:when>
					<xsl:otherwise>0</xsl:otherwise>
				</xsl:choose>
			</short>

			<label id="className"/>
			<short>
				<xsl:value-of select="string-length(@name)"/>
			</short>
			<string>
				<xsl:value-of select="@name"/>
			</string>
			
			<label id="classType"/>
			<short>
				<xsl:value-of select="string-length(@type)"/>
			</short>
			<string>
				<xsl:value-of select="@type"/>
			</string>

			<label id="classFields"/>
			<xsl:call-template name="classFields"/>

			<label id="classMethods"/>
			<xsl:call-template name="classMethods"/>
			
			<label id="classStaticMethods"/>
			<xsl:call-template name="classStaticMethods"/>
		</scope>
	</xsl:template>

	<xsl:template name="classFields">
		<short>
			<xsl:value-of select="count(cls:field)"/>
		</short>
		<xsl:for-each select="cls:field">
			<xsl:sort select="@name"/>
			<xsl:element name="addressOf">
				<xsl:attribute name="ref">
					<xsl:value-of select="@name"/>
					<xsl:text>_field</xsl:text>
				</xsl:attribute>
				<xsl:attribute name="type">Absolute16</xsl:attribute>
			</xsl:element>
		</xsl:for-each>
		<xsl:for-each select="cls:field">
			<xsl:element name="label">
				<xsl:attribute name="id">
					<xsl:value-of select="@name"/>
					<xsl:text>_field</xsl:text>
				</xsl:attribute>
			</xsl:element>
			<xsl:call-template name="classField"/>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="classField">
		<xsl:element name="addressOf">
			<xsl:attribute name="ref">
				<xsl:value-of select="@name"/>
				<xsl:text>_fieldName</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="type">Relative16</xsl:attribute>
			<xsl:attribute name="offset">0</xsl:attribute>
		</xsl:element>
		<xsl:element name="addressOf">
			<xsl:attribute name="ref">
				<xsl:value-of select="@name"/>
				<xsl:text>_fieldType</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="type">Relative16</xsl:attribute>
			<xsl:attribute name="offset">2</xsl:attribute>
		</xsl:element>
		<short>
			<xsl:value-of select="@offset"/>
		</short>

		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@name"/>
				<xsl:text>_fieldName</xsl:text>
			</xsl:attribute>
		</xsl:element>
		<short>
			<xsl:value-of select="string-length(@name)"/>
		</short>
		<string>
			<xsl:value-of select="@name"/>
		</string>

		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@name"/>
				<xsl:text>_fieldType</xsl:text>
			</xsl:attribute>
		</xsl:element>
		<short>
			<xsl:value-of select="string-length(@type)"/>
		</short>
		<string>
			<xsl:value-of select="@type"/>
		</string>
	</xsl:template>

	<xsl:template name="classMethods">
		<short>
			<xsl:value-of select="count(cls:method[not(@static = 'true')])"/>
		</short>
		<xsl:for-each select="cls:method[not(@static = 'true')]">
			<xsl:sort select="@name"/>
			<xsl:element name="addressOf">
				<xsl:attribute name="ref">
					<xsl:value-of select="@name"/>
					<xsl:text>_method</xsl:text>
				</xsl:attribute>
				<xsl:attribute name="type">Absolute16</xsl:attribute>
			</xsl:element>
		</xsl:for-each>
		<xsl:for-each select="cls:method[not(@static = 'true')]">
			<xsl:element name="label">
				<xsl:attribute name="id">
					<xsl:value-of select="@name"/>
					<xsl:text>_method</xsl:text>
				</xsl:attribute>
			</xsl:element>
			<xsl:call-template name="classMethod"/>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="classStaticMethods">
		<short>
			<xsl:value-of select="count(cls:method[@static = 'true'])"/>
		</short>
		<xsl:for-each select="cls:method[@static = 'true']">
			<xsl:sort select="@name"/>
			<xsl:element name="addressOf">
				<xsl:attribute name="ref">
					<xsl:value-of select="@name"/>
					<xsl:text>_method</xsl:text>
				</xsl:attribute>
				<xsl:attribute name="type">Absolute16</xsl:attribute>
			</xsl:element>
		</xsl:for-each>
		<xsl:for-each select="cls:method[@static = 'true']">
			<xsl:element name="label">
				<xsl:attribute name="id">
					<xsl:value-of select="@name"/>
					<xsl:text>_method</xsl:text>
				</xsl:attribute>
			</xsl:element>
			<xsl:call-template name="classMethod"/>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="classMethod">
		<xsl:element name="addressOf">
			<xsl:attribute name="ref">
				<xsl:value-of select="@name"/>
				<xsl:text>_methodName</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="type">Relative16</xsl:attribute>
			<xsl:attribute name="offset">0</xsl:attribute>
		</xsl:element>
		<xsl:element name="addressOf">
			<xsl:attribute name="ref">
				<xsl:value-of select="@name"/>
				<xsl:text>_methodType</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="type">Relative16</xsl:attribute>
			<xsl:attribute name="offset">2</xsl:attribute>
		</xsl:element>
		<short>
			<xsl:choose>
				<xsl:when test="@static='true'">1</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</short>
		<xsl:element name="addressOf">
			<xsl:attribute name="ref">
				<xsl:value-of select="@name"/>
				<xsl:text>_methodLocation</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="type">Relative16</xsl:attribute>
			<xsl:attribute name="offset">6</xsl:attribute>
		</xsl:element>

		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@name"/>
				<xsl:text>_methodName</xsl:text>
			</xsl:attribute>
		</xsl:element>
		<short>
			<xsl:value-of select="string-length(@name)"/>
		</short>
		<string>
			<xsl:value-of select="@name"/>
		</string>

		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@name"/>
				<xsl:text>_methodType</xsl:text>
			</xsl:attribute>
		</xsl:element>
		<short>
			<xsl:value-of select="string-length(@type)"/>
		</short>
		<string>
			<xsl:value-of select="@type"/>
		</string>

		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@name"/>
				<xsl:text>_methodLocation</xsl:text>
			</xsl:attribute>
		</xsl:element>

		<xsl:element name="scope">
			<xsl:copy-of select="node()"/>
		</xsl:element>

	</xsl:template>
</xsl:stylesheet>
