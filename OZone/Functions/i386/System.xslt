<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sys="http://metalx.org/i386/Functions/System"
	xmlns:kbd="http://metalx.org/Pc/Keyboard"
	xmlns:ari="http://metalx.org/Intel/80386/Arithmetic"
	xmlns:math="http://metalx.org/Intel/80386/Math"
	xmlns:shift="http://metalx.org/Intel/80386/Shift"
	xmlns:imm="http://metalx.org/Intel/80386/Immediate"
	xmlns:cpu="http://metalx.org/Intel/80386/Operators"
	xmlns:op="http://metalx.org/Intel/80386/Operands">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="sys:GetMemoryManager">
		<cpu:CopyImmediateToSI/>
		<hex>01100000</hex>
	</xsl:template>

	<xsl:template match="sys:GetProcessors">
		<cpu:CopyImmediateToSI/>
		<hex>01000010</hex>
	</xsl:template>

	<xsl:template match="sys:GetTaskManager">
		<cpu:CopyImmediateToSI/>
		<hex>01000000</hex>
	</xsl:template>

	<xsl:template match="sys:GetCatalog">
		<cpu:CopyImmediateToSI/>
		<hex>00005000</hex>
	</xsl:template>

	<xsl:template match="sys:GetMemoryMap">
		<cpu:CopyImmediateToSI/>
		<hex>00003000</hex>
	</xsl:template>

	<xsl:template match="sys:Lock">
		<scope>
			<cpu:CopyImmediateToCX/>
			<int>1</int>

			<label id="waitForLock"/>

			<cpu:ExchangeOperandWithRegister/>
			<op:CX-ImmediateAddress/>
			<hex>01000020</hex>

			<cpu:BranchToRelative8IfCXIsZero/>
			<addressOf ref="lockAcquired" type="Relative8"/>

			<cpu:JumpToRelative8/>
			<addressOf ref="waitForLock" type="Relative8"/>

			<label id="lockAcquired"/>
		</scope>
	</xsl:template>

	<xsl:template match="sys:Unlock">
		<cpu:CopyImmediateToOperandFunction/>
		<imm:CopyImmediateToImmediateAddress/>
		<hex>01000020</hex>
		<int>0</int>
	</xsl:template>

	<xsl:template match="sys:Reset">
		<cpu:CopyImmediateToAL/>
		<kbd:ResetCpu/>

		<cpu:WriteALToImmediate8Port/>
		<kbd:ControlPort/>
	</xsl:template>
	
	<xsl:template match="sys:Shutdown">
		<!--Find ACPI Root System Descriptor Pointer-->
		<cpu:CopyImmediateToDI/>
		<hex>000E0000</hex>

		<cpu:CopyImmediateToAX/>
		<string xml:space="preserve">RSD </string>

		<cpu:CopyImmediateToCX/>
		<hex>00008000</hex>

		<cpu:RepeatWhileNotEqual/>
		<cpu:CompareAXToDIAddressAndIncrementDI/>

		<!--Get Root System Descriptor Table-->
		<cpu:CopyOperandToRegister/>
		<op:DI-DIAddressPlusImmediate8/>
		<byte>12</byte>

		<!--Get Child Table Count-->
		<cpu:CopyImmediateToDX/>
		<int>0</int>

		<cpu:CopyOperandToRegister/>
		<op:AX-DIAddressPlusImmediate8/>
		<byte>4</byte>

		<cpu:CopyImmediateToBX/>
		<int>4</int>

		<cpu:ArithmeticDXAXOperandFunction/>
		<ari:DivideByBXRegister/>

		<cpu:CopyRegisterToOperand/>
		<op:AX-CXRegister/>

		<!--Find Fixed ACPI Description Table-->
		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDIRegister/>
		<byte>36</byte>

		<label id="findFacp"/>

		<cpu:CopyOperandToRegister/>
		<op:AX-DIAddress/>

		<cpu:CopyOperandToRegister/>
		<op:AX-AXAddress/>

		<cpu:CompareAXToImmediate/>
		<string>FACP</string>

		<cpu:BranchToRelative8IfEqual/>
		<addressOf ref="getSystemControlPort" type="Relative8"/>

		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDIRegister/>
		<byte>4</byte>

		<cpu:LoopToRelative8/>
		<addressOf ref="findFacp" type="Relative8"/>

		<!--Get System Control Port-->
		<label id="getSystemControlPort"/>

		<cpu:CopyOperandToRegister/>
		<op:DI-DIAddress/>

		<cpu:CopyOperandToRegister/>
		<op:DX-DIAddressPlusImmediate8/>
		<byte>64</byte>

		<!--Get Shutdown Value-->
		<cpu:CopyOperandToRegister/>
		<op:DI-DIAddressPlusImmediate8/>
		<byte>40</byte>

		<cpu:CopyOperandToRegister/>
		<op:CX-DIAddressPlusImmediate8/>
		<byte>4</byte>

		<cpu:MathImmediate8ToOperandFunction/>
		<math:SubtractFromCXRegister/>
		<byte>36</byte>

		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDIRegister/>
		<byte>36</byte>

		<!--Find Shutdown Value-->
		<label id="findShutdownValue"/>

		<cpu:MathImmediateToOperandFunction/>
		<math:CompareWithDIAddress/>
		<string>_S5_</string>

		<cpu:BranchToRelative8IfNotEqual/>
		<addressOf ref="nextByte" type="Relative8"/>

		<cpu:CopyOperandToRegister8/>
		<op:AL-DIAddressPlusImmediate8/>
		<sbyte>-1</sbyte>

		<cpu:CompareALToImmediate/>
		<hex>08</hex>

		<cpu:BranchToRelative8IfEqual/>
		<addressOf ref="checkNextByte" type="Relative8"/>

		<cpu:CopyOperandToRegister8/>
		<op:AL-DIAddressPlusImmediate8/>
		<sbyte>-2</sbyte>

		<cpu:CompareALToImmediate/>
		<hex>08</hex>

		<cpu:BranchToRelative8IfNotEqual/>
		<addressOf ref="nextByte" type="Relative8"/>

		<cpu:CopyOperandToRegister8/>
		<op:AL-DIAddressPlusImmediate8/>
		<sbyte>-1</sbyte>

		<cpu:CompareALToImmediate/>
		<string>\</string>

		<cpu:BranchToRelative8IfNotEqual/>
		<addressOf ref="nextByte" type="Relative8"/>

		<label id="checkNextByte"/>

		<cpu:CopyOperandToRegister8/>
		<op:AL-DIAddressPlusImmediate8/>
		<byte>4</byte>

		<cpu:CompareALToImmediate/>
		<hex>12</hex>

		<cpu:BranchToRelative8IfNotEqual/>
		<addressOf ref="nextByte" type="Relative8"/>

		<cpu:JumpToRelative8/>
		<addressOf ref="getShutdownValue" type="Relative8"/>

		<label id="nextByte"/>

		<cpu:IncrementDI/>

		<cpu:LoopToRelative8/>
		<addressOf ref="findShutdownValue" type="Relative8"/>

		<label id="getShutdownValue"/>

		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDIRegister/>
		<byte>5</byte>

		<cpu:CopyOperandToRegister/>
		<op:AX-DIAddress/>

		<cpu:AndAXWithImmediate/>
		<hex>000000C0</hex>

		<cpu:ShiftRegisterByImmediate8Function/>
		<shift:ShiftAXRegisterRight/>
		<byte>6</byte>

		<cpu:IncrementAX/>
		<cpu:IncrementAX/>

		<cpu:AddRegisterToOperand/>
		<op:AX-DIRegister/>

		<cpu:CopyOperandToRegister8/>
		<op:AL-DIAddress/>

		<cpu:CompareALToImmediate/>
		<hex>0a</hex>

		<cpu:BranchToRelative8IfNotEqual/>
		<addressOf ref="noPrefix" type="Relative8"/>

		<cpu:IncrementDI/>

		<label id="noPrefix"/>

		<cpu:Operand16/>
		<cpu:CopyOperandToRegister/>
		<op:AX-DIAddress/>

		<cpu:ShiftRegisterByImmediate8Function/>
		<shift:ShiftAXRegisterLeft/>
		<byte>10</byte>

		<cpu:OrAXWithImmediate/>
		<hex>00002000</hex>

		<cpu:Operand16/>
		<cpu:WriteAXToDXPort/>
	</xsl:template>
</xsl:stylesheet>
