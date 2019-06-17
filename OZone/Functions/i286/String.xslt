<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:str="http://metalx.org/i286/Functions/String"
	xmlns:inc="http://metalx.org/Intel/80286/Increment"
	xmlns:imm="http://metalx.org/Intel/80286/Immediate"
	xmlns:math="http://metalx.org/Intel/80286/Math"
	xmlns:obj="http://metalx.org/i286/Functions/Object"
	xmlns:cat="http://metalx.org/i286/Functions/Catalog"
	xmlns:lst="http://metalx.org/i286/Functions/List"
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

	<xsl:template match="str:Create">
		<xsl:choose>
			<xsl:when test="@length">
				<xsl:element name="mm:CheckOut">
					<xsl:attribute name="length">
						<xsl:value-of select="@length+2"/>
					</xsl:attribute>
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>
				<cpu:IncrementAX/>
				<cpu:IncrementAX/>
				<mm:CheckOut/>
			</xsl:otherwise>
		</xsl:choose>

		<!--Clear buffer length-->
		<cpu:CopyImmediateToOperandFunction16/>
		<imm:CopyImmediateToDIAddress/>
		<short>0</short>
	</xsl:template>

	<xsl:template match="str:CreateObject">
		<scope>
			<!--Get String Length-->
			<cpu:CopyOperandToRegister16/>
			<op:AX-DIAddress/>

			<cpu:IncrementAX/>
			<cpu:IncrementAX/>

			<cpu:PushAXToStack/>
			<cpu:PushDSToStack/>
			<cpu:PushSIToStack/>
			<!--<cpu:PushESToStack/>-->
			<cpu:PushDIToStack/>

			<!--<cpu:PushImmediateToStack16/>
			<addressOf ref="stringClassName" type="Segment16"/>

			<cpu:PullESFromStack/>-->

			<cpu:CopyImmediateToDI/>
			<addressOf ref="stringClassName" type="Absolute16"/>

			<sys:GetCatalog/>

			<cat:FindType/>

			<cpu:CopyRegisterToOperand16/>
			<op:SI-BXRegister/>

			<cpu:PullDIFromStack/>
			<!--<cpu:PullESFromStack/>-->
			<cpu:PullSIFromStack/>
			<cpu:PullDSFromStack/>
			<cpu:PullAXFromStack/>

			<obj:Create/>

			<cpu:JumpToRelative8/>
			<addressOf ref="end" type="Relative8"/>

			<label id="stringClassName"/>
			<short>23</short>
			<string>http://metalx.org/String</string>

			<label id="end"/>
		</scope>
	</xsl:template>

	<xsl:template match="str:Clear">
		<!--Reset buffer length-->
		<cpu:CopyImmediateToOperandFunction16/>
		<imm:CopyImmediateToSIAddress/>
		<short>0</short>
	</xsl:template>

	<xsl:template match="str:GetLength">
		<!--Set AL to the value at SI-->
		<cpu:CopyOperandToRegister16/>
		<op:AX-SIAddress/>
	</xsl:template>

	<xsl:template match="str:AppendByte">
		<!--Increase string length-->
		<cpu:IncrementFunction16/>
		<inc:IncrementSIAddress/>

		<!--Jump to next character-->
		<cpu:CopyOperandToRegister16/>
		<op:BX-SIAddress/>

		<cpu:AddRegisterToOperand16/>
		<op:BX-SIRegister/>

		<cpu:IncrementSI/>

		<xsl:choose>
			<xsl:when test="@value">
				<cpu:CopyImmediateToOperandFunction8/>
				<imm:CopyImmediateToSIAddress/>
				<string>
					<xsl:value-of select="@value"/>
				</string>
			</xsl:when>
			<xsl:otherwise>
				<!--Copy character from AL to address of SI-->
				<cpu:CopyRegisterToOperand8/>
				<op:AL-SIAddress/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="str:AppendString">
		<cpu:CopyOperandToRegister16/>
		<op:CX-SIAddress/>

		<cpu:IncrementSI/>
		<cpu:IncrementSI/>

		<cpu:CopyRegisterToOperand16/>
		<op:DI-BXRegister/>

		<cpu:PushCXToStack/>

		<cpu:SegmentES/>
		<cpu:CopyOperandToRegister16/>
		<op:CX-DIAddress/>

		<cpu:AddOperandToRegister16/>
		<op:DI-CXRegister/>

		<cpu:IncrementDI/>
		<cpu:IncrementDI/>

		<cpu:PullCXFromStack/>

		<cpu:SegmentES/>
		<cpu:AddRegisterToOperand16/>
		<op:CX-BXAddress/>

		<cpu:Repeat/>
		<cpu:CopySIAddressToDIAddressAndIncrementSIAndDI8/>
	</xsl:template>

	<xsl:template match="str:TrimLastCharacter">
		<!--Decrease buffer length-->
		<cpu:IncrementFunction16/>
		<inc:DecrementSIAddress/>
	</xsl:template>

	<xsl:template match="str:Compare">
		<cpu:CopyOperandToRegister16/>
		<op:CX-SIAddress/>

		<cpu:IncrementCX/>
		<cpu:IncrementCX/>

		<cpu:RepeatWhileEqual/>
		<cpu:CompareSIAddressToDIAddressAndIncrementSIAndDI8/>
	</xsl:template>

	<xsl:template match="str:BeginsWith">
		<scope>
			<cpu:CopyOperandToRegister16/>
			<op:CX-DIAddress/>

			<cpu:CompareSIAddressToDIAddressAndIncrementSIAndDI16/>

			<cpu:BranchToRelativeIfLess8/>
			<addressOf ref="end" type="Relative8"/>

			<cpu:RepeatWhileEqual/>
			<cpu:CompareSIAddressToDIAddressAndIncrementSIAndDI8/>

			<label id="end"/>
		</scope>
	</xsl:template>

	<xsl:template match="str:ForEach">
		<scope>
			<cpu:CopyOperandToRegister16/>
			<op:CX-SIAddress/>

			<cpu:MathImmediateToOperandFunction16/>
			<math:CompareWithCXRegister/>
			<short>0</short>

			<cpu:BranchToRelativeIfNotEqual8/>
			<addressOf ref="start" type="Relative8"/>

			<cpu:JumpToRelative16/>
			<addressOf ref="end" type="Relative16"/>

			<label id="start"/>

			<cpu:IncrementSI/>

			<label id="next"/>
			
			<cpu:IncrementSI/>

			<cpu:CopyOperandToRegister8/>
			<op:AL-SIAddress/>

			<xsl:apply-templates select="@* | node()"/>

			<cpu:LoopToRelative8/>
			<addressOf ref="next" type="Relative8"/>

			<label id="end"/>
		</scope>
	</xsl:template>

</xsl:stylesheet>
