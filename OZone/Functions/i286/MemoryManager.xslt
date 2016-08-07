<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:mm="http://metalx.org/i286/Functions/MemoryManager"
	xmlns:cpu="http://metalx.org/Intel/80286/Operators"
	xmlns:op="http://metalx.org/Intel/80286/Operands"
	xmlns:imm="http://metalx.org/Intel/80286/Immediate"
	xmlns:math="http://metalx.org/Intel/80286/Math">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="mm:Reset">
		<!--Set memory manager pointer back to default value-->
		<cpu:CopyOperandToRegister16/>
		<op:AX-SIRegister/>

		<cpu:IncrementAX/>
		<cpu:IncrementAX/>

		<cpu:CopyRegisterToOperand16/>
		<op:AX-SIAddress/>
	</xsl:template>
	
	<xsl:template match="mm:CheckOut">
		<cpu:PushDSToStack/>
		<cpu:PullESFromStack/>
		
		<cpu:CopyOperandToRegister16/>
		<op:DI-SIAddress/>
		
		<xsl:choose>
			<xsl:when test="@length">
				<!--Increment the memory segment offset for the next object-->
				<cpu:MathImmediateToOperandFunction16/>
				<math:AddToSIAddress/>
				<short>
					<xsl:value-of select="@length"/>
				</short>
			</xsl:when>
			<xsl:otherwise>
				<cpu:AddRegisterToOperand16/>
				<op:AX-SIAddress/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="mm:CheckIn">
	</xsl:template>
</xsl:stylesheet>
