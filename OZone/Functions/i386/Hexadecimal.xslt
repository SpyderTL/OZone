<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:var="http://metalx.org/Variable"
	xmlns:hex="http://metalx.org/i386/Functions/Hexadecimal"
	xmlns:mm="http://metalx.org/i386/Functions/MemoryManager"
	xmlns:sys="http://metalx.org/i386/Functions/System"
	xmlns:cat="http://metalx.org/i386/Functions/Catalog"
	xmlns:obj="http://metalx.org/i386/Functions/Object"
	xmlns:str="http://metalx.org/i386/Functions/String"
	xmlns:asc="http://metalx.org/Ansi/Ascii"
	xmlns:ari="http://metalx.org/Intel/80386/Arithmetic"
	xmlns:imm="http://metalx.org/Intel/80386/Immediate"
	xmlns:inc="http://metalx.org/Intel/80386/Increment"
	xmlns:math="http://metalx.org/Intel/80386/Math"
	xmlns:cpu="http://metalx.org/Intel/80386/Operators"
	xmlns:op="http://metalx.org/Intel/80386/Operands">
	
	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="hex:CreateObject">
		<scope>
			<cpu:PushSIToStack/>

			<mm:CheckOut length="4"/>

			<cpu:PushDIToStack/>

			<cpu:CopyRegisterToOperand/>
			<op:AX-DIAddress/>

			<sys:GetCatalog/>

			<cpu:CopyImmediateToDI/>
			<addressOf ref="className" type="Absolute32"/>

			<cat:FindType/>

			<cpu:CopyRegisterToOperand/>
			<op:SI-BXRegister/>

			<cpu:PullDIFromStack/>
			<cpu:PullSIFromStack/>

			<cpu:CopyImmediateToAX/>
			<int>4</int>

			<obj:Create/>

			<cpu:JumpToRelative8/>
			<addressOf ref="end" type="Relative8"/>

			<var:string id="className">http://metalx.org/Hexadecimal</var:string>

			<label id="end"/>
		</scope>
	</xsl:template>

	<xsl:template match="hex:Parse">
		<scope>
			<cpu:CopySIAddressToAXAndIncrementSI/>

			<cpu:CopyRegisterToOperand/>
			<op:AX-CXRegister/>

			<cpu:CopyRegisterToOperand/>
			<op:AX-DXRegister/>

			<cpu:CopyImmediateToAX/>
			<int>0</int>

			<label id="pushHexadecimalCharacters"/>

			<cpu:CopySIAddressToALAndIncrementSI/>

			<cpu:CompareALToImmediate/>
			<string>a</string>

			<cpu:BranchToRelative8IfLess/>
			<addressOf ref="notLowerCase" type="Relative8"/>

			<cpu:SubtractImmediateFromAL/>
			<byte>87</byte>

			<cpu:JumpToRelative8/>
			<addressOf ref="storeDigit" type="Relative8"/>

			<label id="notLowerCase"/>
			
			<cpu:CompareALToImmediate/>
			<string>A</string>

			<cpu:BranchToRelative8IfLess/>
			<addressOf ref="notUpperCase" type="Relative8"/>
			
			<cpu:SubtractImmediateFromAL/>
			<byte>55</byte>

			<cpu:JumpToRelative8/>
			<addressOf ref="storeDigit" type="Relative8"/>

			<label id="notUpperCase"/>

			<cpu:SubtractImmediateFromAL/>
			<string>0</string>

			<label id="storeDigit"/>

			<cpu:PushAXToStack/>

			<cpu:LoopToRelative8/>
			<addressOf ref="pushHexadecimalCharacters" type="Relative8"/>

			<cpu:CopyRegisterToOperand/>
			<op:DX-CXRegister/>

			<cpu:CopyImmediateToBX/>
			<int>1</int>

			<cpu:CopyImmediateToDX/>
			<int>0</int>

			<cpu:CopyImmediateToSI/>
			<int>0</int>

			<cpu:CopyImmediateToDI/>
			<int>16</int>

			<label id="addNextHexadecimalCharacter"/>

			<cpu:CopyImmediateToDX/>
			<int>0</int>
			
			<cpu:PullAXFromStack/>

			<cpu:ArithmeticDXAXOperandFunction/>
			<ari:MultiplyByBXRegister/>

			<cpu:AddRegisterToOperand/>
			<op:AX-SIRegister/>

			<cpu:ExchangeBXWithAX/>

			<cpu:CopyImmediateToDX/>
			<int>0</int>

			<cpu:ArithmeticDXAXOperandFunction/>
			<ari:MultiplyByDIRegister/>

			<cpu:ExchangeBXWithAX/>

			<cpu:LoopToRelative8/>
			<addressOf ref="addNextHexadecimalCharacter" type="Relative8"/>

			<cpu:CopyRegisterToOperand/>
			<op:SI-AXRegister/>
		</scope>
	</xsl:template>

	<xsl:template match="hex:ToString">
		<scope>
			<str:Create length="8"/>

			<cpu:CompareAXToImmediate/>
			<int>0</int>

			<cpu:BranchToRelative8IfNotEqual/>
			<addressOf ref="start" type="Relative8"/>

			<cpu:PushAXToStack/>

			<cpu:CopyImmediateToCX/>
			<int>1</int>

			<cpu:JumpToRelative8/>
			<addressOf ref="padCharacters" type="Relative8"/>

			<label id="start"/>

			<cpu:CopyImmediateToBX/>
			<hex>00000010</hex>

			<cpu:CopyImmediateToCX/>
			<int>0</int>

			<label id="nextCharacter"/>

			<cpu:CopyImmediateToDX/>
			<int>0</int>

			<cpu:ArithmeticDXAXOperandFunction/>
			<ari:DivideByBXRegister/>

			<cpu:PushDXToStack/>

			<cpu:IncrementCX/>

			<cpu:CompareAXToImmediate/>
			<int>0</int>

			<cpu:BranchToRelative8IfNotEqual/>
			<addressOf ref="nextCharacter" type="Relative8"/>

			<label id="padCharacters"/>
			
			<xsl:if test="@digits">
				<cpu:MathImmediate8ToOperandFunction/>
				<math:CompareWithCXRegister/>
				<byte>
					<xsl:value-of select="@digits"/>
				</byte>

				<cpu:BranchToRelative8IfGreaterOrEqual/>
				<addressOf ref="drawCharacters" type='Relative8'/>

				<cpu:CopyImmediateToDX/>
				<int>0</int>

				<cpu:PushDXToStack/>

				<cpu:IncrementCX/>

				<cpu:JumpToRelative8/>
				<addressOf ref="padCharacters" type="Relative8"/>
			</xsl:if>

			<label id="drawCharacters"/>

			<cpu:PullAXFromStack/>

			<cpu:CompareALToImmediate/>
			<hex>0a</hex>

			<cpu:BranchToRelative8IfGreaterOrEqual/>
			<addressOf ref="letter" type="Relative8"/>

			<cpu:AddImmediateToAL/>
			<asc:Zero/>

			<cpu:JumpToRelative8/>
			<addressOf ref="print" type="Relative8"/>

			<label id="letter"/>

			<cpu:AddImmediateToAL/>
			<asc:Seven/>

			<label id="print"/>

			<cpu:CopyRegisterToOperand/>
			<op:DI-SIRegister/>

			<str:AppendCharacter/>

			<cpu:LoopToRelative8/>
			<addressOf ref="drawCharacters" type="Relative8"/>

			<label id="end"/>
		</scope>
	</xsl:template>
</xsl:stylesheet>
