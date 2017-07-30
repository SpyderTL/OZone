<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:scr="http://metalx.org/C64Console/Functions/Screen"
	xmlns:cpu="http://metalx.org/Mos/6502/Operators">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="scr:DrawCharacter">
		<scope>
			<!--Draw Character-->
			<cpu:CopyImmediate8ToYIndex/>
			<byte>0</byte>

			<cpu:CopyAccumulatorToImmediate8PointerPlusYIndexAddress/>
			<hex>04</hex>

			<!--Increment Column-->
			<cpu:IncrementImmediate8Address/>
			<hex>02</hex>

			<cpu:CopyImmediate8ToAccumulator/>
			<byte>40</byte>

			<cpu:CompareAccumulatorToImmediate8Address/>
			<hex>02</hex>

			<cpu:BranchToRelative8IfNotEqual/>
			<addressOf ref="skipNewLine" type="Relative8"/>

			<cpu:IncrementImmediate8Address/>
			<hex>03</hex>

			<cpu:CopyImmediate8ToAccumulator/>
			<byte>0</byte>

			<cpu:CopyAccumulatorToImmediate8Address/>
			<hex>02</hex>

			<label id="skipNewLine"/>
			
			<!--Move Cursor-->
			<cpu:IncrementImmediate8Address/>
			<hex>04</hex>

			<cpu:BranchToRelative8IfNotZero/>
			<addressOf ref="notCarry" type="Relative8"/>

			<cpu:IncrementImmediate8Address/>
			<hex>05</hex>

			<label id="notCarry"/>
		</scope>
	</xsl:template>

	<xsl:template match="scr:DeleteCharacter">
		<scope>
			<cpu:DecrementImmediate8Address/>
			<hex>02</hex>

			<cpu:DecrementImmediate8Address/>
			<hex>04</hex>

			<cpu:BranchToRelative8IfNotZero/>
			<addressOf ref="notCarry" type="Relative8"/>

			<cpu:DecrementImmediate8Address/>
			<hex>05</hex>

			<label id="notCarry"/>

			<cpu:CopyImmediate8ToAccumulator/>
			<string xml:space="preserve"> </string>

			<cpu:CopyImmediate8ToYIndex/>
			<byte>0</byte>

			<cpu:CopyAccumulatorToImmediate8PointerPlusYIndexAddress/>
			<hex>04</hex>
		</scope>
	</xsl:template>

	<xsl:template match="scr:NewLine">
		<scope>
			<cpu:CopyImmediate8ToAccumulator/>
			<byte>39</byte>

			<cpu:SubtractImmediate8AddressFromAccumulator/>
			<hex>02</hex>

			<cpu:AddImmediate8AddressToAccumulator/>
			<hex>04</hex>

			<cpu:CopyAccumulatorToImmediate8Address/>
			<hex>04</hex>

			<cpu:BranchToRelative8IfNotCarry/>
			<addressOf ref="notCarry" type="Relative8"/>
			
			<cpu:IncrementImmediate8Address/>
			<hex>05</hex>
			
			<label id="notCarry"/>
			
			<cpu:IncrementImmediate8Address/>
			<hex>03</hex>

			<cpu:CopyImmediate8ToAccumulator/>
			<byte>0</byte>

			<cpu:CopyAccumulatorToImmediate8Address/>
			<hex>02</hex>			
		</scope>
	</xsl:template>

</xsl:stylesheet>
