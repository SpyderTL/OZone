<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:var="http://metalx.org/Variable"
	xmlns:inc="http://metalx.org/Intel/80386/Increment"
	xmlns:imm="http://metalx.org/Intel/80386/Immediate"
	xmlns:math="http://metalx.org/Intel/80386/Math"
	xmlns:cpu="http://metalx.org/Intel/80386/Operators"
	xmlns:op="http://metalx.org/Intel/80386/Operands"
	xmlns:obj="http://metalx.org/i386/Functions/Object"
	xmlns:cat="http://metalx.org/i386/Functions/Catalog"
	xmlns:str="http://metalx.org/i386/Functions/String"
	xmlns:sys="http://metalx.org/i386/Functions/System"
	xmlns:mm="http://metalx.org/i386/Functions/MemoryManager">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="str:Create">
		<xsl:choose>
			<xsl:when test="@length">
				<xsl:element name="mm:CheckOut">
					<xsl:attribute name="length">
						<xsl:value-of select="@length+4"/>
					</xsl:attribute>
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>
				<cpu:AddImmediateToAX/>
				<int>4</int>
				<mm:CheckOut/>
			</xsl:otherwise>
		</xsl:choose>

		<!--Clear buffer length-->
		<cpu:CopyImmediateToOperandFunction/>
		<imm:CopyImmediateToDIAddress/>
		<int>0</int>
	</xsl:template>

	<xsl:template match="str:CreateObject">
		<scope>
			<!--Get String Length-->
			<cpu:CopyOperandToRegister/>
			<op:AX-DIAddress/>

			<cpu:IncrementAX/>
			<cpu:IncrementAX/>
			<cpu:IncrementAX/>
			<cpu:IncrementAX/>

			<cpu:PushAXToStack/>
			<cpu:PushSIToStack/>
			<cpu:PushDIToStack/>

			<cpu:CopyImmediateToDI/>
			<addressOf ref="stringClassName" type="Absolute32"/>

			<sys:GetCatalog/>

			<cat:FindType/>

			<cpu:CopyRegisterToOperand/>
			<op:SI-BXRegister/>

			<cpu:PullDIFromStack/>
			<cpu:PullSIFromStack/>
			<cpu:PullAXFromStack/>

			<obj:Create/>

			<cpu:JumpToRelative8/>
			<addressOf ref="end" type="Relative8"/>

			<var:string id="stringClassName">http://metalx.org/String</var:string>

			<label id="end"/>
		</scope>
	</xsl:template>

	<xsl:template match="str:Clear">
		<!--Reset buffer length-->
		<cpu:CopyImmediateToOperandFunction/>
		<imm:CopyImmediateToSIAddress/>
		<int>0</int>
	</xsl:template>

	<xsl:template match="str:Copy">
		<cpu:CopyOperandToRegister/>
		<op:CX-SIAddress/>

		<cpu:CopySIAddressToDIAddressAndIncrementSIAndDI/>

		<cpu:Repeat/>
		<cpu:CopySIAddressToDIAddressAndIncrementSIAndDI8/>
	</xsl:template>

	<xsl:template match="str:Clone">
		<cpu:CopyOperandToRegister/>
		<op:CX-SIAddress/>

		<cpu:CopyRegisterToOperand/>
		<op:CX-AXRegister/>

		<cpu:AddImmediateToAX/>
		<int>4</int>

		<mm:CheckOut/>

		<cpu:PushDIToStack/>
		
		<cpu:CopySIAddressToDIAddressAndIncrementSIAndDI/>

		<cpu:Repeat/>
		<cpu:CopySIAddressToDIAddressAndIncrementSIAndDI8/>

		<cpu:PullDIFromStack/>
	</xsl:template>

	<xsl:template match="str:ContainsCharacter">
		<cpu:CopyOperandToRegister/>
		<op:CX-DIAddress/>

		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDIRegister/>
		<byte>4</byte>

		<cpu:RepeatWhileNotEqual/>
		<cpu:CompareALToDIAddressAndIncrementDI/>
	</xsl:template>

	<xsl:template match="str:ContainsString">
		<scope>
			<!--Set CX To Destination Length-->
			<cpu:CopyOperandToRegister/>
			<op:CX-DIAddress/>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToDIRegister/>
			<byte>4</byte>

			<!--Set AX To Source Length-->
			<cpu:CopySIAddressToAXAndIncrementSI/>

			<cpu:SubtractRegisterFromOperand/>
			<op:AX-CXRegister/>

			<cpu:BranchToRelative8IfNegative/>
			<addressOf ref="end" type="Relative8"/>

			<cpu:IncrementCX/>

			<label id="nextCharacter"/>

			<cpu:PushSIToStack/>
			<cpu:PushDIToStack/>
			<cpu:PushAXToStack/>
			<cpu:ExchangeCXWithAX/>

			<cpu:RepeatWhileEqual/>
			<cpu:CompareSIAddressToDIAddressAndIncrementSIAndDI8/>

			<cpu:ExchangeCXWithAX/>
			<cpu:PullAXFromStack/>
			<cpu:PullDIFromStack/>
			<cpu:PullSIFromStack/>

			<cpu:PushFlagsToStack/>

			<cpu:IncrementDI/>

			<cpu:PullFlagsFromStack/>

			<cpu:LoopToRelative8WhileNotEqual/>
			<addressOf ref="nextCharacter" type="Relative8"/>

			<label id="end"/>
		</scope>
	</xsl:template>

	<xsl:template match="str:GetLength">
		<!--Set AX to the value at SI-->
		<cpu:CopyOperandToRegister/>
		<op:AX-SIAddress/>
	</xsl:template>

	<xsl:template match="str:AppendCharacter">
		<!--Increase string length-->
		<cpu:IncrementFunction/>
		<inc:IncrementSIAddress/>

		<!--Jump to next character-->
		<cpu:AddOperandToRegister/>
		<op:SI-SIAddress/>

		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToSIRegister/>
		<byte>3</byte>

		<xsl:choose>
			<xsl:when test="@value">
				<cpu:CopyImmediateToOperandFunction8/>
				<imm:CopyImmediateToSIAddress/>
				<string xml:space="preserve"><xsl:value-of select="@value"/></string>
			</xsl:when>
			<xsl:otherwise>
				<!--Copy character from AL to address of SI-->
				<cpu:CopyRegisterToOperand8/>
				<op:AL-SIAddress/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="str:AppendString">
		<cpu:CopyOperandToRegister/>
		<op:CX-SIAddress/>

		<cpu:IncrementSI/>
		<cpu:IncrementSI/>
		<cpu:IncrementSI/>
		<cpu:IncrementSI/>

		<cpu:CopyRegisterToOperand/>
		<op:DI-BXRegister/>

		<cpu:PushCXToStack/>

		<cpu:CopyOperandToRegister/>
		<op:CX-DIAddress/>

		<cpu:AddOperandToRegister/>
		<op:DI-CXRegister/>

		<cpu:IncrementDI/>
		<cpu:IncrementDI/>
		<cpu:IncrementDI/>
		<cpu:IncrementDI/>

		<cpu:PullCXFromStack/>

		<cpu:AddRegisterToOperand/>
		<op:CX-BXAddress/>

		<cpu:Repeat/>
		<cpu:CopySIAddressToDIAddressAndIncrementSIAndDI8/>
	</xsl:template>

	<xsl:template match="str:TrimCharacter">
		<!--Decrease buffer length-->
		<cpu:IncrementFunction/>
		<inc:DecrementSIAddress/>
	</xsl:template>

	<xsl:template match="str:Compare">
		<cpu:CopyOperandToRegister/>
		<op:CX-SIAddress/>

		<cpu:IncrementCX/>
		<cpu:IncrementCX/>
		<cpu:IncrementCX/>
		<cpu:IncrementCX/>

		<cpu:RepeatWhileEqual/>
		<cpu:CompareSIAddressToDIAddressAndIncrementSIAndDI8/>
	</xsl:template>

	<xsl:template match="str:BeginsWith">
		<scope>
			<cpu:CopyOperandToRegister/>
			<op:CX-DIAddress/>

			<cpu:CompareSIAddressToDIAddressAndIncrementSIAndDI/>

			<cpu:BranchToRelative8IfLess/>
			<addressOf ref="end" type="Relative8"/>

			<cpu:RepeatWhileEqual/>
			<cpu:CompareSIAddressToDIAddressAndIncrementSIAndDI8/>

			<label id="end"/>
		</scope>
	</xsl:template>

	<xsl:template match="str:ForEach">
		<scope>
			<cpu:CopyOperandToRegister/>
			<op:CX-SIAddress/>

			<cpu:MathImmediateToOperandFunction/>
			<math:CompareWithCXRegister/>
			<int>0</int>

			<cpu:BranchToRelative8IfNotEqual/>
			<addressOf ref="start" type="Relative8"/>

			<cpu:JumpToRelative/>
			<addressOf ref="end" type="Relative32"/>

			<label id="start"/>

			<cpu:IncrementSI/>
			<cpu:IncrementSI/>
			<cpu:IncrementSI/>

			<label id="next"/>

			<cpu:IncrementSI/>

			<cpu:CopyOperandToRegister8/>
			<op:AL-SIAddress/>

			<xsl:apply-templates select="@* | node()"/>

			<cpu:LoopToRelative8/>
			<addressOf ref="next" type="Relative8"/>

			<label id="end"/>
		</scope>
	</xsl:template>

</xsl:stylesheet>
