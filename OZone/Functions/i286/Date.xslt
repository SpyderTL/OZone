<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:date="http://metalx.org/i286/Functions/Date"
	xmlns:inc="http://metalx.org/Intel/80286/Increment"
	xmlns:imm="http://metalx.org/Intel/80286/Immediate"
	xmlns:math="http://metalx.org/Intel/80286/Math"
	xmlns:obj="http://metalx.org/i286/Functions/Object"
	xmlns:lst="http://metalx.org/i286/Functions/List"
	xmlns:con="http://metalx.org/i286/Functions/Console"
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

	<xsl:template match="date:CreateObject">
		<scope>
			<cpu:PushSIToStack/>
			<!--<cpu:PushDSToStack/>-->

			<mm:CheckOut length="4"/>

			<cpu:PushDIToStack/>
			<!--<cpu:PushESToStack/>-->

			<cpu:CopyRegisterToOperand16/>
			<op:CX-DIAddress/>

			<!--<cpu:IncrementDI/>
			<cpu:IncrementDI/>-->

			<cpu:CopyRegisterToOperand8/>
			<op:DH-DIAddressPlusImmediate8/>
			<byte>2</byte>

			<!--<cpu:IncrementDI/>-->

			<cpu:CopyRegisterToOperand8/>
			<op:DL-DIAddressPlusImmediate8/>
			<byte>3</byte>

			<sys:GetCatalog/>

			<!--<cpu:PushImmediateToStack16/>
			<addressOf ref="dateClassName" type="Segment16" />

			<cpu:PullESFromStack/>-->

			<cpu:CopyImmediateToDI/>
			<addressOf ref="dateClassName" type="Absolute16"/>

			<cat:FindType/>

			<cpu:CopyRegisterToOperand16/>
			<op:SI-BXRegister/>

			<!--<cpu:PullESFromStack/>-->
			<cpu:PullDIFromStack/>
			<!--<cpu:PullDSFromStack/>-->
			<cpu:PullSIFromStack/>

			<cpu:CopyImmediateToAX/>
			<short>4</short>

			<obj:Create/>

			<cpu:JumpToRelative8/>
			<addressOf ref="end" type="Relative8"/>

			<label id="dateClassName"/>
			<short>22</short>
			<string>http://metalx.org/Date</string>

			<label id="end"/>
		</scope>
	</xsl:template>

</xsl:stylesheet>
