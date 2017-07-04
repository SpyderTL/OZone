<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:var="http://metalx.org/Variable"
	xmlns:vector="http://metalx.org/i386/Functions/Vector4"
	xmlns:float="http://metalx.org/i386/Functions/Float"
	xmlns:cat="http://metalx.org/i386/Functions/Catalog"
	xmlns:obj="http://metalx.org/i386/Functions/Object"
	xmlns:str="http://metalx.org/i386/Functions/String"
	xmlns:lst="http://metalx.org/i386/Functions/List"
	xmlns:sys="http://metalx.org/i386/Functions/System"
	xmlns:mm="http://metalx.org/i386/Functions/MemoryManager"
	xmlns:asc="http://metalx.org/Ansi/Ascii"
	xmlns:ari="http://metalx.org/Intel/80386/Arithmetic"
	xmlns:imm="http://metalx.org/Intel/80386/Immediate"
	xmlns:inc="http://metalx.org/Intel/80386/Increment"
	xmlns:math="http://metalx.org/Intel/80386/Math"
	xmlns:cpu="http://metalx.org/Intel/80386/Operators"
	xmlns:op="http://metalx.org/Intel/80386/Operands"
	xmlns:fpu="http://metalx.org/Intel/80386/FpuOperators">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="vector:CreateObject">
		<scope>
			<cpu:PushSIToStack/>

			<mm:CheckOut length="16"/>

			<cpu:PushDIToStack/>

			<fpu:PullFloatAtDIAddressFromST0/>

			<fpu:PullFloatAtDIAddressPlusImmediate8FromST0/>
			<byte>4</byte>

			<fpu:PullFloatAtDIAddressPlusImmediate8FromST0/>
			<byte>8</byte>

			<fpu:PullFloatAtDIAddressPlusImmediate8FromST0/>
			<byte>12</byte>

			<cpu:WaitForFloatingPointUnit/>

			<sys:GetCatalog/>

			<cpu:CopyImmediateToDI/>
			<addressOf ref="vector4ClassName" type="Absolute32"/>

			<cat:FindType/>

			<cpu:CopyRegisterToOperand/>
			<op:SI-BXRegister/>

			<cpu:PullDIFromStack/>
			<cpu:PullSIFromStack/>

			<cpu:CopyImmediateToAX/>
			<int>16</int>

			<obj:Create/>

			<cpu:JumpToRelative8/>
			<addressOf ref="end" type="Relative8"/>

			<var:string id="vector4ClassName">http://metalx.org/Video/Graphics/Vector4</var:string>

			<label id="end"/>
		</scope>
	</xsl:template>

	<xsl:template match="vector:Transform">
		<fpu:ResetFpu/>

		<fpu:PushFloatAtAXAddressToST0/>

		<fpu:PushFloatAtSIAddressToST0/>

		<fpu:MultiplyST1ByST0AndIncrementST/>

		<fpu:PushFloatAtAXAddressPlusImmediate8ToST0/>
		<byte>16</byte>

		<fpu:PushFloatAtSIAddressPlusImmediate8ToST0/>
		<byte>4</byte>

		<fpu:MultiplyST1ByST0AndIncrementST/>

		<fpu:AddST0ToST1AndIncrementST/>

		<fpu:PushFloatAtAXAddressPlusImmediate8ToST0/>
		<byte>32</byte>

		<fpu:PushFloatAtSIAddressPlusImmediate8ToST0/>
		<byte>8</byte>

		<fpu:MultiplyST1ByST0AndIncrementST/>

		<fpu:AddST0ToST1AndIncrementST/>

		<fpu:PushFloatAtAXAddressPlusImmediate8ToST0/>
		<byte>48</byte>

		<fpu:AddST0ToST1AndIncrementST/>



		<fpu:PushFloatAtAXAddressPlusImmediate8ToST0/>
		<byte>4</byte>

		<fpu:PushFloatAtSIAddressToST0/>

		<fpu:MultiplyST1ByST0AndIncrementST/>

		<fpu:PushFloatAtAXAddressPlusImmediate8ToST0/>
		<byte>20</byte>

		<fpu:PushFloatAtSIAddressPlusImmediate8ToST0/>
		<byte>4</byte>

		<fpu:MultiplyST1ByST0AndIncrementST/>

		<fpu:AddST0ToST1AndIncrementST/>

		<fpu:PushFloatAtAXAddressPlusImmediate8ToST0/>
		<byte>36</byte>

		<fpu:PushFloatAtSIAddressPlusImmediate8ToST0/>
		<byte>8</byte>

		<fpu:MultiplyST1ByST0AndIncrementST/>

		<fpu:AddST0ToST1AndIncrementST/>

		<fpu:PushFloatAtAXAddressPlusImmediate8ToST0/>
		<byte>52</byte>

		<fpu:AddST0ToST1AndIncrementST/>



		<fpu:PushFloatAtAXAddressPlusImmediate8ToST0/>
		<byte>8</byte>

		<fpu:PushFloatAtSIAddressToST0/>

		<fpu:MultiplyST1ByST0AndIncrementST/>

		<fpu:PushFloatAtAXAddressPlusImmediate8ToST0/>
		<byte>24</byte>

		<fpu:PushFloatAtSIAddressPlusImmediate8ToST0/>
		<byte>4</byte>

		<fpu:MultiplyST1ByST0AndIncrementST/>

		<fpu:AddST0ToST1AndIncrementST/>

		<fpu:PushFloatAtAXAddressPlusImmediate8ToST0/>
		<byte>40</byte>

		<fpu:PushFloatAtSIAddressPlusImmediate8ToST0/>
		<byte>8</byte>

		<fpu:MultiplyST1ByST0AndIncrementST/>

		<fpu:AddST0ToST1AndIncrementST/>

		<fpu:PushFloatAtAXAddressPlusImmediate8ToST0/>
		<byte>56</byte>

		<fpu:AddST0ToST1AndIncrementST/>



		<fpu:PullFloatAtDIAddressPlusImmediate8FromST0/>
		<byte>8</byte>

		<fpu:PullFloatAtDIAddressPlusImmediate8FromST0/>
		<byte>4</byte>

		<fpu:PullFloatAtDIAddressFromST0/>

		<cpu:WaitForFloatingPointUnit/>
	</xsl:template>
	
	<xsl:template match="vector:ToString">
		<scope>
			<fpu:ResetFpu/>

			<fpu:PushFloatAtSIAddressPlusImmediate8ToST0/>
			<byte>8</byte>

			<fpu:PushFloatAtSIAddressPlusImmediate8ToST0/>
			<byte>4</byte>

			<fpu:PushFloatAtSIAddressToST0/>

			<str:Create length="60"/>

			<cpu:PushDIToStack/>

			<float:ToString/>

			<cpu:CopyRegisterToOperand/>
			<op:DI-SIRegister/>

			<cpu:PullDIFromStack/>
			<cpu:PushDIToStack/>

			<str:AppendString/>

			<cpu:PullSIFromStack/>
			<cpu:PushSIToStack/>

			<str:AppendCharacter value=","/>

			<float:ToString/>

			<cpu:CopyRegisterToOperand/>
			<op:DI-SIRegister/>

			<cpu:PullDIFromStack/>
			<cpu:PushDIToStack/>

			<str:AppendString/>

			<cpu:PullSIFromStack/>
			<cpu:PushSIToStack/>

			<str:AppendCharacter value=","/>

			<float:ToString/>

			<cpu:CopyRegisterToOperand/>
			<op:DI-SIRegister/>

			<cpu:PullDIFromStack/>
			<cpu:PushDIToStack/>

			<str:AppendString/>

			<cpu:PullDIFromStack/>
		</scope>
	</xsl:template>
</xsl:stylesheet>
