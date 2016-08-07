<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:task="http://metalx.org/i386/Functions/TaskManager"
	xmlns:mem="http://metalx.org/i386/Functions/MemoryManager"
	xmlns:lst="http://metalx.org/i386/Functions/List"
	xmlns:col="http://metalx.org/i386/Functions/Collection"
	xmlns:obj="http://metalx.org/i386/Functions/Object"
	xmlns:cpu="http://metalx.org/Intel/80386/Operators"
	xmlns:op="http://metalx.org/Intel/80386/Operands"
	xmlns:imm="http://metalx.org/Intel/80386/Immediate"
	xmlns:math="http://metalx.org/Intel/80386/Math"
	xmlns:index="http://metalx.org/Intel/80386/Index"
	xmlns:logic="http://metalx.org/Intel/80386/Logic">

  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template name="TaskManagerAddress">
    <hex>01000000</hex>
  </xsl:template>

  <xsl:template match="task:Reset">
	  <lst:Create length="8"/>

	  <cpu:PushDIToStack/>

	  <mem:CheckOut length="4"/>

	  <obj:Create length="4" type="http://metalx.org/System/Task"/>

	  <cpu:CopyOperandToRegister/>
	  <op:SI-IndexAddress/>
	  <index:SP/>
	  
	  <lst:SetItem index="0"/>

	  <cpu:PullDIFromStack/>
	  
	  <lst:CreateObject/>

	  <cpu:CopyImmediateToSI/>
	  <xsl:call-template name="TaskManagerAddress"/>

	  <cpu:CopyImmediateToOperandFunction/>
	  <imm:CopyImmediateToSIAddress/>
	  <int>1</int>

	  <cpu:CopyRegisterToOperand/>
	  <op:DI-SIAddressPlusImmediate8/>
	  <byte>4</byte>
	  
	  <cpu:CopyImmediateToOperandFunction/>
	  <imm:CopyImmediateToSIAddressPlusImmediate8/>
	  <byte>8</byte>
	  <int>0</int>
  </xsl:template>

  <xsl:template match="task:AddTask">
  </xsl:template>

	<xsl:template match="task:Next">
		<cpu:PushAllRegistersToStack/>
		<cpu:PushDSToStack/>
		<cpu:PushESToStack/>
		<cpu:PushFlagsToStack/>

		<cpu:CopyImmediateToSI/>
		<xsl:call-template name="TaskManagerAddress"/>

		<cpu:CopyOperandToRegister/>
		<op:AX-SIAddressPlusImmediate8/>
		<byte>8</byte>

		<cpu:CopyRegisterToOperand/>
		<op:AX-BXRegister/>

		<cpu:IncrementAX/>

		<cpu:CompareRegisterToOperand/>
		<op:AX-SIAddress/>

		<cpu:BranchToRelative8IfLess/>
		<addressOf ref="notLastTask" type="Relative8"/>

		<cpu:ExclusiveOrRegisterWithOperand/>
		<op:AX-AXRegister/>

		<label id="notLastTask"/>

		<cpu:CopyRegisterToOperand/>
		<op:AX-SIAddressPlusImmediate8/>
		<byte>8</byte>

		<!--Find Task List-->
		<cpu:CopyOperandToRegister/>
		<op:SI-SIAddressPlusImmediate8/>
		<byte>4</byte>

		<obj:GetData/>

		<!--Swap Tasks-->
		<cpu:CopyRegisterToOperand/>
		<op:SI-DIRegister/>

		<cpu:CopyOperandToRegister/>
		<op:SI-IndexAddressPlusImmediate8/>
		<index:BXTimesFourPlusDI/>
		<byte>4</byte>

		<obj:GetData/>

		<cpu:CopyRegisterToOperand/>
		<op:SP-SIAddress/>

		<cpu:CopyOperandToRegister/>
		<op:SI-IndexAddressPlusImmediate8/>
		<index:AXTimesFourPlusDI/>
		<byte>4</byte>

		<obj:GetData/>

		<cpu:CopyOperandToRegister/>
		<op:SP-SIAddress/>

		<cpu:PullFlagsFromStack/>
		<cpu:PullESFromStack/>
		<cpu:PullDSFromStack/>
		<cpu:PullAllRegistersFromStack/>
	</xsl:template>
	
	<xsl:template match="task:Yield">
		<scope>
			<!--Simulate Interrupt-->
			<cpu:PushFlagsToStack/>
		
			<cpu:PushImmediateToStack/>
			<hex>00000008</hex>
		
			<cpu:PushImmediateToStack/>
			<addressOf ref="resume" type="Absolute32"/>
			
			<cpu:PushAllRegistersToStack/>
			<cpu:PushDSToStack/>
			<cpu:PushESToStack/>
			
			<cpu:PushImmediateToStack/>
			<hex>00000202</hex>

			<cpu:CopyImmediateToSI/>
			<xsl:call-template name="TaskManagerAddress"/>

			<cpu:CopyOperandToRegister/>
			<op:AX-SIAddressPlusImmediate8/>
			<byte>8</byte>

			<cpu:CopyRegisterToOperand/>
			<op:AX-BXRegister/>

			<cpu:IncrementAX/>

			<cpu:CompareRegisterToOperand/>
			<op:AX-SIAddress/>

			<cpu:BranchToRelative8IfLess/>
			<addressOf ref="notLastTask" type="Relative8"/>

			<cpu:ExclusiveOrRegisterWithOperand/>
			<op:AX-AXRegister/>

			<label id="notLastTask"/>

			<cpu:CopyRegisterToOperand/>
			<op:AX-SIAddressPlusImmediate8/>
			<byte>8</byte>

			<!--Find Task List-->
			<cpu:CopyOperandToRegister/>
			<op:SI-SIAddressPlusImmediate8/>
			<byte>4</byte>

			<obj:GetData/>

			<!--Swap Tasks-->
			<cpu:CopyRegisterToOperand/>
			<op:SI-DIRegister/>

			<cpu:CopyOperandToRegister/>
			<op:SI-IndexAddressPlusImmediate8/>
			<index:BXTimesFourPlusDI/>
			<byte>4</byte>

			<obj:GetData/>

			<cpu:CopyRegisterToOperand/>
			<op:SP-SIAddress/>

			<cpu:CopyOperandToRegister/>
			<op:SI-IndexAddressPlusImmediate8/>
			<index:AXTimesFourPlusDI/>
			<byte>4</byte>

			<obj:GetData/>

			<cpu:CopyOperandToRegister/>
			<op:SP-SIAddress/>

			<cpu:PullFlagsFromStack/>
			<cpu:PullESFromStack/>
			<cpu:PullDSFromStack/>
			<cpu:PullAllRegistersFromStack/>

			<cpu:ReturnFromInterrupt/>

			<label id="resume"/>
		</scope>
	</xsl:template>
</xsl:stylesheet>
