<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:rect="http://metalx.org/i386/Functions/Rectangle"
	xmlns:asc="http://metalx.org/Ansi/Ascii"
	xmlns:ari="http://metalx.org/Intel/80386/Arithmetic"
	xmlns:imm="http://metalx.org/Intel/80386/Immediate"
	xmlns:inc="http://metalx.org/Intel/80386/Incremental"
	xmlns:math="http://metalx.org/Intel/80386/Math"
	xmlns:cpu="http://metalx.org/Intel/80386/Operators"
	xmlns:op="http://metalx.org/Intel/80386/Operands">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="rect:Contains">
		<scope>
			<!--Left-->
			<cpu:CompareSIAddressToDIAddressAndIncrementSIAndDI/>

			<cpu:BranchToRelative8IfGreater/>
			<addressOf ref="pointNotWithinRectangle" type="Relative8"/>

			<!--Top-->
			<cpu:CompareSIAddressToDIAddressAndIncrementSIAndDI/>

			<cpu:BranchToRelative8IfGreater/>
			<addressOf ref="pointNotWithinRectangle" type="Relative8"/>

			<!--Right-->
			<cpu:CopySIAddressToAXAndIncrementSI/>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:SubtractFromSIRegister/>
			<byte>12</byte>

			<cpu:AddOperandToRegister/>
			<op:AX-SIAddress/>

			<cpu:DecrementAX/>
			
			<cpu:MathImmediate8ToOperandFunction/>
			<math:SubtractFromDIRegister/>
			<byte>8</byte>

			<cpu:CompareAXToDIAddressAndIncrementDI/>

			<cpu:BranchToRelative8IfLess/>
			<addressOf ref="pointNotWithinRectangle" type="Relative8"/>

			<!--Bottom-->
			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToSIRegister/>
			<byte>4</byte>

			<cpu:CopySIAddressToAXAndIncrementSI/>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToSIRegister/>
			<byte>4</byte>

			<cpu:AddOperandToRegister/>
			<op:AX-SIAddress/>

			<cpu:DecrementAX/>

			<cpu:CompareAXToDIAddressAndIncrementDI/>
			
			<cpu:BranchToRelative8IfLess/>
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
