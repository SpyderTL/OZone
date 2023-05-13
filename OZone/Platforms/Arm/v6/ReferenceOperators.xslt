<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:prg="http://metalx.org/Program" xmlns:ns="http://metalx.org/Arm/v6/Operators">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="ns:SetRegisterToAddressOf">
		<xsl:variable name="operator">60817408</xsl:variable>
		<xsl:variable name="destination" select="@register * 4096"/>
		<xsl:variable name="address" select="@prg:refAddress mod 256"/>
		<xsl:variable name="operator2">58720256</xsl:variable>
		<xsl:variable name="register" select="@register * 65536"/>
		<xsl:variable name="rollRight">0</xsl:variable>
		<xsl:variable name="address2" select="floor(@prg:refAddress div 256) mod 256"/>
		<xsl:variable name="rollRight2" select="12 * 256"/>
		<xsl:variable name="address3" select="floor(@prg:refAddress div 65536) mod 256"/>
		<xsl:variable name="rollRight3" select="8 * 256"/>
		<xsl:variable name="address4" select="floor(@prg:refAddress div 16777216) mod 256"/>
		<xsl:variable name="rollRight4" select="4 * 256"/>

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
			<xsl:value-of select="$condition + $operator + $destination + $rollRight + $address"/>
		</prg:uint>

		<prg:uint>
			<xsl:value-of select="$condition + $operator2 + $register + $destination + $rollRight2 + $address2"/>
		</prg:uint>

		<prg:uint>
			<xsl:value-of select="$condition + $operator2 + $register + $destination + $rollRight3 + $address3"/>
		</prg:uint>

		<prg:uint>
			<xsl:value-of select="$condition + $operator2 + $register + $destination + $rollRight4 + $address4"/>
		</prg:uint>
	</xsl:template>

	<xsl:template match="ns:Jump">
		<xsl:variable name="operator">167772160</xsl:variable>
		<xsl:variable name="offset" select="(@prg:refAddress - @prg:address - 8) div 4"/>
		<xsl:variable name="unsignedOffset">
			<xsl:choose>
				<xsl:when test="$offset &lt; 0">
					<xsl:value-of select="$offset + 16777216"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$offset"/>
				</xsl:otherwise>
			</xsl:choose>
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
			<xsl:value-of select="$condition + $operator + $unsignedOffset"/>
		</prg:uint>
	</xsl:template>

	<xsl:template match="ns:Call">
		<xsl:variable name="operator">184549376</xsl:variable>
		<xsl:variable name="offset" select="(@prg:refAddress - @prg:address - 8) div 4"/>
		<xsl:variable name="unsignedOffset">
			<xsl:choose>
				<xsl:when test="$offset &lt; 0">
					<xsl:value-of select="$offset + 16777216"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$offset"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="condition">
			<xsl:choose>
				<xsl:when test="@Condition='Equal'">
					<xsl:value-of select="0"/>
				</xsl:when>
				<xsl:when test="@Condition='NotEqual'">
					<xsl:value-of select="268435456"/>
				</xsl:when>
				<xsl:when test="@Condition='HigherOrEqual'">
					<xsl:value-of select="536870912"/>
				</xsl:when>
				<xsl:when test="@Condition='Lower'">
					<xsl:value-of select="805306368"/>
				</xsl:when>
				<xsl:when test="@Condition='Negative'">
					<xsl:value-of select="1073741824"/>
				</xsl:when>
				<xsl:when test="@Condition='NotNegative'">
					<xsl:value-of select="1342177280"/>
				</xsl:when>
				<xsl:when test="@Condition='Overflow'">
					<xsl:value-of select="1610612736"/>
				</xsl:when>
				<xsl:when test="@Condition='NotOverflow'">
					<xsl:value-of select="1879048192"/>
				</xsl:when>
				<xsl:when test="@Condition='Higher'">
					<xsl:value-of select="2147483648"/>
				</xsl:when>
				<xsl:when test="@Condition='LowerOrEqual'">
					<xsl:value-of select="2415919104"/>
				</xsl:when>
				<xsl:when test="@Condition='GreaterThanOrEqual'">
					<xsl:value-of select="2684354560"/>
				</xsl:when>
				<xsl:when test="@Condition='LessThan'">
					<xsl:value-of select="2952790016"/>
				</xsl:when>
				<xsl:when test="@Condition='GreaterThan'">
					<xsl:value-of select="3221225472"/>
				</xsl:when>
				<xsl:when test="@Condition='LessThanOrEqual'">
					<xsl:value-of select="3489660928"/>
				</xsl:when>
				<xsl:when test="@Condition='Never'">
					<xsl:value-of select="4026531840"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="3758096384"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<prg:uint>
			<xsl:value-of select="$condition + $operator + $unsignedOffset"/>
		</prg:uint>
	</xsl:template>
</xsl:stylesheet>