<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:addr="http://metalx.org/i286/Functions/Address"
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

	<xsl:template match="addr:CreateObject">
		<scope>
			<cpu:PushSIToStack/>

			<cpu:CopyRegisterToOperand16/>
			<op:DI-BXRegister/>

			<mm:CheckOut length="4"/>

			<cpu:PushDIToStack/>

			<cpu:CopyRegisterToOperand16/>
			<op:BX-DIAddress/>

			<cpu:IncrementDI/>
			<cpu:IncrementDI/>

			<cpu:PushESToStack/>
			<cpu:PullBXFromStack/>

			<cpu:CopyRegisterToOperand16/>
			<op:BX-DIAddress/>

			<sys:GetCatalog/>

			<cpu:PushImmediateToStack16/>
			<addressOf ref="className" type="Segment16"/>

			<cpu:PullESFromStack/>
			
			<cpu:CopyImmediateToDI/>
			<addressOf ref="className" type="Absolute16"/>

			<cat:FindType/>

			<cpu:CopyRegisterToOperand16/>
			<op:SI-BXRegister/>

			<cpu:PullDIFromStack/>
			<cpu:PullSIFromStack/>

			<cpu:CopyImmediateToAX/>
			<short>4</short>

			<obj:Create/>

			<cpu:JumpToRelative8/>
			<addressOf ref="end" type="Relative8"/>

			<label id="className"/>
			<short>24</short>
			<string>http://metalx.org/Address</string>

			<label id="end"/>
		</scope>
	</xsl:template>
	
	<xsl:template match="addr:CreatePointer">
		<scope>
			<cpu:PushDSToStack/>
			<cpu:PushSIToStack/>
			<cpu:PushESToStack/>
			<cpu:PushDIToStack/>

			<sys:GetCatalog/>

			<cpu:PushImmediateToStack16/>
			<addressOf ref="className" type="Segment16"/>

			<cpu:PullESFromStack/>
			
			<cpu:CopyImmediateToDI/>
			<addressOf ref="className" type="Absolute16"/>

			<cat:FindType/>

			<cpu:CopyRegisterToOperand16/>
			<op:SI-BXRegister/>

			<cpu:PullDIFromStack/>
			<cpu:PullESFromStack/>
			<cpu:PullSIFromStack/>
			<cpu:PullDSFromStack/>

			<cpu:CopyImmediateToAX/>
			<short>4</short>

			<obj:Create/>

			<cpu:JumpToRelative8/>
			<addressOf ref="end" type="Relative8"/>

			<label id="className"/>
			<short>24</short>
			<string>http://metalx.org/Address</string>

			<label id="end"/>
		</scope>
	</xsl:template>

</xsl:stylesheet>
