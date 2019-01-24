<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:var="http://metalx.org/Variable"
	xmlns:cls="http://metalx.org/i386/Functions/Class"
	xmlns:sys="http://metalx.org/i386/Functions/System"
	xmlns:cat="http://metalx.org/i386/Functions/Catalog"
	xmlns:obj="http://metalx.org/i386/Functions/Object"
	xmlns:mm="http://metalx.org/i386/Functions/MemoryManager"
	xmlns:ari="http://metalx.org/Intel/80386/Arithmetic"
	xmlns:math="http://metalx.org/Intel/80386/Math"
	xmlns:logic="http://metalx.org/Intel/80386/Logic"
	xmlns:cpu="http://metalx.org/Intel/80386/Operators"
	xmlns:op="http://metalx.org/Intel/80386/Operands">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="cls:GetName">
		<cpu:CopyOperandToRegister/>
		<op:SI-SIAddress/>
	</xsl:template>

	<xsl:template match="cls:GetNamespace">
		<cpu:CopyOperandToRegister/>
		<op:SI-SIAddressPlusImmediate8/>
		<byte>4</byte>
	</xsl:template>

	<xsl:template match="cls:GetBase">
		<cpu:CopyOperandToRegister/>
		<op:SI-SIAddressPlusImmediate8/>
		<byte>8</byte>
	</xsl:template>

	<xsl:template match="cls:GetFields">
		<cpu:CopyOperandToRegister/>
		<op:SI-SIAddressPlusImmediate8/>
		<byte>12</byte>
	</xsl:template>

	<xsl:template match="cls:GetMethods">
		<cpu:CopyOperandToRegister/>
		<op:SI-SIAddressPlusImmediate8/>
		<byte>16</byte>
	</xsl:template>

	<xsl:template match="cls:FindMethod" name="FindMethod">
		<scope>
			<cpu:CopyOperandToRegister/>
			<op:SI-SIAddressPlusImmediate8/>
			<byte>16</byte>

			<!--Set CX to method count-->
			<cpu:CopyOperandToRegister/>
			<op:CX-SIAddress/>

			<!--Handle classes with zero methods-->
			<cpu:MathImmediate8ToOperandFunction/>
			<math:CompareWithCXRegister/>
			<byte>0</byte>

			<cpu:BranchToRelative8IfNotEqual/>
			<addressOf ref="firstMethod" type="Relative8"/>

			<!--Clear the zero / equal flag-->
			<cpu:MathImmediate8ToOperandFunction/>
			<math:CompareWithCXRegister/>
			<byte>1</byte>

			<cpu:JumpToRelative/>
			<addressOf ref="exitFunction" type="Relative32"/>

			<!--Move to first method-->
			<label id="firstMethod"/>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToSIRegister/>
			<byte>4</byte>

			<!--Compare method-->
			<label id="nextMethod"/>

			<cpu:CopyRegisterToOperand/>
			<op:SI-DXRegister/>

			<cpu:PushDIToStack/>
			<cpu:PushCXToStack/>

			<!--Dereference SI to method description-->
			<cpu:CopyOperandToRegister/>
			<op:SI-SIAddress/>

			<cpu:PushSIToStack/>

			<!--Deference SI to name field-->
			<cpu:CopyOperandToRegister/>
			<op:SI-SIAddress/>

			<!--Set CX to character count-->
			<cpu:CopyOperandToRegister/>
			<op:CX-DIAddress/>

			<!--Include size field-->
			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToCXRegister/>
			<byte>4</byte>

			<cpu:RepeatWhileEqual/>
			<cpu:CompareSIAddressToDIAddressAndIncrementSIAndDI8/>

			<!--Restore registers-->
			<cpu:PullSIFromStack/>
			<cpu:PullCXFromStack/>
			<cpu:PullDIFromStack/>

			<cpu:BranchToRelative8IfEqual/>
			<addressOf ref="exitFunction" type="Relative8"/>

			<!--Move to next method-->
			<cpu:CopyRegisterToOperand/>
			<op:DX-SIRegister/>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToSIRegister/>
			<byte>4</byte>

			<!--Loop until method is found-->
			<cpu:LoopToRelative8WhileNotEqual/>
			<addressOf ref="nextMethod" type="Relative8"/>

			<label id="exitFunction"/>
		</scope>
	</xsl:template>

	<xsl:template match="cls:GetStaticMethods">
		<cpu:CopyOperandToRegister/>
		<op:SI-SIAddressPlusImmediate8/>
		<byte>20</byte>
	</xsl:template>

	<xsl:template match="cls:FindStaticMethod" name="FindStaticMethod">
		<scope>
			<cpu:CopyOperandToRegister/>
			<op:SI-SIAddressPlusImmediate8/>
			<byte>20</byte>

			<!--Set CX to method count-->
			<cpu:CopyOperandToRegister/>
			<op:CX-SIAddress/>

			<!--Handle classes with zero methods-->
			<cpu:MathImmediate8ToOperandFunction/>
			<math:CompareWithCXRegister/>
			<byte>0</byte>

			<cpu:BranchToRelative8IfNotEqual/>
			<addressOf ref="firstMethod" type="Relative8"/>

			<!--Clear the zero / equal flag-->
			<cpu:MathImmediate8ToOperandFunction/>
			<math:CompareWithCXRegister/>
			<byte>1</byte>

			<cpu:JumpToRelative/>
			<addressOf ref="exitFunction" type="Relative32"/>

			<!--Move to first method-->
			<label id="firstMethod"/>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToSIRegister/>
			<byte>4</byte>

			<!--Compare method-->
			<label id="nextMethod"/>

			<cpu:CopyRegisterToOperand/>
			<op:SI-DXRegister/>

			<cpu:PushDIToStack/>
			<cpu:PushCXToStack/>

			<!--Dereference SI to method description-->
			<cpu:CopyOperandToRegister/>
			<op:SI-SIAddress/>

			<cpu:PushSIToStack/>

			<!--Deference SI to name field-->
			<cpu:CopyOperandToRegister/>
			<op:SI-SIAddress/>

			<!--Set CX to character count-->
			<cpu:CopyOperandToRegister/>
			<op:CX-DIAddress/>

			<!--Include size field-->
			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToCXRegister/>
			<byte>4</byte>

			<cpu:RepeatWhileEqual/>
			<cpu:CompareSIAddressToDIAddressAndIncrementSIAndDI8/>

			<!--Restore registers-->
			<cpu:PullSIFromStack/>
			<cpu:PullCXFromStack/>
			<cpu:PullDIFromStack/>

			<cpu:BranchToRelative8IfEqual/>
			<addressOf ref="exitFunction" type="Relative8"/>

			<!--Move to next method-->
			<cpu:CopyRegisterToOperand/>
			<op:DX-SIRegister/>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToSIRegister/>
			<byte>4</byte>

			<!--Loop until method is found-->
			<cpu:LoopToRelative8WhileNotEqual/>
			<addressOf ref="nextMethod" type="Relative8"/>

			<label id="exitFunction"/>
		</scope>
	</xsl:template>

	<xsl:template match="cls:FindField">
		<scope>
			<cpu:CopyOperandToRegister/>
			<op:SI-SIAddressPlusImmediate8/>
			<byte>12</byte>

			<!--Set CX to field count-->
			<cpu:CopyOperandToRegister/>
			<op:CX-SIAddress/>

			<!--Handle classes with zero fields-->
			<cpu:MathImmediate8ToOperandFunction/>
			<math:CompareWithCXRegister/>
			<byte>0</byte>

			<cpu:BranchToRelative8IfNotEqual/>
			<addressOf ref="firstField" type="Relative8"/>

			<!--Clear the zero / equal flag-->
			<cpu:MathImmediate8ToOperandFunction/>
			<math:CompareWithCXRegister/>
			<byte>1</byte>

			<cpu:JumpToRelative/>
			<addressOf ref="exitFunction" type="Relative32"/>

			<!--Move to first method-->
			<label id="firstField"/>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToSIRegister/>
			<byte>4</byte>

			<!--Compare method-->
			<label id="nextField"/>

			<cpu:CopyRegisterToOperand/>
			<op:SI-DXRegister/>

			<cpu:PushDIToStack/>
			<cpu:PushCXToStack/>

			<!--Dereference SI to field description-->
			<cpu:CopyOperandToRegister/>
			<op:SI-SIAddress/>

			<cpu:PushSIToStack/>

			<!--Deference SI to name field-->
			<cpu:CopyOperandToRegister/>
			<op:SI-SIAddress/>

			<!--Set CX to character count-->
			<cpu:CopyOperandToRegister/>
			<op:CX-DIAddress/>

			<!--Include size field-->
			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToCXRegister/>
			<byte>4</byte>

			<cpu:RepeatWhileEqual/>
			<cpu:CompareSIAddressToDIAddressAndIncrementSIAndDI8/>

			<!--Restore registers-->
			<cpu:PullSIFromStack/>
			<cpu:PullCXFromStack/>
			<cpu:PullDIFromStack/>

			<cpu:BranchToRelative8IfEqual/>
			<addressOf ref="exitFunction" type="Relative8"/>

			<!--Move to next field-->

			<cpu:CopyRegisterToOperand/>
			<op:DX-SIRegister/>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToSIRegister/>
			<byte>4</byte>

			<!--Loop until method is found-->
			<cpu:LoopToRelative8WhileNotEqual/>
			<addressOf ref="nextField" type="Relative8"/>

			<label id="exitFunction"/>
		</scope>
	</xsl:template>

	<xsl:template match="cls:IsStatic">
		<cpu:CopyOperandToRegister/>
		<op:AX-SIAddressPlusImmediate8/>
		<byte>24</byte>

		<cpu:AndAXWithImmediate/>
		<int>1</int>

		<cpu:CompareAXToImmediate/>
		<int>1</int>
	</xsl:template>

	<xsl:template match="cls:GetMethodName">
		<cpu:CopyOperandToRegister/>
		<op:SI-SIAddress/>
	</xsl:template>

	<xsl:template match="cls:GetMethodType">
		<cpu:CopyOperandToRegister/>
		<op:SI-SIAddressPlusImmediate8/>
		<byte>4</byte>
	</xsl:template>

	<xsl:template match="cls:GetMethodEntryPoint">
		<cpu:CopyOperandToRegister/>
		<op:SI-SIAddressPlusImmediate8/>
		<byte>12</byte>
	</xsl:template>

	<xsl:template match="cls:GetMethodParameters">
		<cpu:CopyOperandToRegister/>
		<op:SI-SIAddressPlusImmediate8/>
		<byte>16</byte>
	</xsl:template>

	<xsl:template match="cls:GetParameterName">
		<cpu:CopyOperandToRegister/>
		<op:SI-SIAddress/>
	</xsl:template>

	<xsl:template match="cls:GetParameterType">
		<cpu:CopyOperandToRegister/>
		<op:SI-SIAddressPlusImmediate8/>
		<byte>4</byte>
	</xsl:template>

	<xsl:template match="cls:IsMethodStatic">
		<cpu:CopyOperandToRegister/>
		<op:AX-SIAddressPlusImmediate8/>
		<byte>8</byte>

		<cpu:AndAXWithImmediate/>
		<int>1</int>

		<cpu:CompareAXToImmediate/>
		<int>1</int>
	</xsl:template>

	<xsl:template match="cls:ExecuteMethod">
		<xsl:choose>
			<xsl:when test="@class">
				<scope>
					<cpu:PushDIToStack/>

					<sys:GetCatalog/>

					<cpu:CopyImmediateToDI/>
					<addressOf ref="className" type="Absolute32"/>

					<cat:FindClass/>

					<cpu:PushSIToStack/>

					<cpu:CopyImmediateToDI/>
					<addressOf ref="methodName" type="Absolute32"/>

					<xsl:call-template name="FindStaticMethod"/>

					<cpu:PullBXFromStack/>

					<cpu:PullDIFromStack/>

					<cpu:LogicFunction/>
					<logic:CallSIAddressPlusImmediate8/>
					<byte>12</byte>

					<cpu:JumpToRelative8/>
					<addressOf ref="end" type="Relative8"/>

					<var:string id="className">
						<xsl:value-of select="@class"/>
					</var:string>

					<var:string id="methodName">
						<xsl:value-of select="@method"/>
					</var:string>

					<label id="end"/>
				</scope>
			</xsl:when>
			<xsl:when test="@type">
				<scope>
					<cpu:PushDIToStack/>

					<sys:GetCatalog/>

					<cpu:CopyImmediateToDI/>
					<addressOf ref="className" type="Absolute32"/>

					<cat:FindType/>

					<cpu:PushSIToStack/>

					<cpu:CopyImmediateToDI/>
					<addressOf ref="methodName" type="Absolute32"/>

					<xsl:call-template name="FindStaticMethod"/>

					<cpu:PullBXFromStack/>

					<cpu:PullDIFromStack/>

					<cpu:LogicFunction/>
					<logic:CallSIAddressPlusImmediate8/>
					<byte>12</byte>

					<cpu:JumpToRelative8/>
					<addressOf ref="end" type="Relative8"/>

					<var:string id="className">
						<xsl:value-of select="@type"/>
					</var:string>

					<var:string id="methodName">
						<xsl:value-of select="@method"/>
					</var:string>

					<label id="end"/>
				</scope>
			</xsl:when>
			<xsl:when test="@method">
				<scope>
					<cpu:PushDIToStack/>

					<cpu:CopyRegisterToOperand/>
					<op:BX-SIRegister/>

					<cpu:CopyImmediateToDI/>
					<addressOf ref="methodName" type="Absolute32"/>

					<xsl:call-template name="FindMethod"/>

					<cpu:PullDIFromStack/>

					<cpu:LogicFunction/>
					<logic:CallSIAddressPlusImmediate8/>
					<byte>12</byte>

					<cpu:JumpToRelative8/>
					<addressOf ref="end" type="Relative8"/>

					<var:string id="methodName">
						<xsl:value-of select="@method"/>
					</var:string>
					<label id="end"/>
				</scope>
			</xsl:when>
			<xsl:otherwise>
				<cpu:LogicFunction/>
				<logic:CallSIAddressPlusImmediate8/>
				<byte>12</byte>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="cls:GetFieldName">
		<cpu:CopyOperandToRegister/>
		<op:SI-SIAddress/>
	</xsl:template>

	<xsl:template match="cls:GetFieldType">
		<cpu:CopyOperandToRegister/>
		<op:SI-SIAddressPlusImmediate8/>
		<byte>4</byte>
	</xsl:template>

	<xsl:template match="cls:GetFieldPosition">
		<cpu:CopyOperandToRegister/>
		<op:AX-SIAddressPlusImmediate8/>
		<byte>8</byte>
	</xsl:template>

	<xsl:template match="cls:GetFieldValue">
		<cpu:CopyOperandToRegister/>
		<op:AX-SIAddressPlusImmediate8/>
		<byte>8</byte>

		<cpu:ExchangeOperandWithRegister/>
		<op:SI-DIRegister/>

		<obj:GetData/>

		<cpu:AddRegisterToOperand/>
		<op:AX-SIRegister/>

		<cpu:ExchangeOperandWithRegister/>
		<op:SI-DIRegister/>

		<cpu:PushDIToStack/>

		<cls:GetFieldType/>

		<cpu:CopyRegisterToOperand/>
		<op:SI-DIRegister/>

		<sys:GetCatalog/>

		<cat:FindType/>

		<cpu:CopyRegisterToOperand/>
		<op:SI-BXRegister/>

		<cpu:PullDIFromStack/>

		<obj:Create/>
	</xsl:template>

	<xsl:template match="cls:CreateObject">
		<scope>
			<cpu:PushAXToStack/>
			<cpu:PushSIToStack/>
			<cpu:PushDIToStack/>

			<cpu:CopyImmediateToDI/>
			<addressOf ref="classType" type="Absolute32"/>

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

			<var:string id="classType">http://metalx.org/Class</var:string>

			<label id="end"/>
		</scope>
	</xsl:template>

</xsl:stylesheet>
