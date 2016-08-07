<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:rect="http://metalx.org/i286/Functions/Rectangle"
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

	<xsl:template match="rect:Contains">
		<scope>
			<!--Left-->
			<cpu:CompareSIAddressToDIAddressAndIncrementSIAndDI16/>

			<cpu:BranchToRelativeIfGreater8/>
			<addressOf ref="pointNotWithinRectangle" type="Relative8"/>

			<!--Top-->
			<cpu:CompareSIAddressToDIAddressAndIncrementSIAndDI16/>

			<cpu:BranchToRelativeIfGreater8/>
			<addressOf ref="pointNotWithinRectangle" type="Relative8"/>

			<!--Right-->
			<cpu:CopySIAddressToAXAndIncrementSI/>

			<cpu:MathImmediate8ToOperand16Function/>
			<math:SubtractFromSIRegister/>
			<byte>6</byte>

			<cpu:AddOperandToRegister16/>
			<op:AX-SIAddress/>
			
			<cpu:MathImmediate8ToOperand16Function/>
			<math:SubtractFromDIRegister/>
			<byte>4</byte>

			<cpu:CompareAXToDIAddressAndIncrementDI/>

			<cpu:BranchToRelativeIfLess8/>
			<addressOf ref="pointNotWithinRectangle" type="Relative8"/>

			<!--Bottom-->
			<cpu:MathImmediate8ToOperand16Function/>
			<math:AddToSIRegister/>
			<byte>2</byte>

			<cpu:CopySIAddressToAXAndIncrementSI/>

			<cpu:MathImmediate8ToOperand16Function/>
			<math:AddToSIRegister/>
			<byte>2</byte>

			<cpu:AddOperandToRegister16/>
			<op:AX-SIAddress/>

			<cpu:CompareAXToDIAddressAndIncrementDI/>
			
			<cpu:BranchToRelativeIfLess8/>
			<addressOf ref="pointNotWithinRectangle" type="Relative8"/>

			<cpu:SetCarryFlag/>

			<cpu:JumpToRelative8/>
			<addressOf ref="end" type="Relative8"/>

			<label id="pointNotWithinRectangle"/>

			<cpu:ClearCarryFlag/>
			
			<label id="end"/>
		</scope>
	</xsl:template>
</xsl:stylesheet>
