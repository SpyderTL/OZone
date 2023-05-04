<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:prg="http://metalx.org/Program" xmlns:ns="http://metalx.org/Berkeley/RiscV/Operators" xmlns:ref="http://metalx.org/Berkeley/RiscV/ReferenceOperators">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="ns:JumpToAddress">
		<xsl:choose>
			<xsl:when test="@returnAddressRegister">
				<ref:JumpToAddress prg:ref="{@ref}" returnAddressRegister="{@returnAddressRegister}" prg:compile="false" prg:length="4"/>
			</xsl:when>
			<xsl:otherwise>
				<ref:JumpToAddress prg:ref="{@ref}" returnAddressRegister="0" prg:compile="false" prg:length="4"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="ns:IfEqual">
		<ref:IfEqual prg:ref="{@ref}" register="{@register}" register2="{@register2}" prg:compile="false" prg:length="4"/>
	</xsl:template>

	<xsl:template match="ns:JumpToRegister">
		<xsl:variable name="opcode" select="103"/>
		<xsl:variable name="addressRegister" select="@addressRegister * 32768"/>

		<xsl:variable name="returnAddressRegister">
			<xsl:choose>
				<xsl:when test="@returnAddressRegister">
					<xsl:value-of select="@returnAddressRegister * 128"/>
				</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="offset">
			<xsl:choose>
				<xsl:when test="@offset">
					<xsl:value-of select="@offset * 1048576"/>
				</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<prg:uint>
			<xsl:value-of select="$opcode + $addressRegister + $returnAddressRegister + $offset"/>
		</prg:uint>
	</xsl:template>

	<xsl:template match="ns:SetRegisterToAddressOf">
		<ref:SetRegisterToAddressOf prg:ref="{@ref}" register="{@register}" prg:compile="false" prg:length="8"/>
	</xsl:template>

	<xsl:template match="ns:AddValueToRegister">
		<xsl:variable name="opcode" select="19"/>
		<xsl:variable name="register" select="@register * 32768"/>
		<xsl:variable name="destination" select="@destination * 128"/>

		<xsl:variable name="value">
			<xsl:choose>
				<xsl:when test="@value &lt; 0">
					<xsl:value-of select="(@value + 4096) * 1048576"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="@value * 1048576"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<prg:uint>
			<xsl:value-of select="$opcode + $value + $register + $destination"/>
		</prg:uint>
	</xsl:template>

	<xsl:template match="ns:CopyRegisterToAddress8">
		<xsl:variable name="opcode" select="35"/>
		<xsl:variable name="offset">
			<xsl:choose>
				<xsl:when test="@offset">
					<xsl:value-of select="@offset * 128"/>
				</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="register" select="@register * 1048576"/>
		<xsl:variable name="addressRegister" select="@addressRegister * 32768"/>

		<prg:uint>
			<xsl:value-of select="$opcode + $offset + $register + $addressRegister"/>
		</prg:uint>
	</xsl:template>

	<xsl:template match="ns:CopyRegisterToAddress16">
		<xsl:variable name="opcode" select="35"/>
		<xsl:variable name="offset">
			<xsl:choose>
				<xsl:when test="@offset">
					<xsl:value-of select="@offset * 128"/>
				</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="register" select="@register * 1048576"/>
		<xsl:variable name="addressRegister" select="@addressRegister * 32768"/>

		<prg:uint>
			<xsl:value-of select="$opcode + $offset + $register + $addressRegister"/>
		</prg:uint>
	</xsl:template>

	<xsl:template match="ns:CopyRegisterToAddress32">
		<xsl:variable name="opcode" select="35"/>
		<xsl:variable name="offset">
			<xsl:choose>
				<xsl:when test="@offset">
					<xsl:value-of select="@offset * 128"/>
				</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="register" select="@register * 1048576"/>
		<xsl:variable name="addressRegister" select="@addressRegister * 32768"/>

		<prg:uint>
			<xsl:value-of select="$opcode + $offset + $register + $addressRegister"/>
		</prg:uint>
	</xsl:template>

	<xsl:template match="ns:CopyAddressToRegister8">
		<xsl:variable name="opcode" select="3"/>
		<xsl:variable name="offset">
			<xsl:choose>
				<xsl:when test="@offset">
					<xsl:value-of select="@offset * 1048576"/>
				</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="addressRegister" select="@addressRegister * 32768"/>
		<xsl:variable name="register" select="@register * 128"/>

		<prg:uint>
			<xsl:value-of select="$opcode + $offset + $register + $addressRegister"/>
		</prg:uint>
	</xsl:template>

	<xsl:template match="ns:CopyAddressToRegister16">
		<xsl:variable name="opcode" select="4099"/>
		<xsl:variable name="offset">
			<xsl:choose>
				<xsl:when test="@offset">
					<xsl:value-of select="@offset * 1048576"/>
				</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="addressRegister" select="@addressRegister * 32768"/>
		<xsl:variable name="register" select="@register * 128"/>

		<prg:uint>
			<xsl:value-of select="$opcode + $offset + $register + $addressRegister"/>
		</prg:uint>
	</xsl:template>

	<xsl:template match="ns:CopyAddressToRegister32">
		<xsl:variable name="opcode" select="8195"/>
		<xsl:variable name="offset">
			<xsl:choose>
				<xsl:when test="@offset">
					<xsl:value-of select="@offset * 1048576"/>
				</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="addressRegister" select="@addressRegister * 32768"/>
		<xsl:variable name="register" select="@register * 128"/>

		<prg:uint>
			<xsl:value-of select="$opcode + $offset + $register + $addressRegister"/>
		</prg:uint>
	</xsl:template>

	<xsl:template match="ns:SetRegisterToValue">
		<xsl:variable name="opcode" select="55"/>
		<xsl:variable name="register" select="@register * 128"/>
		<xsl:variable name="value" select="floor(@value div 4096) * 4096"/>
		<xsl:variable name="opcode2" select="19"/>
		<xsl:variable name="value2" select="(@value mod 4096) * 1048576"/>
		<xsl:variable name="register2" select="@register * 32768"/>

		<prg:uint>
			<xsl:value-of select="$opcode + $register + $value"/>
		</prg:uint>

		<xsl:if test="$value2 != 0">
			<prg:uint>
				<xsl:value-of select="$opcode2 + $value2 + $register + $register2"/>
			</prg:uint>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>