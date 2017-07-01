<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:var="http://metalx.org/Variable"
	xmlns:float="http://metalx.org/i386/Functions/Float"
	xmlns:int="http://metalx.org/i386/Functions/Integer"
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

	<xsl:template match="float:CreateObject">
		<scope>
			<cpu:WaitForFloatingPointUnit/>
			
			<cpu:PushSIToStack/>

			<mm:CheckOut length="4"/>

			<cpu:PushDIToStack/>

			<fpu:PullFloatAtDIAddressFromST0/>

			<cpu:WaitForFloatingPointUnit/>
			
			<sys:GetCatalog/>

			<cpu:CopyImmediateToDI/>
			<addressOf ref="floatClassName" type="Absolute32"/>

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
			
			<var:string id="floatClassName">http://metalx.org/Float</var:string>

			<label id="end"/>
		</scope>
	</xsl:template>

	<xsl:template match="float:Parse">
		<scope>
			<fpu:ResetFpu/>

			<cpu:WaitForFloatingPointUnit/>

			<cpu:CopyImmediateToAX/>
			<int>10</int>

			<cpu:CopyAXToAbsoluteMemory/>
			<addressOf ref="value" type="Absolute32"/>

			<fpu:PushIntegerAtImmediateAddressToST0/>
			<addressOf ref="value" type="Absolute32"/>

			<fpu:Zero/>

			<cpu:WaitForFloatingPointUnit/>

			<cpu:CopySIAddressToAXAndIncrementSI/>

			<cpu:CopyRegisterToOperand/>
			<op:AX-CXRegister/>

			<cpu:CopyOperandToRegister/>
			<op:AL-SIAddress/>

			<cpu:PushAXToStack/>

			<cpu:CompareALToImmediate/>
			<string>-</string>

			<cpu:BranchToRelative8IfNotEqual/>
			<addressOf ref="notNegative" type="Relative8"/>

			<cpu:IncrementSI/>
			<cpu:DecrementCX/>

			<label id="notNegative"/>

			<cpu:CopyImmediateToAX/>
			<int>0</int>

			<label id="nextInteger"/>

			<cpu:CopySIAddressToALAndIncrementSI/>

			<cpu:CompareALToImmediate/>
			<string>.</string>

			<cpu:BranchToRelative8IfEqual/>
			<addressOf ref="readDecimal" type="Relative8"/>

			<fpu:MultiplyST0ByST1/>

			<cpu:WaitForFloatingPointUnit/>
			
			<cpu:SubtractImmediateFromAL/>
			<string>0</string>

			<cpu:CopyAXToAbsoluteMemory/>
			<addressOf ref="value" type="Absolute32"/>

			<fpu:PushIntegerAtImmediateAddressToST0/>
			<addressOf ref="value" type="Absolute32"/>

			<fpu:AddST0ToST1AndIncrementST/>

			<cpu:WaitForFloatingPointUnit/>

			<cpu:LoopToRelative8/>
			<addressOf ref="nextInteger" type="Relative8"/>

			<label id="readDecimal"/>

			<cpu:DecrementCX/>
			
			<fpu:PushST1/>

			<cpu:WaitForFloatingPointUnit/>

			<label id="nextDecimal"/>

			<cpu:CopySIAddressToALAndIncrementSI/>

			<cpu:SubtractImmediateFromAL/>
			<string>0</string>

			<cpu:CopyAXToAbsoluteMemory/>
			<addressOf ref="value" type="Absolute32"/>

			<fpu:PushIntegerAtImmediateAddressToST0/>
			<addressOf ref="value" type="Absolute32"/>

			<fpu:DivideST0ByST1/>

			<fpu:AddST0ToST2AndIncrementST/>

			<fpu:MultiplyST0ByST2/>

			<cpu:WaitForFloatingPointUnit/>
			
			<cpu:LoopToRelative8/>
			<addressOf ref="nextDecimal" type="Relative8"/>

			<fpu:PullST0/>

			<cpu:WaitForFloatingPointUnit/>

			<cpu:PullAXFromStack/>

			<cpu:CompareALToImmediate/>
			<string>-</string>

			<cpu:BranchToRelative8IfNotEqual/>
			<addressOf ref="end" type="Relative8"/>

			<fpu:ChangeSign/>

			<cpu:WaitForFloatingPointUnit/>

			<cpu:JumpToRelative8/>
			<addressOf ref="end" type="Relative8"/>

			<var:integer id="value">0</var:integer>
			
			<label id="end"/>
		</scope>
	</xsl:template>
	
	<xsl:template match="float:ToString">
		<scope>
			<!--<fpu:ResetFpu/>-->
			
			<cpu:CopyImmediateToOperandFunction/>
			<imm:CopyImmediateToImmediateAddress/>
			<addressOf ref="value" type="Absolute32"/>
			<hex>00000f7f</hex>

			<fpu:SetControlToShortAtImmediateAddress/>
			<addressOf ref="value" type="Absolute32"/>

			<cpu:CopyImmediateToOperandFunction/>
			<imm:CopyImmediateToImmediateAddress/>
			<addressOf ref="value" type="Absolute32"/>
			<int>10</int>

			<fpu:PushIntegerAtImmediateAddressToST0/>
			<addressOf ref="value" type="Absolute32"/>

			<!--<cpu:CopyRegisterToOperand/>
			<op:DI-SIRegister/>

			<obj:GetData/>

			<fpu:PushFloatAtSIAddressToST0/>-->

			<fpu:ExchangeST1WithST0/>

			<str:Create length="20"/>

			<cpu:PushDIToStack/>
			
			<!--Find Sign-->
			<fpu:CopyST0ToFloatAtImmediateAddress/>
			<addressOf ref="value" type="Absolute32"/>

			<cpu:WaitForFloatingPointUnit/>

			<cpu:CopyAbsoluteMemoryToAX/>
			<addressOf ref="value" type="Absolute32"/>

			<cpu:TestAXWithImmediate/>
			<hex>80000000</hex>

			<cpu:BranchToRelative8IfZero/>
			<addressOf ref="notNegative" type="Relative8"/>

			<fpu:ChangeSign/>

			<cpu:PullSIFromStack/>
			<cpu:PushSIToStack/>

			<str:AppendCharacter value="-"/>

			<label id="notNegative"/>

			<!--Calculate Whole Number-->
			<fpu:CopyST0ToIntegerAtImmediateAddress/>
			<addressOf ref="value" type="Absolute32"/>
			
			<cpu:WaitForFloatingPointUnit/>

			<!--<fpu:PushIntegerAtImmediateAddressToST0/>
			<addressOf ref="value" type="Absolute32"/>

			<fpu:SubtractST0FromST1AndIncrementST/>-->

			<!--Get Whole Number-->
			<cpu:CopyAbsoluteMemoryToAX/>
			<addressOf ref="value" type="Absolute32"/>

			<int:ToString/>

			<cpu:PullSIFromStack/>
			<cpu:PushSIToStack/>

			<cpu:ExchangeOperandWithRegister/>
			<op:SI-DIRegister/>

			<str:AppendString/>

			<cpu:PullSIFromStack/>
			<cpu:PushSIToStack/>

			<str:AppendCharacter value="."/>

			<!--Get Fractional Numbers-->
			<fpu:AbsoluteValue/>
			
			<fpu:CopyST0ToIntegerAtImmediateAddress/>
			<addressOf ref="value" type="Absolute32"/>

			<fpu:PushIntegerAtImmediateAddressToST0/>
			<addressOf ref="value" type="Absolute32"/>

			<fpu:SubtractST0FromST1AndIncrementST/>

			<cpu:CopyImmediateToCX/>
			<int>5</int>

			<label id="nextDigit"/>

			<fpu:MultiplyST0ByST1/>
			
			<fpu:CopyST0ToIntegerAtImmediateAddress/>
			<addressOf ref="value" type="Absolute32"/>

			<cpu:WaitForFloatingPointUnit/>

			<fpu:PushIntegerAtImmediateAddressToST0/>
			<addressOf ref="value" type="Absolute32"/>

			<fpu:SubtractST0FromST1AndIncrementST/>

			<!--Get Decimal Number-->
			<cpu:CopyAbsoluteMemoryToAX/>
			<addressOf ref="value" type="Absolute32"/>

			<cpu:AddImmediateToAL/>
			<asc:Zero/>

			<cpu:PullSIFromStack/>
			<cpu:PushSIToStack/>

			<str:AppendCharacter/>

			<cpu:DecrementCX/>

			<cpu:BranchToRelative8IfZero/>
			<addressOf ref="lastDigit" type="Relative8"/>

			<cpu:JumpToRelative/>
			<addressOf ref="nextDigit" type="Relative32"/>

			<!--Last Digit-->
			<label id="lastDigit"/>

			<cpu:CopyImmediateToOperandFunction/>
			<imm:CopyImmediateToImmediateAddress/>
			<addressOf ref="value" type="Absolute32"/>
			<hex>0000037f</hex>

			<fpu:SetControlToShortAtImmediateAddress/>
			<addressOf ref="value" type="Absolute32"/>

			<fpu:PullIntegerAtImmediateAddressFromST0/>
			<addressOf ref="value" type="Absolute32"/>

			<fpu:PullST0/>

			<cpu:WaitForFloatingPointUnit/>

			<!--Get Decimal Number-->
			<cpu:CopyAbsoluteMemoryToAX/>
			<addressOf ref="value" type="Absolute32"/>

			<cpu:AddImmediateToAL/>
			<asc:Zero/>

			<cpu:PullSIFromStack/>
			<cpu:PushSIToStack/>

			<str:AppendCharacter/>

			<!--Create Object-->
			<cpu:PullDIFromStack/>

			<cpu:JumpToRelative8/>
			<addressOf ref="end" type="Relative8"/>
			
			<var:integer id="value">0</var:integer>

			<label id="end"/>
		</scope>
	</xsl:template>
</xsl:stylesheet>
