<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:cpu="http://metalx.org/Mos/6502/Operators"
	xmlns:mem="http://metalx.org/6502/Functions/Memory">
	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="mem:Set">
		<xsl:if test="string-length(@address) = 2">
			<xsl:if test="string-length(@value) = 2">
				<cpu:CopyImmediate8ToAccumulator/>
				<hex>
					<xsl:value-of select="@value"/>
				</hex>

				<cpu:CopyAccumulatorToImmediate8Address/>
				<hex>
					<xsl:value-of select="@address"/>
				</hex>
			</xsl:if>
			<xsl:if test="string-length(@value) = 4">
				<scope>
					<label id="address" offset="{@address}"/>

					<cpu:CopyImmediate8ToAccumulator/>
					<hex>
						<xsl:value-of select="substring(@value, 3, 2)"/>
					</hex>

					<cpu:CopyAccumulatorToImmediate8Address/>
					<addressOf ref="address" type="Absolute16Low8"/>

					<cpu:CopyImmediate8ToAccumulator/>
					<hex>
						<xsl:value-of select="substring(@value, 1, 2)"/>
					</hex>

					<cpu:CopyAccumulatorToImmediate8Address/>
					<addressOf ref="address" type="Absolute16Low8" offset="1"/>
				</scope>
			</xsl:if>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
