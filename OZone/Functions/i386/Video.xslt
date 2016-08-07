<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:vid="http://metalx.org/i386/Functions/Video"
	xmlns:crt="http://metalx.org/Pc/Video/Ports"
	xmlns:reg="http://metalx.org/Pc/Video/Registers"
	xmlns:cpu="http://metalx.org/Intel/80386/Operators"
	xmlns:op="http://metalx.org/Intel/80386/Operands"
	xmlns:imm="http://metalx.org/Intel/80386/Immediate"
	xmlns:math="http://metalx.org/Intel/80386/Math"
	xmlns:ari="http://metalx.org/Intel/80386/Arithmetic">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="vid:SetCursorPosition">
		<!--Store Position-->
		<cpu:CopyRegisterToOperand/>
		<op:AX-BXRegister/>

		<!--Write Cursor Position Low Register-->
		<cpu:Operand16/>
		<cpu:CopyImmediateToDX/>
		<crt:CrtRegisterIndex/>

		<cpu:CopyImmediateToAL/>
		<reg:CursorPositionLow/>

		<cpu:WriteALToDXPort/>

		<cpu:Operand16/>
		<cpu:CopyImmediateToDX/>
		<crt:CrtRegisterData/>

		<cpu:CopyRegisterToOperand8/>
		<op:BL-ALRegister/>

		<cpu:WriteALToDXPort/>

		<!--Write Cursor Position High Register-->
		<cpu:Operand16/>
		<cpu:CopyImmediateToDX/>
		<crt:CrtRegisterIndex/>

		<cpu:CopyImmediateToAL/>
		<reg:CursorPositionHigh/>

		<cpu:WriteALToDXPort/>

		<cpu:Operand16/>
		<cpu:CopyImmediateToDX/>
		<crt:CrtRegisterData/>

		<cpu:CopyRegisterToOperand8/>
		<op:BH-ALRegister/>

		<cpu:WriteALToDXPort/>

	</xsl:template>
	
	<!--<xsl:template match="vid:SetCursorPosition">
		<cpu:CopyImmediateToAH/>
		<byte>0</byte>

		<cpu:CopyImmediateToBH/>
		<byte>0</byte>

		<cpu:CopyImmediateToDL/>
		<byte>80</byte>

		<cpu:ArithmeticAXOperandFunction/>
		<ari:MultiplyByDLRegister/>

		<cpu:AddOperandToRegister/>
		<op:AX-BXRegister/>

		<cpu:PushAXToStack/>

		<cpu:Operand16/>
		<cpu:CopyImmediateToDX/>
		<crt:CrtRegisterIndex/>

		<cpu:CopyImmediateToAL/>
		<reg:CursorPositionLow/>

		<cpu:WriteALToDXPort/>

		<cpu:Operand16/>
		<cpu:CopyImmediateToDX/>
		<crt:CrtRegisterData/>

		<cpu:PullAXFromStack/>

		<cpu:WriteALToDXPort/>

	</xsl:template>-->
</xsl:stylesheet>
