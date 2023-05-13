<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:prg="http://metalx.org/Program" xmlns:ns="http://metalx.org/Arm/v6/Operators">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="ns:Jump">
		<xsl:choose>
			<xsl:when test="@condition">
				<ns:Jump condition="{@condition}" prg:ref="{@ref}" prg:compile="false" prg:length="4"/>
			</xsl:when>
			<xsl:otherwise>
				<ns:Jump prg:ref="{@ref}" prg:compile="false" prg:length="4"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="ns:Call">
		<xsl:choose>
			<xsl:when test="@condition">
				<ns:Call condition="{@condition}" ref="{@ref}" prg:compile="false" prg:length="4"/>
			</xsl:when>
			<xsl:otherwise>
				<ns:Call ref="{@ref}" prg:compile="false" prg:length="4"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<xsl:template match="ns:SetRegisterToAddressOf">
		<xsl:choose>
			<xsl:when test="@condition">
				<ns:SetRegisterToAddressOf condition="{@condition}" register="{@register}" prg:ref="{@ref}" prg:compile="false" prg:length="16"/>
			</xsl:when>
			<xsl:otherwise>
				<ns:SetRegisterToAddressOf register="{@register}" prg:ref="{@ref}" prg:compile="false" prg:length="16"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="ns:SetRegisterToValue">
		<xsl:variable name="operator">60817408</xsl:variable>

		<xsl:variable name="setFlags">
			<xsl:choose>
				<xsl:when test="@setFlags = 'true'">1048576</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="register">
			<xsl:value-of select="@register * 4096"/>
		</xsl:variable>

		<xsl:variable name="rollRight">
			<xsl:choose>
				<xsl:when test="@rollRight">
					<xsl:value-of select="floor(@rollRight div 2) * 256"/>
				</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="value">
			<xsl:value-of select="@value"/>
		</xsl:variable>

		<xsl:variable name="condition">
			<xsl:choose>
				<xsl:when test="@condition='Equal'">
					<xsl:value-of select="0"/>
				</xsl:when>
				<xsl:when test="@condition='NotEqual'">
					<xsl:value-of select="268435456"/>
				</xsl:when>
				<xsl:when test="@condition='HigherOrEqual'">
					<xsl:value-of select="536870912"/>
				</xsl:when>
				<xsl:when test="@condition='Lower'">
					<xsl:value-of select="805306368"/>
				</xsl:when>
				<xsl:when test="@condition='Negative'">
					<xsl:value-of select="1073741824"/>
				</xsl:when>
				<xsl:when test="@condition='NotNegative'">
					<xsl:value-of select="1342177280"/>
				</xsl:when>
				<xsl:when test="@condition='Overflow'">
					<xsl:value-of select="1610612736"/>
				</xsl:when>
				<xsl:when test="@condition='NotOverflow'">
					<xsl:value-of select="1879048192"/>
				</xsl:when>
				<xsl:when test="@condition='Higher'">
					<xsl:value-of select="2147483648"/>
				</xsl:when>
				<xsl:when test="@condition='LowerOrEqual'">
					<xsl:value-of select="2415919104"/>
				</xsl:when>
				<xsl:when test="@condition='GreaterThanOrEqual'">
					<xsl:value-of select="2684354560"/>
				</xsl:when>
				<xsl:when test="@condition='LessThan'">
					<xsl:value-of select="2952790016"/>
				</xsl:when>
				<xsl:when test="@condition='GreaterThan'">
					<xsl:value-of select="3221225472"/>
				</xsl:when>
				<xsl:when test="@condition='LessThanOrEqual'">
					<xsl:value-of select="3489660928"/>
				</xsl:when>
				<xsl:when test="@condition='Never'">
					<xsl:value-of select="4026531840"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="3758096384"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<prg:uint>
			<xsl:value-of select="$condition + $operator + $setFlags + $register + $rollRight + $value"/>
		</prg:uint>
	</xsl:template>
	
	<xsl:template match="ns:CopyRegisterToAddress8">
		<xsl:variable name="operator">96468992</xsl:variable>
		<xsl:variable name="addressRegister" select="@addressRegister * 65536"/>
		<xsl:variable name="register" select="@register * 4096"/>

		<xsl:variable name="condition">
			<xsl:choose>
				<xsl:when test="@condition='Equal'">
					<xsl:value-of select="0"/>
				</xsl:when>
				<xsl:when test="@condition='NotEqual'">
					<xsl:value-of select="268435456"/>
				</xsl:when>
				<xsl:when test="@condition='HigherOrEqual'">
					<xsl:value-of select="536870912"/>
				</xsl:when>
				<xsl:when test="@condition='Lower'">
					<xsl:value-of select="805306368"/>
				</xsl:when>
				<xsl:when test="@condition='Negative'">
					<xsl:value-of select="1073741824"/>
				</xsl:when>
				<xsl:when test="@condition='NotNegative'">
					<xsl:value-of select="1342177280"/>
				</xsl:when>
				<xsl:when test="@condition='Overflow'">
					<xsl:value-of select="1610612736"/>
				</xsl:when>
				<xsl:when test="@condition='NotOverflow'">
					<xsl:value-of select="1879048192"/>
				</xsl:when>
				<xsl:when test="@condition='Higher'">
					<xsl:value-of select="2147483648"/>
				</xsl:when>
				<xsl:when test="@condition='LowerOrEqual'">
					<xsl:value-of select="2415919104"/>
				</xsl:when>
				<xsl:when test="@condition='GreaterThanOrEqual'">
					<xsl:value-of select="2684354560"/>
				</xsl:when>
				<xsl:when test="@condition='LessThan'">
					<xsl:value-of select="2952790016"/>
				</xsl:when>
				<xsl:when test="@condition='GreaterThan'">
					<xsl:value-of select="3221225472"/>
				</xsl:when>
				<xsl:when test="@condition='LessThanOrEqual'">
					<xsl:value-of select="3489660928"/>
				</xsl:when>
				<xsl:when test="@condition='Never'">
					<xsl:value-of select="4026531840"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="3758096384"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<prg:uint>
			<xsl:value-of select="$condition + $operator + $addressRegister + $register"/>
		</prg:uint>
	</xsl:template>
	
	<xsl:template match="ns:AddValueToRegister">
		<xsl:variable name="operator">41943040</xsl:variable>

		<xsl:variable name="setFlags">
			<xsl:choose>
				<xsl:when test="@setFlags = 'true'">1048576</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="register">
			<xsl:value-of select="@register * 65536"/>
		</xsl:variable>

		<xsl:variable name="destination">
			<xsl:choose>
				<xsl:when test="@destination">
					<xsl:value-of select="@destination * 4096"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="@register * 4096"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="rollRight">
			<xsl:choose>
				<xsl:when test="@rollRight">
					<xsl:value-of select="floor(@rollRight div 2) * 256"/>
				</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="value">
			<xsl:value-of select="@value"/>
		</xsl:variable>

		<xsl:variable name="condition">
			<xsl:choose>
				<xsl:when test="@condition='Equal'">
					<xsl:value-of select="0"/>
				</xsl:when>
				<xsl:when test="@condition='NotEqual'">
					<xsl:value-of select="268435456"/>
				</xsl:when>
				<xsl:when test="@condition='HigherOrEqual'">
					<xsl:value-of select="536870912"/>
				</xsl:when>
				<xsl:when test="@condition='Lower'">
					<xsl:value-of select="805306368"/>
				</xsl:when>
				<xsl:when test="@condition='Negative'">
					<xsl:value-of select="1073741824"/>
				</xsl:when>
				<xsl:when test="@condition='NotNegative'">
					<xsl:value-of select="1342177280"/>
				</xsl:when>
				<xsl:when test="@condition='Overflow'">
					<xsl:value-of select="1610612736"/>
				</xsl:when>
				<xsl:when test="@condition='NotOverflow'">
					<xsl:value-of select="1879048192"/>
				</xsl:when>
				<xsl:when test="@condition='Higher'">
					<xsl:value-of select="2147483648"/>
				</xsl:when>
				<xsl:when test="@condition='LowerOrEqual'">
					<xsl:value-of select="2415919104"/>
				</xsl:when>
				<xsl:when test="@condition='GreaterThanOrEqual'">
					<xsl:value-of select="2684354560"/>
				</xsl:when>
				<xsl:when test="@condition='LessThan'">
					<xsl:value-of select="2952790016"/>
				</xsl:when>
				<xsl:when test="@condition='GreaterThan'">
					<xsl:value-of select="3221225472"/>
				</xsl:when>
				<xsl:when test="@condition='LessThanOrEqual'">
					<xsl:value-of select="3489660928"/>
				</xsl:when>
				<xsl:when test="@condition='Never'">
					<xsl:value-of select="4026531840"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="3758096384"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<prg:uint>
			<xsl:value-of select="$condition + $operator + $setFlags + $register + $destination + $rollRight + $value"/>
		</prg:uint>
	</xsl:template>

	<xsl:template match="ns:SubtractValueFromRegister">
		<xsl:variable name="operator">37748736</xsl:variable>

		<xsl:variable name="setFlags">
			<xsl:choose>
				<xsl:when test="@setFlags = 'true'">1048576</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="register">
			<xsl:value-of select="@register * 65536"/>
		</xsl:variable>

		<xsl:variable name="destination">
			<xsl:choose>
				<xsl:when test="@destination">
					<xsl:value-of select="@destination * 4096"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="@register * 4096"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="rollRight">
			<xsl:choose>
				<xsl:when test="@rollRight">
					<xsl:value-of select="floor(@rollRight div 2) * 256"/>
				</xsl:when>
				<xsl:otherwise>0</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="value">
			<xsl:value-of select="@value"/>
		</xsl:variable>

		<xsl:variable name="condition">
			<xsl:choose>
				<xsl:when test="@condition='Equal'">
					<xsl:value-of select="0"/>
				</xsl:when>
				<xsl:when test="@condition='NotEqual'">
					<xsl:value-of select="268435456"/>
				</xsl:when>
				<xsl:when test="@condition='HigherOrEqual'">
					<xsl:value-of select="536870912"/>
				</xsl:when>
				<xsl:when test="@condition='Lower'">
					<xsl:value-of select="805306368"/>
				</xsl:when>
				<xsl:when test="@condition='Negative'">
					<xsl:value-of select="1073741824"/>
				</xsl:when>
				<xsl:when test="@condition='NotNegative'">
					<xsl:value-of select="1342177280"/>
				</xsl:when>
				<xsl:when test="@condition='Overflow'">
					<xsl:value-of select="1610612736"/>
				</xsl:when>
				<xsl:when test="@condition='NotOverflow'">
					<xsl:value-of select="1879048192"/>
				</xsl:when>
				<xsl:when test="@condition='Higher'">
					<xsl:value-of select="2147483648"/>
				</xsl:when>
				<xsl:when test="@condition='LowerOrEqual'">
					<xsl:value-of select="2415919104"/>
				</xsl:when>
				<xsl:when test="@condition='GreaterThanOrEqual'">
					<xsl:value-of select="2684354560"/>
				</xsl:when>
				<xsl:when test="@condition='LessThan'">
					<xsl:value-of select="2952790016"/>
				</xsl:when>
				<xsl:when test="@condition='GreaterThan'">
					<xsl:value-of select="3221225472"/>
				</xsl:when>
				<xsl:when test="@condition='LessThanOrEqual'">
					<xsl:value-of select="3489660928"/>
				</xsl:when>
				<xsl:when test="@condition='Never'">
					<xsl:value-of select="4026531840"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="3758096384"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<prg:uint>
			<xsl:value-of select="$condition + $operator + $setFlags + $register + $destination + $rollRight + $value"/>
		</prg:uint>
	</xsl:template>
</xsl:stylesheet>