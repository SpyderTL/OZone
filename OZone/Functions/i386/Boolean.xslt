<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:var="http://metalx.org/Variable"
	xmlns:bool="http://metalx.org/i386/Functions/Boolean"
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

	<xsl:template match="bool:CreateObject">
		<scope>
			<cpu:PushSIToStack/>

			<mm:CheckOut length="1"/>

			<cpu:PushDIToStack/>

			<cpu:CopyRegisterToOperand8/>
			<op:AL-DIAddress/>

			<sys:GetCatalog/>

			<cpu:CopyImmediateToDI/>
			<addressOf ref="booleanClassName" type="Absolute32"/>

			<cat:FindType/>

			<cpu:CopyRegisterToOperand/>
			<op:SI-BXRegister/>

			<cpu:PullDIFromStack/>
			<cpu:PullSIFromStack/>

			<cpu:CopyImmediateToAX/>
			<int>1</int>

			<obj:Create/>

			<cpu:JumpToRelative8/>
			<addressOf ref="end" type="Relative8"/>

			<var:string id="booleanClassName">http://metalx.org/Boolean</var:string>
			
			<label id="end"/>
		</scope>
	</xsl:template>

</xsl:stylesheet>
