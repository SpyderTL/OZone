<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:var="http://metalx.org/Variable"
	xmlns:ns="http://metalx.org/i386/Functions/Network"
	xmlns:pci="http://metalx.org/Pc/Pci/Ports"
	xmlns:cfg="http://metalx.org/Pc/Pci/Configuration"
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

	<xsl:template match="ns:GetEthernetAddress">
		<cpu:PushDIToStack/>

		<str:Create length="12"/>

		<cpu:PullSIFromStack/>

		<cpu:Operand16/>
		<cpu:CopyOperandToRegister/>
		<op:AX-SIAddress/>

		<cpu:ExchangeOperandWithRegister8/>
		<op:AL-AHRegister/>

		<cpu:PushSIToStack/>
		<cpu:PushDIToStack/>
		<cpu:PushDIToStack/>

		<hex:ToString digits="4"/>

		<cpu:CopyRegisterToOperand/>
		<op:DI-SIRegister/>

		<cpu:PullDIFromStack/>

		<str:AppendString/>

		<cpu:PullDIFromStack/>
		<cpu:PullSIFromStack/>

		<cpu:Operand16/>
		<cpu:CopyOperandToRegister/>
		<op:AX-SIAddressPlusImmediate8/>
		<byte>2</byte>

		<cpu:ExchangeOperandWithRegister8/>
		<op:AL-AHRegister/>

		<cpu:PushSIToStack/>
		<cpu:PushDIToStack/>
		<cpu:PushDIToStack/>

		<hex:ToString digits="4"/>

		<cpu:CopyRegisterToOperand/>
		<op:DI-SIRegister/>

		<cpu:PullDIFromStack/>

		<str:AppendString/>

		<cpu:PullDIFromStack/>
		<cpu:PullSIFromStack/>

		<cpu:Operand16/>
		<cpu:CopyOperandToRegister/>
		<op:AX-SIAddressPlusImmediate8/>
		<byte>4</byte>

		<cpu:ExchangeOperandWithRegister8/>
		<op:AL-AHRegister/>

		<cpu:PushSIToStack/>
		<cpu:PushDIToStack/>
		<cpu:PushDIToStack/>

		<hex:ToString digits="4"/>

		<cpu:CopyRegisterToOperand/>
		<op:DI-SIRegister/>

		<cpu:PullDIFromStack/>

		<str:AppendString/>

		<cpu:PullDIFromStack/>
		<cpu:PullSIFromStack/>
	</xsl:template>

	<xsl:template match="ns:GetInternetAddress">
		<cpu:PushAXToStack/>

		<str:Create length="15"/>

		<cpu:PullAXFromStack/>

		<cpu:PushDIToStack/>

		<cpu:PushAXToStack/>

		<cpu:AndAXWithImmediate/>
		<hex>000000ff</hex>

		<int:ToString/>

		<cpu:PullAXFromStack/>

		<cpu:CopyRegisterToOperand/>
		<op:DI-SIRegister/>

		<cpu:PullDIFromStack/>
		<cpu:PushDIToStack/>

		<str:AppendString/>

		<cpu:PullSIFromStack/>
		<cpu:PushSIToStack/>

		<str:AppendCharacter value="."/>

		<cpu:ShiftRegisterByImmediate8Function/>
		<shift:RollAXRegisterRight/>
		<byte>8</byte>

		<cpu:PushAXToStack/>

		<cpu:AndAXWithImmediate/>
		<hex>000000ff</hex>

		<int:ToString/>

		<cpu:PullAXFromStack/>

		<cpu:CopyRegisterToOperand/>
		<op:DI-SIRegister/>

		<cpu:PullDIFromStack/>
		<cpu:PushDIToStack/>

		<str:AppendString/>

		<cpu:PullSIFromStack/>
		<cpu:PushSIToStack/>

		<str:AppendCharacter value="."/>

		<cpu:ShiftRegisterByImmediate8Function/>
		<shift:RollAXRegisterRight/>
		<byte>8</byte>

		<cpu:PushAXToStack/>

		<cpu:AndAXWithImmediate/>
		<hex>000000ff</hex>

		<int:ToString/>

		<cpu:PullAXFromStack/>

		<cpu:CopyRegisterToOperand/>
		<op:DI-SIRegister/>

		<cpu:PullDIFromStack/>
		<cpu:PushDIToStack/>

		<str:AppendString/>

		<cpu:PullSIFromStack/>
		<cpu:PushSIToStack/>

		<str:AppendCharacter value="."/>

		<cpu:ShiftRegisterByImmediate8Function/>
		<shift:RollAXRegisterRight/>
		<byte>8</byte>

		<cpu:PushAXToStack/>

		<cpu:AndAXWithImmediate/>
		<hex>000000ff</hex>

		<int:ToString/>

		<cpu:PullAXFromStack/>

		<cpu:CopyRegisterToOperand/>
		<op:DI-SIRegister/>

		<cpu:PullDIFromStack/>
		<cpu:PushDIToStack/>

		<str:AppendString/>

		<cpu:PullDIFromStack/>
	</xsl:template>

	<xsl:template match="ns:CalculateIpChecksum">
		<scope>
			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToSIRegister/>
			<byte>14</byte>

			<cpu:CopyOperandToRegister8/>
			<op:AL-SIAddress/>

			<cpu:AndAXWithImmediate/>
			<hex>0000000f</hex>

			<cpu:ShiftRegisterByOneFunction/>
			<shift:ShiftAXRegisterLeft/>

			<cpu:CopyRegisterToOperand/>
			<op:AX-CXRegister/>

			<cpu:CopyImmediateToAX/>
			<int>0</int>

			<cpu:CopyRegisterToOperand/>
			<op:AX-DIRegister/>

			<label id="nextValue"/>

			<cpu:Operand16/>
			<cpu:CopySIAddressToAXAndIncrementSI/>
			
			<!--<cpu:Operand16/>
			<cpu:CopyOperandToRegister/>
			<op:AX-SIAddress/>-->

			<cpu:ExchangeOperandWithRegister8/>
			<op:AL-AHRegister/>

			<cpu:AddRegisterToOperand/>
			<op:AX-DIRegister/>

			<!--<cpu:IncrementSI/>
			<cpu:IncrementSI/>-->

			<cpu:LoopToRelative8/>
			<addressOf ref="nextValue" type="Relative8"/>

			<cpu:CopyRegisterToOperand/>
			<op:DI-AXRegister/>

			<cpu:ShiftRegisterByImmediate8Function/>
			<shift:ShiftDIRegisterRight/>
			<byte>16</byte>

			<cpu:AddRegisterToOperand/>
			<op:DI-AXRegister/>

			<cpu:Operand16/>
			<cpu:ExclusiveOrAXWithImmediate/>
			<hex>ffff</hex>

			<cpu:AndAXWithImmediate/>
			<hex>0000ffff</hex>
		</scope>
	</xsl:template>

	<xsl:template match="ns:CalculateTcpChecksum">
		<scope>
			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToSIRegister/>
			<byte>14</byte>

			<!--Get IP Length-->
			<cpu:CopyImmediateToAX/>
			<int>0</int>

			<cpu:Operand16/>
			<cpu:CopyOperandToRegister/>
			<op:AX-SIAddressPlusImmediate8/>
			<byte>2</byte>

			<cpu:ExchangeOperandWithRegister8/>
			<op:AL-AHRegister/>

			<cpu:CopyRegisterToOperand/>
			<op:AX-DXRegister/>

			<!--Get IP Header Length-->
			<cpu:CopyOperandToRegister8/>
			<op:AL-SIAddress/>

			<cpu:AndAXWithImmediate/>
			<hex>0000000f</hex>

			<cpu:ShiftRegisterByImmediate8Function/>
			<shift:ShiftAXRegisterLeft/>
			<byte>2</byte>

			<cpu:CopyRegisterToOperand/>
			<op:AX-BXRegister/>

			<cpu:SubtractRegisterFromOperand/>
			<op:AX-DXRegister/>

			<cpu:CopyRegisterToOperand/>
			<op:DX-DIRegister/>

			<cpu:CopyImmediateToAX/>
			<int>0</int>

			<cpu:CopyOperandToRegister8/>
			<op:AL-SIAddressPlusImmediate8/>
			<byte>9</byte>

			<cpu:AddRegisterToOperand/>
			<op:AX-DIRegister/>

			<cpu:Operand16/>
			<cpu:CopyOperandToRegister/>
			<op:AX-SIAddressPlusImmediate8/>
			<byte>12</byte>

			<cpu:ExchangeOperandWithRegister8/>
			<op:AL-AHRegister/>

			<cpu:AddRegisterToOperand/>
			<op:AX-DIRegister/>

			<cpu:Operand16/>
			<cpu:CopyOperandToRegister/>
			<op:AX-SIAddressPlusImmediate8/>
			<byte>14</byte>

			<cpu:ExchangeOperandWithRegister8/>
			<op:AL-AHRegister/>

			<cpu:AddRegisterToOperand/>
			<op:AX-DIRegister/>

			<cpu:Operand16/>
			<cpu:CopyOperandToRegister/>
			<op:AX-SIAddressPlusImmediate8/>
			<byte>16</byte>

			<cpu:ExchangeOperandWithRegister8/>
			<op:AL-AHRegister/>

			<cpu:AddRegisterToOperand/>
			<op:AX-DIRegister/>

			<cpu:Operand16/>
			<cpu:CopyOperandToRegister/>
			<op:AX-SIAddressPlusImmediate8/>
			<byte>18</byte>

			<cpu:ExchangeOperandWithRegister8/>
			<op:AL-AHRegister/>

			<cpu:AddRegisterToOperand/>
			<op:AX-DIRegister/>

			<cpu:AddRegisterToOperand/>
			<op:BX-SIRegister/>

			<cpu:CopyRegisterToOperand/>
			<op:DX-CXRegister/>

			<cpu:ShiftRegisterByOneFunction/>
			<shift:ShiftCXRegisterRight/>

			<label id="nextValue"/>

			<cpu:Operand16/>
			<cpu:CopySIAddressToAXAndIncrementSI/>

			<cpu:ExchangeOperandWithRegister8/>
			<op:AL-AHRegister/>

			<cpu:AddRegisterToOperand/>
			<op:AX-DIRegister/>

			<cpu:LoopToRelative8/>
			<addressOf ref="nextValue" type="Relative8"/>

			<cpu:MathImmediateToOperandFunction/>
			<math:AndWithDXRegister/>
			<int>1</int>

			<cpu:BranchToRelative8IfZero/>
			<addressOf ref="skipPadding" type="Relative8"/>

			<cpu:CopyOperandToRegister8/>
			<op:AH-SIAddress/>

			<cpu:MathImmediateToOperandFunction/>
			<math:AndWithAXRegister/>
			<hex>0000ff00</hex>

			<cpu:AddRegisterToOperand/>
			<op:AX-DIRegister/>

			<label id="skipPadding"/>

			<cpu:CopyRegisterToOperand/>
			<op:DI-AXRegister/>

			<cpu:ShiftRegisterByImmediate8Function/>
			<shift:ShiftDIRegisterRight/>
			<byte>16</byte>

			<cpu:AddRegisterToOperand/>
			<op:DI-AXRegister/>

			<cpu:Operand16/>
			<cpu:ExclusiveOrAXWithImmediate/>
			<hex>ffff</hex>

			<cpu:AndAXWithImmediate/>
			<hex>0000ffff</hex>
		</scope>
	</xsl:template>

</xsl:stylesheet>
