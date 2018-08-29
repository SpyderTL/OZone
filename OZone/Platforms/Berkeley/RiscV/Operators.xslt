<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:prg="http://metalx.org/Program" xmlns:ns="http://metalx.org/Arm/Arm7/Operators">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="ns:RegisterDataImmediateShift">
		<xsl:variable name="opcode" select="33554432"/>

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

		<xsl:variable name="operation">
			<xsl:choose>
				<xsl:when test="@Operation='AndRegisterWithOperand'">
					<xsl:value-of select="0"/>
				</xsl:when>
				<xsl:when test="@Operation='ExclusiveOrRegisterWithOperand'">
					<xsl:value-of select="2097152"/>
				</xsl:when>
				<xsl:when test="@Operation='SubtractOperandFromRegister'">
					<xsl:value-of select="4194304"/>
				</xsl:when>
				<xsl:when test="@Operation='SubtractRegisterFromOperand'">
					<xsl:value-of select="6291456"/>
				</xsl:when>
				<xsl:when test="@Operation='AddRegisterAndOperand'">
					<xsl:value-of select="8388608"/>
				</xsl:when>
				<xsl:when test="@Operation='AddRegisterAndOperandWithCarry'">
					<xsl:value-of select="10485760"/>
				</xsl:when>
				<xsl:when test="@Operation='SubtractOperandFromRegisterWithCarry'">
					<xsl:value-of select="12582912"/>
				</xsl:when>
				<xsl:when test="@Operation='SubtractRegisterFromOperandWithCarry'">
					<xsl:value-of select="14680064"/>
				</xsl:when>
				<xsl:when test="@Operation='TestAndRegisterWithOperand'">
					<xsl:value-of select="16777216"/>
				</xsl:when>
				<xsl:when test="@Operation='TestExclusiveOrRegisterWithOperand'">
					<xsl:value-of select="18874368"/>
				</xsl:when>
				<xsl:when test="@Operation='TestSubtractOperandFromRegister'">
					<xsl:value-of select="20971520"/>
				</xsl:when>
				<xsl:when test="@Operation='TestAddRegisterAndOperand'">
					<xsl:value-of select="23068672"/>
				</xsl:when>
				<xsl:when test="@Operation='OrRegisterWithOperand'">
					<xsl:value-of select="25165824"/>
				</xsl:when>
				<xsl:when test="@Operation='CopyOperand'">
					<xsl:value-of select="27262976"/>
				</xsl:when>
				<xsl:when test="@Operation='AndRegisterWithOperandComplement'">
					<xsl:value-of select="29360128"/>
				</xsl:when>
				<xsl:when test="@Operation='CopyOperandComplement'">
					<xsl:value-of select="31457280"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:message terminate="yes">
						Invalid Data Operation: <xsl:value-of select="@Operation"/>
					</xsl:message>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="setFlags">
			<xsl:choose>
				<xsl:when test="@SetFlags='true'">
					<xsl:value-of select="1048576"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="register">
			<xsl:value-of select="@Register * 65536"/>
		</xsl:variable>

		<xsl:variable name="destination">
			<xsl:value-of select="@Destination * 4096"/>
		</xsl:variable>

		<xsl:variable name="shift">
			<xsl:value-of select="@Shift * 128"/>
		</xsl:variable>

		<xsl:variable name="shiftType">
			<xsl:choose>
				<xsl:when test="@ShiftType='ShiftRight'">
					<xsl:value-of select="32"/>
				</xsl:when>
				<xsl:when test="@ShiftType='SignedShiftRight'">
					<xsl:value-of select="64"/>
				</xsl:when>
				<xsl:when test="@ShiftType='RotateRight'">
					<xsl:value-of select="96"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="operand">
			<xsl:value-of select="@Operand"/>
		</xsl:variable>

		<prg:uint>
			<xsl:value-of select="$opcode + $condition + $operation + $setFlags + $register + $destination + $shift + $shiftType + $operand"/>
		</prg:uint>
	</xsl:template>

	<xsl:template match="ns:RegisterDataRegisterShift">
		<xsl:variable name="opcode" select="33554448"/>

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

		<xsl:variable name="operation">
			<xsl:choose>
				<xsl:when test="@Operation='AndRegisterWithOperand'">
					<xsl:value-of select="0"/>
				</xsl:when>
				<xsl:when test="@Operation='ExclusiveOrRegisterWithOperand'">
					<xsl:value-of select="2097152"/>
				</xsl:when>
				<xsl:when test="@Operation='SubtractOperandFromRegister'">
					<xsl:value-of select="4194304"/>
				</xsl:when>
				<xsl:when test="@Operation='SubtractRegisterFromOperand'">
					<xsl:value-of select="6291456"/>
				</xsl:when>
				<xsl:when test="@Operation='AddRegisterAndOperand'">
					<xsl:value-of select="8388608"/>
				</xsl:when>
				<xsl:when test="@Operation='AddRegisterAndOperandWithCarry'">
					<xsl:value-of select="10485760"/>
				</xsl:when>
				<xsl:when test="@Operation='SubtractOperandFromRegisterWithCarry'">
					<xsl:value-of select="12582912"/>
				</xsl:when>
				<xsl:when test="@Operation='SubtractRegisterFromOperandWithCarry'">
					<xsl:value-of select="14680064"/>
				</xsl:when>
				<xsl:when test="@Operation='TestAndRegisterWithOperand'">
					<xsl:value-of select="16777216"/>
				</xsl:when>
				<xsl:when test="@Operation='TestExclusiveOrRegisterWithOperand'">
					<xsl:value-of select="18874368"/>
				</xsl:when>
				<xsl:when test="@Operation='TestSubtractOperandFromRegister'">
					<xsl:value-of select="20971520"/>
				</xsl:when>
				<xsl:when test="@Operation='TestAddRegisterAndOperand'">
					<xsl:value-of select="23068672"/>
				</xsl:when>
				<xsl:when test="@Operation='OrRegisterWithOperand'">
					<xsl:value-of select="25165824"/>
				</xsl:when>
				<xsl:when test="@Operation='CopyOperand'">
					<xsl:value-of select="27262976"/>
				</xsl:when>
				<xsl:when test="@Operation='AndRegisterWithOperandComplement'">
					<xsl:value-of select="29360128"/>
				</xsl:when>
				<xsl:when test="@Operation='CopyOperandComplement'">
					<xsl:value-of select="31457280"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:message terminate="yes">
						Invalid Data Operation: <xsl:value-of select="@Operation"/>
					</xsl:message>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="setFlags">
			<xsl:choose>
				<xsl:when test="@SetFlags='true'">
					<xsl:value-of select="1048576"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="register">
			<xsl:value-of select="@Register * 65536"/>
		</xsl:variable>

		<xsl:variable name="destination">
			<xsl:value-of select="@Destination * 4096"/>
		</xsl:variable>

		<xsl:variable name="shiftRegister">
			<xsl:value-of select="@ShiftRegister * 256"/>
		</xsl:variable>

		<xsl:variable name="shiftType">
			<xsl:choose>
				<xsl:when test="@ShiftType='ShiftRight'">
					<xsl:value-of select="32"/>
				</xsl:when>
				<xsl:when test="@ShiftType='SignedShiftRight'">
					<xsl:value-of select="64"/>
				</xsl:when>
				<xsl:when test="@ShiftType='RotateRight'">
					<xsl:value-of select="96"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="operand">
			<xsl:value-of select="@Operand"/>
		</xsl:variable>

		<prg:uint>
			<xsl:value-of select="$opcode + $condition + $operation + $setFlags + $register + $destination + $shiftRegister + $shiftType + $operand"/>
		</prg:uint>
	</xsl:template>

	<xsl:template match="ns:ImmediateData">
		<xsl:variable name="opcode" select="33554432"/>

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

		<xsl:variable name="operation">
			<xsl:choose>
				<xsl:when test="@Operation='AndRegisterWithOperand'">
					<xsl:value-of select="0"/>
				</xsl:when>
				<xsl:when test="@Operation='ExclusiveOrRegisterWithOperand'">
					<xsl:value-of select="2097152"/>
				</xsl:when>
				<xsl:when test="@Operation='SubtractOperandFromRegister'">
					<xsl:value-of select="4194304"/>
				</xsl:when>
				<xsl:when test="@Operation='SubtractRegisterFromOperand'">
					<xsl:value-of select="6291456"/>
				</xsl:when>
				<xsl:when test="@Operation='AddRegisterAndOperand'">
					<xsl:value-of select="8388608"/>
				</xsl:when>
				<xsl:when test="@Operation='AddRegisterAndOperandWithCarry'">
					<xsl:value-of select="10485760"/>
				</xsl:when>
				<xsl:when test="@Operation='SubtractOperandFromRegisterWithCarry'">
					<xsl:value-of select="12582912"/>
				</xsl:when>
				<xsl:when test="@Operation='SubtractRegisterFromOperandWithCarry'">
					<xsl:value-of select="14680064"/>
				</xsl:when>
				<xsl:when test="@Operation='TestAndRegisterWithOperand'">
					<xsl:value-of select="16777216"/>
				</xsl:when>
				<xsl:when test="@Operation='TestExclusiveOrRegisterWithOperand'">
					<xsl:value-of select="18874368"/>
				</xsl:when>
				<xsl:when test="@Operation='TestSubtractOperandFromRegister'">
					<xsl:value-of select="20971520"/>
				</xsl:when>
				<xsl:when test="@Operation='TestAddRegisterAndOperand'">
					<xsl:value-of select="23068672"/>
				</xsl:when>
				<xsl:when test="@Operation='OrRegisterWithOperand'">
					<xsl:value-of select="25165824"/>
				</xsl:when>
				<xsl:when test="@Operation='CopyOperand'">
					<xsl:value-of select="27262976"/>
				</xsl:when>
				<xsl:when test="@Operation='AndRegisterWithOperandComplement'">
					<xsl:value-of select="29360128"/>
				</xsl:when>
				<xsl:when test="@Operation='CopyOperandComplement'">
					<xsl:value-of select="31457280"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:message terminate="yes">
						Invalid Data Operation: <xsl:value-of select="@Operation"/>
					</xsl:message>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="setFlags">
			<xsl:choose>
				<xsl:when test="@SetFlags='true'">
					<xsl:value-of select="1048576"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="register">
			<xsl:choose>
				<xsl:when test="@Register">
					<xsl:value-of select="@Register * 65536"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="destination">
			<xsl:value-of select="@Destination * 4096"/>
		</xsl:variable>

		<xsl:variable name="rotate">
			<xsl:choose>
				<xsl:when test="@Rotate">
					<xsl:value-of select="@Rotate * 256"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="operand">
			<xsl:value-of select="@Operand"/>
		</xsl:variable>

		<prg:uint>
			<xsl:value-of select="$opcode + $condition + $operation + $setFlags + $register + $destination + $rotate + $operand"/>
		</prg:uint>
	</xsl:template>

	<xsl:template match="ns:CopyStatusToRegister">
		<xsl:variable name="opcode" select="17760256"/>

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

		<xsl:variable name="savedStatus">
			<xsl:choose>
				<xsl:when test="@SavedStatus = 'true'">
					<xsl:value-of select="4194304"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="destination">
			<xsl:value-of select="@Destination * 4096"/>
		</xsl:variable>

		<prg:uint>
			<xsl:value-of select="$opcode + $condition + $savedStatus + $destination"/>
		</prg:uint>
	</xsl:template>

	<xsl:template match="ns:CopyRegisterToStatus">
		<xsl:variable name="opcode" select="19525632"/>

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

		<xsl:variable name="savedStatus">
			<xsl:choose>
				<xsl:when test="@SavedStatus = 'true'">
					<xsl:value-of select="4194304"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="register">
			<xsl:value-of select="@Register"/>
		</xsl:variable>

		<prg:uint>
			<xsl:value-of select="$opcode + $condition + $savedStatus + $register"/>
		</prg:uint>
	</xsl:template>

	<xsl:template match="ns:CopyRegisterToFlags">
		<xsl:variable name="opcode" select="19460096"/>

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

		<xsl:variable name="savedStatus">
			<xsl:choose>
				<xsl:when test="@SavedStatus = 'true'">
					<xsl:value-of select="4194304"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="register">
			<xsl:value-of select="@Register"/>
		</xsl:variable>

		<prg:uint>
			<xsl:value-of select="$opcode + $condition + $savedStatus + $register"/>
		</prg:uint>
	</xsl:template>

	<xsl:template match="ns:SetFlags">
		<xsl:variable name="opcode" select="53014528"/>

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

		<xsl:variable name="savedStatus">
			<xsl:choose>
				<xsl:when test="@SavedStatus = 'true'">
					<xsl:value-of select="4194304"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="rotate">
			<xsl:value-of select="@Rotate * 256"/>
		</xsl:variable>

		<xsl:variable name="value">
			<xsl:value-of select="@Value"/>
		</xsl:variable>

		<prg:uint>
			<xsl:value-of select="$opcode + $condition + $savedStatus + $rotate + $value"/>
		</prg:uint>
	</xsl:template>

	<xsl:template match="ns:MultiplyRegisters">
		<xsl:variable name="opcode" select="144"/>

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

		<xsl:variable name="setFlags">
			<xsl:choose>
				<xsl:when test="@SetFlags='true'">
					<xsl:value-of select="1048576"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="destination">
			<xsl:value-of select="@Destination * 65536"/>
		</xsl:variable>

		<xsl:variable name="register1">
			<xsl:value-of select="@Register1"/>
		</xsl:variable>

		<xsl:variable name="register2">
			<xsl:value-of select="@Register2 * 256"/>
		</xsl:variable>

		<prg:uint>
			<xsl:value-of select="$opcode + $condition + $setFlags + $destination + $register1 + $register2"/>
		</prg:uint>
	</xsl:template>

	<xsl:template match="ns:MultiplyAndAddRegisters">
		<xsl:variable name="opcode" select="2097296"/>

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

		<xsl:variable name="setFlags">
			<xsl:choose>
				<xsl:when test="@SetFlags='true'">
					<xsl:value-of select="1048576"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="destination">
			<xsl:value-of select="@Destination * 65536"/>
		</xsl:variable>

		<xsl:variable name="register1">
			<xsl:value-of select="@Register1"/>
		</xsl:variable>

		<xsl:variable name="register2">
			<xsl:value-of select="@Register2 * 256"/>
		</xsl:variable>

		<xsl:variable name="addRegister">
			<xsl:value-of select="@AddRegister * 4096"/>
		</xsl:variable>

		<prg:uint>
			<xsl:value-of select="$opcode + $condition + $setFlags + $destination + $register1 + $register2 + $addRegister"/>
		</prg:uint>
	</xsl:template>

	<xsl:template match="ns:ImmediateOffsetMemory">
		<xsl:variable name="opcode" select="67108864"/>

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

		<xsl:variable name="applyOffsetBeforeTransfer">
			<xsl:choose>
				<xsl:when test="@ApplyOffsetBeforeTransfer='true'">
					<xsl:value-of select="16777216"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="addOffset">
			<xsl:choose>
				<xsl:when test="@AddOffset='true'">
					<xsl:value-of select="8388608"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="transferByte">
			<xsl:choose>
				<xsl:when test="@TransferByte='true'">
					<xsl:value-of select="4194304"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="updateBaseRegister">
			<xsl:choose>
				<xsl:when test="@UpdateBaseRegister='true'">
					<xsl:value-of select="2097152"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="readFromMemory">
			<xsl:choose>
				<xsl:when test="@ReadFromMemory='true'">
					<xsl:value-of select="1048576"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="register">
			<xsl:value-of select="@Register * 4096"/>
		</xsl:variable>

		<xsl:variable name="addressRegister">
			<xsl:value-of select="@AddressRegister * 65536"/>
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
			<xsl:value-of select="$opcode + $condition + $applyOffsetBeforeTransfer + $addOffset + $transferByte + $updateBaseRegister + $readFromMemory + $register + $addressRegister + $offset"/>
		</prg:uint>
	</xsl:template>

	<xsl:template match="ns:RegisterOffsetMemory">
		<xsl:variable name="opcode" select="100663296"/>

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

		<xsl:variable name="applyOffsetBeforeTransfer">
			<xsl:choose>
				<xsl:when test="@ApplyOffsetBeforeTransfer='true'">
					<xsl:value-of select="16777216"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="addOffset">
			<xsl:choose>
				<xsl:when test="@AddOffset='true'">
					<xsl:value-of select="8388608"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="transferByte">
			<xsl:choose>
				<xsl:when test="@TransferByte='true'">
					<xsl:value-of select="4194304"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="updateBaseRegister">
			<xsl:choose>
				<xsl:when test="@UpdateBaseRegister='true'">
					<xsl:value-of select="2097152"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="readFromMemory">
			<xsl:choose>
				<xsl:when test="@ReadFromMemory='true'">
					<xsl:value-of select="1048576"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="register">
			<xsl:value-of select="@Register * 4096"/>
		</xsl:variable>

		<xsl:variable name="addressRegister">
			<xsl:value-of select="@AddressRegister * 65536"/>
		</xsl:variable>

		<xsl:variable name="offsetRegisterShift">
			<xsl:value-of select="@OffsetRegisterShift * 128"/>
		</xsl:variable>

		<xsl:variable name="offsetRegisterShiftType">
			<xsl:choose>
				<xsl:when test="@OffsetRegisterShiftType='ShiftRight'">
					<xsl:value-of select="32"/>
				</xsl:when>
				<xsl:when test="@OffsetRegisterShiftType='SignedShiftRight'">
					<xsl:value-of select="64"/>
				</xsl:when>
				<xsl:when test="@OffsetRegisterShiftType='RotateRight'">
					<xsl:value-of select="96"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="offsetRegister">
			<xsl:value-of select="@OffsetRegister"/>
		</xsl:variable>

		<prg:uint>
			<xsl:value-of select="$opcode + $condition + $applyOffsetBeforeTransfer + $addOffset + $transferByte + $updateBaseRegister + $readFromMemory + $register + $addressRegister + $offsetRegisterShift + $offsetRegisterShiftType + $offsetRegister"/>
		</prg:uint>
	</xsl:template>

	<xsl:template match="ns:ImmediateOffsetShortMemory">
		<xsl:variable name="opcode" select="4194448"/>

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

		<xsl:variable name="applyOffsetBeforeTransfer">
			<xsl:choose>
				<xsl:when test="@ApplyOffsetBeforeTransfer='true'">
					<xsl:value-of select="16777216"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="addOffset">
			<xsl:choose>
				<xsl:when test="@AddOffset='true'">
					<xsl:value-of select="8388608"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="updateBaseRegister">
			<xsl:choose>
				<xsl:when test="@UpdateBaseRegister='true'">
					<xsl:value-of select="2097152"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="readFromMemory">
			<xsl:choose>
				<xsl:when test="@ReadFromMemory='true'">
					<xsl:value-of select="1048576"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="signed">
			<xsl:choose>
				<xsl:when test="@Signed='true'">
					<xsl:value-of select="64"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="transferShort">
			<xsl:choose>
				<xsl:when test="@TransferShort='true'">
					<xsl:value-of select="32"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="register">
			<xsl:value-of select="@Register * 4096"/>
		</xsl:variable>

		<xsl:variable name="addressRegister">
			<xsl:value-of select="@AddressRegister * 65536"/>
		</xsl:variable>

		<xsl:variable name="offsetHigh">
			<xsl:value-of select="@OffsetHigh * 256"/>
		</xsl:variable>

		<xsl:variable name="offsetLow">
			<xsl:value-of select="@OffsetLow"/>
		</xsl:variable>

		<prg:uint>
			<xsl:value-of select="$opcode + $condition + $applyOffsetBeforeTransfer + $addOffset + $updateBaseRegister + $readFromMemory + $signed + $transferShort + $register + $addressRegister + $offsetHigh + $offsetLow"/>
		</prg:uint>
	</xsl:template>

	<xsl:template match="ns:RegisterOffsetMemory">
		<xsl:variable name="opcode" select="144"/>

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

		<xsl:variable name="applyOffsetBeforeTransfer">
			<xsl:choose>
				<xsl:when test="@ApplyOffsetBeforeTransfer='true'">
					<xsl:value-of select="16777216"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="addOffset">
			<xsl:choose>
				<xsl:when test="@AddOffset='true'">
					<xsl:value-of select="8388608"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="updateBaseRegister">
			<xsl:choose>
				<xsl:when test="@UpdateBaseRegister='true'">
					<xsl:value-of select="2097152"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="readFromMemory">
			<xsl:choose>
				<xsl:when test="@ReadFromMemory='true'">
					<xsl:value-of select="1048576"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="signed">
			<xsl:choose>
				<xsl:when test="@Signed='true'">
					<xsl:value-of select="64"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="transferShort">
			<xsl:choose>
				<xsl:when test="@TransferShort='true'">
					<xsl:value-of select="32"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="register">
			<xsl:value-of select="@Register * 4096"/>
		</xsl:variable>

		<xsl:variable name="addressRegister">
			<xsl:value-of select="@AddressRegister * 65536"/>
		</xsl:variable>

		<xsl:variable name="offsetRegister">
			<xsl:value-of select="@OffsetRegister"/>
		</xsl:variable>

		<prg:uint>
			<xsl:value-of select="$opcode + $condition + $applyOffsetBeforeTransfer + $addOffset + $updateBaseRegister + $readFromMemory + $signed + $transferShort + $register + $addressRegister + $offsetRegister"/>
		</prg:uint>
	</xsl:template>

	<xsl:template match="ns:BlockMemory">
		<xsl:variable name="opcode" select="0"/>

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
			<xsl:value-of select="$opcode + $condition"/>
		</prg:uint>
	</xsl:template>

	<xsl:template match="ns:SwapMemory">
		<xsl:variable name="opcode" select="0"/>

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
			<xsl:value-of select="$opcode + $condition"/>
		</prg:uint>
	</xsl:template>

	<xsl:template match="ns:BranchToRelative">
		<xsl:variable name="opcode" select="10"/>

		<xsl:variable name="condition">
			<xsl:choose>
				<xsl:when test="@Condition='Equal'">
					<xsl:value-of select="0"/>
				</xsl:when>
				<xsl:when test="@Condition='NotEqual'">
					<xsl:value-of select="16"/>
				</xsl:when>
				<xsl:when test="@Condition='HigherOrEqual'">
					<xsl:value-of select="32"/>
				</xsl:when>
				<xsl:when test="@Condition='Lower'">
					<xsl:value-of select="48"/>
				</xsl:when>
				<xsl:when test="@Condition='Negative'">
					<xsl:value-of select="64"/>
				</xsl:when>
				<xsl:when test="@Condition='NotNegative'">
					<xsl:value-of select="80"/>
				</xsl:when>
				<xsl:when test="@Condition='Overflow'">
					<xsl:value-of select="96"/>
				</xsl:when>
				<xsl:when test="@Condition='NotOverflow'">
					<xsl:value-of select="112"/>
				</xsl:when>
				<xsl:when test="@Condition='Higher'">
					<xsl:value-of select="128"/>
				</xsl:when>
				<xsl:when test="@Condition='LowerOrEqual'">
					<xsl:value-of select="144"/>
				</xsl:when>
				<xsl:when test="@Condition='GreaterThanOrEqual'">
					<xsl:value-of select="160"/>
				</xsl:when>
				<xsl:when test="@Condition='LessThan'">
					<xsl:value-of select="176"/>
				</xsl:when>
				<xsl:when test="@Condition='GreaterThan'">
					<xsl:value-of select="192"/>
				</xsl:when>
				<xsl:when test="@Condition='LessThanOrEqual'">
					<xsl:value-of select="208"/>
				</xsl:when>
				<xsl:when test="@Condition='Never'">
					<xsl:value-of select="240"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="224"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:variable name="setReturnAddress">
			<xsl:choose>
				<xsl:when test="@SetReturnAddress='true'">
					<xsl:value-of select="1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="0"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:element name="prg:addressOf">
			<xsl:attribute name="ref">
				<xsl:value-of select="@ref"/>
			</xsl:attribute>
			<xsl:attribute name="type">Relative24</xsl:attribute>
			<xsl:attribute name="stride">4</xsl:attribute>
		</xsl:element>

		<prg:byte>
			<xsl:value-of select="$opcode + $condition + $setReturnAddress"/>
		</prg:byte>
	</xsl:template>

	<xsl:template match="ns:SoftwareInterrupt">
		<xsl:variable name="opcode" select="251658240"/>

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
			<xsl:value-of select="$opcode + $condition"/>
		</prg:uint>
	</xsl:template>

	<xsl:template match="ns:CoprocessorOperation">
		<xsl:variable name="opcode" select="0"/>

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
			<xsl:value-of select="$opcode + $condition"/>
		</prg:uint>
	</xsl:template>

	<xsl:template match="ns:CoprocessorMemory">
		<xsl:variable name="opcode" select="0"/>

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
			<xsl:value-of select="$opcode + $condition"/>
		</prg:uint>
	</xsl:template>

	<xsl:template match="ns:CoprocessorRegister">
		<xsl:variable name="opcode" select="0"/>

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
			<xsl:value-of select="$opcode + $condition"/>
		</prg:uint>
	</xsl:template>
</xsl:stylesheet>