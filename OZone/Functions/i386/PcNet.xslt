<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:var="http://metalx.org/Variable"
	xmlns:ns="http://metalx.org/i386/Functions/PcNet"
	xmlns:pci="http://metalx.org/Pc/Pci/Ports"
	xmlns:cfg="http://metalx.org/Pc/Pci/Configuration"
	xmlns:pcnp="http://metalx.org/Amd/PcNet/Ports"
	xmlns:pcnr="http://metalx.org/Amd/PcNet/ControlStatus"
	xmlns:pcnb="http://metalx.org/Amd/PcNet/BusConfiguration"
	xmlns:inc="http://metalx.org/Intel/80386/Increment"
	xmlns:imm="http://metalx.org/Intel/80386/Immediate"
	xmlns:math="http://metalx.org/Intel/80386/Math"
	xmlns:shift="http://metalx.org/Intel/80386/Shift"
	xmlns:obj="http://metalx.org/i386/Functions/Object"
	xmlns:lst="http://metalx.org/i386/Functions/List"
	xmlns:int="http://metalx.org/i386/Functions/Integer"
	xmlns:hex="http://metalx.org/i386/Functions/Hexadecimal"
	xmlns:str="http://metalx.org/i386/Functions/String"
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

	<xsl:template match="ns:FindDevice">
		<scope>
			<cpu:CopyImmediateToCX/>
			<hex>00010000</hex>

			<cpu:CopyImmediateToAX/>
			<hex>80000000</hex>

			<label id="forEachDevice"/>

			<cpu:CopyImmediateToDX/>
			<pci:ConfigurationAddress/>

			<cpu:WriteAXToDXPort/>

			<cpu:CopyImmediateToDX/>
			<pci:ConfigurationData/>

			<cpu:PushAXToStack/>

			<cpu:ReadFromDXPortToAX/>

			<cpu:CompareAXToImmediate/>
			<hex>20001022</hex>

			<cpu:PullAXFromStack/>

			<cpu:BranchToRelative8IfEqual/>
			<addressOf ref="getPort" type="Relative8"/>

			<cpu:AddImmediateToAX/>
			<hex>00000100</hex>

			<cpu:LoopToRelative8/>
			<addressOf ref="forEachDevice" type="Relative8"/>

			<label id="getPort"/>

			<cpu:OrAXWithImmediate/>
			<hex>00000010</hex>

			<cpu:CopyImmediateToDX/>
			<pci:ConfigurationAddress/>

			<cpu:WriteAXToDXPort/>

			<cpu:CopyImmediateToDX/>
			<pci:ConfigurationData/>

			<cpu:ReadFromDXPortToAX/>

			<cpu:AndAXWithImmediate/>
			<hex>fffffffc</hex>

			<cpu:CopyRegisterToOperand/>
			<op:AX-DXRegister/>
		</scope>
	</xsl:template>

	<xsl:template match="ns:CreateObject">
	</xsl:template>

	<xsl:template match="ns:GetEthernetAddress">
		<mm:CheckOut length="6"/>

		<cpu:PushDIToStack/>

		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDXRegister/>
		<pcnp:RegisterAccess/>

		<cpu:Operand16/>
		<cpu:CopyImmediateToAX/>
		<pcnr:PhysicalAddress0/>
		<hex>00</hex>

		<cpu:Operand16/>
		<cpu:WriteAXToDXPort/>

		<cpu:MathImmediate8ToOperandFunction/>
		<math:SubtractFromDXRegister/>
		<hex>02</hex>

		<cpu:Operand16/>
		<cpu:ReadFromDXPortToDIAddressAndIncrementDI/>

		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDXRegister/>
		<hex>02</hex>

		<cpu:CopyImmediateToAL/>
		<pcnr:PhysicalAddress1/>

		<cpu:Operand16/>
		<cpu:WriteAXToDXPort/>

		<cpu:MathImmediate8ToOperandFunction/>
		<math:SubtractFromDXRegister/>
		<hex>02</hex>

		<cpu:Operand16/>
		<cpu:ReadFromDXPortToDIAddressAndIncrementDI/>

		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDXRegister/>
		<hex>02</hex>

		<cpu:CopyImmediateToAL/>
		<pcnr:PhysicalAddress2/>

		<cpu:Operand16/>
		<cpu:WriteAXToDXPort/>

		<cpu:MathImmediate8ToOperandFunction/>
		<math:SubtractFromDXRegister/>
		<hex>02</hex>

		<cpu:Operand16/>
		<cpu:ReadFromDXPortToDIAddressAndIncrementDI/>

		<cpu:PullDIFromStack/>
	</xsl:template>

	<xsl:template match="ns:SetReceiveDescriptorRing">
		<cpu:PushAXToStack/>

		<!--Initialize ReceiveRingLower-->
		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDXRegister/>
		<pcnp:RegisterAccess/>

		<cpu:Operand16/>
		<cpu:CopyImmediateToAX/>
		<pcnr:ReceiveRingLower/>
		<hex>00</hex>

		<cpu:Operand16/>
		<cpu:WriteAXToDXPort/>

		<cpu:MathImmediate8ToOperandFunction/>
		<math:SubtractFromDXRegister/>
		<hex>02</hex>

		<cpu:CopyRegisterToOperand/>
		<op:SI-AXRegister/>

		<cpu:Operand16/>
		<cpu:WriteAXToDXPort/>

		<!--Initialize ReceiveRingUpper-->
		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDXRegister/>
		<hex>02</hex>

		<cpu:CopyImmediateToAL/>
		<pcnr:ReceiveRingUpper/>

		<cpu:Operand16/>
		<cpu:WriteAXToDXPort/>

		<cpu:MathImmediate8ToOperandFunction/>
		<math:SubtractFromDXRegister/>
		<hex>02</hex>

		<cpu:CopyRegisterToOperand/>
		<op:SI-AXRegister/>

		<cpu:ShiftRegisterByImmediate8Function/>
		<shift:ShiftAXRegisterRight/>
		<byte>16</byte>

		<cpu:Operand16/>
		<cpu:WriteAXToDXPort/>

		<!--Initialize ReceiveRingLength-->
		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDXRegister/>
		<hex>02</hex>

		<cpu:CopyImmediateToAL/>
		<pcnr:ReceiveRingLength/>

		<cpu:Operand16/>
		<cpu:WriteAXToDXPort/>

		<cpu:MathImmediate8ToOperandFunction/>
		<math:SubtractFromDXRegister/>
		<hex>02</hex>

		<cpu:PullAXFromStack/>

		<cpu:Operand16/>
		<cpu:ExclusiveOrAXWithImmediate/>
		<hex>ffff</hex>

		<cpu:Operand16/>
		<cpu:IncrementAX/>

		<cpu:Operand16/>
		<cpu:WriteAXToDXPort/>
	</xsl:template>

	<xsl:template match="ns:SetTransmitDescriptorRing">
		<cpu:PushAXToStack/>

		<!--Initialize TransmitRingLower-->
		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDXRegister/>
		<pcnp:RegisterAccess/>

		<cpu:Operand16/>
		<cpu:CopyImmediateToAX/>
		<pcnr:TransmitRingLower/>
		<hex>00</hex>

		<cpu:Operand16/>
		<cpu:WriteAXToDXPort/>

		<cpu:MathImmediate8ToOperandFunction/>
		<math:SubtractFromDXRegister/>
		<hex>02</hex>

		<cpu:CopyRegisterToOperand/>
		<op:SI-AXRegister/>

		<cpu:Operand16/>
		<cpu:WriteAXToDXPort/>

		<!--Initialize ReceiveRingUpper-->
		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDXRegister/>
		<hex>02</hex>

		<cpu:CopyImmediateToAL/>
		<pcnr:TransmitRingUpper/>

		<cpu:Operand16/>
		<cpu:WriteAXToDXPort/>

		<cpu:MathImmediate8ToOperandFunction/>
		<math:SubtractFromDXRegister/>
		<hex>02</hex>

		<cpu:CopyRegisterToOperand/>
		<op:SI-AXRegister/>

		<cpu:ShiftRegisterByImmediate8Function/>
		<shift:ShiftAXRegisterRight/>
		<byte>16</byte>

		<cpu:Operand16/>
		<cpu:WriteAXToDXPort/>

		<!--Initialize ReceiveRingLength-->
		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDXRegister/>
		<hex>02</hex>

		<cpu:CopyImmediateToAL/>
		<pcnr:TransmitRingLength/>

		<cpu:Operand16/>
		<cpu:WriteAXToDXPort/>

		<cpu:MathImmediate8ToOperandFunction/>
		<math:SubtractFromDXRegister/>
		<hex>02</hex>

		<cpu:PullAXFromStack/>

		<cpu:Operand16/>
		<cpu:ExclusiveOrAXWithImmediate/>
		<hex>ffff</hex>

		<cpu:Operand16/>
		<cpu:IncrementAX/>

		<cpu:Operand16/>
		<cpu:WriteAXToDXPort/>
	</xsl:template>

	<xsl:template match="ns:Start">
		<!--Initialize Mode-->
		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDXRegister/>
		<pcnp:RegisterAccess/>

		<cpu:Operand16/>
		<cpu:CopyImmediateToAX/>
		<pcnr:Mode/>
		<hex>00</hex>

		<cpu:Operand16/>
		<cpu:WriteAXToDXPort/>

		<cpu:MathImmediate8ToOperandFunction/>
		<math:SubtractFromDXRegister/>
		<hex>02</hex>

		<cpu:Operand16/>
		<cpu:CopyImmediateToAX/>
		<binary>1000000110000000</binary>

		<cpu:Operand16/>
		<cpu:WriteAXToDXPort/>

		<!--Set START bit on CSR0-->
		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDXRegister/>
		<hex>02</hex>

		<cpu:CopyImmediateToAL/>
		<pcnr:ControlAndStatus/>

		<cpu:Operand16/>
		<cpu:WriteAXToDXPort/>

		<cpu:MathImmediate8ToOperandFunction/>
		<math:SubtractFromDXRegister/>
		<hex>02</hex>

		<cpu:Operand16/>
		<cpu:CopyImmediateToAX/>
		<binary>0000000000000010</binary>

		<cpu:Operand16/>
		<cpu:WriteAXToDXPort/>
	</xsl:template>

	<xsl:template match="ns:Stop">
		<!--Set STOP bit on CSR0-->
		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDXRegister/>
		<pcnp:RegisterAccess/>

		<cpu:CopyImmediateToAX/>
		<pcnr:ControlAndStatus/>
		<hex>00</hex>
		<hex>0000</hex>

		<cpu:Operand16/>
		<cpu:WriteAXToDXPort/>

		<cpu:MathImmediate8ToOperandFunction/>
		<math:SubtractFromDXRegister/>
		<hex>02</hex>

		<cpu:Operand16/>
		<cpu:CopyImmediateToAX/>
		<binary>0000000000000100</binary>

		<cpu:Operand16/>
		<cpu:WriteAXToDXPort/>
	</xsl:template>

	<xsl:template match="ns:RequestTransmit">
	</xsl:template>

	<xsl:template match="ns:IsInterruptFlagSet">
	</xsl:template>

	<xsl:template match="ns:ClearInterruptFlag">
	</xsl:template>

	<xsl:template match="ns:IsInitializing">
	</xsl:template>

	<xsl:template match="ns:IsPacketSent">
	</xsl:template>

	<xsl:template match="ns:ClearPacketSentFlag">
	</xsl:template>

	<xsl:template match="ns:IsPacketReceived">
	</xsl:template>

	<xsl:template match="ns:ClearPacketReceivedFlag">
	</xsl:template>

	<xsl:template match="ns:IsMemoryErrorFlagSet">
	</xsl:template>

	<xsl:template match="ns:ClearMemoryErrorFlag">
	</xsl:template>

	<xsl:template match="ns:IsMissedFrameFlagSet">
	</xsl:template>

	<xsl:template match="ns:ClearMissedFrameFlag">
	</xsl:template>

	<xsl:template match="ns:IsCollisionFlagSet">
	</xsl:template>

	<xsl:template match="ns:ClearCollisionFlag">
	</xsl:template>

	<xsl:template match="ns:IsErrorFlagSet">
	</xsl:template>

	<xsl:template match="ns:IsPacketAvailable">
	</xsl:template>

	<xsl:template match="ns:IsBufferAvailable">
	</xsl:template>

	<xsl:template match="ns:IsConnected">
		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDXRegister/>
		<pcnp:RegisterAccess/>

		<cpu:CopyImmediateToAX/>
		<pcnb:PhyAddress/>
		<hex>00</hex>
		<hex>0000</hex>

		<cpu:Operand16/>
		<cpu:WriteAXToDXPort/>

		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDXRegister/>
		<byte>4</byte>

		<cpu:Operand16/>
		<cpu:CopyImmediateToAX/>
		<short>1</short>

		<cpu:Operand16/>
		<cpu:WriteAXToDXPort/>

		<cpu:MathImmediate8ToOperandFunction/>
		<math:SubtractFromDXRegister/>
		<byte>4</byte>

		<cpu:CopyImmediateToAL/>
		<pcnb:PhyManagementData/>

		<cpu:Operand16/>
		<cpu:WriteAXToDXPort/>

		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDXRegister/>
		<byte>4</byte>

		<cpu:Operand16/>
		<cpu:ReadFromDXPortToAX/>

		<cpu:Operand16/>
		<cpu:TestAXWithImmediate/>
		<binary>0000000000000100</binary>
	</xsl:template>

	<xsl:template match="ns:GetMissedFrameCount">
		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDXRegister/>
		<pcnp:RegisterAccess/>

		<cpu:CopyImmediateToAX/>
		<pcnr:MissedFrameCount/>
		<hex>00</hex>
		<hex>0000</hex>

		<cpu:Operand16/>
		<cpu:WriteAXToDXPort/>

		<cpu:MathImmediate8ToOperandFunction/>
		<math:SubtractFromDXRegister/>
		<hex>02</hex>

		<cpu:Operand16/>
		<cpu:ReadFromDXPortToAX/>
	</xsl:template>

	<xsl:template match="ns:GetCollisionCount">
		<cpu:MathImmediate8ToOperandFunction/>
		<math:AddToDXRegister/>
		<pcnp:RegisterAccess/>

		<cpu:CopyImmediateToAX/>
		<pcnr:ReceiveCollisionCount/>
		<hex>00</hex>
		<hex>0000</hex>

		<cpu:Operand16/>
		<cpu:WriteAXToDXPort/>

		<cpu:MathImmediate8ToOperandFunction/>
		<math:SubtractFromDXRegister/>
		<hex>02</hex>

		<cpu:Operand16/>
		<cpu:ReadFromDXPortToAX/>
	</xsl:template>
</xsl:stylesheet>
