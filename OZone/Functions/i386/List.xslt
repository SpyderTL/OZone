<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:var="http://metalx.org/Variable"
	xmlns:lst="http://metalx.org/i386/Functions/List"
	xmlns:obj="http://metalx.org/i386/Functions/Object"
	xmlns:cat="http://metalx.org/i386/Functions/Catalog"
	xmlns:mm="http://metalx.org/i386/Functions/MemoryManager"
	xmlns:sys="http://metalx.org/i386/Functions/System"
	xmlns:inc="http://metalx.org/Intel/80386/Increment"
	xmlns:imm="http://metalx.org/Intel/80386/Immediate"
	xmlns:math="http://metalx.org/Intel/80386/Math"
	xmlns:shift="http://metalx.org/Intel/80386/Shift"
	xmlns:cpu="http://metalx.org/Intel/80386/Operators"
	xmlns:op="http://metalx.org/Intel/80386/Operands">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="lst:Create">
		<xsl:choose>
			<xsl:when test="@length">
				<xsl:element name="mm:CheckOut">
					<xsl:attribute name="length">
						<xsl:value-of select="4+(@length*4)"/>
					</xsl:attribute>
				</xsl:element>

				<!--Set length field-->
				<cpu:CopyImmediateToOperandFunction/>
				<imm:CopyImmediateToDIAddress/>
				<int>
					<xsl:value-of select="@length"/>
				</int>
			</xsl:when>
			<xsl:otherwise>
				<cpu:PushAXToStack/>

				<cpu:IncrementAX/>

				<cpu:ShiftRegisterByImmediate8Function/>
				<shift:ShiftAXRegisterLeft/>
				<byte>2</byte>

				<mm:CheckOut/>

				<!--Set length field-->
				<cpu:PullAXFromStack/>

				<cpu:CopyRegisterToOperand/>
				<op:AX-DIAddress/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="lst:CreateObject">
		<scope>
			<!--Get Item Count-->
			<cpu:CopyOperandToRegister/>
			<op:AX-DIAddress/>

			<cpu:IncrementAX/>

			<cpu:ShiftRegisterByImmediate8Function/>
			<shift:ShiftAXRegisterLeft/>
			<byte>2</byte>

			<cpu:PushAXToStack/>
			<cpu:PushSIToStack/>
			<cpu:PushDIToStack/>

			<cpu:CopyImmediateToDI/>
			<addressOf ref="className" type="Absolute32"/>

			<sys:GetCatalog/>

			<cat:FindType/>

			<cpu:CopyRegisterToOperand/>
			<op:SI-BXRegister/>

			<cpu:PullDIFromStack/>
			<cpu:PullSIFromStack/>
			<cpu:PullAXFromStack/>

			<obj:Create/>

			<cpu:JumpToRelative8/>
			<addressOf ref="end" type="Relative8"/>

			<var:string id="className">http://metalx.org/List</var:string>

			<label id="end"/>
		</scope>
	</xsl:template>

	<xsl:template match="lst:CreateIteratorObject">
		<scope>
			<cpu:PushDIToStack/>
			<cpu:PushSIToStack/>

			<cpu:CopyImmediateToDI/>
			<addressOf ref="className" type="Absolute32"/>

			<sys:GetCatalog/>

			<cat:FindType/>

			<cpu:CopyRegisterToOperand/>
			<op:SI-BXRegister/>

			<cpu:PullSIFromStack/>

			<cpu:CopyImmediateToAX/>
			<int>8</int>

			<mm:CheckOut/>

			<cpu:PullDXFromStack/>

			<cpu:CopyRegisterToOperand/>
			<op:DX-DIAddress/>

			<cpu:CopyImmediateToOperandFunction/>
			<imm:CopyImmediateToDIAddressPlusImmediate8/>
			<byte>4</byte>
			<int>1</int>

			<obj:Create/>

			<cpu:JumpToRelative8/>
			<addressOf ref="end" type="Relative8"/>

			<var:string id="className">http://metalx.org/ListIterator</var:string>

			<label id="end"/>
		</scope>
	</xsl:template>

	<xsl:template match="lst:GetLength">
		<!--Set AX to the value at SI-->
		<cpu:CopyOperandToRegister/>
		<op:AX-SIAddress/>
	</xsl:template>

	<xsl:template match="lst:GetItem">
		<xsl:choose>
			<xsl:when test="@index">
				<cpu:CopyOperandToRegister/>
				<op:SI-SIAddressPlusImmediate/>
				<uint>
					<xsl:value-of select="(@index+1)*4"/>
				</uint>
			</xsl:when>
			<xsl:otherwise>
				<cpu:IncrementAX/>

				<cpu:ShiftRegisterByImmediate8Function/>
				<shift:ShiftAXRegisterLeft/>
				<byte>2</byte>

				<cpu:AddRegisterToOperand/>
				<op:AX-SIRegister/>

				<cpu:CopyOperandToRegister/>
				<op:SI-SIAddress/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="lst:SetItem">
		<xsl:choose>
			<xsl:when test="@index">
				<cpu:CopyRegisterToOperand/>
				<op:DI-SIAddressPlusImmediate/>
				<uint>
					<xsl:value-of select="(@index+1)*4"/>
				</uint>
			</xsl:when>
			<xsl:otherwise>
				<cpu:IncrementAX/>

				<cpu:ShiftRegisterByImmediate8Function/>
				<shift:ShiftAXRegisterLeft/>
				<byte>2</byte>

				<cpu:AddRegisterToOperand/>
				<op:AX-SIRegister/>

				<cpu:CopyRegisterToOperand/>
				<op:DI-SIAddress/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="lst:ForEach">
		<scope>
			<cpu:CopyOperandToRegister/>
			<op:CX-SIAddress/>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:CompareWithCXRegister/>
			<byte>0</byte>

			<cpu:BranchToRelative8IfNotEqual/>
			<addressOf ref="start" type="Relative8"/>

			<cpu:JumpToRelative/>
			<addressOf ref="end" type="Relative32"/>

			<label id="start"/>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToSIRegister/>
			<byte>4</byte>

			<cpu:CopyRegisterToOperand/>
			<op:SI-DXRegister/>

			<cpu:CopyOperandToRegister/>
			<op:SI-SIAddress/>

			<xsl:apply-templates select="@* | node()"/>

			<cpu:CopyRegisterToOperand/>
			<op:DX-SIRegister/>

			<cpu:LoopToRelative8/>
			<addressOf ref="start" type="Relative8"/>

			<label id="end"/>
		</scope>
	</xsl:template>

</xsl:stylesheet>
