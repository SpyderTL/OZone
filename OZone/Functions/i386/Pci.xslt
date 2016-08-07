<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:var="http://metalx.org/Variable"
	xmlns:ns="http://metalx.org/i386/Functions/Pci"
	xmlns:pci="http://metalx.org/Pc/Pci/Ports"
	xmlns:cfg="http://metalx.org/Pc/Pci/Configuration"
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

	<xsl:template match="ns:CreateDeviceObject">
		<scope>
			<cpu:PushSIToStack/>

			<mm:CheckOut length="8"/>

			<cpu:CopyRegisterToOperand/>
			<op:AX-DIAddress/>

			<cpu:PushDIToStack/>

			<sys:GetCatalog/>

			<cpu:CopyImmediateToDI/>
			<addressOf ref="className" type="Absolute32"/>

			<cat:FindType/>

			<cpu:CopyRegisterToOperand/>
			<op:SI-BXRegister/>

			<cpu:PullDIFromStack/>
			<cpu:PullSIFromStack/>

			<cpu:CopyImmediateToAX/>
			<int>8</int>
			
			<obj:Create/>

			<cpu:JumpToRelative8/>
			<addressOf ref="end" type="Relative8"/>

			<var:string id="className">http://metalx.org/Pci/PciDevice</var:string>
			
			<label id="end"/>
		</scope>
	</xsl:template>

	<xsl:template match="ns:GetBaseAddress0">
		<cpu:CopyImmediateToDX/>
		<pci:ConfigurationAddress/>

		<cpu:ShiftRegisterByImmediate8Function/>
		<shift:ShiftAXRegisterLeft/>
		<byte>8</byte>

		<cpu:OrAXWithImmediate/>
		<hex>80000000</hex>

		<cpu:OrALWithImmediate/>
		<cfg:BaseAddress0/>

		<cpu:WriteAXToDXPort/>

		<cpu:CopyImmediateToDX/>
		<pci:ConfigurationData/>

		<cpu:ReadFromDXPortToAX/>
	</xsl:template>

	<xsl:template match="ns:GetBaseAddress1">
		<cpu:CopyImmediateToDX/>
		<pci:ConfigurationAddress/>

		<cpu:ShiftRegisterByImmediate8Function/>
		<shift:ShiftAXRegisterLeft/>
		<byte>8</byte>

		<cpu:OrAXWithImmediate/>
		<hex>80000000</hex>

		<cpu:OrALWithImmediate/>
		<cfg:BaseAddress1/>

		<cpu:WriteAXToDXPort/>

		<cpu:CopyImmediateToDX/>
		<pci:ConfigurationData/>

		<cpu:ReadFromDXPortToAX/>
	</xsl:template>

	<xsl:template match="ns:GetBaseAddress2">
		<cpu:CopyImmediateToDX/>
		<pci:ConfigurationAddress/>

		<cpu:ShiftRegisterByImmediate8Function/>
		<shift:ShiftAXRegisterLeft/>
		<byte>8</byte>

		<cpu:OrAXWithImmediate/>
		<hex>80000000</hex>

		<cpu:OrALWithImmediate/>
		<cfg:BaseAddress2/>

		<cpu:WriteAXToDXPort/>

		<cpu:CopyImmediateToDX/>
		<pci:ConfigurationData/>

		<cpu:ReadFromDXPortToAX/>
	</xsl:template>

	<xsl:template match="ns:GetBaseAddress3">
		<cpu:CopyImmediateToDX/>
		<pci:ConfigurationAddress/>

		<cpu:ShiftRegisterByImmediate8Function/>
		<shift:ShiftAXRegisterLeft/>
		<byte>8</byte>

		<cpu:OrAXWithImmediate/>
		<hex>80000000</hex>

		<cpu:OrALWithImmediate/>
		<cfg:BaseAddress3/>

		<cpu:WriteAXToDXPort/>

		<cpu:CopyImmediateToDX/>
		<pci:ConfigurationData/>

		<cpu:ReadFromDXPortToAX/>
	</xsl:template>

	<xsl:template match="ns:GetBaseAddress4">
		<cpu:CopyImmediateToDX/>
		<pci:ConfigurationAddress/>

		<cpu:ShiftRegisterByImmediate8Function/>
		<shift:ShiftAXRegisterLeft/>
		<byte>8</byte>

		<cpu:OrAXWithImmediate/>
		<hex>80000000</hex>

		<cpu:OrALWithImmediate/>
		<cfg:BaseAddress4/>

		<cpu:WriteAXToDXPort/>

		<cpu:CopyImmediateToDX/>
		<pci:ConfigurationData/>

		<cpu:ReadFromDXPortToAX/>
	</xsl:template>

	<xsl:template match="ns:GetBaseAddress5">
		<cpu:CopyImmediateToDX/>
		<pci:ConfigurationAddress/>

		<cpu:ShiftRegisterByImmediate8Function/>
		<shift:ShiftAXRegisterLeft/>
		<byte>8</byte>

		<cpu:OrAXWithImmediate/>
		<hex>80000000</hex>

		<cpu:OrALWithImmediate/>
		<cfg:BaseAddress5/>

		<cpu:WriteAXToDXPort/>

		<cpu:CopyImmediateToDX/>
		<pci:ConfigurationData/>

		<cpu:ReadFromDXPortToAX/>
	</xsl:template>

	<xsl:template match="ns:GetInterruptLine">
		<cpu:CopyImmediateToDX/>
		<pci:ConfigurationAddress/>

		<cpu:ShiftRegisterByImmediate8Function/>
		<shift:ShiftAXRegisterLeft/>
		<byte>8</byte>

		<cpu:OrAXWithImmediate/>
		<hex>80000000</hex>

		<cpu:AddImmediateToAX/>
		<hex>0000003c</hex>

		<cpu:WriteAXToDXPort/>

		<cpu:CopyImmediateToDX/>
		<pci:ConfigurationData/>

		<cpu:ReadFromDXPortToAX/>
	</xsl:template>

	<xsl:template match="ns:GetCommandStatus">
		<cpu:CopyImmediateToDX/>
		<pci:ConfigurationAddress/>

		<cpu:ShiftRegisterByImmediate8Function/>
		<shift:ShiftAXRegisterLeft/>
		<byte>8</byte>

		<cpu:OrAXWithImmediate/>
		<hex>80000000</hex>

		<cpu:AddImmediateToAX/>
		<int>4</int>

		<cpu:WriteAXToDXPort/>

		<cpu:CopyImmediateToDX/>
		<pci:ConfigurationData/>

		<cpu:ReadFromDXPortToAX/>
	</xsl:template>

	<xsl:template match="ns:SetCommand">
		<cpu:CopyImmediateToDX/>
		<pci:ConfigurationAddress/>

		<cpu:ShiftRegisterByImmediate8Function/>
		<shift:ShiftAXRegisterLeft/>
		<byte>8</byte>

		<cpu:OrAXWithImmediate/>
		<hex>80000000</hex>

		<cpu:AddImmediateToAX/>
		<int>4</int>

		<cpu:WriteAXToDXPort/>

		<cpu:CopyImmediateToDX/>
		<pci:ConfigurationData/>

		<cpu:CopyRegisterToOperand/>
		<op:BX-AXRegister/>

		<cpu:Operand16/>
		<cpu:WriteAXToDXPort/>
	</xsl:template>

	<xsl:template match="ns:GetDeviceID">
		<cpu:CopyImmediateToDX/>
		<pci:ConfigurationAddress/>

		<cpu:ShiftRegisterByImmediate8Function/>
		<shift:ShiftAXRegisterLeft/>
		<byte>8</byte>

		<cpu:OrAXWithImmediate/>
		<hex>80000000</hex>

		<cpu:WriteAXToDXPort/>

		<cpu:CopyImmediateToDX/>
		<pci:ConfigurationData/>

		<cpu:ReadFromDXPortToAX/>
	</xsl:template>
	
	<xsl:template match="ns:GetSubsystemID">
		<cpu:CopyImmediateToDX/>
		<pci:ConfigurationAddress/>

		<cpu:ShiftRegisterByImmediate8Function/>
		<shift:ShiftAXRegisterLeft/>
		<byte>8</byte>

		<cpu:OrAXWithImmediate/>
		<hex>80000000</hex>

		<cpu:OrALWithImmediate/>
		<cfg:SubsystemDeviceID/>

		<cpu:WriteAXToDXPort/>

		<cpu:CopyImmediateToDX/>
		<pci:ConfigurationData/>

		<cpu:ReadFromDXPortToAX/>
	</xsl:template>

	<xsl:template match="ns:GetClassCode">
		<cpu:CopyImmediateToDX/>
		<pci:ConfigurationAddress/>

		<cpu:ShiftRegisterByImmediate8Function/>
		<shift:ShiftAXRegisterLeft/>
		<byte>8</byte>

		<cpu:OrAXWithImmediate/>
		<hex>80000000</hex>

		<cpu:OrALWithImmediate/>
		<cfg:RevisionID/>
		
		<cpu:WriteAXToDXPort/>

		<cpu:CopyImmediateToAX/>
		<int>0</int>

		<cpu:CopyImmediateToDX/>
		<pci:ConfigurationData/>

		<cpu:ReadFromDXPortToAX/>
	</xsl:template>
</xsl:stylesheet>
