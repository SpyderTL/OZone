<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sys="http://metalx.org/C64Console/Functions/System"
	xmlns:cpu="http://metalx.org/Mos/6502/Operators">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="sys:MemoryManager">
		<hex>2000</hex>
	</xsl:template>

	<xsl:template match="sys:CheckOut">
		<!--Check Out Memory-->
		<cpu:CopyImmediate16AddressToAccumulator/>
		<addressOf ref="freeRamPointer" type="Absolute16"/>

		<cpu:CopyAccumulatorToImmediate8Address/>
		<hex>02</hex>

		<cpu:CopyImmediate16AddressToAccumulator/>
		<addressOf ref="freeRamPointer" type="Absolute16" offset="1"/>

		<cpu:CopyAccumulatorToImmediate8Address/>
		<hex>03</hex>

		<cpu:CopyImmediate8ToAccumulator/>
		<byte>
			<xsl:value-of select="@length"/>
		</byte>

		<cpu:ClearCarryFlag/>

		<cpu:AddImmediate16AddressToAccumulator/>
		<addressOf ref="freeRamPointer" type="Absolute16"/>

		<cpu:CopyAccumulatorToImmediate16Address/>
		<addressOf ref="freeRamPointer" type="Absolute16"/>

		<cpu:CopyImmediate8ToAccumulator/>
		<byte>0</byte>

		<cpu:AddImmediate16AddressToAccumulator/>
		<addressOf ref="freeRamPointer" type="Absolute16" offset="1"/>

		<cpu:CopyAccumulatorToImmediate16Address/>
		<addressOf ref="freeRamPointer" type="Absolute16" offset="1"/>
	</xsl:template>

</xsl:stylesheet>
