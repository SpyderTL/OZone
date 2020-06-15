<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:cpu="http://metalx.org/Wdc/65C02/Operators"
	xmlns:int="http://metalx.org/65C02/Functions/Integer">
	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="int:Copy">
		<xsl:choose>
			<xsl:when test="@value">
				<cpu:CopyImmediate8ToAccumulator/>
				<byte>
					<xsl:value-of select="@value"/>
				</byte>

				<cpu:CopyAccumulatorToImmediate16Address/>
				<addressOf ref="{@destination}" type="Absolute16"/>

				<cpu:CopyImmediate8ToAccumulator/>
				<hex>00</hex>

				<cpu:CopyAccumulatorToImmediate16Address/>
				<addressOf ref="{@destination}" type="Absolute16" offset="1"/>

				<cpu:CopyAccumulatorToImmediate16Address/>
				<addressOf ref="{@destination}" type="Absolute16" offset="2"/>

				<cpu:CopyAccumulatorToImmediate16Address/>
				<addressOf ref="{@destination}" type="Absolute16" offset="3"/>
			</xsl:when>
			<xsl:otherwise>
				<cpu:CopyImmediate16AddressToAccumulator/>
				<addressOf ref="{@source}" type="Absolute16"/>

				<cpu:CopyAccumulatorToImmediate16Address/>
				<addressOf ref="{@destination}" type="Absolute16"/>

				<cpu:CopyImmediate16AddressToAccumulator/>
				<addressOf ref="{@source}" type="Absolute16" offset="1"/>

				<cpu:CopyAccumulatorToImmediate16Address/>
				<addressOf ref="{@destination}" type="Absolute16" offset="1"/>

				<cpu:CopyImmediate16AddressToAccumulator/>
				<addressOf ref="{@source}" type="Absolute16" offset="2"/>

				<cpu:CopyAccumulatorToImmediate16Address/>
				<addressOf ref="{@destination}" type="Absolute16" offset="2"/>

				<cpu:CopyImmediate16AddressToAccumulator/>
				<addressOf ref="{@source}" type="Absolute16" offset="3"/>

				<cpu:CopyAccumulatorToImmediate16Address/>
				<addressOf ref="{@destination}" type="Absolute16" offset="3"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="int:Add">
		<xsl:choose>
			<xsl:when test="@value">
				<cpu:ClearCarryFlag/>

				<cpu:CopyImmediate16AddressToAccumulator/>
				<addressOf ref="{@ref}" type="Absolute16"/>

				<cpu:AddImmediate8ToAccumulator/>
				<byte>
					<xsl:value-of select="@value"/>
				</byte>

				<cpu:CopyAccumulatorToImmediate16Address/>
				<addressOf ref="{@destination}" type="Absolute16"/>

				<cpu:CopyImmediate16AddressToAccumulator/>
				<addressOf ref="{@ref}" type="Absolute16" offset="1"/>

				<cpu:AddImmediate8ToAccumulator/>
				<byte>0</byte>

				<cpu:CopyAccumulatorToImmediate16Address/>
				<addressOf ref="{@destination}" type="Absolute16" offset="1"/>

				<cpu:CopyImmediate16AddressToAccumulator/>
				<addressOf ref="{@ref}" type="Absolute16" offset="2"/>

				<cpu:AddImmediate8ToAccumulator/>
				<byte>0</byte>

				<cpu:CopyAccumulatorToImmediate16Address/>
				<addressOf ref="{@destination}" type="Absolute16" offset="2"/>

				<cpu:CopyImmediate16AddressToAccumulator/>
				<addressOf ref="{@ref}" type="Absolute16" offset="3"/>

				<cpu:AddImmediate8ToAccumulator/>
				<byte>0</byte>

				<cpu:CopyAccumulatorToImmediate16Address/>
				<addressOf ref="{@destination}" type="Absolute16" offset="3"/>
			</xsl:when>
			<xsl:otherwise>
				<cpu:ClearCarryFlag/>

				<cpu:CopyImmediate16AddressToAccumulator/>
				<addressOf ref="{@ref}" type="Absolute16"/>

				<cpu:AddImmediate16AddressToAccumulator/>
				<addressOf ref="{@ref2}" type="Absolute16"/>

				<cpu:CopyAccumulatorToImmediate16Address/>
				<addressOf ref="{@destination}" type="Absolute16"/>

				<cpu:CopyImmediate16AddressToAccumulator/>
				<addressOf ref="{@ref}" type="Absolute16" offset="1"/>

				<cpu:AddImmediate16AddressToAccumulator/>
				<addressOf ref="{@ref2}" type="Absolute16" offset="1"/>

				<cpu:CopyAccumulatorToImmediate16Address/>
				<addressOf ref="{@destination}" type="Absolute16" offset="1"/>

				<cpu:CopyImmediate16AddressToAccumulator/>
				<addressOf ref="{@ref}" type="Absolute16" offset="2"/>

				<cpu:AddImmediate16AddressToAccumulator/>
				<addressOf ref="{@ref2}" type="Absolute16" offset="2"/>

				<cpu:CopyAccumulatorToImmediate16Address/>
				<addressOf ref="{@destination}" type="Absolute16" offset="2"/>

				<cpu:CopyImmediate16AddressToAccumulator/>
				<addressOf ref="{@ref}" type="Absolute16" offset="3"/>

				<cpu:AddImmediate16AddressToAccumulator/>
				<addressOf ref="{@ref2}" type="Absolute16" offset="3"/>

				<cpu:CopyAccumulatorToImmediate16Address/>
				<addressOf ref="{@destination}" type="Absolute16" offset="3"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="int:Subtract">
		<xsl:choose>
			<xsl:when test="@value">
				<cpu:SetCarryFlag/>

				<cpu:CopyImmediate16AddressToAccumulator/>
				<addressOf ref="{@ref}" type="Absolute16"/>

				<cpu:SubtractImmediate8FromAccumulator/>
				<byte>
					<xsl:value-of select="@value"/>
				</byte>

				<cpu:CopyAccumulatorToImmediate16Address/>
				<addressOf ref="{@destination}" type="Absolute16"/>

				<cpu:CopyImmediate16AddressToAccumulator/>
				<addressOf ref="{@ref}" type="Absolute16" offset="1"/>

				<cpu:SubtractImmediate8FromAccumulator/>
				<byte>0</byte>

				<cpu:CopyAccumulatorToImmediate16Address/>
				<addressOf ref="{@destination}" type="Absolute16" offset="1"/>

				<cpu:CopyImmediate16AddressToAccumulator/>
				<addressOf ref="{@ref}" type="Absolute16" offset="2"/>

				<cpu:SubtractImmediate8FromAccumulator/>
				<byte>0</byte>

				<cpu:CopyAccumulatorToImmediate16Address/>
				<addressOf ref="{@destination}" type="Absolute16" offset="2"/>

				<cpu:CopyImmediate16AddressToAccumulator/>
				<addressOf ref="{@ref}" type="Absolute16" offset="3"/>

				<cpu:SubtractImmediate8FromAccumulator/>
				<byte>0</byte>

				<cpu:CopyAccumulatorToImmediate16Address/>
				<addressOf ref="{@destination}" type="Absolute16" offset="3"/>
			</xsl:when>
			<xsl:otherwise>
				<cpu:SetCarryFlag/>

				<cpu:CopyImmediate16AddressToAccumulator/>
				<addressOf ref="{@ref}" type="Absolute16"/>

				<cpu:SubtractImmediate16AddressFromAccumulator/>
				<addressOf ref="{@ref2}" type="Absolute16"/>

				<cpu:CopyAccumulatorToImmediate16Address/>
				<addressOf ref="{@destination}" type="Absolute16"/>

				<cpu:CopyImmediate16AddressToAccumulator/>
				<addressOf ref="{@ref}" type="Absolute16" offset="1"/>

				<cpu:SubtractImmediate16AddressFromAccumulator/>
				<addressOf ref="{@ref2}" type="Absolute16" offset="1"/>

				<cpu:CopyAccumulatorToImmediate16Address/>
				<addressOf ref="{@destination}" type="Absolute16" offset="1"/>

				<cpu:CopyImmediate16AddressToAccumulator/>
				<addressOf ref="{@ref}" type="Absolute16" offset="2"/>

				<cpu:SubtractImmediate16AddressFromAccumulator/>
				<addressOf ref="{@ref2}" type="Absolute16" offset="2"/>

				<cpu:CopyAccumulatorToImmediate16Address/>
				<addressOf ref="{@destination}" type="Absolute16" offset="2"/>

				<cpu:CopyImmediate16AddressToAccumulator/>
				<addressOf ref="{@ref}" type="Absolute16" offset="3"/>

				<cpu:SubtractImmediate16AddressFromAccumulator/>
				<addressOf ref="{@ref2}" type="Absolute16" offset="3"/>

				<cpu:CopyAccumulatorToImmediate16Address/>
				<addressOf ref="{@destination}" type="Absolute16" offset="3"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="int:Compare">
		<scope>
			<cpu:CopyImmediate16AddressToAccumulator/>
			<addressOf ref="{@ref}" type="Absolute16" offset="3"/>

			<cpu:CompareAccumulatorToImmediate16Address/>
			<addressOf ref="{@ref2}" type="Absolute16" offset="3"/>

			<cpu:BranchToRelative8IfNotEqual/>
			<addressOf ref="notEqual" type="Relative8"/>

			<cpu:CopyImmediate16AddressToAccumulator/>
			<addressOf ref="{@ref}" type="Absolute16" offset="2"/>

			<cpu:CompareAccumulatorToImmediate16Address/>
			<addressOf ref="{@ref2}" type="Absolute16" offset="2"/>

			<cpu:BranchToRelative8IfNotEqual/>
			<addressOf ref="notEqual" type="Relative8"/>

			<cpu:CopyImmediate16AddressToAccumulator/>
			<addressOf ref="{@ref}" type="Absolute16" offset="1"/>

			<cpu:CompareAccumulatorToImmediate16Address/>
			<addressOf ref="{@ref2}" type="Absolute16" offset="1"/>

			<cpu:BranchToRelative8IfNotEqual/>
			<addressOf ref="notEqual" type="Relative8"/>

			<cpu:CopyImmediate16AddressToAccumulator/>
			<addressOf ref="{@ref}" type="Absolute16"/>

			<cpu:CompareAccumulatorToImmediate16Address/>
			<addressOf ref="{@ref2}" type="Absolute16"/>

			<label id="notEqual"/>
		</scope>
	</xsl:template>
	
	<xsl:template match="int:ShiftLeft">
		<cpu:ShiftImmediate16AddressLeft/>
		<addressOf ref="{@ref}" type="Absolute16"/>

		<cpu:RollImmediate16AddressLeft/>
		<addressOf ref="{@ref}" type="Absolute16" offset="1"/>

		<cpu:RollImmediate16AddressLeft/>
		<addressOf ref="{@ref}" type="Absolute16" offset="2"/>

		<cpu:RollImmediate16AddressLeft/>
		<addressOf ref="{@ref}" type="Absolute16" offset="3"/>
	</xsl:template>

	<xsl:template match="int:ShiftRight">
		<cpu:ShiftImmediate16AddressRight/>
		<addressOf ref="{@ref}" type="Absolute16" offset="3"/>

		<cpu:RollImmediate16AddressRight/>
		<addressOf ref="{@ref}" type="Absolute16" offset="2"/>

		<cpu:RollImmediate16AddressRight/>
		<addressOf ref="{@ref}" type="Absolute16" offset="1"/>

		<cpu:RollImmediate16AddressRight/>
		<addressOf ref="{@ref}" type="Absolute16"/>
	</xsl:template>
</xsl:stylesheet>
