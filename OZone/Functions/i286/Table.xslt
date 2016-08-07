<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:tbl="http://metalx.org/i286/Functions/Table"
	xmlns:mm="http://metalx.org/i286/Functions/MemoryManager"
	xmlns:math="http://metalx.org/Intel/80286/Math"
	xmlns:shift="http://metalx.org/Intel/80286/Shift"
	xmlns:inc="http://metalx.org/Intel/80286/Increment"
	xmlns:imm="http://metalx.org/Intel/80286/Immediate"
	xmlns:cpu="http://metalx.org/Intel/80286/Operators"
	xmlns:op="http://metalx.org/Intel/80286/Operands">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="tbl:Create">
		<xsl:choose>
			<xsl:when test="@length">
				<xsl:element name="mm:CheckOut">
					<xsl:attribute name="length">
						<xsl:value-of select="2+(@length*4)"/>
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

	<xsl:template match="tbl:GetLength">
		<!--Set AX to the value at SI-->
		<cpu:CopyOperandToRegister16/>
		<op:AX-SIAddress/>
	</xsl:template>

	<xsl:template match="tbl:Set">
		<scope>
			<!--Save SI-->
			<cpu:CopyRegisterToOperand16/>
			<op:SI-DXRegister/>

			<!--Copy table length to CX-->
			<cpu:CopyOperandToRegister16/>
			<op:CX-SIAddress/>

			<!--Compare items-->
			<label id="nextRow"/>

			<cpu:IncrementSI/>
			<cpu:IncrementSI/>

			<cpu:MathImmediateToOperandFunction16/>
			<math:CompareWithSIAddress/>
			<short>0</short>

			<cpu:BranchToRelativeIfEqual8/>
			<addressOf ref="nextRow" type="Relative8"/>

			<!--Save Registers-->
			<cpu:PushSIToStack/>
			<cpu:PushDIToStack/>
			<cpu:PushCXToStack/>

			<!--Dereference SI to key-->
			<cpu:CopyOperandToRegister16/>
			<op:SI-SIAddress/>

			<!--Get String Length-->
			<cpu:CopyOperandToRegister16/>
			<op:CX-DIAddress/>

			<!--Include Length Field-->
			<cpu:IncrementCX/>
			<cpu:IncrementCX/>

			<cpu:RepeatWhileEqual/>
			<cpu:CompareSIAddressToDIAddressAndIncrementSIAndDI8/>

			<!--Restore SI an DI-->
			<cpu:PullCXFromStack/>
			<cpu:PullDIFromStack/>
			<cpu:PullSIFromStack/>

			<cpu:LoopToRelativeWhileNotEqual8/>
			<addressOf ref="nextRow" type="Relative8"/>

			<cpu:BranchToRelativeIfEqual8/>
			<addressOf ref="found" type="Relative8"/>

			<!--Find empty row-->

			<!--Restore SI-->
			<cpu:CopyRegisterToOperand16/>
			<op:DX-SIRegister/>

			<!--Copy table length to CX-->
			<cpu:CopyOperandToRegister16/>
			<op:CX-SIAddress/>

			<!--Move to first item-->
			<cpu:IncrementSI/>
			<cpu:IncrementSI/>

			<!--Compare items-->
			<label id="findNextRow"/>

			<cpu:MathImmediateToOperandFunction16/>
			<math:CompareWithSIAddress/>
			<short>0</short>

			<cpu:BranchToRelativeIfEqual8/>
			<addressOf ref="found" type="Relative8"/>

			<cpu:IncrementSI/>
			<cpu:IncrementSI/>
			<cpu:IncrementSI/>
			<cpu:IncrementSI/>

			<cpu:LoopToRelative8/>
			<addressOf ref="findNextRow" type="Relative8"/>

			<cpu:JumpToRelative8/>
			<addressOf ref="end" type="Relative8"/>

			<!--Update value-->
			<label id="found"/>
			<cpu:IncrementSI/>
			<cpu:IncrementSI/>

			<cpu:CopyRegisterToOperand16/>
			<op:AX-SIAddress/>

			<label id="end"/>
		</scope>
	</xsl:template>

	<xsl:template match="tbl:Get">
		<scope>
			<!--Copy table length to CX-->
			<cpu:CopyOperandToRegister16/>
			<op:CX-SIAddress/>

			<!--Move to first item-->
			<cpu:IncrementSI/>
			<cpu:IncrementSI/>

			<!--Next Row-->
			<label id="nextRow"/>

			<cpu:MathImmediateToOperandFunction16/>
			<math:CompareWithSIAddress/>
			<short>0</short>

			<cpu:BranchToRelativeIfEqual8/>
			<addressOf ref="nextRow" type="Relative8"/>

			<!--Save Registers-->
			<cpu:PushSIToStack/>
			<cpu:PushDIToStack/>
			<cpu:PushCXToStack/>

			<!--Dereference SI to key-->
			<cpu:CopyOperandToRegister16/>
			<op:SI-SIAddress/>

			<!--Compare Keys-->
			<cpu:CopyOperandToRegister16/>
			<op:CX-DIAddress/>

			<cpu:IncrementCX/>
			<cpu:IncrementCX/>

			<cpu:RepeatWhileEqual/>
			<cpu:CompareSIAddressToDIAddressAndIncrementSIAndDI8/>

			<cpu:PullCXFromStack/>
			<cpu:PullDIFromStack/>
			<cpu:PullSIFromStack/>

			<cpu:BranchToRelativeIfEqual8/>
			<addressOf ref="found" type="Relative8"/>

			<cpu:IncrementSI/>
			<cpu:IncrementSI/>
			<cpu:IncrementSI/>
			<cpu:IncrementSI/>

			<cpu:LoopToRelative8/>
			<addressOf ref="nextRow" type="Relative8"/>

			<cpu:BranchToRelativeIfNotEqual8/>
			<addressOf ref="end" type="Relative8"/>

			<label id="found"/>

			<cpu:PushFlagsToStack/>

			<cpu:IncrementSI/>
			<cpu:IncrementSI/>

			<cpu:CopyOperandToRegister16/>
			<op:SI-SIAddress/>

			<cpu:PullFlagsFromStack/>

			<label id="end"/>
		</scope>
	</xsl:template>

	<xsl:template match="tbl:ForEach">
		<scope>
			<cpu:CopyOperandToRegister16/>
			<op:CX-SIAddress/>

			<cpu:MathImmediate8ToOperand16Function/>
			<math:CompareWithCXRegister/>
			<byte>0</byte>

			<cpu:BranchToRelativeIfEqual8/>
			<addressOf ref="end" type="Relative8"/>
			
			<cpu:IncrementSI/>
			<cpu:IncrementSI/>

			<label id="start"/>

			<xsl:apply-templates select="@* | node()"/>

			<cpu:IncrementSI/>
			<cpu:IncrementSI/>
			<cpu:IncrementSI/>
			<cpu:IncrementSI/>
			
			<cpu:LoopToRelative8/>
			<addressOf ref="start" type="Relative8"/>

			<label id="end"/>
		</scope>
	</xsl:template>
</xsl:stylesheet>
