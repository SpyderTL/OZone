<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:mm="http://metalx.org/i286/Functions/MemoryManager"
	xmlns:sys="http://metalx.org/i286/Functions/System"
	xmlns:col="http://metalx.org/i286/Functions/Collection"
	xmlns:cpu="http://metalx.org/Intel/80286/Operators"
	xmlns:op="http://metalx.org/Intel/80286/Operands"
	xmlns:imm="http://metalx.org/Intel/80286/Immediate"
	xmlns:math="http://metalx.org/Intel/80286/Math">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="sys:GetMemoryManager">
		<cpu:PushImmediateToStack16/>
		<hex>2000</hex>

		<cpu:PullDSFromStack/>
		
		<cpu:CopyImmediateToSI/>
		<hex>0000</hex>
	</xsl:template>

	<xsl:template match="sys:GetCatalog">
		<cpu:PushImmediateToStack16/>
		<hex>1000</hex>

		<cpu:PullDSFromStack/>

		<cpu:CopyImmediateToSI/>
		<hex>0000</hex>
	</xsl:template>
</xsl:stylesheet>
