<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:var="http://metalx.org/Variable"
	xmlns:lst="http://metalx.org/i386/Functions/List"
	xmlns:dict="http://metalx.org/i386/Functions/Dictionary"
	xmlns:obj="http://metalx.org/i386/Functions/Object"
	xmlns:cat="http://metalx.org/i386/Functions/Catalog"
	xmlns:mm="http://metalx.org/i386/Functions/MemoryManager"
	xmlns:sys="http://metalx.org/i386/Functions/System"
	xmlns:inc="http://metalx.org/Intel/80386/Increment"
	xmlns:imm="http://metalx.org/Intel/80386/Immediate"
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

	<xsl:template match="dict:Create">
		<cpu:ShiftRegisterByImmediate8Function/>
		<shift:ShiftAXRegisterLeft/>
		<byte>3</byte>
	</xsl:template>

	<xsl:template match="dict:CreateObject">
		<scope>
			<cpu:PushDIToStack/>

			<cpu:CopyImmediateToDI/>
			<addressOf ref="className" type="Absolute32"/>

			<sys:GetCatalog/>

			<cat:FindType/>

			<cpu:CopyRegisterToOperand/>
			<op:SI-BXRegister/>

			<cpu:PullDIFromStack/>

			<cpu:CopyImmediateToAX/>
			<int>8</int>

			<obj:Create/>

			<cpu:JumpToRelative8/>
			<addressOf ref="end" type="Relative8"/>

			<var:string id="className">http://metalx.org/Dictionary</var:string>

			<label id="end"/>
		</scope>
	</xsl:template>

	<!--<xsl:template match="col:CreateIteratorObject">
		<scope>
			<cpu:PushDIToStack/>

			<cpu:CopyImmediateToDI/>
			<addressOf ref="className" type="Absolute32"/>

			<sys:GetCatalog/>

			<cat:FindType/>

			<cpu:CopyRegisterToOperand/>
			<op:SI-BXRegister/>

			<cpu:CopyImmediateToAX/>
			<int>8</int>

			<mm:CheckOut/>

			<cpu:PullDXFromStack/>

			<cpu:CopyRegisterToOperand/>
			<op:DX-DIAddress/>

			<cpu:CopyImmediateToOperandFunction/>
			<imm:CopyImmediateToDIAddressPlusImmediate8/>
			<byte>4</byte>
			<int>0</int>

			<obj:Create/>

			<cpu:JumpToRelative8/>
			<addressOf ref="end" type="Relative8"/>

			<var:string id="className">http://metalx.org/DictionaryIterator</var:string>

			<label id="end"/>
		</scope>
	</xsl:template>

	<xsl:template match="col:GetCount">
		<cpu:CopyOperandToRegister/>
		<op:AX-SIAddress/>
	</xsl:template>

	<xsl:template match="col:GetCapacity">
		<cpu:CopyOperandToRegister/>
		<op:SI-SIAddressPlusImmediate8/>
		<byte>4</byte>

		<lst:GetLength/>
	</xsl:template>

	<xsl:template match="col:GetItem">
		<cpu:CopyOperandToRegister/>
		<op:SI-SIAddressPlusImmediate8/>
		<byte>4</byte>

		<xsl:choose>
			<xsl:when test="@index">
				<lst:GetItem index="{@index}"/>
			</xsl:when>
			<xsl:otherwise>
				<lst:GetItem/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="col:AddItem">
		<scope>
			<cpu:PushSIToStack/>

			<cpu:CopyOperandToRegister/>
			<op:AX-SIAddress/>

			<cpu:CopyOperandToRegister/>
			<op:SI-SIAddressPlusImmediate8/>
			<byte>4</byte>

			<cpu:CompareRegisterToOperand/>
			<op:AX-SIAddress/>

			<cpu:BranchToRelativeIfLess8/>
			<addressOf ref="available" type="Relative8"/>

			--><!--Create New List--><!--
			<cpu:CopyRegisterToOperand/>
			<op:DI-DXRegister/>

			<cpu:PushAXToStack/>

			<cpu:ShiftRegisterByOneFunction/>
			<shift:ShiftAXRegisterLeft/>

			<lst:Create/>

			--><!--Copy Items To New List--><!--
			<cpu:PullAXFromStack/>

			<cpu:PushDIToStack/>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToSIRegister/>
			<byte>4</byte>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToDIRegister/>
			<byte>4</byte>

			<cpu:CopyRegisterToOperand/>
			<op:AX-CXRegister/>

			<cpu:Repeat/>
			<cpu:CopySIAddressToDIAddressAndIncrementSIAndDI/>

			<cpu:PullDIFromStack/>

			<cpu:PullSIFromStack/>

			<cpu:CopyRegisterToOperand/>
			<op:DI-SIAddressPlusImmediate8/>
			<byte>4</byte>

			<cpu:PushSIToStack/>

			<cpu:CopyOperandToRegister/>
			<op:SI-SIAddressPlusImmediate8/>
			<byte>4</byte>

			<cpu:CopyRegisterToOperand/>
			<op:DX-DIRegister/>

			<label id="available"/>

			<lst:SetItem/>

			<cpu:PullSIFromStack/>

			<cpu:IncrementFunction/>
			<inc:IncrementSIAddress/>
		</scope>
	</xsl:template>
	
	<xsl:template match="col:RemoveItem">
		<scope>
			--><!--Find Item--><!--
			<cpu:CopyOperandToRegister/>
			<op:CX-SIAddress/>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:CompareWithCXRegister/>
			<byte>0</byte>

			<cpu:BranchToRelative8IfEqual/>
			<addressOf ref="done" type="Relative8"/>

			<cpu:CopyRegisterToOperand/>
			<op:DI-AXRegister/>

			<cpu:CopyOperandToRegister/>
			<op:DI-SIAddressPlusImmediate8/>
			<byte>4</byte>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToDIRegister/>
			<byte>4</byte>

			<cpu:RepeatWhileNotEqual/>
			<cpu:CompareAXToDIAddressAndIncrementDI/>

			<cpu:BranchToRelative8IfNotEqual/>
			<addressOf ref="done" type="Relative8"/>

			--><!--Remove Item--><!--
			<cpu:IncrementFunction/>
			<inc:DecrementSIAddress xmlns:inc="http://metalx.org/Intel/80386/Increment"/>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:CompareWithCXRegister/>
			<byte>0</byte>

			<cpu:BranchToRelative8IfEqual/>
			<addressOf ref="done" type="Relative8"/>

			<cpu:CopyRegisterToOperand/>
			<op:DI-SIRegister/>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:SubtractFromDIRegister/>
			<byte>4</byte>

			<cpu:Repeat/>
			<cpu:CopySIAddressToDIAddressAndIncrementSIAndDI/>

			<label id="done"/>
		</scope>
	</xsl:template>

	<xsl:template match="col:ForEach">
		<scope>
			<cpu:CopyOperandToRegister/>
			<op:CX-SIAddress/>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:CompareWithCXRegister/>
			<byte>0</byte>

			<cpu:BranchToRelative8IfNotEqual/>
			<addressOf ref="start" type="Relative8"/>

			<cpu:JumpToRelative/>
			<addressOf ref="end" type="Relative32"/>

			<label id="start"/>

			<cpu:CopyOperandToRegister/>
			<op:SI-SIAddressPlusImmediate8/>
			<byte>4</byte>

			<label id="next"/>
			
			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToSIRegister/>
			<byte>4</byte>

			<cpu:CopyRegisterToOperand/>
			<op:SI-DXRegister/>

			<cpu:PushSIToStack/>

			<cpu:CopyOperandToRegister/>
			<op:SI-SIAddress/>

			<xsl:apply-templates select="@* | node()"/>

			<cpu:CopyRegisterToOperand/>
			<op:DX-SIRegister/>

			<cpu:PullSIFromStack/>

			<cpu:LoopToRelative8/>
			<addressOf ref="next" type="Relative8"/>

			<label id="end"/>
		</scope>
	</xsl:template>-->
</xsl:stylesheet>
