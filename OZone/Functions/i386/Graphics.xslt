<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:gfx="http://metalx.org/i386/Functions/Graphics"
	xmlns:cat="http://metalx.org/x86/Catalog/Functions"
	xmlns:obj="http://metalx.org/x86/Object/Functions"
	xmlns:str="http://metalx.org/x86/String/Functions"
	xmlns:lst="http://metalx.org/x86/List/Functions"
	xmlns:sys="http://metalx.org/x86/System/Functions"
	xmlns:mm="http://metalx.org/x86/MemoryManager/Functions"
	xmlns:asc="http://metalx.org/Ansi/Ascii"
	xmlns:ari="http://metalx.org/Intel/80386/Arithmetic"
	xmlns:imm="http://metalx.org/Intel/80386/Immediate"
	xmlns:inc="http://metalx.org/Intel/80386/Incremental"
	xmlns:math="http://metalx.org/Intel/80386/Math"
	xmlns:shift="http://metalx.org/Intel/80386/Shift"
	xmlns:cpu="http://metalx.org/Intel/80386/Operators"
	xmlns:op="http://metalx.org/Intel/80386/Operands">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="gfx:ClearScreen">
		<scope>
			<cpu:CopyImmediateToCX/>
			<int>1310720</int>

			<cpu:Repeat/>
			<cpu:CopyAXToDIAddressAndIncrementDI/>
		</scope>
	</xsl:template>

	<xsl:template match="gfx:DrawPixel">
		<scope>
			<cpu:PushAXToStack/>

			<!--Get Y-->
			<cpu:CopyOperandToRegister/>
			<op:AX-SIAddressPlusImmediate8/>
			<byte>4</byte>

			<cpu:CopyImmediateToDX/>
			<int>0</int>

			<cpu:CopyImmediateToBX/>
			<!--<int>1280</int>-->
			<int>1024</int>
			<!--<int>800</int>-->

			<cpu:ArithmeticDXAXOperandFunction/>
			<ari:MultiplyByBXRegister/>

			<!--Get X-->
			<cpu:AddOperandToRegister/>
			<op:AX-SIAddress/>

			<cpu:ShiftRegisterByImmediate8Function/>
			<shift:ShiftAXRegisterLeft/>
			<byte>2</byte>

			<cpu:AddRegisterToOperand/>
			<op:AX-DIRegister/>

			<cpu:PullAXFromStack/>

			<cpu:CopyAXToDIAddressAndIncrementDI/>
		</scope>
	</xsl:template>

	<xsl:template match="gfx:DrawLine">
		<scope>
			<cpu:PushAXToStack/>
			
			<!--Swap Points By Y If Needed-->
			<cpu:CopyOperandToRegister/>
			<op:AX-BXAddressPlusImmediate8/>
			<byte>4</byte>

			<cpu:CompareRegisterToOperand/>
			<op:AX-DXAddressPlusImmediate8/>
			<byte>4</byte>

			<cpu:BranchToRelativeIfLess8/>
			<addressOf ref="skipSwapPoints" type="Relative8"/>

			<cpu:ExchangeOperandWithRegister/>
			<op:BX-DXRegister/>

			<label id="skipSwapPoints"/>

			<!--Swap Direction By X If Needed-->
			<cpu:CopyOperandToRegister/>
			<op:AX-BXAddress/>

			<cpu:CompareRegisterToOperand/>
			<op:AX-DXAddress/>

			<cpu:BranchToRelativeIfLessOrEqual8/>
			<addressOf ref="skipSwapDirection" type="Relative8"/>

			<cpu:SetDirectionFlag/>

			<label id="skipSwapDirection"/>
			
			<cpu:PushBXToStack/>
			<cpu:PushDXToStack/>

			<!--Get Y-->
			<cpu:CopyOperandToRegister/>
			<op:AX-BXAddressPlusImmediate8/>
			<byte>4</byte>

			<cpu:CopyImmediateToDX/>
			<int>0</int>

			<cpu:CopyImmediateToBX/>
			<!--<int>1280</int>-->
			<int>1024</int>
			<!--<int>800</int>-->

			<cpu:ArithmeticDXAXOperandFunction/>
			<ari:MultiplyByBXRegister/>

			<!--Get X-->
			<cpu:PullDXFromStack/>
			<cpu:PullBXFromStack/>

			<cpu:AddOperandToRegister/>
			<op:AX-BXAddress/>

			<cpu:ShiftRegisterByImmediate8Function/>
			<shift:ShiftAXRegisterLeft/>
			<byte>2</byte>

			<cpu:AddRegisterToOperand/>
			<op:AX-DIRegister/>
			
			<!--Get Slope-->
			<cpu:CopyOperandToRegister/>
			<op:AX-DXAddress/>

			<cpu:SubtractOperandFromRegister/>
			<op:AX-BXAddress/>

			<cpu:PushAXToStack/>

			<cpu:CopyOperandToRegister/>
			<op:DX-DXAddressPlusImmediate8/>
			<byte>4</byte>

			<cpu:SubtractOperandFromRegister/>
			<op:DX-BXAddressPlusImmediate8/>
			<byte>4</byte>

			<cpu:PullBXFromStack/>
			
			<cpu:MathImmediateToOperandFunction/>
			<math:CompareWithBXRegister/>
			<int>0</int>

			<cpu:BranchToRelative8IfGreaterOrEqual/>
			<addressOf ref="skipInvert" type="Relative8"/>

			<cpu:ArithmeticDXAXOperandFunction/>
			<ari:NegateWithBXRegister/>
			
			<label id="skipInvert"/>

			<cpu:ShiftRegisterByOneFunction/>
			<shift:ShiftBXRegisterLeft/>

			<cpu:ShiftRegisterByOneFunction/>
			<shift:ShiftDXRegisterLeft/>

			<cpu:CompareRegisterToOperand/>
			<op:BX-DXRegister/>

			<cpu:BranchToRelativeIfLess8/>
			<addressOf ref="verticalLine" type="Relative8"/>
			
			<cpu:CopyRegisterToOperand/>
			<op:BX-SIRegister/>

			<cpu:CopyRegisterToOperand/>
			<op:BX-CXRegister/>

			<cpu:ShiftRegisterByOneFunction/>
			<shift:ShiftCXRegisterRight/>

			
			<cpu:IncrementCX/>

			<cpu:PullAXFromStack/>

			<label id="drawHorizontalPixel">
				<cpu:CopyAXToDIAddressAndIncrementDI/>

				<cpu:SubtractOperandFromRegister/>
				<op:BX-DXRegister/>

				<cpu:BranchToRelative8IfGreater/>
				<addressOf ref="skipNextHorizontalLine" type="Relative8"/>

				<cpu:MathImmediateToOperandFunction/>
				<math:AddToDIRegister/>
				<!--<int>5120</int>-->
				<int>4096</int>
				<!--<int>3200</int>-->

				<cpu:AddOperandToRegister/>
				<op:BX-SIRegister/>

				<label id="skipNextHorizontalLine"/>

				<cpu:LoopToRelative8/>
				<addressOf ref="drawHorizontalPixel" type="Relative8"/>

				<cpu:JumpToRelative8/>
				<addressOf ref="exit" type="Relative8"/>
			</label>

			<label id="verticalLine"/>

			<cpu:CopyRegisterToOperand/>
			<op:DX-SIRegister/>

			<cpu:CopyRegisterToOperand/>
			<op:DX-CXRegister/>

			<cpu:ShiftRegisterByOneFunction/>
			<shift:ShiftCXRegisterRight/>

			<cpu:IncrementCX/>
			
			<cpu:PullAXFromStack/>

			<label id="drawVerticalPixel">
				<!--<cpu:CopyAXToDIAddressAndIncrementDI/>-->

				<cpu:CopyRegisterToOperand/>
				<op:AX-DIAddress/>
				
				<cpu:MathImmediateToOperandFunction/>
				<math:AddToDIRegister/>
				<!--<int>5120</int>-->
				<int>4096</int>
				<!--<int>3200</int>-->

				<cpu:SubtractOperandFromRegister/>
				<op:DX-BXRegister/>

				<cpu:BranchToRelative8IfGreater/>
				<addressOf ref="skipNextVerticalLine" type="Relative8"/>

				<!--<cpu:MathImmediateToOperandFunction/>
				<math:AddToDIRegister/>
				<int>5120</int>-->

				<cpu:CompareAXToDIAddressAndIncrementDI/>

				<cpu:AddOperandToRegister/>
				<op:DX-SIRegister/>

				<label id="skipNextVerticalLine"/>

				<cpu:LoopToRelative8/>
				<addressOf ref="drawVerticalPixel" type="Relative8"/>
			</label>

			<label id="exit"/>
			
			<cpu:ClearDirectionFlag/>
		</scope>
	</xsl:template>

	<xsl:template match="gfx:DrawRectangle">
		<scope>
			<cpu:PushAXToStack/>

			<!--Get Y-->
			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToSIRegister/>
			<byte>4</byte>

			<cpu:CopyOperandToRegister/>
			<op:AX-SIAddress/>

			<cpu:CopyImmediateToDX/>
			<int>0</int>

			<cpu:CopyImmediateToBX/>
			<!--<int>5120</int>-->
			<int>4096</int>
			<!--<int>3200</int>-->

			<cpu:ArithmeticDXAXOperandFunction/>
			<ari:MultiplyByBXRegister/>

			<!--Get X-->
			<cpu:MathImmediate8ToOperandFunction/>
			<math:SubtractFromSIRegister/>
			<byte>4</byte>

			<cpu:AddOperandToRegister/>
			<op:AX-SIAddress/>

			<cpu:AddOperandToRegister/>
			<op:AX-SIAddress/>

			<cpu:AddOperandToRegister/>
			<op:AX-SIAddress/>

			<cpu:AddOperandToRegister/>
			<op:AX-SIAddress/>

			<cpu:AddRegisterToOperand/>
			<op:AX-DIRegister/>

			<!--Get Height-->
			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToSIRegister/>
			<byte>12</byte>

			<cpu:CopyOperandToRegister/>
			<op:DX-SIAddress/>

			<cpu:DecrementDX/>
			<cpu:DecrementDX/>

			<!--Get Width-->
			<cpu:MathImmediate8ToOperandFunction/>
			<math:SubtractFromSIRegister/>
			<byte>4</byte>

			<cpu:PullAXFromStack/>

			<!--Draw First Row-->
			<cpu:CopyOperandToRegister/>
			<op:CX-SIAddress/>

			<cpu:Repeat/>
			<cpu:CopyAXToDIAddressAndIncrementDI/>

			<cpu:SubtractOperandFromRegister/>
			<op:DI-SIAddress/>

			<cpu:SubtractOperandFromRegister/>
			<op:DI-SIAddress/>

			<cpu:SubtractOperandFromRegister/>
			<op:DI-SIAddress/>

			<cpu:SubtractOperandFromRegister/>
			<op:DI-SIAddress/>

			<cpu:MathImmediateToOperandFunction/>
			<math:AddToDIRegister/>
			<!--<int>5120</int>-->
			<int>4096</int>
			<!--<int>3200</int>-->

			<!--Draw Middle Rows-->
			<label id="drawRow"/>

			<cpu:CopyRegisterToOperand/>
			<op:AX-DIAddress/>

			<cpu:AddOperandToRegister/>
			<op:DI-SIAddress/>

			<cpu:AddOperandToRegister/>
			<op:DI-SIAddress/>

			<cpu:AddOperandToRegister/>
			<op:DI-SIAddress/>

			<cpu:AddOperandToRegister/>
			<op:DI-SIAddress/>

			<cpu:DecrementDI/>
			<cpu:DecrementDI/>
			<cpu:DecrementDI/>
			<cpu:DecrementDI/>

			<cpu:CopyAXToDIAddressAndIncrementDI/>

			<cpu:SubtractOperandFromRegister/>
			<op:DI-SIAddress/>

			<cpu:SubtractOperandFromRegister/>
			<op:DI-SIAddress/>

			<cpu:SubtractOperandFromRegister/>
			<op:DI-SIAddress/>

			<cpu:SubtractOperandFromRegister/>
			<op:DI-SIAddress/>

			<cpu:MathImmediateToOperandFunction/>
			<math:AddToDIRegister/>
			<!--<int>5120</int>-->
			<int>4096</int>
			<!--<int>3200</int>-->

			<cpu:DecrementDX/>

			<cpu:BranchToRelative8IfNotZero/>
			<addressOf ref="drawRow" type="Relative8"/>

			<!--Draw End Row-->
			<cpu:CopyOperandToRegister/>
			<op:CX-SIAddress/>

			<cpu:Repeat/>
			<cpu:CopyAXToDIAddressAndIncrementDI/>
		</scope>
	</xsl:template>

	<xsl:template match="gfx:FillRectangle">
		<scope>
			<cpu:PushAXToStack/>

			<!--Get Y-->
			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToSIRegister/>
			<byte>4</byte>

			<cpu:CopyOperandToRegister/>
			<op:AX-SIAddress/>

			<cpu:CopyImmediateToDX/>
			<int>0</int>

			<cpu:CopyImmediateToBX/>
			<!--<int>5120</int>-->
			<int>4096</int>
			<!--<int>3200</int>-->

			<cpu:ArithmeticDXAXOperandFunction/>
			<ari:MultiplyByBXRegister/>

			<!--Get X-->
			<cpu:MathImmediate8ToOperandFunction/>
			<math:SubtractFromSIRegister/>
			<byte>4</byte>

			<cpu:AddOperandToRegister/>
			<op:AX-SIAddress/>

			<cpu:AddOperandToRegister/>
			<op:AX-SIAddress/>

			<cpu:AddOperandToRegister/>
			<op:AX-SIAddress/>

			<cpu:AddOperandToRegister/>
			<op:AX-SIAddress/>

			<cpu:AddRegisterToOperand/>
			<op:AX-DIRegister/>

			<!--Get Height-->
			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToSIRegister/>
			<byte>12</byte>

			<cpu:CopyOperandToRegister/>
			<op:DX-SIAddress/>

			<!--Get Width-->
			<cpu:MathImmediate8ToOperandFunction/>
			<math:SubtractFromSIRegister/>
			<byte>4</byte>

			<cpu:PullAXFromStack/>

			<!--Draw Rows-->
			<label id="drawRow"/>

			<cpu:CopyOperandToRegister/>
			<op:CX-SIAddress/>

			<cpu:Repeat/>
			<cpu:CopyAXToDIAddressAndIncrementDI/>

			<cpu:SubtractOperandFromRegister/>
			<op:DI-SIAddress/>

			<cpu:SubtractOperandFromRegister/>
			<op:DI-SIAddress/>

			<cpu:SubtractOperandFromRegister/>
			<op:DI-SIAddress/>

			<cpu:SubtractOperandFromRegister/>
			<op:DI-SIAddress/>

			<cpu:MathImmediateToOperandFunction/>
			<math:AddToDIRegister/>
			<!--<int>5120</int>-->
			<int>4096</int>
			<!--<int>3200</int>-->

			<cpu:DecrementDX/>

			<cpu:BranchToRelative8IfNotZero/>
			<addressOf ref="drawRow" type="Relative8"/>
		</scope>
	</xsl:template>

	<xsl:template match="gfx:DrawBitmap">
		<scope>
			<cpu:PushAXToStack/>

			<!--Get Y-->
			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToAXRegister/>
			<byte>4</byte>

			<cpu:CopyOperandToRegister/>
			<op:AX-AXAddress/>

			<cpu:CopyImmediateToDX/>
			<int>0</int>

			<cpu:CopyImmediateToBX/>
			<!--<int>5120</int>-->
			<int>4096</int>
			<!--<int>3200</int>-->

			<cpu:ArithmeticDXAXOperandFunction/>
			<ari:MultiplyByBXRegister/>

			<cpu:AddRegisterToOperand/>
			<op:AX-DIRegister/>

			<!--Get X-->
			<cpu:PullAXFromStack/>

			<cpu:CopyOperandToRegister/>
			<op:AX-AXAddress/>

			<cpu:ShiftRegisterByImmediate8Function/>
			<shift:ShiftAXRegisterLeft/>
			<byte>2</byte>

			<cpu:AddRegisterToOperand/>
			<op:AX-DIRegister/>

			<!--Get Width-->
			<cpu:CopySIAddressToAXAndIncrementSI/>

			<!--Get Height-->
			<cpu:CopyOperandToRegister/>
			<op:DX-SIAddress/>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToSIRegister/>
			<byte>4</byte>

			<!--Draw Rows-->
			<label id="drawRow"/>

			<cpu:CopyRegisterToOperand/>
			<op:AX-CXRegister/>

			<cpu:Repeat/>
			<cpu:CopySIAddressToDIAddressAndIncrementSIAndDI/>

			<cpu:SubtractOperandFromRegister/>
			<op:DI-AXRegister/>

			<cpu:SubtractOperandFromRegister/>
			<op:DI-AXRegister/>

			<cpu:SubtractOperandFromRegister/>
			<op:DI-AXRegister/>

			<cpu:SubtractOperandFromRegister/>
			<op:DI-AXRegister/>

			<cpu:MathImmediateToOperandFunction/>
			<math:AddToDIRegister/>
			<!--<int>5120</int>-->
			<int>4096</int>
			<!--<int>3200</int>-->

			<cpu:DecrementDX/>

			<cpu:BranchToRelative8IfNotZero/>
			<addressOf ref="drawRow" type="Relative8"/>
		</scope>
	</xsl:template>

	<xsl:template match="gfx:RenderBitmap">
		<scope>
			<cpu:PushAXToStack/>

			<!--Get Y-->
			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToAXRegister/>
			<byte>4</byte>

			<cpu:CopyOperandToRegister/>
			<op:AX-AXAddress/>

			<cpu:CopyImmediateToDX/>
			<int>0</int>

			<cpu:CopyImmediateToBX/>
			<!--<int>5120</int>-->
			<int>4096</int>
			<!--<int>3200</int>-->

			<cpu:ArithmeticDXAXOperandFunction/>
			<ari:MultiplyByBXRegister/>

			<cpu:AddRegisterToOperand/>
			<op:AX-DIRegister/>

			<!--Get X-->
			<cpu:PullAXFromStack/>

			<cpu:CopyOperandToRegister/>
			<op:AX-AXAddress/>

			<cpu:ShiftRegisterByImmediate8Function/>
			<shift:ShiftAXRegisterLeft/>
			<byte>2</byte>

			<cpu:AddRegisterToOperand/>
			<op:AX-DIRegister/>

			<!--Get Width-->
			<cpu:CopySIAddressToAXAndIncrementSI/>

			<!--Get Height-->
			<cpu:CopyOperandToRegister/>
			<op:DX-SIAddress/>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToSIRegister/>
			<byte>4</byte>

			<!--Draw Rows-->
			<label id="drawRow"/>

			<cpu:PushDXToStack/>

			<cpu:CopyRegisterToOperand/>
			<op:AX-CXRegister/>

			<cpu:PushAXToStack/>

			<cpu:CopyImmediateToAX/>
			<int>0</int>

			<cpu:CopyImmediateToDX/>
			<int>0</int>

			<label id="drawPixel"/>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToSIRegister/>
			<byte>3</byte>

			<cpu:CopyImmediateToDX/>
			<int>0</int>

			<cpu:CopyOperandToRegister8/>
			<op:DL-SIAddress/>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:SubtractFromSIRegister/>
			<byte>3</byte>

			<!--Calculate Blue Value-->
			<cpu:CopyImmediateToAX/>
			<int>0</int>

			<cpu:CopySIAddressToALAndIncrementSI/>

			<cpu:CopyImmediateToBX/>
			<int>0</int>

			<cpu:CopyOperandToRegister8/>
			<op:BL-DIAddress/>

			<cpu:SubtractOperandFromRegister/>
			<op:AX-BXRegister/>

			<cpu:PushDXToStack/>

			<cpu:ArithmeticDXAXOperandFunction/>
			<ari:MultiplyByDXRegisterWithSign/>

			<cpu:ShiftRegisterByImmediate8Function/>
			<shift:ShiftAXRegisterRightWithSign/>
			<byte>8</byte>

			<cpu:PullDXFromStack/>

			<cpu:AddRegisterToOperand8/>
			<op:AL-DIAddress/>

			<cpu:IncrementDI/>

			<!--Calculate Green Value-->
			<cpu:CopyImmediateToAX/>
			<int>0</int>

			<cpu:CopySIAddressToALAndIncrementSI/>

			<cpu:CopyImmediateToBX/>
			<int>0</int>

			<cpu:CopyOperandToRegister8/>
			<op:BL-DIAddress/>

			<cpu:SubtractOperandFromRegister/>
			<op:AX-BXRegister/>

			<cpu:PushDXToStack/>

			<cpu:ArithmeticDXAXOperandFunction/>
			<ari:MultiplyByDXRegisterWithSign/>

			<cpu:ShiftRegisterByImmediate8Function/>
			<shift:ShiftAXRegisterRightWithSign/>
			<byte>8</byte>

			<cpu:PullDXFromStack/>

			<cpu:AddRegisterToOperand8/>
			<op:AL-DIAddress/>

			<cpu:IncrementDI/>

			<!--Calculate Red Value-->
			<cpu:CopyImmediateToAX/>
			<int>0</int>

			<cpu:CopySIAddressToALAndIncrementSI/>

			<cpu:CopyImmediateToBX/>
			<int>0</int>

			<cpu:CopyOperandToRegister8/>
			<op:BL-DIAddress/>

			<cpu:SubtractOperandFromRegister/>
			<op:AX-BXRegister/>

			<cpu:PushDXToStack/>

			<cpu:ArithmeticDXAXOperandFunction/>
			<ari:MultiplyByDXRegisterWithSign/>

			<cpu:ShiftRegisterByImmediate8Function/>
			<shift:ShiftAXRegisterRightWithSign/>
			<byte>8</byte>

			<cpu:PullDXFromStack/>

			<cpu:AddRegisterToOperand8/>
			<op:AL-DIAddress/>

			<cpu:IncrementDI/>

			<!--Skip Alpha Value-->
			<cpu:IncrementSI/>
			<cpu:IncrementDI/>

			<cpu:LoopToRelative8/>
			<addressOf ref="drawPixel" type="Relative8"/>

			<cpu:PullAXFromStack/>

			<cpu:SubtractOperandFromRegister/>
			<op:DI-AXRegister/>

			<cpu:SubtractOperandFromRegister/>
			<op:DI-AXRegister/>

			<cpu:SubtractOperandFromRegister/>
			<op:DI-AXRegister/>

			<cpu:SubtractOperandFromRegister/>
			<op:DI-AXRegister/>

			<cpu:MathImmediateToOperandFunction/>
			<math:AddToDIRegister/>
			<!--<int>5120</int>-->
			<int>4096</int>
			<!--<int>3200</int>-->

			<cpu:PullDXFromStack/>

			<cpu:DecrementDX/>

			<cpu:BranchToRelative8IfNotZero/>
			<addressOf ref="drawRow" type="Relative8"/>
		</scope>
	</xsl:template>

</xsl:stylesheet>
