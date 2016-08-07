<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:var="http://metalx.org/Variable"
	xmlns:clk="http://metalx.org/i386/Functions/Clock"
	xmlns:inc="http://metalx.org/Intel/80386/Increment"
	xmlns:imm="http://metalx.org/Intel/80386/Immediate"
	xmlns:math="http://metalx.org/Intel/80386/Math"
	xmlns:obj="http://metalx.org/i386/Functions/Object"
	xmlns:lst="http://metalx.org/i386/Functions/List"
	xmlns:cat="http://metalx.org/i386/Functions/Catalog"
	xmlns:sys="http://metalx.org/i386/Functions/System"
	xmlns:mm="http://metalx.org/i386/Functions/MemoryManager"
	xmlns:cpu="http://metalx.org/Intel/80386/Operators"
	xmlns:op="http://metalx.org/Intel/80386/Operands"
	xmlns:cmos="http://metalx.org/Pc/Cmos/Ports"
	xmlns:cmr="http://metalx.org/Pc/Cmos/Registers">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="clk:GetHours">
		<cpu:CopyImmediateToAL/>
		<cmr:Hours/>

		<cpu:WriteALToImmediate8Port/>
		<cmos:Register/>

		<cpu:ReadFromImmediate8PortToAL/>
		<cmos:Value/>
	</xsl:template>

	<xsl:template match="clk:GetMinutes">
		<cpu:CopyImmediateToAL/>
		<cmr:Minutes/>

		<cpu:WriteALToImmediate8Port/>
		<cmos:Register/>

		<cpu:ReadFromImmediate8PortToAL/>
		<cmos:Value/>
	</xsl:template>

	<xsl:template match="clk:GetSeconds">
		<cpu:CopyImmediateToAL/>
		<cmr:Seconds/>

		<cpu:WriteALToImmediate8Port/>
		<cmos:Register/>

		<cpu:ReadFromImmediate8PortToAL/>
		<cmos:Value/>
	</xsl:template>

	<xsl:template match="clk:GetDayOfMonth">
		<cpu:CopyImmediateToAL/>
		<cmr:DayOfMonth/>

		<cpu:WriteALToImmediate8Port/>
		<cmos:Register/>

		<cpu:ReadFromImmediate8PortToAL/>
		<cmos:Value/>
	</xsl:template>

	<xsl:template match="clk:GetMonth">
		<cpu:CopyImmediateToAL/>
		<cmr:Month/>

		<cpu:WriteALToImmediate8Port/>
		<cmos:Register/>

		<cpu:ReadFromImmediate8PortToAL/>
		<cmos:Value/>
	</xsl:template>

	<xsl:template match="clk:GetYear">
		<cpu:CopyImmediateToAL/>
		<cmr:Year/>

		<cpu:WriteALToImmediate8Port/>
		<cmos:Register/>

		<cpu:ReadFromImmediate8PortToAL/>
		<cmos:Value/>
	</xsl:template>

	<xsl:template match="clk:GetCentury">
		<cpu:CopyImmediateToAL/>
		<cmr:Century/>

		<cpu:WriteALToImmediate8Port/>
		<cmos:Register/>

		<cpu:ReadFromImmediate8PortToAL/>
		<cmos:Value/>
	</xsl:template>

</xsl:stylesheet>
