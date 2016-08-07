<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:var="http://metalx.org/Variable"
	xmlns:loop="http://metalx.org/i386/Functions/Loop"
	xmlns:obj="http://metalx.org/i386/Functions/Object"
	xmlns:cat="http://metalx.org/i386/Functions/Catalog"
	xmlns:mm="http://metalx.org/i386/Functions/MemoryManager"
	xmlns:sys="http://metalx.org/i386/Functions/System"
	xmlns:inc="http://metalx.org/Intel/80386/Increment"
	xmlns:imm="http://metalx.org/Intel/80386/Immediate"
	xmlns:math="http://metalx.org/Intel/80386/Math"
	xmlns:shift="http://metalx.org/Intel/80386/Shift"
	xmlns:cpu="http://metalx.org/Intel/80386/Operators"
	xmlns:op="http://metalx.org/Intel/80386/Operands">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="loop:For">
		<scope>
			<label id="http://metalx.org/i386/Functions/Loop/For/Start"/>

			<xsl:copy-of select="@* | node()"/>

			<xsl:choose>
				<xsl:when test="@type='Relative32'">
					<cpu:DecrementCX/>

					<cpu:BranchToRelative8IfZero/>
					<addressOf ref="http://metalx.org/i386/Functions/Loop/For/End" type="Relative8"/>

					<cpu:JumpToRelative/>
					<addressOf ref="http://metalx.org/i386/Functions/Loop/For/Start" type="Relative32"/>

					<label id="http://metalx.org/i386/Functions/Loop/For/End"/>
				</xsl:when>
				<xsl:otherwise>
					<cpu:LoopToRelative8/>
					<addressOf ref="http://metalx.org/i386/Functions/Loop/For/Start" type="Relative8"/>
				</xsl:otherwise>
			</xsl:choose>
		</scope>
	</xsl:template>

</xsl:stylesheet>
