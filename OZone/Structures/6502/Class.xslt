<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:cls="http://metalx.org/Class"
	xmlns:cpu="http://metalx.org/Mos/6502/Operators"	>

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="cls:return">
		<cpu:ReturnFromSubroutine/>
	</xsl:template>

	<xsl:template match="cls:class">
		<scope>
			<addressOf ref="className" type="Absolute16"/>
			<addressOf ref="classType" type="Absolute16"/>
			<xsl:choose>
				<xsl:when test="@base">
					<addressOf ref="classBase" type="Absolute16"/>
				</xsl:when>
				<xsl:otherwise>
					<short>0</short>
				</xsl:otherwise>
			</xsl:choose>
			<addressOf ref="classFields" type="Absolute16"/>
			<addressOf ref="classMethods" type="Absolute16"/>
			<addressOf ref="classStaticMethods" type="Absolute16"/>
			<short>
				<xsl:choose>
					<xsl:when test="@static='true'">1</xsl:when>
					<xsl:otherwise>0</xsl:otherwise>
				</xsl:choose>
			</short>
			<addressOf ref="classStaticFields" type="Absolute16"/>

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

			<xsl:if test="@base">
				<label id="classBase"/>
				<short>
					<xsl:value-of select="string-length(@base)"/>
				</short>
				<string>
					<xsl:value-of select="@base"/>
				</string>
			</xsl:if>

			<label id="classFields"/>
			<xsl:call-template name="classFields"/>

			<label id="classMethods"/>
			<xsl:call-template name="classMethods"/>

			<label id="classStaticMethods"/>
			<xsl:call-template name="classStaticMethods"/>

			<label id="classStaticFields"/>
			<xsl:call-template name="classStaticFields"/>

			<xsl:apply-templates select="node()"/>
		</scope>
	</xsl:template>

	<xsl:template match="cls:method">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@name"/>
				<xsl:choose>
					<xsl:when test="@static='true'">
						<xsl:text>_staticMethodLocation</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>_methodLocation</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
		</xsl:element>
		<scope>
			<xsl:copy-of select="*[not(self::cls:parameter)]"/>
		</scope>
	</xsl:template>

	<xsl:template match="cls:field">
		<xsl:copy-of select="*"/>
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
			<xsl:attribute name="type">Absolute16</xsl:attribute>
		</xsl:element>
		<xsl:element name="addressOf">
			<xsl:attribute name="ref">
				<xsl:value-of select="@name"/>
				<xsl:text>_fieldType</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="type">Absolute16</xsl:attribute>
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

	<xsl:template name="classMethod">
		<xsl:element name="addressOf">
			<xsl:attribute name="ref">
				<xsl:value-of select="@name"/>
				<xsl:text>_methodName</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="type">Absolute16</xsl:attribute>
		</xsl:element>
		<xsl:element name="addressOf">
			<xsl:attribute name="ref">
				<xsl:value-of select="@name"/>
				<xsl:text>_methodType</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="type">Absolute16</xsl:attribute>
		</xsl:element>
		<short>
			<xsl:choose>
				<xsl:when test="@static = 'true'">1</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</short>
		<xsl:element name="addressOf">
			<xsl:attribute name="ref">
				<xsl:value-of select="@name"/>
				<xsl:text>_methodLocation</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="type">Absolute16</xsl:attribute>
		</xsl:element>
		<xsl:element name="addressOf">
			<xsl:attribute name="ref">
				<xsl:value-of select="@name"/>
				<xsl:text>_methodParameters</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="type">Absolute16</xsl:attribute>
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
				<xsl:text>_methodParameters</xsl:text>
			</xsl:attribute>
		</xsl:element>
		<short>
			<xsl:value-of select="count(cls:parameter)"/>
		</short>
		<xsl:for-each select="cls:parameter">
			<xsl:element name="addressOf">
				<xsl:attribute name="ref">
					<xsl:value-of select="../@name"/>
					<xsl:text>_</xsl:text>
					<xsl:value-of select="@name"/>
					<xsl:text>_methodParameter</xsl:text>
				</xsl:attribute>
				<xsl:attribute name="type">Absolute16</xsl:attribute>
			</xsl:element>
		</xsl:for-each>
		<xsl:for-each select="cls:parameter">
			<xsl:element name="label">
				<xsl:attribute name="id">
					<xsl:value-of select="../@name"/>
					<xsl:text>_</xsl:text>
					<xsl:value-of select="@name"/>
					<xsl:text>_methodParameter</xsl:text>
				</xsl:attribute>
			</xsl:element>
			<xsl:call-template name="classMethodParameter"/>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="classMethodParameter">
		<xsl:element name="addressOf">
			<xsl:attribute name="ref">
				<xsl:value-of select="../@name"/>
				<xsl:text>_</xsl:text>
				<xsl:value-of select="@name"/>
				<xsl:text>_parameterName</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="type">Absolute16</xsl:attribute>
		</xsl:element>
		<xsl:element name="addressOf">
			<xsl:attribute name="ref">
				<xsl:value-of select="../@name"/>_<xsl:value-of select="@name"/>
				<xsl:text>_parameterType</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="type">Absolute16</xsl:attribute>
		</xsl:element>

		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="../@name"/>
				<xsl:text>_</xsl:text>
				<xsl:value-of select="@name"/>
				<xsl:text>_parameterName</xsl:text>
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
				<xsl:value-of select="../@name"/>
				<xsl:text>_</xsl:text>
				<xsl:value-of select="@name"/>
				<xsl:text>_parameterType</xsl:text>
			</xsl:attribute>
		</xsl:element>
		<short>
			<xsl:value-of select="string-length(@type)"/>
		</short>
		<string>
			<xsl:value-of select="@type"/>
		</string>

	</xsl:template>

	<xsl:template name="classStaticFields">
		<short>
			<xsl:value-of select="count(cls:field[@static = 'true'])"/>
		</short>
		<xsl:for-each select="cls:field[@static = 'true']">
			<xsl:sort select="@name"/>
			<xsl:element name="addressOf">
				<xsl:attribute name="ref">
					<xsl:value-of select="@ref"/>
				</xsl:attribute>
				<xsl:attribute name="type">Absolute16</xsl:attribute>
			</xsl:element>
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
					<xsl:text>_staticMethod</xsl:text>
				</xsl:attribute>
				<xsl:attribute name="type">Absolute16</xsl:attribute>
			</xsl:element>
		</xsl:for-each>
		<xsl:for-each select="cls:method[@static = 'true']">
			<xsl:element name="label">
				<xsl:attribute name="id">
					<xsl:value-of select="@name"/>
					<xsl:text>_staticMethod</xsl:text>
				</xsl:attribute>
			</xsl:element>
			<xsl:call-template name="classStaticMethod"/>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="classStaticMethod">
		<xsl:element name="addressOf">
			<xsl:attribute name="ref">
				<xsl:value-of select="@name"/>
				<xsl:text>_staticMethodName</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="type">Absolute16</xsl:attribute>
		</xsl:element>
		<xsl:element name="addressOf">
			<xsl:attribute name="ref">
				<xsl:value-of select="@name"/>
				<xsl:text>_staticMethodType</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="type">Absolute16</xsl:attribute>
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
				<xsl:text>_staticMethodLocation</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="type">Absolute16</xsl:attribute>
		</xsl:element>
		<xsl:element name="addressOf">
			<xsl:attribute name="ref">
				<xsl:value-of select="@name"/>
				<xsl:text>_staticMethodParameters</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="type">Absolute16</xsl:attribute>
		</xsl:element>

		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@name"/>
				<xsl:text>_staticMethodName</xsl:text>
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
				<xsl:text>_staticMethodType</xsl:text>
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
				<xsl:text>_staticMethodParameters</xsl:text>
			</xsl:attribute>
		</xsl:element>
		<short>
			<xsl:value-of select="count(cls:parameter)"/>
		</short>
		<xsl:for-each select="cls:parameter">
			<xsl:element name="addressOf">
				<xsl:attribute name="ref">
					<xsl:value-of select="../@name"/>
					<xsl:text>_</xsl:text>
					<xsl:value-of select="@name"/>
					<xsl:text>_staticMethodParameter</xsl:text>
				</xsl:attribute>
				<xsl:attribute name="type">Absolute16</xsl:attribute>
			</xsl:element>
		</xsl:for-each>
		<xsl:for-each select="cls:parameter">
			<xsl:element name="label">
				<xsl:attribute name="id">
					<xsl:value-of select="../@name"/>
					<xsl:text>_</xsl:text>
					<xsl:value-of select="@name"/>
					<xsl:text>_staticMethodParameter</xsl:text>
				</xsl:attribute>
			</xsl:element>
			<xsl:call-template name="classStaticMethodParameter"/>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="classStaticMethodParameter">
		<xsl:element name="addressOf">
			<xsl:attribute name="ref">
				<xsl:value-of select="../@name"/>
				<xsl:text>_</xsl:text>
				<xsl:value-of select="@name"/>
				<xsl:text>_staticParameterName</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="type">Absolute16</xsl:attribute>
		</xsl:element>
		<xsl:element name="addressOf">
			<xsl:attribute name="ref">
				<xsl:value-of select="../@name"/>_<xsl:value-of select="@name"/>
				<xsl:text>_staticParameterType</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="type">Absolute16</xsl:attribute>
		</xsl:element>

		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="../@name"/>
				<xsl:text>_</xsl:text>
				<xsl:value-of select="@name"/>
				<xsl:text>_staticParameterName</xsl:text>
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
				<xsl:value-of select="../@name"/>
				<xsl:text>_</xsl:text>
				<xsl:value-of select="@name"/>
				<xsl:text>_staticParameterType</xsl:text>
			</xsl:attribute>
		</xsl:element>
		<short>
			<xsl:value-of select="string-length(@type)"/>
		</short>
		<string>
			<xsl:value-of select="@type"/>
		</string>
	</xsl:template>
</xsl:stylesheet>
