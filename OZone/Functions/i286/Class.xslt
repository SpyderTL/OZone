<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:clsf="http://metalx.org/i286/Functions/Class"
	xmlns:con="http://metalx.org/i286/Functions/Console"
	xmlns:mm="http://metalx.org/i286/Functions/MemoryManager"
	xmlns:ari="http://metalx.org/Intel/80286/Arithmetic"
	xmlns:math="http://metalx.org/Intel/80286/Math"
	xmlns:cpu="http://metalx.org/Intel/80286/Operators"
	xmlns:op="http://metalx.org/Intel/80286/Operands">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="clsf:GetName">
		<cpu:AddOperandToRegister16/>
		<op:SI-SIAddress/>
	</xsl:template>

	<xsl:template match="clsf:GetNamespace">
		<cpu:AddOperandToRegister16/>
		<op:SI-SIAddressPlusImmediate8/>
		<byte>2</byte>
	</xsl:template>

	<xsl:template match="clsf:GetFields">
		<cpu:AddOperandToRegister16/>
		<op:SI-SIAddressPlusImmediate8/>
		<byte>4</byte>
	</xsl:template>

	<xsl:template match="clsf:GetInstanceMethods">
		<cpu:AddOperandToRegister16/>
		<op:SI-SIAddressPlusImmediate8/>
		<byte>6</byte>
	</xsl:template>

	<xsl:template match="clsf:GetStaticMethods">
		<cpu:AddOperandToRegister16/>
		<op:SI-SIAddressPlusImmediate8/>
		<byte>8</byte>
	</xsl:template>

	<xsl:template match="clsf:IsStatic">
		<cpu:CopyOperandToRegister16/>
		<op:AX-SIAddressPlusImmediate8/>
		<byte>10</byte>

		<cpu:AndAXWithImmediate/>
		<short>1</short>

		<cpu:CompareAXToImmediate/>
		<short>1</short>
	</xsl:template>

	<xsl:template match="clsf:FindInstanceMethod">
		<scope>
			<!--Dereference SI-->
			<cpu:AddOperandToRegister16/>
			<op:SI-SIAddressPlusImmediate8/>
			<byte>6</byte>

			<!--Set CX to method count-->
			<cpu:CopyOperandToRegister16/>
			<op:CX-SIAddress/>

			<!--Handle classes with zero methods-->
			<cpu:MathImmediate8ToOperand16Function/>
			<math:CompareWithCXRegister/>
			<byte>0</byte>

			<cpu:BranchToRelativeIfNotEqual8/>
			<addressOf ref="firstMethod" type="Relative8"/>

			<cpu:MathImmediate8ToOperand16Function/>
			<math:CompareWithCXRegister/>
			<byte>1</byte>

			<cpu:JumpToRelative16/>
			<addressOf ref="exitFunction" type="Relative16"/>

			<label id="firstMethod"/>
			<!--Move to first method-->
			<cpu:IncrementSI/>
			<cpu:IncrementSI/>

			<!--Compare method-->
			<label id="nextMethod"/>
			<cpu:PushSIToStack/>
			<cpu:PushDIToStack/>
			<cpu:PushCXToStack/>

			<!--Dereference SI to method description-->
			<cpu:CopyOperandToRegister16/>
			<op:SI-SIAddress/>

			<!--Get method name-->
			<cpu:AddOperandToRegister16/>
			<op:SI-SIAddress/>

			<!--Set CX to character count-->
			<cpu:CopyOperandToRegister16/>
			<op:CX-DIAddress/>

			<!--Include size field-->
			<cpu:IncrementCX/>
			<cpu:IncrementCX/>

			<cpu:RepeatWhileEqual/>
			<cpu:CompareSIAddressToDIAddressAndIncrementSIAndDI8/>

			<!--Restore registers-->
			<cpu:PullCXFromStack/>
			<cpu:PullDIFromStack/>
			<cpu:PullSIFromStack/>

			<cpu:BranchToRelativeIfEqual8/>
			<addressOf ref="exitFunction" type="Relative8"/>

			<!--Move to next method-->
			<cpu:IncrementSI/>
			<cpu:IncrementSI/>

			<!--Loop until method is found-->
			<cpu:LoopToRelativeWhileNotEqual8/>
			<addressOf ref="nextMethod" type="Relative8"/>

			<label id="exitFunction"/>
		</scope>
	</xsl:template>

	<xsl:template match="clsf:FindStaticMethod">
		<scope>
			<!--Dereference SI-->
			<cpu:AddOperandToRegister16/>
			<op:SI-SIAddressPlusImmediate8/>
			<byte>8</byte>

			<!--Set CX to method count-->
			<cpu:CopyOperandToRegister16/>
			<op:CX-SIAddress/>

			<!--Handle classes with zero methods-->
			<cpu:MathImmediate8ToOperand16Function/>
			<math:CompareWithCXRegister/>
			<byte>0</byte>

			<cpu:BranchToRelativeIfNotEqual8/>
			<addressOf ref="firstMethod" type="Relative8"/>

			<cpu:MathImmediate8ToOperand16Function/>
			<math:CompareWithCXRegister/>
			<byte>1</byte>

			<cpu:JumpToRelative16/>
			<addressOf ref="exitFunction" type="Relative16"/>

			<label id="firstMethod"/>
			<!--Move to first method-->
			<cpu:IncrementSI/>
			<cpu:IncrementSI/>

			<!--Compare method-->
			<label id="nextMethod"/>
			<cpu:PushSIToStack/>
			<cpu:PushDIToStack/>
			<cpu:PushCXToStack/>

			<!--Dereference SI to method description-->
			<cpu:CopyOperandToRegister16/>
			<op:SI-SIAddress/>

			<!--Get method name-->
			<cpu:AddOperandToRegister16/>
			<op:SI-SIAddress/>

			<!--Set CX to character count-->
			<cpu:CopyOperandToRegister16/>
			<op:CX-DIAddress/>

			<!--Include size field-->
			<cpu:IncrementCX/>
			<cpu:IncrementCX/>

			<cpu:RepeatWhileEqual/>
			<cpu:CompareSIAddressToDIAddressAndIncrementSIAndDI8/>

			<!--Restore registers-->
			<cpu:PullCXFromStack/>
			<cpu:PullDIFromStack/>
			<cpu:PullSIFromStack/>

			<cpu:BranchToRelativeIfEqual8/>
			<addressOf ref="exitFunction" type="Relative8"/>

			<cpu:IncrementSI/>
			<cpu:IncrementSI/>

			<!--Loop until method is found-->
			<cpu:LoopToRelativeWhileNotEqual8/>
			<addressOf ref="nextMethod" type="Relative8"/>

			<label id="exitFunction"/>
		</scope>
	</xsl:template>

	<xsl:template match="clsf:GetMethodName">
		<cpu:AddOperandToRegister16/>
		<op:SI-SIAddress/>
	</xsl:template>

	<xsl:template match="clsf:GetMethodEntryPoint">
		<cpu:AddOperandToRegister16/>
		<op:SI-SIAddressPlusImmediate8/>
		<byte>6</byte>
	</xsl:template>
	
	<xsl:template match="clsf:IsStaticMethod">
		<cpu:CopyOperandToRegister16/>
		<op:AX-SIAddressPlusImmediate8/>
		<byte>4</byte>

		<cpu:AndAXWithImmediate/>
		<short>1</short>

		<cpu:CompareAXToImmediate/>
		<short>1</short>
	</xsl:template>
</xsl:stylesheet>
