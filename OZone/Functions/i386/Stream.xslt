<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:var="http://metalx.org/Variable"
	xmlns:inc="http://metalx.org/Intel/80386/Increment"
	xmlns:imm="http://metalx.org/Intel/80386/Immediate"
	xmlns:math="http://metalx.org/Intel/80386/Math"
	xmlns:shift="http://metalx.org/Intel/80386/Shift"
	xmlns:cpu="http://metalx.org/Intel/80386/Operators"
	xmlns:op="http://metalx.org/Intel/80386/Operands"
	xmlns:obj="http://metalx.org/i386/Functions/Object"
	xmlns:cat="http://metalx.org/i386/Functions/Catalog"
	xmlns:str="http://metalx.org/i386/Functions/Stream"
	xmlns:sys="http://metalx.org/i386/Functions/System"
	xmlns:mm="http://metalx.org/i386/Functions/MemoryManager">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="str:ReadByte">
		<cpu:CopySIAddressToALAndIncrementSI/>
	</xsl:template>

	<xsl:template match="str:WriteByte">
		<cpu:CopyALToDIAddressAndIncrementDI/>
	</xsl:template>

	<xsl:template match="str:ReadShort">
		<cpu:Operand16/>
		<cpu:CopySIAddressToAXAndIncrementSI/>
	</xsl:template>

	<xsl:template match="str:WriteShort">
		<cpu:Operand16/>
		<cpu:CopyAXToDIAddressAndIncrementDI/>
	</xsl:template>

	<xsl:template match="str:ReadShortReverse">
		<cpu:Operand16/>
		<cpu:CopySIAddressToAXAndIncrementSI/>

		<cpu:ExchangeOperandWithRegister/>
		<op:AL-AHRegister/>
	</xsl:template>

	<xsl:template match="str:WriteShortReverse">
		<cpu:ExchangeOperandWithRegister/>
		<op:AL-AHRegister/>
		
		<cpu:Operand16/>
		<cpu:CopyAXToDIAddressAndIncrementDI/>
	</xsl:template>

	<xsl:template match="str:ReadInteger">
		<cpu:CopySIAddressToAXAndIncrementSI/>
	</xsl:template>

	<xsl:template match="str:WriteInteger">
		<cpu:CopyAXToDIAddressAndIncrementDI/>
	</xsl:template>

	<xsl:template match="str:ReadIntegerReverse">
		<cpu:CopySIAddressToALAndIncrementSI/>

		<cpu:ShiftRegisterByImmediate8Function/>
		<shift:ShiftAXRegisterLeft/>
		<byte>8</byte>

		<cpu:CopySIAddressToALAndIncrementSI/>

		<cpu:ShiftRegisterByImmediate8Function/>
		<shift:ShiftAXRegisterLeft/>
		<byte>8</byte>

		<cpu:CopySIAddressToALAndIncrementSI/>

		<cpu:ShiftRegisterByImmediate8Function/>
		<shift:ShiftAXRegisterLeft/>
		<byte>8</byte>

		<cpu:CopySIAddressToALAndIncrementSI/>
	</xsl:template>

	<xsl:template match="str:WriteIntegerReverse">
		<cpu:CopyALToDIAddressAndIncrementDI/>

		<cpu:ShiftRegisterByImmediate8Function/>
		<shift:ShiftAXRegisterRight/>
		<byte>8</byte>

		<cpu:CopyALToDIAddressAndIncrementDI/>

		<cpu:ShiftRegisterByImmediate8Function/>
		<shift:ShiftAXRegisterRight/>
		<byte>8</byte>

		<cpu:CopyALToDIAddressAndIncrementDI/>

		<cpu:ShiftRegisterByImmediate8Function/>
		<shift:ShiftAXRegisterRight/>
		<byte>8</byte>

		<cpu:CopyALToDIAddressAndIncrementDI/>
	</xsl:template>

	<xsl:template match="str:ReadString32">
		<cpu:CopySIAddressToAXAndIncrementSI/>

		<cpu:PushSIToStack/>

		<cpu:AddImmediateToAX/>
		<int>4</int>

		<mm:CheckOut/>

		<cpu:PullSIFromStack/>
		<cpu:PushDIToStack/>

		<cpu:SubtractImmediateFromAL/>
		<int>4</int>

		<cpu:CopyAXToDIAddressAndIncrementDI/>

		<cpu:CopyRegisterToOperand/>
		<op:AX-CXRegister/>

		<cpu:Repeat/>
		<cpu:CopySIAddressToDIAddressAndIncrementSIAndDI8/>

		<cpu:PullDIFromStack/>
	</xsl:template>

	<xsl:template match="str:WriteString32">
		<cpu:CopySIAddressToAXAndIncrementSI/>

		<cpu:CopyAXToDIAddressAndIncrementDI/>

		<cpu:CopyRegisterToOperand/>
		<op:AX-CXRegister/>

		<cpu:Repeat/>
		<cpu:CopySIAddressToDIAddressAndIncrementSIAndDI8/>
	</xsl:template>

	<xsl:template match="str:ReadString16">
		<cpu:Operand16/>
		<cpu:CopySIAddressToAXAndIncrementSI/>

		<cpu:PushSIToStack/>

		<cpu:AddImmediateToAX/>
		<int>4</int>

		<mm:CheckOut/>

		<cpu:PullSIFromStack/>
		<cpu:PushDIToStack/>

		<cpu:SubtractImmediateFromAL/>
		<int>4</int>

		<cpu:CopyAXToDIAddressAndIncrementDI/>

		<cpu:CopyRegisterToOperand/>
		<op:AX-CXRegister/>

		<cpu:Repeat/>
		<cpu:CopySIAddressToDIAddressAndIncrementSIAndDI8/>

		<cpu:PullDIFromStack/>
	</xsl:template>

	<xsl:template match="str:WriteString16">
		<cpu:Operand16/>
		<cpu:CopySIAddressToAXAndIncrementSI/>

		<cpu:Operand16/>
		<cpu:CopyAXToDIAddressAndIncrementDI/>

		<cpu:CopyRegisterToOperand/>
		<op:AX-CXRegister/>

		<cpu:Repeat/>
		<cpu:CopySIAddressToDIAddressAndIncrementSIAndDI8/>
	</xsl:template>

	<xsl:template match="str:ReadString8">
		<cpu:CopySIAddressToALAndIncrementSI/>

		<cpu:PushSIToStack/>

		<cpu:AddImmediateToAX/>
		<int>4</int>

		<mm:CheckOut/>

		<cpu:PullSIFromStack/>
		<cpu:PushDIToStack/>

		<cpu:SubtractImmediateFromAL/>
		<int>4</int>

		<cpu:CopyAXToDIAddressAndIncrementDI/>

		<cpu:CopyRegisterToOperand/>
		<op:AX-CXRegister/>

		<cpu:Repeat/>
		<cpu:CopySIAddressToDIAddressAndIncrementSIAndDI8/>

		<cpu:PullDIFromStack/>
	</xsl:template>

	<xsl:template match="str:WriteString8">
		<cpu:CopySIAddressToALAndIncrementSI/>

		<cpu:CopyALToDIAddressAndIncrementDI/>

		<cpu:CopyRegisterToOperand/>
		<op:AX-CXRegister/>

		<cpu:Repeat/>
		<cpu:CopySIAddressToDIAddressAndIncrementSIAndDI8/>
	</xsl:template>

	<xsl:template match="str:ReadCharacters">
		<cpu:PushSIToStack/>

		<cpu:AddImmediateToAX/>
		<int>4</int>

		<mm:CheckOut/>

		<cpu:PullSIFromStack/>
		<cpu:PushDIToStack/>

		<cpu:SubtractImmediateFromAL/>
		<int>4</int>

		<cpu:CopyAXToDIAddressAndIncrementDI/>

		<cpu:CopyRegisterToOperand/>
		<op:AX-CXRegister/>

		<cpu:Repeat/>
		<cpu:CopySIAddressToDIAddressAndIncrementSIAndDI8/>

		<cpu:PullDIFromStack/>
	</xsl:template>

	<xsl:template match="str:WriteCharacters">
		<cpu:CopyOperandToRegister/>
		<op:CX-SIAddress/>

		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToSIRegister/>
		<byte>4</byte>

		<cpu:Repeat/>
		<cpu:CopySIAddressToDIAddressAndIncrementSIAndDI8/>
		
		<!--TODO: Write null padded characters-->
	</xsl:template>

	<xsl:template match="str:ReadString">
	</xsl:template>

	<xsl:template match="str:WriteString">
	</xsl:template>
</xsl:stylesheet>
