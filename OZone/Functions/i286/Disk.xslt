<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:dsk="http://metalx.org/i286/Functions/Disk"
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

	<xsl:template match="dsk:ReadSectors">
		<cpu:CopyImmediateToAH/>
		<disk:ReadSectorsFromDrive/>

		<xsl:if test="@count">
			<cpu:CopyImmediateToAL/>
			<byte>
				<xsl:value-of select="@count"/>
			</byte>
		</xsl:if>

		<xsl:if test="@track">
			<cpu:CopyImmediateToCH/>
			<byte>
				<xsl:value-of select="@track"/>
			</byte>
		</xsl:if>

		<xsl:if test="@sector">
			<cpu:CopyImmediateToCL/>
			<byte>
				<xsl:value-of select="@sector+1"/>
			</byte>
		</xsl:if>

		<xsl:if test="@head">
			<cpu:CopyImmediateToDH/>
			<byte>
				<xsl:value-of select="@head"/>
			</byte>
		</xsl:if>

		<xsl:if test="@drive">
			<cpu:CopyImmediateToDL/>
			<hex>
				<xsl:value-of select="@drive"/>
			</hex>
		</xsl:if>
		
		<cpu:CallImmediate8Interrupt/>
		<bios:DiskFunctions/>
	</xsl:template>

	<xsl:template match="dsk:ConvertBlockToTrackHeadSector">
		<cpu:CopyImmediateToDX/>
		<short>0</short>

		<cpu:CopyImmediateToCX/>
		<short>18</short>

		<cpu:ArithmeticDXAXOperandFunction/>
		<ari:DivideByCXRegister/>

		<cpu:IncrementDX/>

		<cpu:PushDXToStack/>

		<cpu:CopyImmediateToDX/>
		<short>0</short>

		<cpu:CopyImmediateToCX/>
		<short>2</short>

		<cpu:ArithmeticDXAXOperandFunction/>
		<ari:DivideByCXRegister/>

		<cpu:CopyRegisterToOperand8/>
		<op:DL-DHRegister/>

		<cpu:PullCXFromStack/>

		<cpu:CopyRegisterToOperand8/>
		<op:AL-CHRegister/>
	</xsl:template>
</xsl:stylesheet>
