<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:prg="http://metalx.org/Program" xmlns:ns="http://metalx.org/Berkeley/RiscV/ReferenceOperators">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="ns:IfEqual">
		<xsl:variable name="offset" select="@prg:refAddress - @prg:address"/>
		<xsl:variable name="signed">
			<xsl:choose>
				<xsl:when test="$offset &lt; 0">
					<xsl:value-of select="$offset + 4096"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$offset"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="opcode" select="99"/>
		<xsl:variable name="register" select="@register * 32768"/>
		<xsl:variable name="register2" select="@register2 * 1048576"/>
		<xsl:variable name="address1" select="floor(($signed mod 32) div 2) * 256"/>
		<xsl:variable name="address2" select="floor(($signed mod 2048) div 32) * 33554432"/>
		<xsl:variable name="address3" select="floor(($signed mod 4096) div 2048) * 128"/>
		<xsl:variable name="address4" select="floor(($signed mod 8192) div 4096) * 2147483648"/>

		<prg:uint>
			<xsl:value-of select="$opcode + $register + $register2 + $address1 + $address2 + $address3 + $address4"/>
		</prg:uint>
	</xsl:template>

	<xsl:template match="ns:JumpToAddress">
		<xsl:variable name="offset" select="@prg:refAddress - @prg:address"/>
		<xsl:variable name="signed">
			<xsl:choose>
				<xsl:when test="$offset &lt; 0">
					<xsl:value-of select="$offset + 2147483648"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$offset"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="opcode" select="111"/>
		<xsl:variable name="returnAddressRegister" select="@returnAddressRegister * 128"/>
		<xsl:variable name="address1" select="floor(($signed mod 2048) div 2) * 2097152"/>
		<xsl:variable name="address2" select="floor(($signed mod 4096) div 2048) * 1048576"/>
		<xsl:variable name="address3" select="floor(($signed mod 1048576) div 4096) * 4096"/>
		<xsl:variable name="address4" select="floor(($signed mod 2097152) div 1048576) * 2147483648"/>

		<prg:uint>
			<xsl:value-of select="$opcode + $returnAddressRegister + $address1 + $address2 + $address3 + $address4"/>
		</prg:uint>
	</xsl:template>

	<xsl:template match="ns:SetRegisterToAddressOf">
		<xsl:variable name="opcode" select="55"/>
		<xsl:variable name="address" select="@prg:refAddress"/>
		<xsl:variable name="register" select="@register * 128"/>
		<xsl:variable name="value" select="floor($address div 4096) * 4096"/>
		<xsl:variable name="opcode2" select="19"/>
		<xsl:variable name="value2" select="($address mod 4096) * 1048576"/>
		<xsl:variable name="register2" select="@register * 32768"/>

		<prg:uint>
			<xsl:value-of select="$opcode + $register + $value"/>
		</prg:uint>
		<prg:uint>
			<xsl:value-of select="$opcode2 + $value2 + $register + $register2"/>
		</prg:uint>
	</xsl:template>
</xsl:stylesheet>