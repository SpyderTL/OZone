<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:dbg="http://metalx.org/i286/Functions/Debug"
	xmlns:con="http://metalx.org/i286/Functions/Console"
	xmlns:cpu="http://metalx.org/Intel/80286/Operators"
	xmlns:op="http://metalx.org/Intel/80286/Operands">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="dbg:Break">
		<cpu:ClearInterruptFlag/>
		<cpu:HaltProcessing/>
	</xsl:template>

	<xsl:template match="dbg:Print">
		<cpu:PushAllRegistersToStack/>

		<con:WriteText endLine="true">
			<xsl:value-of select="text()"/>
		</con:WriteText>

		<cpu:PullAllRegistersFromStack/>
	</xsl:template>

	<xsl:template match="dbg:PrintAX">
		<cpu:PushAllRegistersToStack/>

		<con:WriteShort endLine="true"/>

		<cpu:PullAllRegistersFromStack/>
	</xsl:template>

	<xsl:template match="dbg:PrintBX">
		<cpu:PushAllRegistersToStack/>

		<cpu:CopyRegisterToOperand16/>
		<op:BX-AXRegister/>

		<con:WriteShort endLine="true"/>

		<cpu:PullAllRegistersFromStack/>
	</xsl:template>

	<xsl:template match="dbg:PrintCX">
		<cpu:PushAllRegistersToStack/>

		<cpu:CopyRegisterToOperand16/>
		<op:CX-AXRegister/>

		<con:WriteShort endLine="true"/>

		<cpu:PullAllRegistersFromStack/>
	</xsl:template>

	<xsl:template match="dbg:PrintDX">
		<cpu:PushAllRegistersToStack/>

		<cpu:CopyRegisterToOperand16/>
		<op:DX-AXRegister/>

		<con:WriteShort endLine="true"/>

		<cpu:PullAllRegistersFromStack/>
	</xsl:template>

	<xsl:template match="dbg:PrintSI">
		<cpu:PushAllRegistersToStack/>

		<cpu:CopyRegisterToOperand16/>
		<op:SI-AXRegister/>

		<con:WriteShort endLine="true"/>

		<cpu:PullAllRegistersFromStack/>
	</xsl:template>

	<xsl:template match="dbg:PrintDI">
		<cpu:PushAllRegistersToStack/>

		<cpu:CopyRegisterToOperand16/>
		<op:DI-AXRegister/>

		<con:WriteShort endLine="true"/>

		<cpu:PullAllRegistersFromStack/>
	</xsl:template>

	<xsl:template match="dbg:PrintAXHex">
		<cpu:PushAllRegistersToStack/>

		<con:WriteShortHex endLine="true"/>

		<cpu:PullAllRegistersFromStack/>
	</xsl:template>

	<xsl:template match="dbg:PrintBXHex">
		<cpu:PushAllRegistersToStack/>

		<cpu:CopyRegisterToOperand16/>
		<op:BX-AXRegister/>

		<con:WriteShortHex endLine="true"/>

		<cpu:PullAllRegistersFromStack/>
	</xsl:template>

	<xsl:template match="dbg:PrintCXHex">
		<cpu:PushAllRegistersToStack/>

		<cpu:CopyRegisterToOperand16/>
		<op:CX-AXRegister/>

		<con:WriteShortHex endLine="true"/>

		<cpu:PullAllRegistersFromStack/>
	</xsl:template>

	<xsl:template match="dbg:PrintDXHex">
		<cpu:PushAllRegistersToStack/>

		<cpu:CopyRegisterToOperand16/>
		<op:DX-AXRegister/>

		<con:WriteShortHex endLine="true"/>

		<cpu:PullAllRegistersFromStack/>
	</xsl:template>

	<xsl:template match="dbg:PrintSIHex">
		<cpu:PushAllRegistersToStack/>

		<cpu:CopyRegisterToOperand16/>
		<op:SI-AXRegister/>

		<con:WriteShortHex endLine="true"/>

		<cpu:PullAllRegistersFromStack/>
	</xsl:template>

	<xsl:template match="dbg:PrintDIHex">
		<cpu:PushAllRegistersToStack/>

		<cpu:CopyRegisterToOperand16/>
		<op:DI-AXRegister/>

		<con:WriteShortHex endLine="true"/>

		<cpu:PullAllRegistersFromStack/>
	</xsl:template>

</xsl:stylesheet>
