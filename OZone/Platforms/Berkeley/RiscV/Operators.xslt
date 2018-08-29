<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:prg="http://metalx.org/Program" xmlns:ns="http://metalx.org/Berkeley/RiscV/Operators">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="ns:CallAddress">
		<xsl:variable name="opcode" select="111"/>

		<prg:uint>
			<xsl:value-of select="$opcode"/>
		</prg:uint>
	</xsl:template>

	<xsl:template match="ns:CallRegisterAddress">
		<xsl:variable name="opcode" select="103"/>
		<xsl:variable name="baseRegister" select="@baseRegister * 32768"/>
		<xsl:variable name="linkRegister" select="@linkRegister * 128"/>
		<xsl:variable name="offset" select="@offset * 1048576"/>

		<prg:uint>
			<xsl:value-of select="$opcode + $baseRegister + $linkRegister + $offset"/>
		</prg:uint>
	</xsl:template>

	<xsl:template match="ns:CopyAddressToRegister">
		<xsl:variable name="opcode" select="3"/>
		<xsl:variable name="baseRegister" select="@baseRegister * 32768"/>
		<xsl:variable name="linkRegister" select="@linkRegister * 128"/>
		<xsl:variable name="offset" select="@offset * 1048576"/>

		<xsl:variable name="operation">
			<xsl:choose>
				<xsl:when test="@Operation='Byte'">
					<xsl:value-of select="0"/>
				</xsl:when>
				<xsl:when test="@Operation='Short'">
					<xsl:value-of select="1"/>
				</xsl:when>
				<xsl:when test="@Operation='Integer'">
					<xsl:value-of select="2"/>
				</xsl:when>
				<xsl:when test="@Operation='SignedByte'">
					<xsl:value-of select="4"/>
				</xsl:when>
				<xsl:when test="@Operation='UnsignedShort'">
					<xsl:value-of select="5"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:message terminate="yes">
						Invalid Data Operation: <xsl:value-of select="@Operation"/>
					</xsl:message>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<prg:uint>
			<xsl:value-of select="$opcode + $baseRegister + $linkRegister + $offset + $operation"/>
		</prg:uint>
	</xsl:template>

	<xsl:template match="ns:CopyRegisterToAddress">
		<xsl:variable name="opcode" select="35"/>
		<xsl:variable name="baseRegister" select="@baseRegister * 32768"/>
		<xsl:variable name="linkRegister" select="@linkRegister * 128"/>
		<xsl:variable name="offset" select="@offset * 1048576"/>

		<xsl:variable name="operation">
			<xsl:choose>
				<xsl:when test="@Operation='Byte'">
					<xsl:value-of select="0"/>
				</xsl:when>
				<xsl:when test="@Operation='Short'">
					<xsl:value-of select="1"/>
				</xsl:when>
				<xsl:when test="@Operation='Integer'">
					<xsl:value-of select="2"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:message terminate="yes">
						Invalid Data Operation: <xsl:value-of select="@Operation"/>
					</xsl:message>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<prg:uint>
			<xsl:value-of select="$opcode + $baseRegister + $linkRegister + $offset + $operation"/>
		</prg:uint>
	</xsl:template>

</xsl:stylesheet>