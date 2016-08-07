<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:kbd="http://metalx.org/i286/Functions/Keyboard"
	xmlns:key="http://metalx.org/Pc/Keyboard"
	xmlns:shift="http://metalx.org/Intel/80286/Shift"
	xmlns:cpu="http://metalx.org/Intel/80286/Operators"
	xmlns:op="http://metalx.org/Intel/80286/Operands"
	xmlns:ari="http://metalx.org/Intel/80286/Arithmetic"
	xmlns:bios="http://metalx.org/Pc/Bios/Functions"
	xmlns:disk="http://metalx.org/Pc/Bios/Disk"
	xmlns:con="http://metalx.org/i286/Functions/Console">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="kbd:WaitRead">
		<!--<scope>
			<label id="waitForRead"/>

			<cpu:ReadFromImmediate8PortToAL/>
			<key:StatusPort/>

			<cpu:AndALWithImmediate/>
			<binary>00000001</binary>

			<cpu:CompareALToImmediate/>
			<binary>00000001</binary>

			<cpu:BranchToRelativeIfNotEqual8/>
			<addressOf ref="waitForRead" type="Relative8"/>
		</scope>-->
	</xsl:template>

	<xsl:template match="kbd:WaitWrite">
		<!--<scope>
			<label id="waitForWrite"/>

			<cpu:ReadFromImmediate8PortToAL/>
			<key:StatusPort/>

			<cpu:AndALWithImmediate/>
			<binary>00000010</binary>

			<cpu:CompareALToImmediate/>
			<binary>00000010</binary>

			<cpu:BranchToRelativeIfEqual8/>
			<addressOf ref="waitForWrite" type="Relative8"/>
		</scope>-->
	</xsl:template>
</xsl:stylesheet>
