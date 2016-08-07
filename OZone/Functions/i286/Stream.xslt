<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:str="http://metalx.org/i286/Functions/Stream"
	xmlns:string="http://metalx.org/i286/Functions/String"
	xmlns:inc="http://metalx.org/Intel/80286/Increment"
	xmlns:imm="http://metalx.org/Intel/80286/Immediate"
	xmlns:math="http://metalx.org/Intel/80286/Math"
	xmlns:cat="http://metalx.org/i286/Functions/Catalog"
	xmlns:obj="http://metalx.org/i286/Functions/Object"
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
						<xsl:value-of select="@length"/>
					</xsl:attribute>
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>
				<cpu:IncrementAX/>
				<mm:CheckOut/>
			</xsl:otherwise>
		</xsl:choose>

		<!--Clear stream-->
		<cpu:CopyImmediateToOperandFunction8/>
		<imm:CopyImmediateToDIAddress/>
		<byte>0</byte>
	</xsl:template>

	<xsl:template match="str:CreateObject">
		<scope>
			<cpu:PushESToStack/>
			<cpu:PushDIToStack/>

			<cpu:CopyImmediateToAX/>
			<short>0</short>

			<!--Get Stream Length-->
			<label id="getStreamLength"/>

			<cpu:MathImmediateToOperandFunction8/>
			<math:CompareWithDIAddress/>
			<byte>0</byte>

			<cpu:BranchToRelativeIfEqual8/>
			<addressOf ref="createObject" type="Relative8"/>

			<cpu:IncrementAX/>
			<cpu:IncrementDI/>

			<cpu:JumpToRelative8/>
			<addressOf ref="getStreamLength" type="Relative8"/>

			<label id="createObject"/>

			<cpu:PushAXToStack/>
			<cpu:PushDSToStack/>
			<cpu:PushSIToStack/>

			<sys:GetCatalog/>

			<cpu:PushImmediateToStack16/>
			<addressOf ref="streamClassName" type="Segment16"/>

			<cpu:PullESFromStack/>
			
			<cpu:CopyImmediateToDI/>
			<addressOf ref="streamClassName" type="Absolute16"/>

			<cat:FindType/>

			<cpu:CopyRegisterToOperand16/>
			<op:SI-BXRegister/>

			<cpu:PullSIFromStack/>
			<cpu:PullDSFromStack/>
			<cpu:PullAXFromStack/>
			<cpu:PullDIFromStack/>
			<cpu:PullESFromStack/>

			<obj:Create/>

			<cpu:JumpToRelative8/>
			<addressOf ref="end" type="Relative8"/>

			<label id="streamClassName"/>
			<short>23</short>
			<string>http://metalx.org/Stream</string>

			<label id="end"/>
		</scope>
	</xsl:template>

	<xsl:template match="str:Clear">
		<!--Reset end of stream-->
		<cpu:CopyImmediateToOperandFunction8/>
		<imm:CopyImmediateToSIAddress/>
		<byte>0</byte>
	</xsl:template>

	<xsl:template match="str:GetLength">
		<scope>
			<cpu:CopyImmediateToAX/>
			<short>0</short>

			<!--Get Stream Length-->
			<label id="getStreamLength"/>

			<cpu:MathImmediateToOperandFunction8/>
			<math:CompareWithSIAddress/>
			<byte>0</byte>

			<cpu:BranchToRelativeIfEqual8/>
			<addressOf ref="end" type="Relative8"/>

			<cpu:IncrementAX/>
			<cpu:IncrementSI/>

			<cpu:JumpToRelative8/>
			<addressOf ref="getStreamLength" type="Relative8"/>

			<label id="end"/>
		</scope>
	</xsl:template>

	<xsl:template match="str:AppendByte">
		<xsl:if test="string-length(@value)=0">
			<!--Store Byte Value-->
			<cpu:PushAXToStack/>
		</xsl:if>

		<!--Find Terminator-->
		<cpu:RepeatWhileNotEqual/>
		<cpu:CopySIAddressToALAndIncrementSI/>

		<cpu:CopyImmediateToOperandFunction8/>
		<imm:CopyImmediateToSIAddress/>
		<byte>0</byte>

		<cpu:DecrementSI/>

		<xsl:choose>
			<xsl:when test="@value">
				<cpu:CopyImmediateToOperandFunction8/>
				<imm:CopyImmediateToSIAddress/>
				<string>
					<xsl:value-of select="@value"/>
				</string>
			</xsl:when>
			<xsl:otherwise>
				<cpu:PullAXFromStack/>

				<!--Copy character from AL to address of SI-->
				<cpu:CopyRegisterToOperand8/>
				<op:AL-SIAddress/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="str:TrimLastCharacter">
		<!--Find Terminator-->
		<cpu:RepeatWhileNotEqual/>
		<cpu:CopySIAddressToALAndIncrementSI/>

		<cpu:DecrementSI/>
		<cpu:DecrementSI/>

		<cpu:CopyImmediateToOperandFunction8/>
		<imm:CopyImmediateToSIAddress/>
		<byte>0</byte>
	</xsl:template>

	<xsl:template match="str:Compare">
		<cpu:CopyImmediateToAL/>
		<byte>0</byte>

		<label id="compareBytes"/>

		<cpu:CompareSIAddressToDIAddressAndIncrementSIAndDI8/>

		<cpu:BranchToRelativeIfNotEqual8/>
		<addressOf ref="endCompareStream" type="Relative8"/>

		<cpu:CompareOperandToRegister8/>
		<op:AL-SIAddress/>

		<cpu:BranchToRelativeIfEqual8/>
		<addressOf ref="endCompareStream" type="Relative8"/>

		<cpu:JumpToRelative8/>
		<addressOf ref="compareBytes" type="Relative8"/>

		<label id="endCompareStream"/>
	</xsl:template>

	<xsl:template match="str:BeginsWith">
		<scope>
			<cpu:CopyImmediateToAL/>
			<byte>0</byte>

			<label id="compareBytes"/>

			<cpu:CompareOperandToRegister8/>
			<op:AL-DIAddress/>

			<cpu:BranchToRelativeIfEqual8/>
			<addressOf ref="end" type="Relative8"/>

			<cpu:CompareSIAddressToDIAddressAndIncrementSIAndDI8/>

			<cpu:BranchToRelativeIfNotEqual8/>
			<addressOf ref="end" type="Relative8"/>

			<cpu:JumpToRelative8/>
			<addressOf ref="compareBytes" type="Relative8"/>

			<label id="end"/>
		</scope>
	</xsl:template>

	<xsl:template match="str:ForEach">
		<scope>
			<cpu:MathImmediateToOperandFunction8/>
			<math:CompareWithSIAddress/>
			<byte>0</byte>

			<cpu:BranchToRelativeIfNotEqual8/>
			<addressOf ref="start" type="Relative8"/>

			<cpu:JumpToRelative16/>
			<addressOf ref="end" type="Relative16"/>

			<label id="start"/>

			<xsl:apply-templates select="@* | node()"/>

			<cpu:IncrementSI/>

			<cpu:MathImmediateToOperandFunction8/>
			<math:CompareWithSIAddress/>
			<byte>0</byte>

			<cpu:BranchToRelativeIfEqual8/>
			<addressOf ref="end" type="Relative8"/>

			<cpu:JumpToRelative16/>
			<addressOf ref="start" type="Relative16"/>

			<label id="end"/>
		</scope>
	</xsl:template>
</xsl:stylesheet>
