<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:var="http://metalx.org/Variable"
	xmlns:fpuf="http://metalx.org/i386/Functions/Fpu"
	xmlns:cat="http://metalx.org/i386/Functions/Catalog"
	xmlns:obj="http://metalx.org/i386/Functions/Object"
	xmlns:str="http://metalx.org/i386/Functions/String"
	xmlns:lst="http://metalx.org/i386/Functions/List"
	xmlns:sys="http://metalx.org/i386/Functions/System"
	xmlns:mm="http://metalx.org/i386/Functions/MemoryManager"
	xmlns:asc="http://metalx.org/Ansi/Ascii"
	xmlns:ari="http://metalx.org/Intel/80386/Arithmetic"
	xmlns:imm="http://metalx.org/Intel/80386/Immediate"
	xmlns:inc="http://metalx.org/Intel/80386/Increment"
	xmlns:math="http://metalx.org/Intel/80386/Math"
	xmlns:cpu="http://metalx.org/Intel/80386/Operators"
	xmlns:op="http://metalx.org/Intel/80386/Operands"
	xmlns:fpu="http://metalx.org/Intel/80386/FpuOperators">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="fpuf:Truncate">
	</xsl:template>
</xsl:stylesheet>
