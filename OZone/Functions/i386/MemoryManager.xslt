<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:mm="http://metalx.org/i386/Functions/MemoryManager"
	xmlns:cpu="http://metalx.org/Intel/80386/Operators"
	xmlns:op="http://metalx.org/Intel/80386/Operands"
	xmlns:imm="http://metalx.org/Intel/80386/Immediate"
	xmlns:math="http://metalx.org/Intel/80386/Math">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template name="MemoryManagerAddress">
		<hex>01100000</hex>
	</xsl:template>

	<xsl:template match="mm:Reset">
		<!--Set memory manager pointer to the default value-->
		<cpu:CopyImmediateToAX/>
		<xsl:call-template name="MemoryManagerAddress"/>

		<cpu:AddImmediateToAX/>
		<int>4</int>
		
		<cpu:CopyAXToAbsoluteMemory/>
		<xsl:call-template name="MemoryManagerAddress"/>
	</xsl:template>
	
	<xsl:template match="mm:CheckOut">
		<cpu:CopyOperandToRegister/>
		<op:DI-ImmediateAddress/>
		<xsl:call-template name="MemoryManagerAddress"/>

		<xsl:choose>
			<xsl:when test="@length">
				<!--Increment the memory segment offset for the next object-->
				<cpu:MathImmediateToOperandFunction/>
				<math:AddToImmediateAddress/>
				<xsl:call-template name="MemoryManagerAddress"/>
				<int>
					<xsl:value-of select="@length"/>
				</int>
			</xsl:when>
			<xsl:otherwise>
				<cpu:AddRegisterToOperand/>
				<op:AX-ImmediateAddress/>
				<xsl:call-template name="MemoryManagerAddress"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="mm:CheckIn">
	</xsl:template>
</xsl:stylesheet>
