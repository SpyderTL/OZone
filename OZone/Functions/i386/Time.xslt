<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:var="http://metalx.org/Variable"
	xmlns:time="http://metalx.org/i386/Functions/Time"
	xmlns:inc="http://metalx.org/Intel/80386/Increment"
	xmlns:imm="http://metalx.org/Intel/80386/Immediate"
	xmlns:math="http://metalx.org/Intel/80386/Math"
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

	<xsl:template match="time:CreateObject">
		<scope>
			<cpu:PushSIToStack/>

			<mm:CheckOut length="12"/>

			<cpu:CopyImmediateToAX/>
			<int>0</int>

			<cpu:CopyRegisterToOperand8/>
			<op:CH-ALRegister/>
			
			<cpu:CopyRegisterToOperand/>
			<op:AX-DIAddress/>

			<cpu:CopyRegisterToOperand8/>
			<op:CL-ALRegister/>

			<cpu:CopyRegisterToOperand/>
			<op:AX-DIAddressPlusImmediate8/>
			<byte>4</byte>

			<cpu:CopyRegisterToOperand8/>
			<op:DH-ALRegister/>
			
			<cpu:CopyRegisterToOperand/>
			<op:AX-DIAddressPlusImmediate8/>
			<byte>8</byte>

			<sys:GetCatalog/>

			<cpu:PushDIToStack/>
			
			<cpu:CopyImmediateToDI/>
			<addressOf ref="timeClassName" type="Absolute32"/>

			<cat:FindType/>

			<cpu:CopyRegisterToOperand/>
			<op:SI-BXRegister/>

			<cpu:PullDIFromStack/>
			<cpu:PullSIFromStack/>

			<cpu:CopyImmediateToAX/>
			<int>3</int>

			<obj:Create/>

			<cpu:JumpToRelative8/>
			<addressOf ref="end" type="Relative8"/>

			<var:string id="timeClassName">http://metalx.org/Time</var:string>

			<label id="end"/>
		</scope>
	</xsl:template>

</xsl:stylesheet>
