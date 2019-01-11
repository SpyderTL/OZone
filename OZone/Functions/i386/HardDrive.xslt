<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:var="http://metalx.org/Variable"
	xmlns:ns="http://metalx.org/i386/Functions/HardDrive"
	xmlns:pata="http://metalx.org/Pc/Pata/Ports"
	xmlns:drive="http://metalx.org/Pc/Pata/DriveSelect"
	xmlns:sta="http://metalx.org/Pc/Pata/Status"
	xmlns:cmd="http://metalx.org/Pc/Pata/Commands"
	xmlns:id="http://metalx.org/Pc/Pata/DriveIdentity"
	xmlns:ari="http://metalx.org/Intel/80386/Arithmetic"
	xmlns:inc="http://metalx.org/Intel/80386/Increment"
	xmlns:imm="http://metalx.org/Intel/80386/Immediate"
	xmlns:math="http://metalx.org/Intel/80386/Math"
	xmlns:shift="http://metalx.org/Intel/80386/Shift"
	xmlns:obj="http://metalx.org/i386/Functions/Object"
	xmlns:lst="http://metalx.org/i386/Functions/List"
	xmlns:cat="http://metalx.org/i386/Functions/Catalog"
	xmlns:sys="http://metalx.org/i386/Functions/System"
	xmlns:mm="http://metalx.org/i386/Functions/MemoryManager"
	xmlns:cpu="http://metalx.org/Intel/80386/Operators"
	xmlns:op="http://metalx.org/Intel/80386/Operands">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="ns:ResetController">
		<cpu:CopyImmediateToAL/>
		<binary>00000100</binary>

		<cpu:WriteALToDXPort/>

		<cpu:ReadFromDXPortToAL/>
		<cpu:ReadFromDXPortToAL/>
		<cpu:ReadFromDXPortToAL/>
		<cpu:ReadFromDXPortToAL/>

		<cpu:CopyImmediateToAL/>
		<binary>00000000</binary>

		<cpu:WriteALToDXPort/>

		<cpu:ReadFromDXPortToAL/>
		<cpu:ReadFromDXPortToAL/>
		<cpu:ReadFromDXPortToAL/>
		<cpu:ReadFromDXPortToAL/>
	</xsl:template>
	
	<xsl:template match="ns:GetBlockCount">
		<!--Select Drive-->
		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDXRegister/>
		<pata:DriveAndHead/>

		<cpu:ShiftRegisterByImmediate8Function/>
		<shift:ShiftALRegisterLeft/>
		<byte>4</byte>

		<cpu:OrALWithImmediate/>
		<binary>11100000</binary>

		<cpu:WriteALToDXPort/>

		<!--Send Identify Command-->
		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDXRegister/>
		<hex>01</hex>

		<cpu:CopyImmediateToAL/>
		<cmd:IdentifyDrive/>

		<cpu:WriteALToDXPort/>

		<label id="waitForBusy"/>

		<cpu:ReadFromDXPortToAL/>

		<cpu:AndALWithImmediate/>
		<sta:Busy/>

		<cpu:BranchToRelative8IfNotZero/>
		<addressOf ref="waitForBusy" type="Relative8"/>

		<!--Read Identify Structure-->
		<cpu:MathImmediate8ToOperandFunction/>
		<math:SubtractFromDXRegister/>
		<hex>07</hex>

		<cpu:CopyImmediateToDI/>
		<hex>00007000</hex>

		<cpu:CopyImmediateToCX/>
		<int>128</int>

		<cpu:Repeat/>
		<cpu:ReadFromDXPortToDIAddressAndIncrementDI/>

		<!--Read Block Count-->
		<cpu:CopyAbsoluteMemoryToAX/>
		<hex>00007078</hex>
	</xsl:template>

	<xsl:template match="ns:GetBlockSize">
		<!--Select Drive-->
		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDXRegister/>
		<pata:DriveAndHead/>

		<cpu:ShiftRegisterByImmediate8Function/>
		<shift:ShiftALRegisterLeft/>
		<byte>4</byte>

		<cpu:OrALWithImmediate/>
		<binary>11100000</binary>

		<cpu:WriteALToDXPort/>

		<!--Send Identify Command-->
		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDXRegister/>
		<hex>01</hex>

		<cpu:CopyImmediateToAL/>
		<cmd:IdentifyDrive/>

		<cpu:WriteALToDXPort/>

		<label id="waitForBusy"/>

		<cpu:ReadFromDXPortToAL/>

		<cpu:AndALWithImmediate/>
		<sta:Busy/>

		<cpu:BranchToRelative8IfNotZero/>
		<addressOf ref="waitForBusy" type="Relative8"/>

		<!--Read Identify Structure-->
		<cpu:MathImmediate8ToOperandFunction/>
		<math:SubtractFromDXRegister/>
		<hex>07</hex>

		<cpu:CopyImmediateToDI/>
		<hex>00007000</hex>

		<cpu:CopyImmediateToCX/>
		<int>128</int>

		<cpu:Repeat/>
		<cpu:ReadFromDXPortToDIAddressAndIncrementDI/>

		<!--Read Block Size-->
		<cpu:CopyAbsoluteMemoryToAX/>
		<hex>00007072</hex>
	</xsl:template>

	<xsl:template match="ns:GetModelNumber">
		<!--Select Drive-->
		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDXRegister/>
		<pata:DriveAndHead/>

		<cpu:ShiftRegisterByImmediate8Function/>
		<shift:ShiftALRegisterLeft/>
		<byte>4</byte>

		<cpu:OrALWithImmediate/>
		<binary>11100000</binary>

		<cpu:WriteALToDXPort/>

		<!--Send Identify Command-->
		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDXRegister/>
		<hex>01</hex>

		<cpu:CopyImmediateToAL/>
		<cmd:IdentifyDrive/>

		<cpu:WriteALToDXPort/>

		<label id="waitForBusy"/>

		<cpu:ReadFromDXPortToAL/>

		<cpu:AndALWithImmediate/>
		<sta:Busy/>

		<cpu:BranchToRelative8IfNotZero/>
		<addressOf ref="waitForBusy" type="Relative8"/>

		<!--Read Identify Structure-->
		<cpu:CopyImmediateToDI/>
		<hex>00007000</hex>

		<cpu:CopyImmediateToCX/>
		<int>256</int>

		<cpu:MathImmediate8ToOperandFunction/>
		<math:SubtractFromDXRegister/>
		<hex>07</hex>

		<cpu:Repeat/>
		<cpu:Operand16/>
		<cpu:ReadFromDXPortToDIAddressAndIncrementDI/>

		<!--Read Model Number-->
		<mm:CheckOut length="44"/>

		<cpu:PushDIToStack/>

		<cpu:CopyImmediateToAX/>
		<int>40</int>

		<cpu:CopyAXToDIAddressAndIncrementDI/>

		<cpu:CopyImmediateToCX/>
		<int>20</int>

		<cpu:CopyImmediateToSI/>
		<hex>00007036</hex>

		<label id="readCharacters"/>

		<cpu:Operand16/>
		<cpu:CopySIAddressToAXAndIncrementSI/>

		<cpu:ExchangeOperandWithRegister8/>
		<op:AL-AHRegister/>

		<cpu:Operand16/>
		<cpu:CopyAXToDIAddressAndIncrementDI/>

		<cpu:LoopToRelative8/>
		<addressOf ref="readCharacters" type="Relative8"/>

		<cpu:PullDIFromStack/>
	</xsl:template>
	
	<xsl:template match="ns:GetSerialNumber">
		<!--Select Master Drive-->
		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDXRegister/>
		<pata:DriveAndHead/>

		<cpu:ShiftRegisterByImmediate8Function/>
		<shift:ShiftALRegisterLeft/>
		<byte>4</byte>

		<cpu:OrALWithImmediate/>
		<binary>11100000</binary>

		<cpu:WriteALToDXPort/>

		<!--Send Identify Command-->
		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDXRegister/>
		<hex>01</hex>

		<cpu:CopyImmediateToAL/>
		<cmd:IdentifyDrive/>

		<cpu:WriteALToDXPort/>

		<label id="waitForBusy"/>

		<cpu:ReadFromDXPortToAL/>

		<cpu:AndALWithImmediate/>
		<sta:Busy/>

		<cpu:BranchToRelative8IfNotZero/>
		<addressOf ref="waitForBusy" type="Relative8"/>

		<!--Read Identify Structure-->
		<cpu:CopyImmediateToDI/>
		<hex>00007000</hex>

		<cpu:CopyImmediateToCX/>
		<int>256</int>

		<cpu:MathImmediate8ToOperandFunction/>
		<math:SubtractFromDXRegister/>
		<hex>07</hex>

		<cpu:Repeat/>
		<cpu:Operand16/>
		<cpu:ReadFromDXPortToDIAddressAndIncrementDI/>

		<!--Read Model Number-->
		<mm:CheckOut length="24"/>

		<cpu:PushDIToStack/>

		<cpu:CopyImmediateToAX/>
		<int>20</int>

		<cpu:CopyAXToDIAddressAndIncrementDI/>

		<cpu:CopyImmediateToCX/>
		<int>10</int>

		<cpu:CopyImmediateToSI/>
		<hex>00007014</hex>

		<label id="readCharacters"/>

		<cpu:Operand16/>
		<cpu:CopySIAddressToAXAndIncrementSI/>

		<cpu:ExchangeOperandWithRegister8/>
		<op:AL-AHRegister/>

		<cpu:Operand16/>
		<cpu:CopyAXToDIAddressAndIncrementDI/>

		<cpu:LoopToRelative8/>
		<addressOf ref="readCharacters" type="Relative8"/>

		<cpu:PullDIFromStack/>
	</xsl:template>

	<xsl:template match="ns:ReadBlock">
		<!--Select Master Drive And Send Block3-->
		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDXRegister/>
		<pata:DriveAndHead/>

		<cpu:PushAXToStack/>

		<cpu:ShiftRegisterByImmediate8Function/>
		<shift:ShiftAXRegisterRight/>
		<byte>24</byte>

		<cpu:AndALWithImmediate/>
		<binary>00001111</binary>

		<cpu:OrALWithImmediate/>
		<binary>11100000</binary>

		<cpu:ShiftRegisterByImmediateFunction8/>
		<shift:ShiftBLRegisterLeft/>
		<byte>4</byte>

		<cpu:OrRegisterWithOperand8/>
		<op:AL-BLRegister/>

		<cpu:WriteALToDXPort/>

		<!--Send Block Count-->
		<cpu:MathImmediate8ToOperandFunction/>
		<math:SubtractFromDXRegister/>
		<byte>4</byte>

		<cpu:CopyImmediateToAL/>
		<byte>1</byte>

		<cpu:WriteALToDXPort/>

		<!--Send Block0-->
		<cpu:IncrementDX/>

		<cpu:PullAXFromStack/>
		<cpu:PushAXToStack/>

		<cpu:WriteALToDXPort/>

		<!--Send Block1-->
		<cpu:IncrementDX/>

		<cpu:PullAXFromStack/>
		<cpu:PushAXToStack/>

		<cpu:ShiftRegisterByImmediate8Function/>
		<shift:ShiftAXRegisterRight/>
		<byte>8</byte>

		<cpu:WriteALToDXPort/>

		<!--Send Block2-->
		<cpu:IncrementDX/>

		<cpu:PullAXFromStack/>

		<cpu:ShiftRegisterByImmediate8Function/>
		<shift:ShiftAXRegisterRight/>
		<byte>16</byte>

		<cpu:WriteALToDXPort/>

		<!--Send Read Sector Command-->
		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDXRegister/>
		<hex>02</hex>

		<cpu:CopyImmediateToAL/>
		<!--<cmd:ReadSectors/>-->
		<cmd:ReadSectorsAndRetry/>

		<cpu:WriteALToDXPort/>

		<!--Wait For Data-->
		<cpu:ReadFromDXPortToAL/>
		<cpu:ReadFromDXPortToAL/>
		<cpu:ReadFromDXPortToAL/>
		<cpu:ReadFromDXPortToAL/>

		<label id="waitForBusy"/>
		
		<cpu:ReadFromDXPortToAL/>

		<cpu:TestALWithImmediate/>
		<sta:Busy/>

		<cpu:BranchToRelative8IfNotZero/>
		<addressOf ref="waitForBusy" type="Relative8"/>
		
		<label id="waitForData"/>

		<cpu:ReadFromDXPortToAL/>

		<cpu:TestALWithImmediate/>
		<sta:Error/>

		<cpu:BranchToRelative8IfNotZero/>
		<addressOf ref="error" type="Relative8"/>

		<cpu:TestALWithImmediate/>
		<sta:DataRequest/>

		<cpu:BranchToRelative8IfZero/>
		<addressOf ref="waitForData" type="Relative8"/>

		<!--Read Data-->
		<cpu:MathImmediate8ToOperandFunction/>
		<math:SubtractFromDXRegister/>
		<hex>07</hex>

		<cpu:CopyImmediateToCX/>
		<int>256</int>

		<cpu:Repeat/>
		<cpu:Operand16/>
		<cpu:ReadFromDXPortToDIAddressAndIncrementDI/>

		<label id="error"/>
	</xsl:template>

	<xsl:template match="ns:ReadBlocks">
		<scope>
			<cpu:ShiftRegisterByImmediateFunction8/>
			<shift:ShiftBLRegisterLeft/>
			<byte>4</byte>
			
			<label id="readBlock"/>

			<cpu:PushAXToStack/>

			<!--Select Master Drive And Send Block3-->
			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToDXRegister/>
			<pata:DriveAndHead/>

			<cpu:ShiftRegisterByImmediate8Function/>
			<shift:ShiftAXRegisterRight/>
			<byte>24</byte>

			<cpu:AndALWithImmediate/>
			<binary>00001111</binary>

			<cpu:OrALWithImmediate/>
			<binary>11100000</binary>

			<cpu:OrRegisterWithOperand8/>
			<op:AL-BLRegister/>

			<cpu:WriteALToDXPort/>

			<!--Send Block Count-->
			<cpu:MathImmediate8ToOperandFunction/>
			<math:SubtractFromDXRegister/>
			<hex>04</hex>

			<cpu:CopyImmediateToAL/>
			<byte>1</byte>

			<cpu:WriteALToDXPort/>

			<!--Send Block0-->
			<cpu:IncrementDX/>

			<cpu:PullAXFromStack/>
			<cpu:PushAXToStack/>

			<cpu:WriteALToDXPort/>

			<!--Send Block1-->
			<cpu:IncrementDX/>

			<cpu:PullAXFromStack/>
			<cpu:PushAXToStack/>

			<cpu:ShiftRegisterByImmediate8Function/>
			<shift:ShiftAXRegisterRight/>
			<byte>8</byte>

			<cpu:WriteALToDXPort/>

			<!--Send Block2-->
			<cpu:IncrementDX/>

			<cpu:PullAXFromStack/>
			<cpu:PushAXToStack/>

			<cpu:ShiftRegisterByImmediate8Function/>
			<shift:ShiftAXRegisterRight/>
			<byte>16</byte>

			<cpu:WriteALToDXPort/>

			<!--Send Read Sector Command-->
			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToDXRegister/>
			<hex>02</hex>

			<cpu:CopyImmediateToAL/>
			<cmd:ReadSectorsAndRetry/>

			<cpu:WriteALToDXPort/>

			<!--Wait For Data-->
			<cpu:ReadFromDXPortToAL/>
			<cpu:ReadFromDXPortToAL/>
			<cpu:ReadFromDXPortToAL/>
			<cpu:ReadFromDXPortToAL/>

			<label id="waitForData"/>

			<cpu:ReadFromDXPortToAL/>

			<cpu:TestALWithImmediate/>
			<sta:DataRequest/>

			<cpu:BranchToRelative8IfZero/>
			<addressOf ref="waitForData" type="Relative8"/>

			<!--Read Data-->
			<cpu:MathImmediate8ToOperandFunction/>
			<math:SubtractFromDXRegister/>
			<hex>07</hex>

			<cpu:PushCXToStack/>

			<cpu:CopyImmediateToCX/>
			<int>128</int>

			<cpu:Repeat/>
			<cpu:ReadFromDXPortToDIAddressAndIncrementDI/>

			<cpu:PullCXFromStack/>
			<cpu:PullAXFromStack/>

			<cpu:IncrementAX/>

			<cpu:LoopToRelative8/>
			<addressOf ref="readBlock" type="Relative8"/>
		</scope>
	</xsl:template>

	<xsl:template match="ns:WriteBlock">
		<!--Select Master Drive And Send Block3-->
		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDXRegister/>
		<pata:DriveAndHead/>

		<cpu:PushAXToStack/>

		<cpu:ShiftRegisterByImmediate8Function/>
		<shift:ShiftAXRegisterRight/>
		<byte>24</byte>

		<cpu:AndALWithImmediate/>
		<binary>00001111</binary>

		<cpu:OrALWithImmediate/>
		<binary>11100000</binary>

		<cpu:ShiftRegisterByImmediateFunction8/>
		<shift:ShiftBLRegisterLeft/>
		<byte>4</byte>

		<cpu:OrRegisterWithOperand8/>
		<op:AL-BLRegister/>

		<cpu:WriteALToDXPort/>

		<!--Send Block Count-->
		<cpu:MathImmediate8ToOperandFunction/>
		<math:SubtractFromDXRegister/>
		<byte>4</byte>

		<cpu:CopyImmediateToAL/>
		<byte>1</byte>

		<cpu:WriteALToDXPort/>

		<!--Send Block0-->
		<cpu:IncrementDX/>

		<cpu:PullAXFromStack/>
		<cpu:PushAXToStack/>

		<cpu:WriteALToDXPort/>

		<!--Send Block1-->
		<cpu:IncrementDX/>

		<cpu:PullAXFromStack/>
		<cpu:PushAXToStack/>

		<cpu:ShiftRegisterByImmediate8Function/>
		<shift:ShiftAXRegisterRight/>
		<byte>8</byte>

		<cpu:WriteALToDXPort/>

		<!--Send Block2-->
		<cpu:IncrementDX/>

		<cpu:PullAXFromStack/>

		<cpu:ShiftRegisterByImmediate8Function/>
		<shift:ShiftAXRegisterRight/>
		<byte>16</byte>

		<cpu:WriteALToDXPort/>

		<!--Send Read Sector Command-->
		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDXRegister/>
		<hex>02</hex>

		<cpu:CopyImmediateToAL/>
		<!--<cmd:ReadSectors/>-->
		<!--<cmd:ReadSectorsAndRetry/>-->
		<cmd:WriteSectorsAndRetry/>
		
		<cpu:WriteALToDXPort/>

		<!--Wait For Data-->
		<cpu:ReadFromDXPortToAL/>
		<cpu:ReadFromDXPortToAL/>
		<cpu:ReadFromDXPortToAL/>
		<cpu:ReadFromDXPortToAL/>

		<label id="waitForData"/>

		<cpu:ReadFromDXPortToAL/>

		<cpu:TestALWithImmediate/>
		<sta:Error/>

		<cpu:BranchToRelative8IfNotZero/>
		<addressOf ref="error" type="Relative8"/>

		<cpu:TestALWithImmediate/>
		<sta:DataRequest/>

		<cpu:BranchToRelative8IfZero/>
		<addressOf ref="waitForData" type="Relative8"/>

		<!--Write Data-->
		<cpu:MathImmediate8ToOperandFunction/>
		<math:SubtractFromDXRegister/>
		<hex>07</hex>

		<cpu:CopyImmediateToCX/>
		<int>128</int>

		<!--<cpu:Repeat/>-->
		<label id="writeByte"/>
		
		<cpu:WriteSIAddressToDXPortAndIncrementSI/>

		<cpu:LoopToRelative8/>
		<addressOf ref="writeByte" type="Relative8"/>

		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDXRegister/>
		<hex>07</hex>

		<cpu:CopyImmediateToAL/>
		<cmd:FlushCache/>

		<cpu:WriteALToDXPort/>

		<label id="error"/>
	</xsl:template>

	<xsl:template match="ns:WriteBlocks">
		<scope>
			<label id="writeBlock"/>

			<cpu:PushAXToStack/>

			<!--Set Drive And Block3-->
			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToDXRegister/>
			<pata:DriveAndHead/>

			<cpu:ShiftRegisterByImmediate8Function/>
			<shift:ShiftAXRegisterRight/>
			<byte>24</byte>

			<cpu:AndALWithImmediate/>
			<binary>00001111</binary>

			<cpu:OrALWithImmediate/>
			<binary>11100000</binary>

			<cpu:WriteALToDXPort/>

			<!--Set Block Count-->
			<cpu:MathImmediate8ToOperandFunction/>
			<math:SubtractFromDXRegister/>
			<hex>04</hex>

			<cpu:CopyImmediateToAL/>
			<byte>1</byte>

			<cpu:WriteALToDXPort/>

			<!--Set Block0-->
			<cpu:IncrementDX/>

			<cpu:PullAXFromStack/>
			<cpu:PushAXToStack/>

			<cpu:WriteALToDXPort/>

			<!--Set Block1-->
			<cpu:IncrementDX/>

			<cpu:PullAXFromStack/>
			<cpu:PushAXToStack/>

			<cpu:ShiftRegisterByImmediate8Function/>
			<shift:ShiftAXRegisterRight/>
			<byte>8</byte>

			<cpu:WriteALToDXPort/>

			<!--Set Block2-->
			<cpu:IncrementDX/>

			<cpu:PullAXFromStack/>
			<cpu:PushAXToStack/>

			<cpu:ShiftRegisterByImmediate8Function/>
			<shift:ShiftAXRegisterRight/>
			<byte>16</byte>

			<cpu:WriteALToDXPort/>

			<!--Send Write Sector Command-->
			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToDXRegister/>
			<hex>02</hex>

			<cpu:CopyImmediateToAL/>
			<cmd:WriteSectors/>

			<cpu:WriteALToDXPort/>

			<!--Send Data-->
			<cpu:MathImmediate8ToOperandFunction/>
			<math:SubtractFromDXRegister/>
			<hex>07</hex>

			<cpu:PushCXToStack/>

			<cpu:CopyImmediateToCX/>
			<int>128</int>

			<cpu:Repeat/>
			<cpu:WriteSIAddressToDXPortAndIncrementSI/>

			<cpu:PullCXFromStack/>

			<cpu:PullAXFromStack/>

			<cpu:IncrementAX/>

			<cpu:LoopToRelative8/>
			<addressOf ref="writeBlock" type="Relative8"/>
		</scope>
	</xsl:template>
</xsl:stylesheet>
