<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:int="http://metalx.org/i286/Functions/Short"
	xmlns:cat="http://metalx.org/i286/Functions/Catalog"
	xmlns:obj="http://metalx.org/i286/Functions/Object"
	xmlns:clsf="http://metalx.org/i286/Functions/Class"
	xmlns:str="http://metalx.org/i286/Functions/String"
	xmlns:lst="http://metalx.org/i286/Functions/List"
	xmlns:sys="http://metalx.org/i286/Functions/System"
	xmlns:mm="http://metalx.org/i286/Functions/MemoryManager"
	xmlns:con="http://metalx.org/i286/Functions/Console"
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

	<xsl:template match="int:CreateObject">
		<scope>
			<!--<cpu:PushDSToStack/>-->
			<cpu:PushSIToStack/>

			<mm:CheckOut length="2"/>

			<!--<cpu:PushESToStack/>-->
			<cpu:PushDIToStack/>

			<cpu:CopyRegisterToOperand16/>
			<op:AX-DIAddress/>

			<sys:GetCatalog/>

			<!--<cpu:PushImmediateToStack16/>
			<addressOf ref="shortClassName" type="Segment16"/>

			<cpu:PullESFromStack/>-->
			
			<cpu:CopyImmediateToDI/>
			<addressOf ref="shortClassName" type="Absolute16"/>

			<cat:FindType/>

			<cpu:CopyRegisterToOperand16/>
			<op:SI-BXRegister/>

			<cpu:PullDIFromStack/>
			<!--<cpu:PullESFromStack/>-->
			<cpu:PullSIFromStack/>
			<!--<cpu:PullDSFromStack/>-->

			<cpu:CopyImmediateToAX/>
			<short>2</short>

			<obj:Create/>

			<cpu:JumpToRelative8/>
			<addressOf ref="end" type="Relative8"/>

			<label id="shortClassName"/>
			<short>23</short>
			<string>http://metalx.org/Short</string>

			<label id="end"/>
		</scope>
	</xsl:template>

	<xsl:template match="int:ToString">
		<scope>
			<sys:GetMemoryManager/>

			<str:Create length="8"/>

			<cpu:CopyRegisterToOperand16/>
			<op:DI-SIRegister/>

			<cpu:CompareAXToImmediate/>
			<short>0</short>

			<cpu:BranchToRelativeIfNotEqual8/>
			<addressOf ref="start" type="Relative8"/>

			<cpu:CopyImmediateToAL/>
			<string>0</string>

			<str:AppendByte/>

			<cpu:JumpToRelative8/>
			<addressOf ref="end" type="Relative8"/>

			<label id="start"/>

			<cpu:CopyImmediateToBX/>
			<short>10</short>

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

			<cpu:BranchToRelativeIfEqual8/>
			<addressOf ref="drawCharacters" type="Relative8"/>

			<cpu:JumpToRelative8/>
			<addressOf ref="nextCharacter" type="Relative8"/>

			<label id="drawCharacters"/>

			<cpu:PullAXFromStack/>

			<cpu:AddImmediateToAL/>
			<asc:Zero/>

			<cpu:CopyRegisterToOperand16/>
			<op:DI-SIRegister/>

			<str:AppendByte/>

			<cpu:LoopToRelative8/>
			<addressOf ref="drawCharacters" type="Relative8"/>

			<label id="end"/>
		</scope>
	</xsl:template>
</xsl:stylesheet>
