<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:cpu="http://metalx.org/Intel/80286/Operators"
	xmlns:op="http://metalx.org/Intel/80286/Operands"
	xmlns:logic="http://metalx.org/Intel/80286/Logic"
	xmlns:obj="http://metalx.org/i286/Functions/Object"
	xmlns:mm="http://metalx.org/i286/Functions/MemoryManager">
	
    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

	<xsl:template match="obj:Create">
		<cpu:PushESToStack/>
		<cpu:PushDIToStack/>

		<mm:CheckOut length="8"/>

		<cpu:CopyRegisterToOperand16/>
		<op:BX-DIAddress/>

		<cpu:CopyRegisterToOperand16/>
		<op:AX-DIAddressPlusImmediate8/>
		<byte>6</byte>

		<cpu:PullAXFromStack/>

		<cpu:CopyRegisterToOperand16/>
		<op:AX-DIAddressPlusImmediate8/>
		<byte>2</byte>
		
		<cpu:PullAXFromStack/>

		<cpu:CopyRegisterToOperand16/>
		<op:AX-DIAddressPlusImmediate8/>
		<byte>4</byte>
	</xsl:template>

	<xsl:template match="obj:GetType">
		<cpu:CopyOperandToRegister16/>
		<op:SI-SIAddress/>
	</xsl:template>

	<xsl:template match="obj:GetLength">
		<cpu:CopyOperandToRegister16/>
		<op:AX-SIAddressPlusImmediate8/>
		<hex>6</hex>
	</xsl:template>

	<xsl:template match="obj:GetData">
		<cpu:LogicFunction/>
		<logic:PushSIAddressPlusImmediate8/>
		<byte>4</byte>
		
		<cpu:CopyOperandToRegister16/>
		<op:SI-SIAddressPlusImmediate8/>
		<byte>2</byte>

		<cpu:PullDSFromStack/>
	</xsl:template>
</xsl:stylesheet>
