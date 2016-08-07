<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:var="http://metalx.org/Variable"
	xmlns:byte="http://metalx.org/i386/Functions/Byte"
	xmlns:cat="http://metalx.org/i386/Functions/Catalog"
	xmlns:obj="http://metalx.org/i386/Functions/Object"
	xmlns:str="http://metalx.org/i386/Functions/String"
	xmlns:lst="http://metalx.org/i386/Functions/List"
	xmlns:sys="http://metalx.org/i386/Functions/System"
	xmlns:mm="http://metalx.org/i386/Functions/MemoryManager"
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

	<xsl:template match="byte:CreateObject">
		<scope>
			<cpu:PushSIToStack/>

			<mm:CheckOut length="1"/>

			<cpu:PushDIToStack/>

			<cpu:CopyRegisterToOperand8/>
			<op:AL-DIAddress/>

			<sys:GetCatalog/>

			<cpu:CopyImmediateToDI/>
			<addressOf ref="byteClassName" type="Absolute32"/>

			<cat:FindType/>

			<cpu:CopyRegisterToOperand/>
			<op:SI-BXRegister/>

			<cpu:PullDIFromStack/>
			<cpu:PullSIFromStack/>

			<cpu:CopyImmediateToAX/>
			<int>1</int>

			<obj:Create/>

			<cpu:JumpToRelative8/>
			<addressOf ref="end" type="Relative8"/>
			
			<var:string id="byteClassName">http://metalx.org/Byte</var:string>

			<label id="end"/>
		</scope>
	</xsl:template>
	
	<xsl:template match="byte:Parse">
		<scope>
			<cpu:CopySIAddressToAXAndIncrementSI/>

			<cpu:CopyRegisterToOperand/>
			<op:AX-CXRegister/>

			<cpu:CopyRegisterToOperand/>
			<op:AX-DXRegister/>

			<cpu:CopyOperandToRegister/>
			<op:AX-SIAddress/>

			<cpu:PushAXToStack/>

			<cpu:CompareALToImmediate/>
			<string>-</string>

			<cpu:BranchToRelative8IfNotEqual/>
			<addressOf ref="notNegative" type="Relative8"/>

			<cpu:IncrementSI/>
			<cpu:DecrementCX/>
			<cpu:DecrementDX/>
			
			<label id="notNegative"/>
			
			<cpu:CopyImmediateToAX/>
			<int>0</int>

			<label id="pushIntegerCharacters"/>

			<cpu:CopySIAddressToALAndIncrementSI/>

			<cpu:SubtractImmediateFromAL/>
			<string>0</string>

			<cpu:PushAXToStack/>

			<cpu:LoopToRelative8/>
			<addressOf ref="pushIntegerCharacters" type="Relative8"/>

			<cpu:CopyRegisterToOperand/>
			<op:DX-CXRegister/>

			<cpu:CopyImmediateToAX/>
			<int>0</int>

			<cpu:CopyImmediateToBX/>
			<int>1</int>

			<cpu:CopyImmediateToDX/>
			<int>0</int>

			<cpu:CopyImmediateToSI/>
			<int>0</int>

			<cpu:CopyImmediateToDI/>
			<int>10</int>

			<label id="addNextIntegerCharacter"/>

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
			<addressOf ref="addNextIntegerCharacter" type="Relative8"/>

			<cpu:PullAXFromStack/>

			<cpu:CompareALToImmediate/>
			<string>-</string>
			
			<cpu:CopyRegisterToOperand/>
			<op:SI-AXRegister/>

			<cpu:BranchToRelative8IfNotEqual/>
			<addressOf ref="notNegative2" type="Relative8"/>

			<cpu:ExclusiveOrAXWithImmediate/>
			<int>-1</int>

			<cpu:IncrementAX/>
			
			<label id="notNegative2"/>
		</scope>
	</xsl:template>
	
	<xsl:template match="byte:ToString">
		<scope>
			<str:Create length="10"/>

			<cpu:CopyRegisterToOperand/>
			<op:DI-SIRegister/>
			
			<cpu:CompareAXToImmediate/>
			<int>0</int>

			<cpu:BranchToRelative8IfNotEqual/>
			<addressOf ref="notZero" type="Relative8"/>

			<cpu:CopyImmediateToAL/>
			<string>0</string>

			<str:AppendCharacter/>

			<cpu:JumpToRelative8/>
			<addressOf ref="end" type="Relative8"/>

			<label id="notZero"/>

			<cpu:BranchToRelative8IfNotLess/>
			<addressOf ref="notNegative" type="Relative8"/>

			<str:AppendCharacter value="-"/>

			<cpu:ExclusiveOrAXWithImmediate/>
			<int>-1</int>

			<cpu:IncrementAX/>

			<label id="notNegative"/>

			<cpu:CopyImmediateToBX/>
			<int>10</int>

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

			<cpu:BranchToRelative8IfEqual/>
			<addressOf ref="padCharacters" type="Relative8"/>

			<cpu:JumpToRelative8/>
			<addressOf ref="nextCharacter" type="Relative8"/>

			<label id="padCharacters"/>

			<xsl:if test="@digits">
				<cpu:MathImmediate8ToOperandFunction/>
				<math:CompareWithCXRegister/>
				<byte>
					<xsl:value-of select="@digits"/>
				</byte>

				<cpu:BranchToRelative8IfGreaterOrEqual/>
				<addressOf ref="drawCharacters" type="Relative8"/>

				<cpu:PushImmediateToStack/>
				<int>0</int>

				<cpu:IncrementCX/>

				<cpu:JumpToRelative8/>
				<addressOf ref="padCharacters" type="Relative8"/>
			</xsl:if>

			<label id="drawCharacters"/>

			<cpu:PullAXFromStack/>

			<cpu:AddImmediateToAL/>
			<asc:Zero/>

			<cpu:CopyRegisterToOperand/>
			<op:DI-SIRegister/>

			<str:AppendCharacter/>

			<cpu:LoopToRelative8/>
			<addressOf ref="drawCharacters" type="Relative8"/>

			<label id="end"/>
		</scope>
	</xsl:template>
</xsl:stylesheet>
