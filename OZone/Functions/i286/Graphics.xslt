<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:gfx="http://metalx.org/i286/Functions/Graphics"
	xmlns:cat="http://metalx.org/i286/Functions/Catalog"
	xmlns:obj="http://metalx.org/i286/Functions/Object"
	xmlns:str="http://metalx.org/i286/Functions/String"
	xmlns:lst="http://metalx.org/i286/Functions/List"
	xmlns:sys="http://metalx.org/i286/Functions/System"
	xmlns:mm="http://metalx.org/i286/Functions/MemoryManager"
	xmlns:asc="http://metalx.org/Ansi/Ascii"
	xmlns:ari="http://metalx.org/Intel/80286/Arithmetic"
	xmlns:imm="http://metalx.org/Intel/80286/Immediate"
	xmlns:inc="http://metalx.org/Intel/80286/Increment"
	xmlns:math="http://metalx.org/Intel/80286/Math"
	xmlns:cpu="http://metalx.org/Intel/80286/Operators"
	xmlns:op="http://metalx.org/Intel/80286/Operands">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="gfx:DrawRectangle">
		<scope>
			<cpu:PushAXToStack/>

			<!--Get Y-->
			<cpu:MathImmediate8ToOperand16Function/>
			<math:AddToSIRegister/>
			<byte>2</byte>

			<cpu:CopyOperandToRegister16/>
			<op:AX-SIAddress/>

			<cpu:CopyImmediateToDX/>
			<short>0</short>

			<cpu:CopyImmediateToBX/>
			<short>320</short>

			<cpu:ArithmeticDXAXOperandFunction/>
			<ari:MultiplyByBXRegister/>

			<!--Get X-->
			<cpu:MathImmediate8ToOperand16Function/>
			<math:SubtractFromSIRegister/>
			<byte>2</byte>

			<cpu:AddOperandToRegister16/>
			<op:AX-SIAddress/>

			<cpu:CopyRegisterToOperand16/>
			<op:AX-DIRegister/>

			<!--Get Height-->
			<cpu:MathImmediate8ToOperand16Function/>
			<math:AddToSIRegister/>
			<byte>6</byte>

			<cpu:CopyOperandToRegister16/>
			<op:DX-SIAddress/>

			<cpu:DecrementDX/>

			<!--Get Width-->
			<cpu:MathImmediate8ToOperand16Function/>
			<math:SubtractFromSIRegister/>
			<byte>2</byte>

			<cpu:PullAXFromStack/>

			<!--Draw First Row-->
			<cpu:CopyOperandToRegister16/>
			<op:CX-SIAddress/>

			<cpu:IncrementCX/>

			<cpu:Repeat/>
			<cpu:CopyALToDIAddressAndIncrementDI/>

			<cpu:SubtractOperandFromRegister16/>
			<op:DI-SIAddress/>

			<cpu:DecrementDI/>

			<cpu:MathImmediateToOperandFunction16/>
			<math:AddToDIRegister/>
			<short>320</short>

			<!--Draw Middle Rows-->
			<label id="drawRow"/>

			<cpu:SegmentES/>
			<cpu:CopyRegisterToOperand8/>
			<op:AL-DIAddress/>

			<cpu:AddOperandToRegister16/>
			<op:DI-SIAddress/>

			<cpu:SegmentES/>
			<cpu:CopyRegisterToOperand8/>
			<op:AL-DIAddress/>

			<cpu:SubtractOperandFromRegister16/>
			<op:DI-SIAddress/>

			<cpu:MathImmediateToOperandFunction16/>
			<math:AddToDIRegister/>
			<short>320</short>

			<cpu:DecrementDX/>

			<cpu:BranchToRelativeIfNotZero8/>
			<addressOf ref="drawRow" type="Relative8"/>
			
			<!--Draw End Row-->
			<cpu:CopyOperandToRegister16/>
			<op:CX-SIAddress/>
			
			<cpu:IncrementCX/>

			<cpu:Repeat/>
			<cpu:CopyALToDIAddressAndIncrementDI/>
		</scope>
	</xsl:template>

	<xsl:template match="gfx:FillRectangle">
		<scope>
			<cpu:PushAXToStack/>

			<!--Get Y-->
			<cpu:MathImmediate8ToOperand16Function/>
			<math:AddToSIRegister/>
			<byte>2</byte>

			<cpu:CopyOperandToRegister16/>
			<op:AX-SIAddress/>

			<cpu:CopyImmediateToDX/>
			<short>0</short>

			<cpu:CopyImmediateToBX/>
			<short>320</short>

			<cpu:ArithmeticDXAXOperandFunction/>
			<ari:MultiplyByBXRegister/>

			<!--Get X-->
			<cpu:MathImmediate8ToOperand16Function/>
			<math:SubtractFromSIRegister/>
			<byte>2</byte>

			<cpu:AddOperandToRegister16/>
			<op:AX-SIAddress/>

			<cpu:CopyRegisterToOperand16/>
			<op:AX-DIRegister/>

			<!--Get Height-->
			<cpu:MathImmediate8ToOperand16Function/>
			<math:AddToSIRegister/>
			<byte>6</byte>

			<cpu:CopyOperandToRegister16/>
			<op:DX-SIAddress/>

			<!--Get Width-->
			<cpu:MathImmediate8ToOperand16Function/>
			<math:SubtractFromSIRegister/>
			<byte>2</byte>

			<cpu:PullAXFromStack/>

			<label id="drawRow"/>

			<cpu:CopyOperandToRegister16/>
			<op:CX-SIAddress/>

			<cpu:Repeat/>
			<cpu:CopyALToDIAddressAndIncrementDI/>

			<cpu:SubtractOperandFromRegister16/>
			<op:DI-SIAddress/>

			<cpu:MathImmediateToOperandFunction16/>
			<math:AddToDIRegister/>
			<short>320</short>

			<cpu:DecrementDX/>

			<cpu:BranchToRelativeIfNotZero8/>
			<addressOf ref="drawRow" type="Relative8"/>
		</scope>
	</xsl:template>
</xsl:stylesheet>
