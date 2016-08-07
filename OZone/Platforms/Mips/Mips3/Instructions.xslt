<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:prg="http://metalx.org/Program" xmlns:ns="http://metalx.org/Mips/Mips3/Instructions">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="ns:NoOperation">
		<prg:uint>0</prg:uint>
	</xsl:template>

	<xsl:template match="ns:Memory">
		<xsl:variable name="operation">
			<xsl:choose>
				<xsl:when test="@Operation='CopySignedMemoryToRegister8'">
					<xsl:value-of select="2147483648"/>
				</xsl:when>
				<xsl:when test="@Operation='CopyMemoryToRegister8'">
					<xsl:value-of select="2415919104"/>
				</xsl:when>
				<xsl:when test="@Operation='CopyMemoryToRegister64'">
					<xsl:value-of select="3690987520"/>
				</xsl:when>
				<xsl:when test="@Operation='CopyLowMemoryToHighRegister64'">
					<xsl:value-of select="1744830464"/>
				</xsl:when>
				<xsl:when test="@Operation='CopyHighMemoryToLowRegister64'">
					<xsl:value-of select="1811939328"/>
				</xsl:when>
				<xsl:when test="@Operation='CopySignedMemoryToRegister16'">
					<xsl:value-of select="2214592512"/>
				</xsl:when>
				<xsl:when test="@Operation='CopyMemoryToRegister16'">
					<xsl:value-of select="2483027968"/>
				</xsl:when>
				<xsl:when test="@Operation='AtomicCopyMemoryToRegister32'">
					<xsl:value-of select="3221225472"/>
				</xsl:when>
				<xsl:when test="@Operation='AtomicCopyMemoryToRegister64'">
					<xsl:value-of select="3489660928"/>
				</xsl:when>
				<xsl:when test="@Operation='CopySignedMemoryToRegister32'">
					<xsl:value-of select="2348810240"/>
				</xsl:when>
				<xsl:when test="@Operation='CopyLowSignedMemoryToHighRegister32'">
					<xsl:value-of select="2281701376"/>
				</xsl:when>
				<xsl:when test="@Operation='CopyHighSignedMemoryToLowRegister32'">
					<xsl:value-of select="2550136832"/>
				</xsl:when>
				<xsl:when test="@Operation='CopyMemoryToRegister32'">
					<xsl:value-of select="2617245696"/>
				</xsl:when>
				<xsl:when test="@Operation='CopyRegisterToMemory8'">
					<xsl:value-of select="2684354560"/>
				</xsl:when>
				<xsl:when test="@Operation='AtomicCopyRegisterToMemory32'">
					<xsl:value-of select="3758096384"/>
				</xsl:when>
				<xsl:when test="@Operation='AtomicCopyRegisterToMemory64'">
					<xsl:value-of select="4026531840"/>
				</xsl:when>
				<xsl:when test="@Operation='CopyRegisterToMemory64'">
					<xsl:value-of select="4227858432"/>
				</xsl:when>
				<xsl:when test="@Operation='CopyHighRegisterToLowMemory64'">
					<xsl:value-of select="2952790016"/>
				</xsl:when>
				<xsl:when test="@Operation='CopyLowRegisterToHighMemory64'">
					<xsl:value-of select="3019898880"/>
				</xsl:when>
				<xsl:when test="@Operation='CopyRegisterToMemory16'">
					<xsl:value-of select="2751463424"/>
				</xsl:when>
				<xsl:when test="@Operation='CopyRegisterToMemory32'">
					<xsl:value-of select="2885681152"/>
				</xsl:when>
				<xsl:when test="@Operation='CopyHighRegisterToLowMemory32'">
					<xsl:value-of select="2818572288"/>
				</xsl:when>
				<xsl:when test="@Operation='CopyLowRegisterToHighMemory32'">
					<xsl:value-of select="3087007744"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:message terminate="yes">
						Invalid Memory Operation: <xsl:value-of select="@Operation"/>
					</xsl:message>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="register">
			<xsl:value-of select="@Register * 65536"/>
		</xsl:variable>

		<xsl:variable name="addressRegister">
			<xsl:value-of select="@AddressRegister * 2097152"/>
		</xsl:variable>

		<xsl:variable name="offset">
			<xsl:choose>
				<xsl:when test="@Offset">
					<xsl:value-of select="@Offset"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<prg:uint>
			<xsl:value-of select="$operation + $register + $addressRegister + $offset"/>
		</prg:uint>
	</xsl:template>

	<xsl:template match="ns:ImmediateMath">
		<xsl:variable name="operation">
			<xsl:choose>
				<xsl:when test="@Operation='AddWithOverflow32'">
					<xsl:value-of select="536870912"/>
				</xsl:when>
				<xsl:when test="@Operation='Add32'">
					<xsl:value-of select="603979776"/>
				</xsl:when>
				<xsl:when test="@Operation='And32'">
					<xsl:value-of select="805306368"/>
				</xsl:when>
				<xsl:when test="@Operation='AddWithOverflow64'">
					<xsl:value-of select="1610612736"/>
				</xsl:when>
				<xsl:when test="@Operation='Add64'">
					<xsl:value-of select="1677721600"/>
				</xsl:when>
				<xsl:when test="@Operation='CopyToHighRegister32'">
					<xsl:value-of select="1006632960"/>
				</xsl:when>
				<xsl:when test="@Operation='Or32'">
					<xsl:value-of select="872415232"/>
				</xsl:when>
				<xsl:when test="@Operation='IsLessThanSigned32'">
					<xsl:value-of select="671088640"/>
				</xsl:when>
				<xsl:when test="@Operation='IsLessThan32'">
					<xsl:value-of select="738197504"/>
				</xsl:when>
				<xsl:when test="@Operation='ExclusiveOr32'">
					<xsl:value-of select="939524096"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:message terminate="yes">
						Invalid Immediate Math Operation: <xsl:value-of select="@Operation"/>
					</xsl:message>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="register">
			<xsl:choose>
				<xsl:when test="@Register">
					<xsl:value-of select="@Register * 2097152"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="destination">
			<xsl:value-of select="@Destination * 65536"/>
		</xsl:variable>

		<xsl:variable name="value">
			<xsl:choose>
				<xsl:when test="@Value &lt; 0">
					<xsl:value-of select="65535 + @Value"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="@Value"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<prg:uint>
			<xsl:value-of select="$operation + $register + $destination + $value"/>
		</prg:uint>
	</xsl:template>

	<xsl:template match="ns:RegisterMath">
		<xsl:variable name="operation">
			<xsl:choose>
				<xsl:when test="@Operation='AddWithOverflow32'">
					<xsl:value-of select="32"/>
				</xsl:when>
				<xsl:when test="@Operation='Add32'">
					<xsl:value-of select="33"/>
				</xsl:when>
				<xsl:when test="@Operation='And32'">
					<xsl:value-of select="36"/>
				</xsl:when>
				<xsl:when test="@Operation='AddWithOverflow64'">
					<xsl:value-of select="44"/>
				</xsl:when>
				<xsl:when test="@Operation='Add64'">
					<xsl:value-of select="45"/>
				</xsl:when>
				<xsl:when test="@Operation='SubtractWithOverflow64'">
					<xsl:value-of select="46"/>
				</xsl:when>
				<xsl:when test="@Operation='Subtract64'">
					<xsl:value-of select="47"/>
				</xsl:when>
				<xsl:when test="@Operation='NotOr64'">
					<xsl:value-of select="39"/>
				</xsl:when>
				<xsl:when test="@Operation='Or64'">
					<xsl:value-of select="37"/>
				</xsl:when>
				<xsl:when test="@Operation='IsLessThanSigned64'">
					<xsl:value-of select="42"/>
				</xsl:when>
				<xsl:when test="@Operation='IsLessThan64'">
					<xsl:value-of select="43"/>
				</xsl:when>
				<xsl:when test="@Operation='SignedSubtract32'">
					<xsl:value-of select="34"/>
				</xsl:when>
				<xsl:when test="@Operation='Subtract32'">
					<xsl:value-of select="35"/>
				</xsl:when>
				<xsl:when test="@Operation='ExclusiveOr64'">
					<xsl:value-of select="38"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:message terminate="yes">
						Invalid Register Math Operation: <xsl:value-of select="@Operation"/>
					</xsl:message>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="register1">
			<xsl:value-of select="@Register1 * 2097152"/>
		</xsl:variable>

		<xsl:variable name="register2">
			<xsl:value-of select="@Register2 * 65536"/>
		</xsl:variable>

		<xsl:variable name="destination">
			<xsl:value-of select="@Destination * 2048"/>
		</xsl:variable>

		<prg:uint>
			<xsl:value-of select="$operation + $register1 + $register2 + $destination"/>
		</prg:uint>
	</xsl:template>

	<xsl:template match="ns:RegisterArithmetic">
		<xsl:variable name="operation">
			<xsl:choose>
				<xsl:when test="@Operation='SignedDivide64'">
					<xsl:value-of select="30"/>
				</xsl:when>
				<xsl:when test="@Operation='Divide64'">
					<xsl:value-of select="31"/>
				</xsl:when>
				<xsl:when test="@Operation='SignedDivide32'">
					<xsl:value-of select="26"/>
				</xsl:when>
				<xsl:when test="@Operation='Divide32'">
					<xsl:value-of select="27"/>
				</xsl:when>
				<xsl:when test="@Operation='SignedMultiply64'">
					<xsl:value-of select="28"/>
				</xsl:when>
				<xsl:when test="@Operation='Multiply64'">
					<xsl:value-of select="29"/>
				</xsl:when>
				<xsl:when test="@Operation='SignedMultiply32'">
					<xsl:value-of select="24"/>
				</xsl:when>
				<xsl:when test="@Operation='Multiply32'">
					<xsl:value-of select="25"/>
				</xsl:when>
				<xsl:when test="@Operation='NotOr64'">
					<xsl:value-of select="39"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:message terminate="yes">
						Invalid Register Arithmetic Operation: <xsl:value-of select="@Operation"/>
					</xsl:message>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="register1">
			<xsl:value-of select="@Register1 * 2097152"/>
		</xsl:variable>

		<xsl:variable name="register2">
			<xsl:value-of select="@Register2 * 65536"/>
		</xsl:variable>

		<prg:uint>
			<xsl:value-of select="$operation + $register1 + $register2"/>
		</prg:uint>
	</xsl:template>

	<xsl:template match="ns:ImmediateShift">
		<xsl:variable name="operation">
			<xsl:choose>
				<xsl:when test="@Operation='ShiftLeft64'">
					<xsl:value-of select="56"/>
				</xsl:when>
				<xsl:when test="@Operation='HighShiftLeft64'">
					<xsl:value-of select="60"/>
				</xsl:when>
				<xsl:when test="@Operation='SignedShiftRight64'">
					<xsl:value-of select="59"/>
				</xsl:when>
				<xsl:when test="@Operation='HighSignedShiftRight64'">
					<xsl:value-of select="63"/>
				</xsl:when>
				<xsl:when test="@Operation='ShiftRight64'">
					<xsl:value-of select="58"/>
				</xsl:when>
				<xsl:when test="@Operation='HighShiftRight64'">
					<xsl:value-of select="62"/>
				</xsl:when>
				<xsl:when test="@Operation='ShiftLeft32'">
					<xsl:value-of select="0"/>
				</xsl:when>
				<xsl:when test="@Operation='SignedShiftRight32'">
					<xsl:value-of select="3"/>
				</xsl:when>
				<xsl:when test="@Operation='ShiftRight32'">
					<xsl:value-of select="2"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:message terminate="yes">
						Invalid Immediate Shift Operation: <xsl:value-of select="@Operation"/>
					</xsl:message>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="register">
			<xsl:value-of select="@Register * 2097152"/>
		</xsl:variable>

		<xsl:variable name="destination">
			<xsl:value-of select="@Destination * 65536"/>
		</xsl:variable>

		<xsl:variable name="shift">
			<xsl:value-of select="@Shift * 64"/>
		</xsl:variable>

		<prg:uint>
			<xsl:value-of select="$operation + $register + $destination + $shift"/>
		</prg:uint>
	</xsl:template>

	<xsl:template match="ns:RegisterShift">
		<xsl:variable name="operation">
			<xsl:choose>
				<xsl:when test="@Operation='ShiftLeft64'">
					<xsl:value-of select="20"/>
				</xsl:when>
				<xsl:when test="@Operation='SignedShiftRight64'">
					<xsl:value-of select="23"/>
				</xsl:when>
				<xsl:when test="@Operation='ShiftRight64'">
					<xsl:value-of select="22"/>
				</xsl:when>
				<xsl:when test="@Operation='ShiftLeft32'">
					<xsl:value-of select="4"/>
				</xsl:when>
				<xsl:when test="@Operation='SignedShiftRight32'">
					<xsl:value-of select="7"/>
				</xsl:when>
				<xsl:when test="@Operation='ShiftRight32'">
					<xsl:value-of select="6"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:message terminate="yes">
						Invalid Register Shift Operation: <xsl:value-of select="@Operation"/>
					</xsl:message>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="register">
			<xsl:value-of select="@Register * 65536"/>
		</xsl:variable>

		<xsl:variable name="shiftRegister">
			<xsl:value-of select="@ShiftRegister * 2097152"/>
		</xsl:variable>

		<xsl:variable name="destination">
			<xsl:value-of select="@Destination * 2048"/>
		</xsl:variable>

		<prg:uint>
			<xsl:value-of select="$operation + $register + $shiftRegister + $destination"/>
		</prg:uint>
	</xsl:template>

	<xsl:template match="ns:CompareBranch">
		<xsl:variable name="operation">
			<xsl:choose>
				<xsl:when test="@Operation='Equal'">
					<xsl:value-of select="4096"/>
				</xsl:when>
				<xsl:when test="@Operation='EqualNoDelay'">
					<xsl:value-of select="20480"/>
				</xsl:when>
				<xsl:when test="@Operation='NotEqual'">
					<xsl:value-of select="5120"/>
				</xsl:when>
				<xsl:when test="@Operation='NotEqualNoDelay'">
					<xsl:value-of select="21504"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:message terminate="yes">
						Invalid Compare Branch Operation: <xsl:value-of select="@Operation"/>
					</xsl:message>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="register1">
			<xsl:value-of select="@Register1 * 32"/>
		</xsl:variable>

		<xsl:variable name="register2">
			<xsl:value-of select="@Register2"/>
		</xsl:variable>

		<prg:ushort>
			<xsl:value-of select="$operation + $register1 + $register2"/>
		</prg:ushort>

		<xsl:element name="prg:addressOf">
			<xsl:attribute name="ref">
				<xsl:value-of select="@ref"/>
			</xsl:attribute>
			<xsl:attribute name="type">Relative16</xsl:attribute>
			<xsl:attribute name="offset">-1</xsl:attribute>
			<xsl:attribute name="stride">4</xsl:attribute>
		</xsl:element>
	</xsl:template>

	<xsl:template match="ns:ConditionalBranch">
		<xsl:variable name="operation">
			<xsl:choose>
				<xsl:when test="@Operation='JumpIfNotNegative'">
					<xsl:value-of select="1025"/>
				</xsl:when>
				<xsl:when test="@Operation='CallIfNotNegative'">
					<xsl:value-of select="1041"/>
				</xsl:when>
				<xsl:when test="@Operation='CallIfNotNegativeNoDelay'">
					<xsl:value-of select="1043"/>
				</xsl:when>
				<xsl:when test="@Operation='JumpIfNotNegativeNoDelay'">
					<xsl:value-of select="1027"/>
				</xsl:when>
				<xsl:when test="@Operation='JumpIfPositive'">
					<xsl:value-of select="7168"/>
				</xsl:when>
				<xsl:when test="@Operation='JumpIfPositiveNoDelay'">
					<xsl:value-of select="23552"/>
				</xsl:when>
				<xsl:when test="@Operation='JumpIfNotPositive'">
					<xsl:value-of select="6144"/>
				</xsl:when>
				<xsl:when test="@Operation='JumpIfNotPositiveNoDelay'">
					<xsl:value-of select="22528"/>
				</xsl:when>
				<xsl:when test="@Operation='JumpIfNegative'">
					<xsl:value-of select="1024"/>
				</xsl:when>
				<xsl:when test="@Operation='CallIfNegative'">
					<xsl:value-of select="1040"/>
				</xsl:when>
				<xsl:when test="@Operation='CallIfNegativeNoDelay'">
					<xsl:value-of select="1042"/>
				</xsl:when>
				<xsl:when test="@Operation='JumpIfNegativeNoDelay'">
					<xsl:value-of select="1026"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:message terminate="yes">
						Invalid Conditional Branch Operation: <xsl:value-of select="@Operation"/>
					</xsl:message>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="register">
			<xsl:value-of select="@Register * 32"/>
		</xsl:variable>

		<prg:ushort>
			<xsl:value-of select="$operation + $register"/>
		</prg:ushort>

		<xsl:element name="prg:addressOf">
			<xsl:attribute name="ref">
				<xsl:value-of select="@ref"/>
			</xsl:attribute>
			<xsl:attribute name="type">Relative16</xsl:attribute>
			<xsl:attribute name="offset">-1</xsl:attribute>
			<xsl:attribute name="stride">4</xsl:attribute>
		</xsl:element>
	</xsl:template>

	<xsl:template match="ns:CallRegister">
		<xsl:variable name="operation">
			<xsl:value-of select="9"/>
		</xsl:variable>

		<xsl:variable name="register">
			<xsl:value-of select="@Register * 2097152"/>
		</xsl:variable>

		<xsl:variable name="returnRegister">
			<xsl:value-of select="@ReturnRegister * 2048"/>
		</xsl:variable>
		<prg:uint>
			<xsl:value-of select="$register + $returnRegister"/>
		</prg:uint>
	</xsl:template>

	<xsl:template match="ns:JumpToRegister">
		<xsl:variable name="operation">
			<xsl:value-of select="8"/>
		</xsl:variable>

		<xsl:variable name="register">
			<xsl:value-of select="@Register * 2097152"/>
		</xsl:variable>

		<prg:uint>
			<xsl:value-of select="$operation + $register"/>
		</prg:uint>
	</xsl:template>
</xsl:stylesheet>