<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:hex="http://metalx.org/i286/Functions/Hexadecimal"
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
	xmlns:op="http://metalx.org/Intel/80286/Operands"
	xmlns:con="http://metalx.org/i286/Functions/Console"
	>

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="hex:CreateObject">
		<scope>
			<cpu:PushDSToStack/>
			<cpu:PushSIToStack/>

			<mm:CheckOut length="2"/>

			<cpu:PushESToStack/>
			<cpu:PushDIToStack/>

			<cpu:CopyRegisterToOperand16/>
			<op:AX-DIAddress/>

			<sys:GetCatalog/>

			<cpu:PushImmediateToStack16/>
			<addressOf ref="className" type="Segment16"/>

			<cpu:PullESFromStack/>

			<cpu:CopyImmediateToDI/>
			<addressOf ref="className" type="Absolute16"/>

			<cat:FindType/>

			<cpu:CopyRegisterToOperand16/>
			<op:SI-BXRegister/>

			<cpu:PullDIFromStack/>
			<cpu:PullESFromStack/>
			<cpu:PullSIFromStack/>
			<cpu:PullDSFromStack/>
			
			<cpu:CopyImmediateToAX/>
			<short>2</short>

			<obj:Create/>

			<cpu:JumpToRelative8/>
			<addressOf ref="end" type="Relative8"/>

			<label id="className"/>
			<short>28</short>
			<string>http://metalx.org/Hexadecimal</string>

			<label id="end"/>
		</scope>
	</xsl:template>
	
	<xsl:template match="hex:ToString">
		<scope>
			<sys:GetMemoryManager/>

			<str:Create length="4"/>

			<cpu:CompareAXToImmediate/>
			<short>0</short>

			<cpu:BranchToRelativeIfNotEqual8/>
			<addressOf ref="start" type="Relative8"/>

			<cpu:PushAXToStack/>

			<cpu:CopyImmediateToCX/>
			<short>1</short>

			<cpu:JumpToRelative8/>
			<addressOf ref="padCharacters" type="Relative8"/>

			<label id="start"/>

			<cpu:CopyImmediateToBX/>
			<hex>0010</hex>

			<cpu:CopyImmediateToCX/>
			<short>0</short>

			<label id="nextCharacter"/>

			<cpu:CopyImmediateToDX/>
			<short>0</short>

			<cpu:ArithmeticDXAXOperandFunction/>
			<ari:DivideByBXRegister/>

			<cpu:PushDXToStack/>

			<cpu:IncrementCX/>

			<cpu:CompareAXToImmediate/>
			<short>0</short>

			<cpu:BranchToRelativeIfNotEqual8/>
			<addressOf ref="nextCharacter" type="Relative8"/>

			<label id="padCharacters"/>
			
			<xsl:if test="@digits">
				<cpu:MathImmediate8ToOperand16Function/>
				<math:CompareWithCXRegister/>
				<byte>
					<xsl:value-of select="@digits"/>
				</byte>

				<cpu:BranchToRelativeIfGreaterOrEqual8/>
				<addressOf ref="drawCharacters" type='Relative8'/>

				<cpu:CopyImmediateToDX/>
				<short>0</short>

				<cpu:PushDXToStack/>

				<cpu:IncrementCX/>

				<cpu:JumpToRelative8/>
				<addressOf ref="padCharacters" type="Relative8"/>
			</xsl:if>

			<label id="drawCharacters"/>

			<cpu:PullAXFromStack/>

			<cpu:CompareALToImmediate/>
			<hex>0a</hex>

			<cpu:BranchToRelativeIfGreaterOrEqual8/>
			<addressOf ref="letter" type="Relative8"/>

			<cpu:AddImmediateToAL/>
			<asc:Zero/>

			<cpu:JumpToRelative8/>
			<addressOf ref="print" type="Relative8"/>

			<label id="letter"/>

			<cpu:AddImmediateToAL/>
			<asc:Seven/>

			<label id="print"/>

			<cpu:CopyRegisterToOperand16/>
			<op:DI-SIRegister/>

			<str:AppendByte/>

			<cpu:LoopToRelative8/>
			<addressOf ref="drawCharacters" type="Relative8"/>

			<label id="end"/>
		</scope>
	</xsl:template>
</xsl:stylesheet>
