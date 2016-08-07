<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:var="http://metalx.org/Variable"
	xmlns:vector="http://metalx.org/i386/Functions/Vector3"
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

			<mm:CheckOut length="12"/>

			<cpu:PushDIToStack/>

			<fpu:PullFloatAtDIAddressFromST0/>

			<fpu:PullFloatAtDIAddressPlusImmediate8FromST0/>
			<byte>4</byte>

			<fpu:PullFloatAtDIAddressPlusImmediate8FromST0/>
			<byte>8</byte>

			<cpu:WaitForFloatingPointUnit/>

			<sys:GetCatalog/>

			<cpu:CopyImmediateToDI/>
			<addressOf ref="vector3ClassName" type="Absolute32"/>

			<cat:FindType/>

			<cpu:CopyRegisterToOperand/>
			<op:SI-BXRegister/>

			<cpu:PullDIFromStack/>
			<cpu:PullSIFromStack/>

			<cpu:CopyImmediateToAX/>
			<int>12</int>

			<obj:Create/>

			<cpu:JumpToRelative8/>
			<addressOf ref="end" type="Relative8"/>

			<var:string id="vector3ClassName">http://metalx.org/Video/Graphics/Vector3</var:string>

			<label id="end"/>
		</scope>
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
