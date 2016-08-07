<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:ns="http://metalx.org/x64/Functions/FloppyDrive"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:var="http://metalx.org/Variable"
	xmlns:ari="http://metalx.org/Amd/Amd64/Arithmetic"
	xmlns:inc="http://metalx.org/Amd/Amd64/Increment"
	xmlns:imm="http://metalx.org/Amd/Amd64/Immediate"
	xmlns:math="http://metalx.org/Amd/Amd64/Math"
	xmlns:shift="http://metalx.org/Amd/Amd64/Shift"
	xmlns:flp="http://metalx.org/Pc/Floppy/Ports"
	xmlns:fcmd="http://metalx.org/Pc/Floppy/Commands"
	xmlns:fdr="http://metalx.org/Pc/Floppy/DataRate"
	xmlns:fdo="http://metalx.org/Pc/Floppy/DigitalOutput"
	xmlns:fst="http://metalx.org/Pc/Floppy/Status"
	xmlns:cpu="http://metalx.org/Amd/Amd64/Operators"
	xmlns:op="http://metalx.org/Amd/Amd64/Operands"
	xmlns:cmos="http://metalx.org/Pc/Cmos/Ports"
	xmlns:cmr="http://metalx.org/Pc/Cmos/Registers">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="ns:GetDrives">
		<scope>
			<cpu:CopyImmediateToAL/>
			<cmr:FloppyDrives/>

			<cpu:WriteALToImmediate8Port/>
			<cmos:Register/>

			<cpu:ReadFromImmediate8PortToAL/>
			<cmos:Value/>
		</scope>
	</xsl:template>
	
	<xsl:template match="ns:ReadBlock">
		<scope>
			<cpu:CopyRegisterToOperand/>
			<op:DX-SIRegister/>
			
			<cpu:PushAXToStack/>

			<!--Turn On Motor-->
			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToDXRegister/>
			<flp:DigitalOutput/>

			<cpu:MathImmediateToOperandFunction8/>
			<math:CompareWithBLRegister/>
			<byte>0</byte>

			<cpu:BranchToRelativeIfNotEqual8/>
			<addressOf ref="channel" type="Relative8"/>
			
			<cpu:CopyImmediateToAL/>
			<fdo:Enabled/>

			<cpu:OrALWithImmediate/>
			<fdo:Drive0MotorEnabled/>

			<cpu:OrALWithImmediate/>
			<fdo:SelectDrive0/>

			<cpu:OrALWithImmediate/>
			<fdo:IrqAndDmaEnabled/>

			<cpu:WriteALToDXPort/>

			<cpu:JumpToRelative8/>
			<addressOf ref="dma" type="Relative8"/>

			<label id="channel"/>

			<cpu:CopyImmediateToAL/>
			<fdo:Enabled/>

			<cpu:OrALWithImmediate/>
			<fdo:Drive1MotorEnabled/>

			<cpu:OrALWithImmediate/>
			<fdo:SelectDrive1/>

			<cpu:OrALWithImmediate/>
			<fdo:IrqAndDmaEnabled/>

			<cpu:WriteALToDXPort/>

			<!--Set up DMA Channel 2-->
			<label id="dma"/>

			<cpu:CopyImmediateToAL/>
			<byte>2</byte>

			<cpu:OrALWithImmediate/>
			<binary>00000100</binary>

			<cpu:WriteALToImmediate8Port/>
			<hex>0a</hex>

			<!--Set target address-->
			<cpu:CopyImmediateToAL/>
			<hex>ff</hex>

			<cpu:WriteALToImmediate8Port/>
			<hex>0c</hex>

			<cpu:CopyImmediateToAL/>
			<hex>00</hex>

			<cpu:WriteALToImmediate8Port/>
			<hex>04</hex>

			<cpu:CopyImmediateToAL/>
			<hex>70</hex>

			<cpu:WriteALToImmediate8Port/>
			<hex>04</hex>

			<cpu:CopyImmediateToAL/>
			<hex>00</hex>

			<cpu:WriteALToImmediate8Port/>
			<hex>81</hex>

			<!--Set Length (minus 1)-->
			<cpu:CopyImmediateToAL/>
			<hex>ff</hex>

			<cpu:WriteALToImmediate8Port/>
			<hex>0c</hex>

			<cpu:CopyImmediateToAL/>
			<hex>ff</hex>

			<cpu:WriteALToImmediate8Port/>
			<hex>05</hex>

			<cpu:CopyImmediateToAL/>
			<hex>01</hex>

			<cpu:WriteALToImmediate8Port/>
			<hex>05</hex>

			<!--Set DMA Mode-->
			<cpu:CopyImmediateToAL/>
			<binary>01000110</binary>

			<cpu:WriteALToImmediate8Port/>
			<hex>0b</hex>

			<!--Release DMA Channel-->
			<cpu:CopyImmediateToAL/>
			<byte>2</byte>

			<cpu:WriteALToImmediate8Port/>
			<hex>0a</hex>

			<!--Calculate Sector-->
			<cpu:CopyRegisterToOperand8/>
			<op:BL-CLRegister/>
			
			<cpu:PullAXFromStack/>

			<cpu:CopyImmediateToDX/>
			<int>0</int>

			<cpu:CopyImmediateToBX/>
			<int>18</int>

			<cpu:ArithmeticDXAXOperandFunction/>
			<ari:DivideByBXRegister/>

			<!--<cpu:IncrementDX/>-->
			<cpu:IncrementFunction/>
			<inc:IncrementDXRegister/>

			<cpu:PushDXToStack/>
			<cpu:PushDXToStack/>

			<!--Calculate Head and Track-->
			<cpu:CopyImmediateToDX/>
			<int>0</int>

			<cpu:CopyImmediateToBX/>
			<int>2</int>

			<cpu:ArithmeticDXAXOperandFunction/>
			<ari:DivideByBXRegister/>

			<cpu:PushDXToStack/>
			<cpu:PushAXToStack/>
			<cpu:PushDXToStack/>

			<!--Send Read Command-->
			<cpu:CopyRegisterToOperand/>
			<op:SI-DXRegister/>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToDXRegister/>
			<flp:Data/>

			<cpu:CopyImmediateToAL/>
			<fcmd:ReadData/>

			<cpu:OrALWithImmediate/>
			<fcmd:MagneticFormatMode/>

			<cpu:WriteALToDXPort/>

			<!--Drive / Head Number-->
			<cpu:PullAXFromStack/>

			<cpu:ShiftRegisterByImmediate8Function/>
			<shift:ShiftAXRegisterLeft/>
			<byte>2</byte>

			<cpu:OrRegisterWithOperand8/>
			<op:AL-CLRegister/>

			<cpu:WriteALToDXPort/>

			<!--Cylinder Number-->
			<cpu:PullAXFromStack/>

			<cpu:WriteALToDXPort/>

			<!--Head Number-->
			<cpu:PullAXFromStack/>

			<cpu:WriteALToDXPort/>

			<!--Sector Number-->
			<cpu:PullAXFromStack/>

			<cpu:WriteALToDXPort/>

			<!--Sector Type-->
			<cpu:CopyImmediateToAL/>
			<byte>2</byte>

			<cpu:WriteALToDXPort/>

			<!--Last Sector Number-->
			<cpu:PullAXFromStack/>

			<cpu:WriteALToDXPort/>

			<!--Gap Length-->
			<cpu:CopyImmediateToAL/>
			<byte>27</byte>

			<cpu:WriteALToDXPort/>

			<!--Bytes Per Sector-->
			<cpu:CopyImmediateToAL/>
			<hex>ff</hex>

			<cpu:WriteALToDXPort/>

			<cpu:CopyImmediateToAX/>
			<int>0</int>

			<!--Wait For Data-->
			<cpu:CopyRegisterToOperand/>
			<op:SI-DXRegister/>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToDXRegister/>
			<flp:MainStatus/>

			<label id="waitForData"/>

			<cpu:ReadFromDXPortToAL/>

			<cpu:TestALWithImmediate/>
			<fst:WaitingForData/>

			<cpu:BranchToRelativeIfZero8/>
			<addressOf ref="waitForData" type="Relative8"/>

			<!--Read Data-->
			<cpu:CopyRegisterToOperand/>
			<op:SI-DXRegister/>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToDXRegister/>
			<flp:Data/>

			<!--Status 0-->
			<cpu:ReadFromDXPortToAL/>

			<!--Status 1-->
			<cpu:ReadFromDXPortToAL/>

			<!--Status 2-->
			<cpu:ReadFromDXPortToAL/>

			<!--Cylinder-->
			<cpu:ReadFromDXPortToAL/>

			<!--Last Head Number-->
			<cpu:ReadFromDXPortToAL/>

			<!--Last Sector Number-->
			<cpu:ReadFromDXPortToAL/>

			<!--Last Sector Type-->
			<cpu:ReadFromDXPortToAL/>

			<!--Turn Off Motor-->
			<label id="turnOffMotor"/>

			<cpu:CopyRegisterToOperand/>
			<op:SI-DXRegister/>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToDXRegister/>
			<flp:DigitalOutput/>

			<cpu:CopyImmediateToAL/>
			<fdo:Enabled/>

			<cpu:OrALWithImmediate/>
			<fdo:SelectDrive0/>

			<cpu:Operand16/>
			<cpu:WriteALToDXPort/>

			<!--Copy Data To Address-->
			<cpu:CopyImmediateToSI/>
			<hex>00007000</hex>

			<cpu:CopyImmediateToCX/>
			<int>128</int>

			<cpu:Repeat/>
			<cpu:CopySIAddressToDIAddressAndIncrementSIAndDI/>
		</scope>
	</xsl:template>

	<xsl:template match="ns:ReadBlocks">
		<scope>
			<cpu:PushAXToStack/>

			<!--Turn On Motor-->
			<cpu:CopyImmediateToDX/>
			<flp:Controller0/>
			<hex>0000</hex>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToDXRegister/>
			<flp:DigitalOutput/>

			<cpu:CopyImmediateToAL/>
			<fdo:Enabled/>

			<cpu:OrALWithImmediate/>
			<fdo:Drive0MotorEnabled/>

			<cpu:OrALWithImmediate/>
			<fdo:SelectDrive0/>

			<cpu:OrALWithImmediate/>
			<fdo:IrqAndDmaEnabled/>

			<cpu:WriteALToDXPort/>

			<cpu:PullAXFromStack/>

			<label id="forEachBlock"/>

			<cpu:PushAXToStack/>

			<!--Set up DMA Channel 2-->
			<cpu:CopyImmediateToAL/>
			<byte>2</byte>

			<cpu:OrALWithImmediate/>
			<binary>00000100</binary>

			<cpu:WriteALToImmediate8Port/>
			<hex>0a</hex>

			<!--Set target address-->
			<cpu:CopyImmediateToAL/>
			<hex>ff</hex>

			<cpu:WriteALToImmediate8Port/>
			<hex>0c</hex>

			<cpu:CopyImmediateToAL/>
			<hex>00</hex>

			<cpu:WriteALToImmediate8Port/>
			<hex>04</hex>

			<cpu:CopyImmediateToAL/>
			<hex>70</hex>

			<cpu:WriteALToImmediate8Port/>
			<hex>04</hex>

			<cpu:CopyImmediateToAL/>
			<hex>00</hex>

			<cpu:WriteALToImmediate8Port/>
			<hex>81</hex>

			<!--Set Length (minus 1)-->
			<cpu:CopyImmediateToAL/>
			<hex>ff</hex>

			<cpu:WriteALToImmediate8Port/>
			<hex>0c</hex>

			<cpu:CopyImmediateToAL/>
			<hex>ff</hex>

			<cpu:WriteALToImmediate8Port/>
			<hex>05</hex>

			<cpu:CopyImmediateToAL/>
			<hex>01</hex>

			<cpu:WriteALToImmediate8Port/>
			<hex>05</hex>

			<!--Set DMA Mode-->
			<cpu:CopyImmediateToAL/>
			<binary>01000110</binary>

			<cpu:WriteALToImmediate8Port/>
			<hex>0b</hex>

			<!--Release DMA Channel-->
			<cpu:CopyImmediateToAL/>
			<byte>2</byte>

			<cpu:WriteALToImmediate8Port/>
			<hex>0a</hex>

			<!--Calculate Sector-->
			<cpu:PullAXFromStack/>
			<cpu:PushAXToStack/>

			<cpu:CopyImmediateToDX/>
			<int>0</int>

			<cpu:CopyImmediateToBX/>
			<int>18</int>

			<cpu:ArithmeticDXAXOperandFunction/>
			<ari:DivideByBXRegister/>

			<!--<cpu:IncrementDX/>-->
			<cpu:IncrementFunction/>
			<inc:IncrementDXRegister/>

			<cpu:PushDXToStack/>
			<cpu:PushDXToStack/>

			<!--Calculate Head and Track-->
			<cpu:CopyImmediateToDX/>
			<int>0</int>

			<cpu:CopyImmediateToBX/>
			<int>2</int>

			<cpu:ArithmeticDXAXOperandFunction/>
			<ari:DivideByBXRegister/>

			<cpu:PushDXToStack/>
			<cpu:PushAXToStack/>
			<cpu:PushDXToStack/>

			<!--Send Read Command-->
			<cpu:CopyImmediateToDX/>
			<flp:Controller0/>
			<hex>0000</hex>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToDXRegister/>
			<flp:Data/>

			<cpu:CopyImmediateToAL/>
			<fcmd:ReadData/>

			<cpu:OrALWithImmediate/>
			<fcmd:MagneticFormatMode/>

			<cpu:WriteALToDXPort/>

			<!--Drive / Head Number-->
			<cpu:PullAXFromStack/>

			<cpu:ShiftRegisterByImmediate8Function/>
			<shift:ShiftAXRegisterLeft/>
			<byte>2</byte>

			<cpu:WriteALToDXPort/>

			<!--Cylinder Number-->
			<cpu:PullAXFromStack/>

			<cpu:WriteALToDXPort/>

			<!--Head Number-->
			<cpu:PullAXFromStack/>

			<cpu:WriteALToDXPort/>

			<!--Sector Number-->
			<cpu:PullAXFromStack/>

			<cpu:WriteALToDXPort/>

			<!--Sector Type-->
			<cpu:CopyImmediateToAL/>
			<byte>2</byte>

			<cpu:WriteALToDXPort/>

			<!--Last Sector Number-->
			<cpu:PullAXFromStack/>

			<cpu:WriteALToDXPort/>

			<!--Gap Length-->
			<cpu:CopyImmediateToAL/>
			<byte>27</byte>

			<cpu:WriteALToDXPort/>

			<!--Bytes Per Sector-->
			<cpu:CopyImmediateToAL/>
			<hex>ff</hex>

			<cpu:WriteALToDXPort/>

			<cpu:CopyImmediateToAX/>
			<int>0</int>

			<!--Wait For Data-->
			<cpu:CopyImmediateToDX/>
			<flp:Controller0/>
			<hex>0000</hex>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToDXRegister/>
			<flp:MainStatus/>

			<label id="waitForData"/>

			<cpu:ReadFromDXPortToAL/>

			<cpu:TestALWithImmediate/>
			<fst:WaitingForData/>

			<cpu:BranchToRelativeIfZero8/>
			<addressOf ref="waitForData" type="Relative8"/>

			<!--Read Data-->
			<cpu:CopyImmediateToDX/>
			<flp:Controller0/>
			<hex>0000</hex>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToDXRegister/>
			<flp:Data/>

			<!--Status 0-->
			<cpu:ReadFromDXPortToAL/>

			<!--Status 1-->
			<cpu:ReadFromDXPortToAL/>

			<!--Status 2-->
			<cpu:ReadFromDXPortToAL/>

			<!--Cylinder-->
			<cpu:ReadFromDXPortToAL/>

			<!--Last Head Number-->
			<cpu:ReadFromDXPortToAL/>

			<!--Last Sector Number-->
			<cpu:ReadFromDXPortToAL/>

			<!--Last Sector Type-->
			<cpu:ReadFromDXPortToAL/>

			<!--Copy Data To Address-->
			<cpu:PushCXToStack/>

			<cpu:CopyImmediateToSI/>
			<hex>00007000</hex>

			<cpu:CopyImmediateToCX/>
			<int>128</int>

			<cpu:Repeat/>
			<cpu:CopySIAddressToDIAddressAndIncrementSIAndDI/>

			<cpu:PullCXFromStack/>
			<cpu:PullAXFromStack/>

			<!--<cpu:IncrementAX/>-->
			<cpu:IncrementFunction/>
			<inc:IncrementAXRegister/>

			<!--<cpu:DecrementCX/>-->
			<cpu:IncrementFunction/>
			<inc:DecrementCXRegister/>

			<cpu:BranchToRelativeIfZero8/>
			<addressOf ref="turnOffMotor" type="Relative8"/>

			<cpu:JumpToRelative/>
			<addressOf ref="forEachBlock" type="Relative32"/>

			<!--Turn Off Motor-->
			<label id="turnOffMotor"/>

			<cpu:CopyImmediateToDX/>
			<flp:Controller0/>
			<hex>0000</hex>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToDXRegister/>
			<flp:DigitalOutput/>

			<cpu:CopyImmediateToAL/>
			<fdo:Enabled/>

			<cpu:OrALWithImmediate/>
			<fdo:SelectDrive0/>

			<cpu:WriteALToDXPort/>
		</scope>
	</xsl:template>

	<xsl:template match="ns:WriteBlock">
		<scope>
			<cpu:PushAXToStack/>

			<!--Turn On Motor-->
			<cpu:Operand16/>
			<cpu:CopyImmediateToDX/>
			<flp:Controller0/>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToDXRegister/>
			<flp:DigitalOutput/>

			<cpu:CopyImmediateToAL/>
			<fdo:Enabled/>

			<cpu:OrALWithImmediate/>
			<fdo:Drive0MotorEnabled/>

			<cpu:OrALWithImmediate/>
			<fdo:SelectDrive0/>

			<cpu:OrALWithImmediate/>
			<fdo:IrqAndDmaEnabled/>

			<cpu:Operand16/>
			<cpu:WriteALToDXPort/>

			<!--Copy Data To Buffer-->
			<cpu:CopyImmediateToDI/>
			<hex>00007000</hex>

			<cpu:CopyImmediateToCX/>
			<int>128</int>

			<cpu:Repeat/>
			<cpu:CopySIAddressToDIAddressAndIncrementSIAndDI/>

			<!--Set up DMA Channel 2-->
			<cpu:CopyImmediateToAL/>
			<byte>2</byte>

			<cpu:OrALWithImmediate/>
			<binary>00000100</binary>

			<cpu:WriteALToImmediate8Port/>
			<hex>0a</hex>

			<!--Set target address-->
			<cpu:CopyImmediateToAL/>
			<hex>ff</hex>

			<cpu:WriteALToImmediate8Port/>
			<hex>0c</hex>

			<cpu:CopyImmediateToAL/>
			<hex>00</hex>

			<cpu:WriteALToImmediate8Port/>
			<hex>04</hex>

			<cpu:CopyImmediateToAL/>
			<hex>70</hex>

			<cpu:WriteALToImmediate8Port/>
			<hex>04</hex>

			<cpu:CopyImmediateToAL/>
			<hex>00</hex>

			<cpu:WriteALToImmediate8Port/>
			<hex>81</hex>

			<!--Set Length (minus 1)-->
			<cpu:CopyImmediateToAL/>
			<hex>ff</hex>

			<cpu:WriteALToImmediate8Port/>
			<hex>0c</hex>

			<cpu:CopyImmediateToAL/>
			<hex>ff</hex>

			<cpu:WriteALToImmediate8Port/>
			<hex>05</hex>

			<cpu:CopyImmediateToAL/>
			<hex>01</hex>

			<cpu:WriteALToImmediate8Port/>
			<hex>05</hex>

			<!--Set DMA Mode-->
			<cpu:CopyImmediateToAL/>
			<binary>01001010</binary>

			<cpu:WriteALToImmediate8Port/>
			<hex>0b</hex>

			<!--Release DMA Channel-->
			<cpu:CopyImmediateToAL/>
			<byte>2</byte>

			<cpu:WriteALToImmediate8Port/>
			<hex>0a</hex>

			<!--Calculate Sector-->
			<cpu:PullAXFromStack/>

			<cpu:CopyImmediateToDX/>
			<int>0</int>

			<cpu:CopyImmediateToBX/>
			<int>18</int>

			<cpu:ArithmeticDXAXOperandFunction/>
			<ari:DivideByBXRegister/>

			<!--<cpu:IncrementDX/>-->
			<cpu:IncrementFunction/>
			<inc:IncrementDXRegister/>

			<cpu:PushDXToStack/>
			<cpu:PushDXToStack/>

			<!--Calculate Head and Track-->
			<cpu:CopyImmediateToDX/>
			<int>0</int>

			<cpu:CopyImmediateToBX/>
			<int>2</int>

			<cpu:ArithmeticDXAXOperandFunction/>
			<ari:DivideByBXRegister/>

			<cpu:PushDXToStack/>
			<cpu:PushAXToStack/>
			<cpu:PushDXToStack/>

			<!--Send Write Command-->
			<cpu:Operand16/>
			<cpu:CopyImmediateToDX/>
			<flp:Controller0/>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToDXRegister/>
			<flp:Data/>

			<cpu:CopyImmediateToAL/>
			<fcmd:WriteData/>

			<cpu:OrALWithImmediate/>
			<fcmd:MagneticFormatMode/>

			<cpu:Operand16/>
			<cpu:WriteALToDXPort/>

			<!--Drive / Head Number-->
			<cpu:PullAXFromStack/>

			<cpu:ShiftRegisterByImmediate8Function/>
			<shift:ShiftAXRegisterLeft/>
			<byte>2</byte>

			<cpu:Operand16/>
			<cpu:WriteALToDXPort/>

			<!--Cylinder Number-->
			<cpu:PullAXFromStack/>

			<cpu:Operand16/>
			<cpu:WriteALToDXPort/>

			<!--Head Number-->
			<cpu:PullAXFromStack/>

			<cpu:Operand16/>
			<cpu:WriteALToDXPort/>

			<!--Sector Number-->
			<cpu:PullAXFromStack/>

			<cpu:Operand16/>
			<cpu:WriteALToDXPort/>

			<!--Sector Type-->
			<cpu:CopyImmediateToAL/>
			<byte>2</byte>

			<cpu:Operand16/>
			<cpu:WriteALToDXPort/>

			<!--Last Sector Number-->
			<cpu:PullAXFromStack/>

			<cpu:Operand16/>
			<cpu:WriteALToDXPort/>

			<!--Gap Length-->
			<cpu:CopyImmediateToAL/>
			<byte>27</byte>

			<cpu:Operand16/>
			<cpu:WriteALToDXPort/>

			<!--Bytes Per Sector-->
			<cpu:CopyImmediateToAL/>
			<hex>ff</hex>

			<cpu:Operand16/>
			<cpu:WriteALToDXPort/>

			<cpu:CopyImmediateToAX/>
			<int>0</int>

			<!--Wait For Data-->
			<cpu:Operand16/>
			<cpu:CopyImmediateToDX/>
			<flp:Controller0/>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToDXRegister/>
			<flp:MainStatus/>

			<label id="waitForData"/>

			<cpu:Operand16/>
			<cpu:ReadFromDXPortToAL/>

			<cpu:TestALWithImmediate/>
			<fst:WaitingForData/>

			<cpu:BranchToRelativeIfZero8/>
			<addressOf ref="waitForData" type="Relative8"/>

			<!--Read Data-->
			<cpu:Operand16/>
			<cpu:CopyImmediateToDX/>
			<flp:Controller0/>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToDXRegister/>
			<flp:Data/>

			<!--Status 0-->
			<cpu:Operand16/>
			<cpu:ReadFromDXPortToAL/>

			<!--Status 1-->
			<cpu:Operand16/>
			<cpu:ReadFromDXPortToAL/>

			<!--Status 2-->
			<cpu:Operand16/>
			<cpu:ReadFromDXPortToAL/>

			<!--Cylinder-->
			<cpu:Operand16/>
			<cpu:ReadFromDXPortToAL/>

			<!--Last Head Number-->
			<cpu:Operand16/>
			<cpu:ReadFromDXPortToAL/>

			<!--Last Sector Number-->
			<cpu:Operand16/>
			<cpu:ReadFromDXPortToAL/>

			<!--Last Sector Type-->
			<cpu:Operand16/>
			<cpu:ReadFromDXPortToAL/>

			<!--Turn Off Motor-->
			<label id="turnOffMotor"/>

			<cpu:Operand16/>
			<cpu:CopyImmediateToDX/>
			<flp:Controller0/>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToDXRegister/>
			<flp:DigitalOutput/>

			<cpu:CopyImmediateToAL/>
			<fdo:Enabled/>

			<cpu:OrALWithImmediate/>
			<fdo:SelectDrive0/>

			<cpu:Operand16/>
			<cpu:WriteALToDXPort/>
		</scope>
	</xsl:template>

	<xsl:template match="ns:WriteBlocks">
		<scope>
			<cpu:PushAXToStack/>

			<!--Turn On Motor-->
			<cpu:Operand16/>
			<cpu:CopyImmediateToDX/>
			<flp:Controller0/>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToDXRegister/>
			<flp:DigitalOutput/>

			<cpu:CopyImmediateToAL/>
			<fdo:Enabled/>

			<cpu:OrALWithImmediate/>
			<fdo:Drive0MotorEnabled/>

			<cpu:OrALWithImmediate/>
			<fdo:SelectDrive0/>

			<cpu:OrALWithImmediate/>
			<fdo:IrqAndDmaEnabled/>

			<cpu:Operand16/>
			<cpu:WriteALToDXPort/>

			<cpu:PullAXFromStack/>

			<label id="forEachBlock"/>

			<cpu:PushAXToStack/>

			<!--Copy Data To Buffer-->
			<cpu:PushCXToStack/>

			<cpu:CopyImmediateToDI/>
			<hex>00007000</hex>

			<cpu:CopyImmediateToCX/>
			<int>128</int>

			<cpu:Repeat/>
			<cpu:CopySIAddressToDIAddressAndIncrementSIAndDI/>

			<cpu:PullCXFromStack/>

			<!--Set up DMA Channel 2-->
			<cpu:CopyImmediateToAL/>
			<byte>2</byte>

			<cpu:OrALWithImmediate/>
			<binary>00000100</binary>

			<cpu:WriteALToImmediate8Port/>
			<hex>0a</hex>

			<!--Set target address-->
			<cpu:CopyImmediateToAL/>
			<hex>ff</hex>

			<cpu:WriteALToImmediate8Port/>
			<hex>0c</hex>

			<cpu:CopyImmediateToAL/>
			<hex>00</hex>

			<cpu:WriteALToImmediate8Port/>
			<hex>04</hex>

			<cpu:CopyImmediateToAL/>
			<hex>70</hex>

			<cpu:WriteALToImmediate8Port/>
			<hex>04</hex>

			<cpu:CopyImmediateToAL/>
			<hex>00</hex>

			<cpu:WriteALToImmediate8Port/>
			<hex>81</hex>

			<!--Set Length (minus 1)-->
			<cpu:CopyImmediateToAL/>
			<hex>ff</hex>

			<cpu:WriteALToImmediate8Port/>
			<hex>0c</hex>

			<cpu:CopyImmediateToAL/>
			<hex>ff</hex>

			<cpu:WriteALToImmediate8Port/>
			<hex>05</hex>

			<cpu:CopyImmediateToAL/>
			<hex>01</hex>

			<cpu:WriteALToImmediate8Port/>
			<hex>05</hex>

			<!--Set DMA Mode-->
			<cpu:CopyImmediateToAL/>
			<binary>01001010</binary>

			<cpu:WriteALToImmediate8Port/>
			<hex>0b</hex>

			<!--Release DMA Channel-->
			<cpu:CopyImmediateToAL/>
			<byte>2</byte>

			<cpu:WriteALToImmediate8Port/>
			<hex>0a</hex>

			<!--Calculate Sector-->
			<cpu:PullAXFromStack/>
			<cpu:PushAXToStack/>

			<cpu:CopyImmediateToDX/>
			<int>0</int>

			<cpu:CopyImmediateToBX/>
			<int>18</int>

			<cpu:ArithmeticDXAXOperandFunction/>
			<ari:DivideByBXRegister/>

			<!--<cpu:IncrementDX/>-->
			<cpu:IncrementFunction/>
			<inc:IncrementDXRegister/>

			<cpu:PushDXToStack/>
			<cpu:PushDXToStack/>

			<!--Calculate Head and Track-->
			<cpu:CopyImmediateToDX/>
			<int>0</int>

			<cpu:CopyImmediateToBX/>
			<int>2</int>

			<cpu:ArithmeticDXAXOperandFunction/>
			<ari:DivideByBXRegister/>

			<cpu:PushDXToStack/>
			<cpu:PushAXToStack/>
			<cpu:PushDXToStack/>

			<!--Send Write Command-->
			<cpu:Operand16/>
			<cpu:CopyImmediateToDX/>
			<flp:Controller0/>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToDXRegister/>
			<flp:Data/>

			<cpu:CopyImmediateToAL/>
			<fcmd:WriteData/>

			<cpu:OrALWithImmediate/>
			<fcmd:MagneticFormatMode/>

			<cpu:Operand16/>
			<cpu:WriteALToDXPort/>

			<!--Drive / Head Number-->
			<cpu:PullAXFromStack/>

			<cpu:ShiftRegisterByImmediate8Function/>
			<shift:ShiftAXRegisterLeft/>
			<byte>2</byte>

			<cpu:Operand16/>
			<cpu:WriteALToDXPort/>

			<!--Cylinder Number-->
			<cpu:PullAXFromStack/>

			<cpu:Operand16/>
			<cpu:WriteALToDXPort/>

			<!--Head Number-->
			<cpu:PullAXFromStack/>

			<cpu:Operand16/>
			<cpu:WriteALToDXPort/>

			<!--Sector Number-->
			<cpu:PullAXFromStack/>

			<cpu:Operand16/>
			<cpu:WriteALToDXPort/>

			<!--Sector Type-->
			<cpu:CopyImmediateToAL/>
			<byte>2</byte>

			<cpu:Operand16/>
			<cpu:WriteALToDXPort/>

			<!--Last Sector Number-->
			<cpu:PullAXFromStack/>

			<cpu:Operand16/>
			<cpu:WriteALToDXPort/>

			<!--Gap Length-->
			<cpu:CopyImmediateToAL/>
			<byte>27</byte>

			<cpu:Operand16/>
			<cpu:WriteALToDXPort/>

			<!--Bytes Per Sector-->
			<cpu:CopyImmediateToAL/>
			<hex>ff</hex>

			<cpu:Operand16/>
			<cpu:WriteALToDXPort/>

			<cpu:CopyImmediateToAX/>
			<int>0</int>

			<!--Wait For Data-->
			<cpu:Operand16/>
			<cpu:CopyImmediateToDX/>
			<flp:Controller0/>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToDXRegister/>
			<flp:MainStatus/>

			<label id="waitForData"/>

			<cpu:Operand16/>
			<cpu:ReadFromDXPortToAL/>

			<cpu:TestALWithImmediate/>
			<fst:WaitingForData/>

			<cpu:BranchToRelativeIfZero8/>
			<addressOf ref="waitForData" type="Relative8"/>

			<!--Read Data-->
			<cpu:Operand16/>
			<cpu:CopyImmediateToDX/>
			<flp:Controller0/>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToDXRegister/>
			<flp:Data/>

			<!--Status 0-->
			<cpu:Operand16/>
			<cpu:ReadFromDXPortToAL/>

			<!--Status 1-->
			<cpu:Operand16/>
			<cpu:ReadFromDXPortToAL/>

			<!--Status 2-->
			<cpu:Operand16/>
			<cpu:ReadFromDXPortToAL/>

			<!--Cylinder-->
			<cpu:Operand16/>
			<cpu:ReadFromDXPortToAL/>

			<!--Last Head Number-->
			<cpu:Operand16/>
			<cpu:ReadFromDXPortToAL/>

			<!--Last Sector Number-->
			<cpu:Operand16/>
			<cpu:ReadFromDXPortToAL/>

			<!--Last Sector Type-->
			<cpu:Operand16/>
			<cpu:ReadFromDXPortToAL/>
			<cpu:PullAXFromStack/>

			<!--<cpu:IncrementAX/>-->
			<cpu:IncrementFunction/>
			<inc:IncrementAXRegister/>
			
			<!--<cpu:DecrementCX/>-->
			<cpu:IncrementFunction/>
			<inc:DecrementCXRegister/>

			<cpu:BranchToRelativeIfZero8/>
			<addressOf ref="turnOffMotor" type="Relative8"/>

			<cpu:JumpToRelative/>
			<addressOf ref="forEachBlock" type="Relative32"/>

			<!--Turn Off Motor-->
			<label id="turnOffMotor"/>

			<cpu:Operand16/>
			<cpu:CopyImmediateToDX/>
			<flp:Controller0/>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToDXRegister/>
			<flp:DigitalOutput/>

			<cpu:CopyImmediateToAL/>
			<fdo:Enabled/>

			<cpu:OrALWithImmediate/>
			<fdo:SelectDrive0/>

			<cpu:Operand16/>
			<cpu:WriteALToDXPort/>
		</scope>
	</xsl:template>

</xsl:stylesheet>
