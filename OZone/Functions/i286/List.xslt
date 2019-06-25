<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:lst="http://metalx.org/i286/Functions/List"
	xmlns:inc="http://metalx.org/Intel/80286/Increment"
	xmlns:imm="http://metalx.org/Intel/80286/Immediate"
	xmlns:math="http://metalx.org/Intel/80286/Math"
	xmlns:obj="http://metalx.org/i286/Functions/Object"
	xmlns:clsf="http://metalx.org/i286/Functions/Class"
	xmlns:con="http://metalx.org/i286/Functions/Console"
	xmlns:cat="http://metalx.org/i286/Functions/Catalog"
	xmlns:shift="http://metalx.org/Intel/80286/Shift"
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

	<xsl:template match="lst:Create">
		<xsl:choose>
			<xsl:when test="@length">
				<xsl:element name="mm:CheckOut">
					<xsl:attribute name="length">
						<xsl:value-of select="2+(@length*2)"/>
					</xsl:attribute>
				</xsl:element>
				
				<!--Set length field-->
				<cpu:CopyImmediateToOperandFunction16/>
				<imm:CopyImmediateToDIAddress/>
				<short>
					<xsl:value-of select="@length"/>
				</short>
			</xsl:when>
			<xsl:otherwise>
				<cpu:PushAXToStack/>

				<cpu:ShiftRegisterByOneFunction16/>
				<shift:ShiftAXRegisterLeft/>

				<cpu:IncrementAX/>
				<cpu:IncrementAX/>

				<mm:CheckOut/>

				<!--Set length field-->
				<cpu:PullAXFromStack/>

				<cpu:CopyRegisterToOperand16/>
				<op:AX-DIAddress/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="lst:CreateObject">
		<scope>
			<!--Get Item Count-->
			<cpu:CopyOperandToRegister16/>
			<op:AX-DIAddress/>

			<cpu:IncrementAX/>

			<cpu:ShiftRegisterByOneFunction16/>
			<shift:ShiftAXRegisterLeft/>

			<cpu:PushAXToStack/>
			<!--<cpu:PushDSToStack/>-->
			<cpu:PushSIToStack/>
			<!--<cpu:PushESToStack/>-->
			<cpu:PushDIToStack/>

			<!--<cpu:PushImmediateToStack16/>
			<addressOf ref="className" type="Segment16"/>

			<cpu:PullESFromStack/>-->
			
			<cpu:CopyImmediateToDI/>
			<addressOf ref="className" type="Absolute16"/>

			<sys:GetCatalog/>

			<cat:FindType/>

			<cpu:CopyRegisterToOperand16/>
			<op:SI-BXRegister/>

			<cpu:PullDIFromStack/>
			<!--<cpu:PullESFromStack/>-->
			<cpu:PullSIFromStack/>
			<!--<cpu:PullDSFromStack/>-->
			<cpu:PullAXFromStack/>
			
			<obj:Create/>

			<cpu:JumpToRelative8/>
			<addressOf ref="end" type="Relative8"/>

			<label id="className"/>
			<short>22</short>
			<string>http://metalx.org/List</string>

			<label id="end"/>
		</scope>
	</xsl:template>

	<xsl:template match="lst:GetLength">
		<!--Set AX to the value at SI-->
		<cpu:CopyOperandToRegister16/>
		<op:AX-SIAddress/>
	</xsl:template>

	<xsl:template match="lst:GetItem">
		<cpu:IncrementSI/>
		<cpu:IncrementSI/>

		<!--Move SI to index-->
		<cpu:AddRegisterToOperand16/>
		<op:AX-SIRegister/>

		<cpu:AddRegisterToOperand16/>
		<op:AX-SIRegister/>

		<!--Dereference SI to value-->
		<cpu:CopyOperandToRegister16/>
		<op:SI-SIAddress/>
	</xsl:template>

	<xsl:template match="lst:SetItem">
		<cpu:IncrementSI/>
		<cpu:IncrementSI/>

		<!--Move SI to index-->
		<cpu:AddRegisterToOperand16/>
		<op:AX-SIRegister/>

		<cpu:AddRegisterToOperand16/>
		<op:AX-SIRegister/>

		<cpu:CopyRegisterToOperand16/>
		<op:DI-SIAddress/>
	</xsl:template>

	<xsl:template match="lst:ForEach">
		<scope>
			<cpu:CopyOperandToRegister16/>
			<op:CX-SIAddress/>

			<cpu:MathImmediate8ToOperand16Function/>
			<math:CompareWithCXRegister/>
			<byte>0</byte>

			<cpu:BranchToRelativeIfNotEqual8/>
			<addressOf ref="start" type="Relative8"/>

			<cpu:JumpToRelative16/>
			<addressOf ref="end" type="Relative16"/>

			<label id="start"/>

			<cpu:IncrementSI/>
			<cpu:IncrementSI/>

			<cpu:CopyRegisterToOperand16/>
			<op:SI-DXRegister/>

			<cpu:CopyOperandToRegister16/>
			<op:SI-SIAddress/>

			<xsl:apply-templates select="@* | node()"/>

			<cpu:CopyRegisterToOperand16/>
			<op:DX-SIRegister/>

			<cpu:LoopToRelative8/>
			<addressOf ref="start" type="Relative8"/>

			<label id="end"/>
		</scope>
	</xsl:template>

</xsl:stylesheet>
