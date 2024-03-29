﻿<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:ver="http://metalx.org/i286/Functions/Version"
	xmlns:inc="http://metalx.org/Intel/80286/Increment"
	xmlns:imm="http://metalx.org/Intel/80286/Immediate"
	xmlns:math="http://metalx.org/Intel/80286/Math"
	xmlns:obj="http://metalx.org/i286/Functions/Object"
	xmlns:lst="http://metalx.org/i286/Functions/List"
	xmlns:cat="http://metalx.org/i286/Functions/Catalog"
	xmlns:sys="http://metalx.org/i286/Functions/System"
	xmlns:mm="http://metalx.org/i286/Functions/MemoryManager"
	xmlns:cpu="http://metalx.org/Intel/80286/Operators"
	xmlns:op="http://metalx.org/Intel/80286/Operands">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="ver:CreateObject">
		<scope>
			<!--<cpu:PushDSToStack/>-->
			<cpu:PushSIToStack/>

			<mm:CheckOut length="3"/>

			<!--<cpu:PushESToStack/>-->
			<cpu:PushDIToStack/>

			<cpu:CopyRegisterToOperand8/>
			<op:BH-DIAddress/>

			<cpu:IncrementDI/>

			<cpu:CopyRegisterToOperand8/>
			<op:BL-DIAddress/>

			<cpu:IncrementDI/>

			<cpu:CopyRegisterToOperand8/>
			<op:DH-DIAddress/>

			<sys:GetCatalog/>

			<!--<cpu:PushImmediateToStack16/>
			<addressOf ref="className" type="Segment16"/>

			<cpu:PullESFromStack/>-->
			
			<cpu:CopyImmediateToDI/>
			<addressOf ref="className" type="Absolute16"/>

			<cat:FindType/>

			<cpu:CopyRegisterToOperand16/>
			<op:SI-BXRegister/>

			<cpu:PullDIFromStack/>
			<!--<cpu:PullESFromStack/>-->
			<cpu:PullSIFromStack/>
			<!--<cpu:PullDSFromStack/>-->

			<cpu:CopyImmediateToAX/>
			<short>3</short>

			<obj:Create/>

			<cpu:JumpToRelative8/>
			<addressOf ref="end" type="Relative8"/>

			<label id="className"/>
			<short>25</short>
			<string>http://metalx.org/Version</string>

			<label id="end"/>
		</scope>
	</xsl:template>

</xsl:stylesheet>
