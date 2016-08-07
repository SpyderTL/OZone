<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:lst="http://metalx.org/i286/Functions/List"
	xmlns:col="http://metalx.org/i286/Functions/Collection"
	xmlns:inc="http://metalx.org/Intel/80286/Increment"
	xmlns:imm="http://metalx.org/Intel/80286/Immediate"
	xmlns:mm="http://metalx.org/i286/Functions/MemoryManager"
	xmlns:sys="http://metalx.org/i286/Functions/System"
	xmlns:cpu="http://metalx.org/Intel/80286/Operators"
	xmlns:op="http://metalx.org/Intel/80286/Operands">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="col:Create">
		<mm:CheckOut length="4"/>

		<!--Save Collection-->
		<cpu:CopyRegisterToOperand16/>
		<op:DI-DXRegister/>

		<!--Create List-->
		<xsl:choose>
			<xsl:when test="@capacity">
				<xsl:element name="lst:Create">
					<xsl:attribute name="length">
						<xsl:value-of select="@capacity"/>
					</xsl:attribute>
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>
				<lst:Create/>
			</xsl:otherwise>
		</xsl:choose>

		<!--Restore Collection-->
		<cpu:CopyRegisterToOperand16/>
		<op:DX-SIRegister/>

		<!--Store List Address-->
		<cpu:IncrementSI/>
		<cpu:IncrementSI/>

		<cpu:CopyRegisterToOperand16/>
		<op:DI-SIAddress/>

		<!--Set Count-->
		<cpu:CopyRegisterToOperand16/>
		<op:DX-DIRegister/>

		<cpu:CopyImmediateToOperandFunction16/>
		<imm:CopyImmediateToDIAddress/>
		<short>0</short>
	</xsl:template>

	<xsl:template match="col:Clear">
		<!--Increase buffer length-->
		<cpu:CopyImmediateToOperandFunction16/>
		<imm:CopyImmediateToSIAddress/>
		<short>0</short>
	</xsl:template>

	<xsl:template match="col:GetCount">
		<!--Set AL to the value at SI-->
		<cpu:CopyOperandToRegister16/>
		<op:AX-SIAddress/>
	</xsl:template>

	<xsl:template match="col:Add">
		<!--Increase length-->
		<cpu:IncrementFunction16/>
		<inc:IncrementDIAddress/>

		<!--Set CX to length-->
		<cpu:CopyOperandToRegister16/>
		<op:CX-DIAddress/>

		<!--Move to list field-->
		<cpu:IncrementDI/>
		<cpu:IncrementDI/>

		<!--Dereference DI to list-->
		<cpu:CopyOperandToRegister16/>
		<op:DI-DIAddress/>

		<!--Jump to next value-->
		<cpu:AddRegisterToOperand16/>
		<op:CX-DIRegister/>

		<cpu:AddRegisterToOperand16/>
		<op:CX-DIRegister/>

		<!--Set Pointer-->
		<cpu:CopyRegisterToOperand16/>
		<op:SI-DIAddress/>
	</xsl:template>

	<xsl:template match="col:GetItems">
		<!--Move SI to items field-->
		<cpu:IncrementSI/>
		<cpu:IncrementSI/>

		<!--Dereference SI to items-->
		<cpu:CopyOperandToRegister16/>
		<op:SI-SIAddress/>
	</xsl:template>

</xsl:stylesheet>
