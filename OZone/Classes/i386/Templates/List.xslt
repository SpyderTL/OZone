<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:template="http://metalx.org/Templates/List"
	xmlns:cls="http://metalx.org/Class"
	xmlns:cpu="http://metalx.org/Intel/80386/Operators"
	xmlns:op="http://metalx.org/Intel/80386/Operands"
	xmlns:index="http://metalx.org/Intel/80386/Index"
	xmlns:lst="http://metalx.org/i386/Functions/List"
	xmlns:obj="http://metalx.org/i386/Functions/Object"
	xmlns:sys="http://metalx.org/i386/Functions/System"
	xmlns:cat="http://metalx.org/i386/Functions/Catalog"
	xmlns:mm="http://metalx.org/i386/Functions/MemoryManager"
	xmlns:var="http://metalx.org/Variable"
	xmlns:str="http://metalx.org/i386/Functions/String"
	xmlns:clsf="http://metalx.org/i386/Functions/Class"
	xmlns:asc="http://metalx.org/Ansi/Ascii"
	xmlns:logic="http://metalx.org/Intel/80386/Logic">
	
    <xsl:output method="xml" indent="yes"/>

	<xsl:template match="template:List">
		<cls:class name="{@name}" base="http://metalx.org/List" type="{@type}">
			
			<cls:field name="Count" offset="0" type="http://metalx.org/Integer"/>

			<cls:method name="Skip" type="{@iteratorType}">
				<cls:parameter name="Count" type="http://metalx.org/Integer"/>

				<cpu:PushDIToStack/>

				<cpu:ExchangeOperandWithRegister/>
				<op:BP-SPRegister/>

				<cpu:PullSIFromStack/>

				<cpu:ExchangeOperandWithRegister/>
				<op:BP-SPRegister/>

				<obj:GetData/>

				<cpu:CopySIAddressToAXAndIncrementSI/>

				<cpu:PushAXToStack/>

				<sys:GetCatalog/>

				<cpu:CopyImmediateToDI/>
				<addressOf ref="className" type="Absolute32"/>

				<cat:FindType/>

				<cpu:CopyRegisterToOperand/>
				<op:SI-BXRegister/>

				<mm:CheckOut length="8"/>

				<cpu:PullAXFromStack/>

				<cpu:CopyRegisterToOperand/>
				<op:AX-DIAddressPlusImmediate8/>
				<byte>4</byte>

				<cpu:PullAXFromStack/>

				<cpu:CopyRegisterToOperand/>
				<op:AX-DIAddress/>

				<cpu:CopyImmediateToAX/>
				<int>8</int>

				<obj:Create/>

				<cpu:ReturnToNearCaller/>

				<var:string id="className"><xsl:value-of select="@iteratorType"/></var:string>
			</cls:method>

			<cls:method name="First" type="{@itemType}">
				<cpu:CopyRegisterToOperand/>
				<op:DI-SIRegister/>

				<obj:GetData/>

				<cpu:CopyOperandToRegister/>
				<op:DI-SIAddressPlusImmediate8/>
				<byte>4</byte>

				<cpu:ReturnToNearCaller/>
			</cls:method>

			<cls:method name="Last" type="{@itemType}">
				<cpu:CopyRegisterToOperand/>
				<op:DI-SIRegister/>

				<obj:GetData/>

				<cpu:CopyOperandToRegister/>
				<op:AX-SIAddress/>

				<cpu:CopyOperandToRegister/>
				<op:DI-IndexAddress/>
				<index:AXTimesFourPlusSI/>
				
				<cpu:ReturnToNearCaller/>
			</cls:method>

			<cls:method name="ToString" type="http://metalx.org/String">
				<cpu:PushDIToStack/>

				<str:Create length="2048"/>

				<cpu:CopyRegisterToOperand/>
				<op:DI-BXRegister/>

				<cpu:PullSIFromStack/>

				<obj:GetData/>

				<lst:ForEach>
					<cpu:PushCXToStack/>
					<cpu:PushDXToStack/>
					<cpu:PushSIToStack/>
					<cpu:PushCXToStack/>
					<cpu:PushSIToStack/>

					<obj:GetType/>

					<cpu:CallRelative/>
					<addressOf ref="findMethod" type="Relative32"/>

					<clsf:GetMethodEntryPoint/>

					<cpu:PullDIFromStack/>

					<cpu:PushBXToStack/>

					<cpu:LogicFunction/>
					<logic:CallSIRegister/>

					<cpu:PullBXFromStack/>

					<cpu:CopyRegisterToOperand/>
					<op:DI-SIRegister/>

					<obj:GetData/>

					<cpu:CopyRegisterToOperand/>
					<op:BX-DIRegister/>

					<str:AppendString/>

					<cpu:PullAXFromStack/>

					<cpu:CompareAXToImmediate/>
					<int>1</int>

					<cpu:BranchToRelative8IfEqual/>
					<addressOf ref="skip" type="Relative8"/>

					<cpu:CopyImmediateToAL/>
					<asc:CarriageReturn/>

					<cpu:CopyRegisterToOperand/>
					<op:BX-SIRegister/>

					<cpu:PushBXToStack/>
					<str:AppendCharacter/>
					<cpu:PullBXFromStack/>

					<cpu:CopyImmediateToAL/>
					<asc:LineFeed/>

					<cpu:CopyRegisterToOperand/>
					<op:BX-SIRegister/>

					<cpu:PushBXToStack/>
					<str:AppendCharacter/>
					<cpu:PullBXFromStack/>

					<label id="skip"/>

					<cpu:PullSIFromStack/>
					<cpu:PullDXFromStack/>
					<cpu:PullCXFromStack/>
				</lst:ForEach>

				<cpu:CopyRegisterToOperand/>
				<op:BX-DIRegister/>

				<str:CreateObject/>

				<cpu:ReturnToNearCaller/>

				<label id="findMethod"/>

				<cpu:CopyImmediateToDI/>
				<addressOf ref="methodName" type="Absolute32"/>

				<clsf:FindMethod/>

				<cpu:ReturnToNearCaller/>

				<label id="methodName"/>
				<int>8</int>
				<string>ToString</string>
			</cls:method>

			<cls:method name="GetClass" type="http://metalx.org/Class">
				<cpu:CopyRegisterToOperand/>
				<op:DI-SIRegister/>

				<obj:GetType/>

				<cpu:CopyRegisterToOperand/>
				<op:SI-DIRegister/>

				<clsf:CreateObject/>

				<cpu:ReturnToNearCaller/>
			</cls:method>

			<cls:method name="GetClass" type="http://metalx.org/Class" static="true">
				<cpu:CopyRegisterToOperand/>
				<op:BX-DIRegister/>

				<clsf:CreateObject/>

				<cpu:ReturnToNearCaller/>
			</cls:method>
		</cls:class>
	</xsl:template>

	<xsl:template match="template:ListIterator">
		<cls:class name="{@name}" base="http://metalx.org/ListIterator" type="{@type}">

			<cls:field name="List" offset="0" type="http://metalx.org/Reference"/>
			<cls:field name="Index" offset="4" type="http://metalx.org/Integer"/>

			<cls:method name="First" type="{@itemType}">
				<cpu:CopyRegisterToOperand/>
				<op:DI-SIRegister/>

				<obj:GetData/>

				<cpu:CopyOperandToRegister/>
				<op:AX-SIAddressPlusImmediate8/>
				<byte>4</byte>

				<cpu:CopyOperandToRegister/>
				<op:SI-SIAddress/>

				<obj:GetData/>

				<lst:GetItem/>

				<cpu:CopyRegisterToOperand/>
				<op:SI-DIRegister/>

				<cpu:ReturnToNearCaller/>
			</cls:method>

			<cls:method name="Skip" type="{@type}">
				<cls:parameter name="Count" type="http://metalx.org/Integer"/>

				<cpu:ExchangeOperandWithRegister/>
				<op:BP-SPRegister/>

				<cpu:PullSIFromStack/>

				<cpu:ExchangeOperandWithRegister/>
				<op:BP-SPRegister/>

				<obj:GetData/>

				<cpu:CopySIAddressToAXAndIncrementSI/>

				<cpu:CopyRegisterToOperand/>
				<op:DI-SIRegister/>

				<obj:GetData/>

				<cpu:AddRegisterToOperand/>
				<op:AX-SIAddressPlusImmediate8/>
				<byte>4</byte>

				<cpu:ReturnToNearCaller/>
			</cls:method>

			<cls:method name="ToString" type="http://metalx.org/String">
				<cpu:CopyRegisterToOperand/>
				<op:DI-SIRegister/>

				<obj:GetData/>

				<cpu:CopyOperandToRegister/>
				<op:AX-SIAddressPlusImmediate8/>
				<byte>4</byte>

				<cpu:CopyOperandToRegister/>
				<op:SI-SIAddress/>

				<obj:GetData/>

				<lst:GetItem/>

				<cpu:PushSIToStack/>

				<obj:GetType/>

				<cpu:CopyImmediateToDI/>
				<addressOf ref="methodName" type="Absolute32"/>

				<clsf:FindMethod/>

				<clsf:GetMethodEntryPoint/>

				<cpu:PullDIFromStack/>

				<cpu:LogicFunction/>
				<logic:CallSIRegister/>

				<cpu:ReturnToNearCaller/>

				<label id="methodName"/>
				<int>8</int>
				<string>ToString</string>
			</cls:method>

			<cls:method name="GetClass" type="http://metalx.org/Class">
				<cpu:CopyRegisterToOperand/>
				<op:DI-SIRegister/>

				<obj:GetType/>

				<cpu:CopyRegisterToOperand/>
				<op:SI-DIRegister/>

				<clsf:CreateObject/>

				<cpu:ReturnToNearCaller/>
			</cls:method>

			<cls:method name="GetClass" type="http://metalx.org/Class" static="true">
				<cpu:CopyRegisterToOperand/>
				<op:BX-DIRegister/>

				<clsf:CreateObject/>

				<cpu:ReturnToNearCaller/>
			</cls:method>
		</cls:class>
	</xsl:template>
</xsl:stylesheet>
