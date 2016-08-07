<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:mm="http://metalx.org/i386/Functions/MemoryManager"
	xmlns:cpu="http://metalx.org/Intel/80386/Operators"
	xmlns:op="http://metalx.org/Intel/80386/Operands"
	xmlns:imm="http://metalx.org/Intel/80386/Immediate"
	xmlns:math="http://metalx.org/Intel/80386/Math">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template name="FindTable">
		<scope>
			<cpu:CopyImmediateToCX/>
			<hex>00010000</hex>

			<cpu:CopyImmediateToSI/>
			<int>0</int>

			<label id="next"/>

			<cpu:MathImmediateToOperandFunction/>
			<math:CompareWithSIAddress/>
			<string>_MP_</string>

			<cpu:BranchToRelative8IfEqual/>
			<addressOf ref="found" type="Relative8"/>

			<label id="notFound"/>

			<cpu:MathImmediate8ToOperandFunction/>
			<math:AddToSIRegister/>
			<byte>16</byte>

			<cpu:LoopToRelative8/>
			<addressOf ref="next" type="Relative8"/>

			<cpu:CopyImmediateToSI/>
			<int>0</int>

			<cpu:ReturnToNearCaller/>

			<label id="found"/>

			<cpu:PushSIToStack/>
			<cpu:PushCXToStack/>

			<cpu:CopyImmediateToAL/>
			<byte>0</byte>

			<cpu:CopyImmediateToCX/>
			<int>16</int>

			<label id="checksum"/>

			<cpu:AddOperandToRegister8/>
			<op:AL-SIAddress/>

			<cpu:IncrementSI/>

			<cpu:LoopToRelative8/>
			<addressOf ref="checksum" type="Relative8"/>

			<cpu:PullCXFromStack/>
			<cpu:PullSIFromStack/>

			<cpu:CompareALToImmediate/>
			<byte>0</byte>

			<cpu:BranchToRelative8IfNotEqual/>
			<addressOf ref="notFound" type="Relative8"/>
		</scope>
	</xsl:template>
</xsl:stylesheet>
