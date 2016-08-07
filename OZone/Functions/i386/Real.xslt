<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:var="http://metalx.org/Variable"
	xmlns:real="http://metalx.org/i386/Functions/Real"
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
	xmlns:op="http://metalx.org/Intel/80386/Operands"
	xmlns:fpu="http://metalx.org/Intel/80386/FpuOperators">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="real:CreateObject">
		<scope>
			<cpu:PushSIToStack/>

			<mm:CheckOut length="10"/>

			<cpu:PushDIToStack/>

			<fpu:PullRealAtDIAddressFromST0/>
			
			<cpu:WaitForFloatingPointUnit/>

			<sys:GetCatalog/>

			<cpu:CopyImmediateToDI/>
			<addressOf ref="realClassName" type="Absolute32"/>

			<cat:FindType/>

			<cpu:CopyRegisterToOperand/>
			<op:SI-BXRegister/>

			<cpu:PullDIFromStack/>
			<cpu:PullSIFromStack/>

			<cpu:CopyImmediateToAX/>
			<int>10</int>

			<obj:Create/>

			<cpu:JumpToRelative8/>
			<addressOf ref="end" type="Relative8"/>

			<var:string id="realClassName">http://metalx.org/Real</var:string>

			<label id="end"/>
		</scope>
	</xsl:template>

	<xsl:template match="real:ToString">
		<scope>
			<str:Create length="10"/>

			<cpu:CopyRegisterToOperand/>
			<op:DI-SIRegister/>

			<cpu:CompareAXToImmediate/>
			<int>0</int>

			<cpu:BranchToRelative8IfNotEqual/>
			<addressOf ref="start" type="Relative8"/>

			<cpu:CopyImmediateToAL/>
			<string>0</string>

			<str:AppendCharacter/>

			<cpu:JumpToRelative8/>
			<addressOf ref="end" type="Relative8"/>

			<label id="start"/>

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
			<addressOf ref="drawCharacters" type="Relative8"/>

			<cpu:JumpToRelative8/>
			<addressOf ref="nextCharacter" type="Relative8"/>

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
