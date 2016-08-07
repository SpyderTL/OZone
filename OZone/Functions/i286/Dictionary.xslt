<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:tbl="http://metalx.org/i286/Functions/Table"
	xmlns:dict="http://metalx.org/i286/Functions/Dictionary"
	xmlns:inc="http://metalx.org/Intel/80286/Increment"
	xmlns:imm="http://metalx.org/Intel/80286/Immediate"
	xmlns:mm="http://metalx.org/i286/Functions/MemoryManager"
	xmlns:cpu="http://metalx.org/Intel/80286/Operators"
	xmlns:op="http://metalx.org/Intel/80286/Operands">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="dict:Create">
		<mm:CheckOut length="4"/>

		<cpu:PushDIToStack/>
		<cpu:PushDIToStack/>

		<cpu:CopyRegisterToOperand16/>
		<op:AX-DIRegister/>
		
		<xsl:choose>
			<xsl:when test="@capacity">
				<xsl:element name="tbl:Create">
					<xsl:attribute name="length">
						<xsl:value-of select="@capacity"/>
					</xsl:attribute>
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>
				<tbl:Create/>
			</xsl:otherwise>
		</xsl:choose>

		<cpu:PullSIFromStack/>

		<cpu:IncrementSI/>
		<cpu:IncrementSI/>
		
		<cpu:CopyRegisterToOperand16/>
		<op:DI-SIAddress/>

		<cpu:PullDIFromStack/>
	</xsl:template>

	<xsl:template match="dict:Clear">
		<!--Reset buffer length-->
		<cpu:CopyImmediateToOperandFunction16/>
		<imm:CopyImmediateToSIAddress/>
		<short>0</short>
	</xsl:template>

	<xsl:template match="dict:GetCount">
		<!--Set AL to the value at SI-->
		<cpu:CopyOperandToRegister16/>
		<op:AX-SIAddress/>
	</xsl:template>

	<xsl:template match="dict:GetItems">
		<!--Move SI to items field-->
		<cpu:IncrementSI/>
		<cpu:IncrementSI/>

		<!--Dereference SI to items-->
		<cpu:CopyOperandToRegister16/>
		<op:SI-SIAddress/>
	</xsl:template>

</xsl:stylesheet>
