<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:mm="http://metalx.org/i286/Functions/MemoryManager"
	xmlns:lst="http://metalx.org/i286/Functions/List"
	xmlns:cls="http://metalx.org/i286/Functions/Class"
	xmlns:cat="http://metalx.org/i286/Functions/Catalog"
	xmlns:col="http://metalx.org/i286/Functions/Collection"
	xmlns:cpu="http://metalx.org/Intel/80286/Operators"
	xmlns:op="http://metalx.org/Intel/80286/Operands"
	xmlns:imm="http://metalx.org/Intel/80286/Immediate"
	xmlns:math="http://metalx.org/Intel/80286/Math">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="cat:Create">
		<mm:CheckOut length="4"/>

		<cpu:CopyRegisterToOperand16/>
		<op:DI-BXRegister/>

		<cpu:CopyImmediateToAX/>
		<short>128</short>

		<col:Create/>

		<cpu:CopyRegisterToOperand16/>
		<op:DI-BXAddress/>

		<cpu:IncrementBX/>
		<cpu:IncrementBX/>

		<col:Create/>

		<cpu:CopyRegisterToOperand16/>
		<op:DI-BXAddress/>

		<cpu:CopyRegisterToOperand16/>
		<op:BX-DIRegister/>
	</xsl:template>

	<xsl:template match="cat:GetObjects">
		<cpu:AddOperandToRegister16/>
		<op:SI-SIAddress/>
	</xsl:template>

	<xsl:template match="cat:GetIndexes">
		<!--<cpu:IncrementSI/>
		<cpu:IncrementSI/>

		<cpu:CopyOperandToRegister16/>
		<op:SI-SIAddress/>-->

		<cpu:AddOperandToRegister16/>
		<op:SI-SIAddressPlusImmediate8/>
		<byte>2</byte>
	</xsl:template>

	<xsl:template match="cat:FindClass">
		<scope>
			<lst:ForEach>
				<cpu:PushSIToStack/>
				<cpu:PushDIToStack/>
				<cpu:PushCXToStack/>

				<cls:GetName />

				<!--Compare Strings-->
				<cpu:CopyOperandToRegister16/>
				<op:CX-SIAddress/>

				<cpu:IncrementCX/>
				<cpu:IncrementCX/>

				<cpu:RepeatWhileEqual/>
				<cpu:CompareSIAddressToDIAddressAndIncrementSIAndDI8/>

				<cpu:PullCXFromStack/>
				<cpu:PullDIFromStack/>
				<cpu:PullSIFromStack/>

				<cpu:BranchToRelativeIfEqual8/>
				<addressOf ref="classFound" type="Relative8"/>
			</lst:ForEach>

			<label id="classFound"/>
		</scope>
	</xsl:template>

	<xsl:template match="cat:FindType">
		<scope>
			<lst:ForEach>
				<cpu:PushSIToStack/>
				<cpu:PushDIToStack/>
				<cpu:PushCXToStack/>

				<cls:GetNamespace/>

				<!--Compare Strings-->
				<cpu:CopyOperandToRegister16/>
				<op:CX-SIAddress/>

				<cpu:IncrementCX/>
				<cpu:IncrementCX/>

				<cpu:RepeatWhileEqual/>
				<cpu:CompareSIAddressToDIAddressAndIncrementSIAndDI8/>

				<cpu:PullCXFromStack/>
				<cpu:PullDIFromStack/>
				<cpu:PullSIFromStack/>

				<cpu:BranchToRelativeIfEqual8/>
				<addressOf ref="classFound" type="Relative8"/>
			</lst:ForEach>

			<label id="classFound"/>
		</scope>
	</xsl:template>

</xsl:stylesheet>
