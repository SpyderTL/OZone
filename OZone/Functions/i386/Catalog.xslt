<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:mm="http://metalx.org/i386/Functions/MemoryManager"
	xmlns:lst="http://metalx.org/i386/Functions/List"
	xmlns:cls="http://metalx.org/i386/Functions/Class"
	xmlns:cat="http://metalx.org/i386/Functions/Catalog"
	xmlns:cpu="http://metalx.org/Intel/80386/Operators"
	xmlns:op="http://metalx.org/Intel/80386/Operands"
	xmlns:imm="http://metalx.org/Intel/80386/Immediate"
	xmlns:math="http://metalx.org/Intel/80386/Math">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="cat:Create">
		<!--<mm:CheckOut length="4"/>

		<cpu:CopyRegisterToOperand/>
		<op:DI-BXRegister/>

		<cpu:CopyImmediateToAX/>
		<short>128</short>

		<col:Create/>

		<cpu:CopyRegisterToOperand/>
		<op:DI-BXAddress/>

		<cpu:IncrementBX/>
		<cpu:IncrementBX/>

		<col:Create/>

		<cpu:CopyRegisterToOperand/>
		<op:DI-BXAddress/>

		<cpu:CopyRegisterToOperand/>
		<op:BX-DIRegister/>-->
	</xsl:template>

	<xsl:template match="cat:GetObjects">
		<!--<cpu:CopyOperandToRegister/>
		<op:SI-SIAddress/>-->
	</xsl:template>

	<xsl:template match="cat:GetIndexes">
		<!--<cpu:CopyOperandToRegister/>
		<op:SI-SIAddressPlusImmediate8/>
		<byte>4</byte>-->
	</xsl:template>

	<xsl:template match="cat:FindClass">
		<!--<cpu:CopyOperandToRegister/>
		<op:SI-SIAddress/>-->

		<scope>
			<lst:ForEach>
				<cpu:PushSIToStack/>
				<cpu:PushDIToStack/>
				<cpu:PushCXToStack/>

				<cls:GetName />

				<!--Compare Strings-->
				<cpu:CopyOperandToRegister/>
				<op:CX-SIAddress/>

				<cpu:MathImmediate8ToOperandFunction/>
				<math:AddToCXRegister/>
				<byte>4</byte>

				<cpu:RepeatWhileEqual/>
				<cpu:CompareSIAddressToDIAddressAndIncrementSIAndDI8/>

				<cpu:PullCXFromStack/>
				<cpu:PullDIFromStack/>
				<cpu:PullSIFromStack/>

				<cpu:BranchToRelative8IfEqual/>
				<addressOf ref="classFound" type="Relative8"/>
			</lst:ForEach>

			<label id="classFound"/>
		</scope>
	</xsl:template>

	<xsl:template match="cat:FindType">
		<!--<cpu:CopyOperandToRegister/>
		<op:SI-SIAddress/>-->
		
		<scope>
			<lst:ForEach>
				<cpu:PushSIToStack/>
				<cpu:PushDIToStack/>
				<cpu:PushCXToStack/>

				<cls:GetNamespace/>

				<!--Compare Strings-->
				<cpu:CopyOperandToRegister/>
				<op:CX-SIAddress/>

				<cpu:MathImmediate8ToOperandFunction/>
				<math:AddToCXRegister/>
				<byte>4</byte>

				<cpu:RepeatWhileEqual/>
				<cpu:CompareSIAddressToDIAddressAndIncrementSIAndDI8/>

				<cpu:PullCXFromStack/>
				<cpu:PullDIFromStack/>
				<cpu:PullSIFromStack/>

				<cpu:BranchToRelative8IfEqual/>
				<addressOf ref="classFound" type="Relative8"/>
			</lst:ForEach>

			<label id="classFound"/>
		</scope>
	</xsl:template>

</xsl:stylesheet>
