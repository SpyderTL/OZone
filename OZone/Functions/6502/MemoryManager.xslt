<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:cpu="http://metalx.org/Mos/6502/Operators"
	xmlns:mm="http://metalx.org/6502/Functions/MemoryManager">
	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="mm:CheckOut">
		<!--Get Address-->
		<cpu:DecrementXIndex/>

		<cpu:CopyImmediate16AddressToAccumulator/>
		<hex>4001</hex>

		<cpu:CopyAccumulatorToImmediate8PlusXIndexAddress/>
		<hex>00</hex>

		<cpu:DecrementXIndex/>

		<cpu:CopyImmediate16AddressToAccumulator/>
		<hex>4000</hex>

		<cpu:CopyAccumulatorToImmediate8PlusXIndexAddress/>
		<hex>00</hex>

		<xsl:choose>
			<xsl:when test="@length">
				<cpu:ClearCarryFlag/>

				<cpu:CopyImmediate8ToAccumulator/>
				<byte>
					<xsl:value-of select="@length"/>
				</byte>

				<cpu:AddImmediate16AddressToAccumulator/>
				<hex>4000</hex>

				<cpu:CopyAccumulatorToImmediate16Address/>
				<hex>4000</hex>

				<cpu:CopyImmediate8AddressToAccumulator/>
				<byte>0</byte>

				<cpu:AddImmediate16AddressToAccumulator/>
				<hex>4001</hex>

				<cpu:CopyAccumulatorToImmediate16Address/>
				<hex>4001</hex>
			</xsl:when>
			<xsl:otherwise>
				<cpu:PullAccumulatorFromStack/>

				<cpu:CopyAccumulatorToImmediate8Address/>
				<hex>02</hex>

				<cpu:PullAccumulatorFromStack/>
				
				<cpu:CopyAccumulatorToImmediate8Address/>
				<hex>03</hex>

				<cpu:ClearCarryFlag/>
				
				<cpu:CopyImmediate8AddressToAccumulator/>
				<hex>02</hex>

				<cpu:AddImmediate16AddressToAccumulator/>
				<hex>4000</hex>

				<cpu:CopyAccumulatorToImmediate16Address/>
				<hex>4000</hex>

				<cpu:CopyImmediate8AddressToAccumulator/>
				<hex>03</hex>

				<cpu:AddImmediate16AddressToAccumulator/>
				<hex>4001</hex>

				<cpu:CopyAccumulatorToImmediate16Address/>
				<hex>4001</hex>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="mm:Reset">
		<cpu:CopyImmediate8ToAccumulator/>
		<hex>02</hex>

		<cpu:CopyAccumulatorToImmediate16Address/>
		<hex>4000</hex>

		<cpu:CopyImmediate8ToAccumulator/>
		<hex>40</hex>

		<cpu:CopyAccumulatorToImmediate16Address/>
		<hex>4001</hex>
	</xsl:template>
</xsl:stylesheet>
