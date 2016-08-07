<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:var="http://metalx.org/Variable"
	xmlns:ns="http://metalx.org/i386/Functions/CdDrive"
	xmlns:pata="http://metalx.org/Pc/Pata/Ports"
	xmlns:status="http://metalx.org/Pc/Pata/Status"
	xmlns:drive="http://metalx.org/Pc/Pata/DriveSelect"
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

	<xsl:template match="ns:GetBlockCount">
		<!--Select Master Drive-->
		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDXRegister/>
		<pata:DriveAndHead/>

		<cpu:CopyImmediateToAL/>
		<binary>11110000</binary>

		<cpu:WriteALToDXPort/>

		<cpu:MathImmediate8ToOperandFunction/>
		<math:SubtractFromDXRegister/>
		<pata:DriveAndHead/>

		<!--Disable DMA-->
		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDXRegister/>
		<pata:Features/>

		<cpu:CopyImmediateToAL/>
		<binary>00000000</binary>

		<cpu:WriteALToDXPort/>

		<cpu:MathImmediate8ToOperandFunction/>
		<math:SubtractFromDXRegister/>
		<pata:Features/>

		<!--Set Byte Count 0-->
		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDXRegister/>
		<pata:ByteCount0/>

		<cpu:CopyImmediateToAL/>
		<hex>08</hex>

		<cpu:WriteALToDXPort/>

		<cpu:MathImmediate8ToOperandFunction/>
		<math:SubtractFromDXRegister/>
		<pata:ByteCount0/>

		<!--Set Byte Count 1-->
		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDXRegister/>
		<pata:ByteCount1/>

		<cpu:CopyImmediateToAL/>
		<hex>00</hex>

		<cpu:WriteALToDXPort/>

		<cpu:MathImmediate8ToOperandFunction/>
		<math:SubtractFromDXRegister/>
		<pata:ByteCount1/>

		<!--Send ATAPI Packet Command-->
		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDXRegister/>
		<pata:Command/>

		<cpu:CopyImmediateToAL/>
		<cmd:Packet/>

		<cpu:WriteALToDXPort/>

		<cpu:MathImmediate8ToOperandFunction/>
		<math:SubtractFromDXRegister/>
		<pata:Command/>

		<!--Send ATAPI Packet Data-->
		<cpu:MathImmediate8ToOperandFunction/>
		<math:SubtractFromDXRegister/>
		<pata:Data/>

		<cpu:Operand16/>
		<cpu:CopyImmediateToAX/>
		<hex>2500</hex>

		<cpu:Operand16/>
		<cpu:WriteAXToDXPort/>

		<cpu:Operand16/>
		<cpu:CopyImmediateToAX/>
		<hex>0000</hex>

		<cpu:Operand16/>
		<cpu:WriteAXToDXPort/>

		<cpu:Operand16/>
		<cpu:CopyImmediateToAX/>
		<hex>0000</hex>

		<cpu:Operand16/>
		<cpu:WriteAXToDXPort/>

		<cpu:Operand16/>
		<cpu:CopyImmediateToAX/>
		<hex>0000</hex>

		<cpu:Operand16/>
		<cpu:WriteAXToDXPort/>

		<cpu:Operand16/>
		<cpu:CopyImmediateToAX/>
		<hex>0000</hex>

		<cpu:Operand16/>
		<cpu:WriteAXToDXPort/>

		<cpu:Operand16/>
		<cpu:CopyImmediateToAX/>
		<hex>0000</hex>

		<cpu:Operand16/>
		<cpu:WriteAXToDXPort/>

		<!--Read Block Count-->
		<cpu:Operand16/>
		<cpu:ReadFromDXPortToAX/>

		<cpu:ShiftRegisterByImmediate8Function/>
		<shift:ShiftAXRegisterLeft/>
		<byte>16</byte>

		<cpu:Operand16/>
		<cpu:ReadFromDXPortToAX/>

		<cpu:PushAXToStack/>

		<!--Read Block Size-->
		<cpu:Operand16/>
		<cpu:ReadFromDXPortToAX/>

		<cpu:ShiftRegisterByImmediate8Function/>
		<shift:ShiftAXRegisterLeft/>
		<byte>16</byte>

		<cpu:Operand16/>
		<cpu:ReadFromDXPortToAX/>

		<cpu:PullAXFromStack/>
	</xsl:template>

	<xsl:template match="ns:GetModelNumber">
		<!--Select Drive-->
		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDXRegister/>
		<pata:DriveAndHead/>

		<cpu:ShiftRegisterByImmediateFunction8/>
		<shift:ShiftALRegisterLeft/>
		<byte>4</byte>

		<cpu:OrALWithImmediate/>
		<binary>11100000</binary>

		<cpu:WriteALToDXPort/>

		<cpu:MathImmediate8ToOperandFunction/>
		<math:SubtractFromDXRegister/>
		<pata:DriveAndHead/>

		<!--Send Identify Command-->
		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDXRegister/>
		<pata:Command/>

		<cpu:CopyImmediateToAL/>
		<cmd:IdentifyAtapi/>

		<cpu:WriteALToDXPort/>

		<label id="waitForBusy"/>

		<cpu:ReadFromDXPortToAL/>

		<cpu:AndALWithImmediate/>
		<sta:Busy xmlns:sta="http://metalx.org/Pc/Pata/Status"/>

		<cpu:BranchToRelative8IfNotZero/>
		<addressOf ref="waitForBusy" type="Relative8"/>

		<cpu:MathImmediate8ToOperandFunction/>
		<math:SubtractFromDXRegister/>
		<pata:Command/>

		<!--Read Identify Structure-->
		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDXRegister/>
		<pata:Data/>

		<cpu:CopyImmediateToDI/>
		<hex>00007000</hex>

		<cpu:CopyImmediateToCX/>
		<int>128</int>

		<cpu:Repeat/>
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
		<!--Select Drive-->
		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDXRegister/>
		<pata:DriveAndHead/>

		<cpu:ShiftRegisterByImmediateFunction8/>
		<shift:ShiftALRegisterLeft/>
		<byte>4</byte>

		<cpu:OrALWithImmediate/>
		<binary>11100000</binary>

		<cpu:WriteALToDXPort/>

		<cpu:MathImmediate8ToOperandFunction/>
		<math:SubtractFromDXRegister/>
		<pata:DriveAndHead/>

		<!--Send Identify Command-->
		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDXRegister/>
		<pata:Command/>

		<cpu:CopyImmediateToAL/>
		<cmd:IdentifyAtapi/>

		<cpu:WriteALToDXPort/>

		<label id="waitForBusy"/>

		<cpu:ReadFromDXPortToAL/>

		<cpu:AndALWithImmediate/>
		<sta:Busy xmlns:sta="http://metalx.org/Pc/Pata/Status"/>

		<cpu:BranchToRelative8IfNotZero/>
		<addressOf ref="waitForBusy" type="Relative8"/>

		<cpu:MathImmediate8ToOperandFunction/>
		<math:SubtractFromDXRegister/>
		<pata:Command/>

		<!--Read Identify Structure-->
		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDXRegister/>
		<pata:Data/>

		<cpu:CopyImmediateToDI/>
		<hex>00007000</hex>

		<cpu:CopyImmediateToCX/>
		<int>128</int>

		<cpu:Repeat/>
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
		<scope>
			<!--Select Drive-->
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

			<cpu:MathImmediate8ToOperandFunction/>
			<math:SubtractFromDXRegister/>
			<pata:DriveAndHead/>

			<!--Wait For Drive Select-->
			<cpu:CallRelative/>
			<addressOf ref="sleep" type="Relative32"/>

			<!--Disable DMA-->
			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToDXRegister/>
			<pata:Features/>

			<cpu:CopyImmediateToAL/>
			<binary>00000000</binary>

			<cpu:WriteALToDXPort/>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:SubtractFromDXRegister/>
			<pata:Features/>

			<!--Enable IRQs-->
			<cpu:Operand16/>
			<cpu:MathImmediateToOperandFunction/>
			<math:AddToDXRegister/>
			<hex>0206</hex>

			<cpu:CopyImmediateToAL/>
			<binary>00000000</binary>

			<cpu:WriteALToDXPort/>

			<cpu:Operand16/>
			<cpu:MathImmediateToOperandFunction/>
			<math:SubtractFromDXRegister/>
			<hex>0206</hex>

			<!--Set Byte Count 0-->
			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToDXRegister/>
			<pata:ByteCount0/>

			<cpu:CopyImmediateToAL/>
			<hex>00</hex>

			<cpu:WriteALToDXPort/>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:SubtractFromDXRegister/>
			<pata:ByteCount0/>

			<!--Set Byte Count 1-->
			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToDXRegister/>
			<pata:ByteCount1/>

			<cpu:CopyImmediateToAL/>
			<hex>08</hex>

			<cpu:WriteALToDXPort/>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:SubtractFromDXRegister/>
			<pata:ByteCount1/>

			<!--Send ATAPI Packet Command-->
			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToDXRegister/>
			<pata:Command/>

			<cpu:CopyImmediateToAL/>
			<cmd:Packet/>

			<cpu:WriteALToDXPort/>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:SubtractFromDXRegister/>
			<pata:Command/>

			<!--Wait While Busy-->
			<cpu:CallRelative/>
			<addressOf ref="wait" type="Relative32"/>

			<cpu:CallRelative/>
			<addressOf ref="poll" type="Relative32"/>

			<!--Send ATAPI Packet-->
			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToDXRegister/>
			<pata:Data/>

			<cpu:Operand16/>
			<cpu:CopyImmediateToAX/>
			<hex>0028</hex>

			<cpu:Operand16/>
			<cpu:WriteAXToDXPort/>

			<cpu:PullAXFromStack/>

			<cpu:ShiftRegisterByImmediate8Function/>
			<shift:RollAXRegisterRight/>
			<byte>16</byte>

			<cpu:Operand16/>
			<cpu:ShiftRegisterByImmediate8Function/>
			<shift:RollAXRegisterRight/>
			<byte>8</byte>

			<cpu:Operand16/>
			<cpu:WriteAXToDXPort/>

			<cpu:ShiftRegisterByImmediate8Function/>
			<shift:RollAXRegisterLeft/>
			<byte>16</byte>

			<cpu:Operand16/>
			<cpu:ShiftRegisterByImmediate8Function/>
			<shift:RollAXRegisterRight/>
			<byte>8</byte>

			<cpu:Operand16/>
			<cpu:WriteAXToDXPort/>

			<cpu:Operand16/>
			<cpu:CopyImmediateToAX/>
			<hex>0000</hex>

			<cpu:Operand16/>
			<cpu:WriteAXToDXPort/>

			<cpu:Operand16/>
			<cpu:CopyImmediateToAX/>
			<hex>0001</hex>

			<cpu:Operand16/>
			<cpu:WriteAXToDXPort/>

			<cpu:Operand16/>
			<cpu:CopyImmediateToAX/>
			<hex>0000</hex>

			<cpu:Operand16/>
			<cpu:WriteAXToDXPort/>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:SubtractFromDXRegister/>
			<pata:Data/>

			<!--Wait While Busy-->
			<cpu:WaitForInterrupt/>
			<cpu:WaitForInterrupt/>
			<cpu:WaitForInterrupt/>
			<cpu:WaitForInterrupt/>

			<!--Get Byte Count 0-->
			<!--<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDXRegister/>
		<pata:ByteCount0/>
		
		<cpu:ReadFromDXPortToAL/>

		<cpu:MathImmediate8ToOperandFunction/>
		<math:SubtractFromDXRegister/>
		<pata:ByteCount0/>-->

			<!--Get Byte Count 1-->
			<!--<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDXRegister/>
		<pata:ByteCount1/>

		<cpu:ReadFromDXPortToAL/>

		<cpu:MathImmediate8ToOperandFunction/>
		<math:SubtractFromDXRegister/>
		<pata:ByteCount1/>-->

			<!--<cpu:CallRelative/>
			<addressOf ref="sleep" type="Relative32"/>-->

			<cpu:CallRelative/>
			<addressOf ref="wait" type="Relative32"/>

			<!--Read Data-->
			<cpu:CallRelative/>
			<addressOf ref="poll" type="Relative32"/>

			<cpu:CopyImmediateToCX/>
			<int>1024</int>

			<cpu:Operand16/>
			<cpu:Repeat/>
			<cpu:ReadFromDXPortToDIAddressAndIncrementDI/>

			<cpu:JumpToRelative8/>
			<addressOf ref="end" type="Relative8"/>

			<label id="sleep"/>

			<cpu:Operand16/>
			<cpu:MathImmediateToOperandFunction/>
			<math:AddToDXRegister/>
			<hex>0206</hex>

			<cpu:ReadFromDXPortToAL/>
			<cpu:ReadFromDXPortToAL/>
			<cpu:ReadFromDXPortToAL/>
			<cpu:ReadFromDXPortToAL/>

			<cpu:Operand16/>
			<cpu:MathImmediateToOperandFunction/>
			<math:SubtractFromDXRegister/>
			<hex>0206</hex>

			<cpu:ReturnToNearCaller/>

			<label id="wait"/>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToDXRegister/>
			<pata:Status/>

			<label id="whileBusy"/>

			<cpu:ReadFromDXPortToAL/>

			<cpu:AndALWithImmediate/>
			<status:Busy/>

			<cpu:BranchToRelative8IfNotZero/>
			<addressOf ref="whileBusy" type="Relative8"/>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:SubtractFromDXRegister/>
			<pata:Status/>

			<cpu:ReturnToNearCaller/>

			<label id="poll"/>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToDXRegister/>
			<pata:Status/>

			<label id="whileEmpty"/>

			<cpu:ReadFromDXPortToAL/>

			<cpu:AndALWithImmediate/>
			<status:DataRequest/>

			<cpu:BranchToRelative8IfZero/>
			<addressOf ref="whileEmpty" type="Relative8"/>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:SubtractFromDXRegister/>
			<pata:Status/>

			<cpu:ReturnToNearCaller/>

			<label id="end"/>
		</scope>
	</xsl:template>

	<xsl:template match="ns:ReadBlocks">
		<scope>
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

			<cpu:ShiftRegisterByImmediateFunction8/>
			<shift:ShiftBLRegisterLeft/>
			<byte>4</byte>

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
			<cmd:ReadSectors/>

			<cpu:WriteALToDXPort/>

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

		<cpu:ShiftRegisterByImmediateFunction8/>
		<shift:ShiftBLRegisterLeft/>
		<byte>4</byte>

		<cpu:OrRegisterWithOperand8/>
		<op:AL-BLRegister/>

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

		<cpu:CopyImmediateToCX/>
		<int>128</int>

		<cpu:Repeat/>
		<cpu:WriteSIAddressToDXPortAndIncrementSI/>
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

			<cpu:ShiftRegisterByImmediateFunction8/>
			<shift:ShiftBLRegisterLeft/>
			<byte>4</byte>

			<cpu:OrRegisterWithOperand8/>
			<op:AL-BLRegister/>

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
