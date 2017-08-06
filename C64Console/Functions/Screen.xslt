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
			<hex>06</hex>

			<!--Increment Column-->
			<cpu:IncrementImmediate8Address/>
			<hex>04</hex>

			<cpu:CopyImmediate8ToAccumulator/>
			<byte>40</byte>

			<cpu:CompareAccumulatorToImmediate8Address/>
			<hex>04</hex>

			<cpu:BranchToRelative8IfNotEqual/>
			<addressOf ref="skipNewLine" type="Relative8"/>

			<!--Increment Row-->
			<cpu:IncrementImmediate8Address/>
			<hex>05</hex>

			<cpu:CopyImmediate8ToAccumulator/>
			<byte>0</byte>

			<cpu:CopyAccumulatorToImmediate8Address/>
			<hex>04</hex>

			<label id="skipNewLine"/>
			
			<!--Move Cursor-->
			<cpu:IncrementImmediate8Address/>
			<hex>06</hex>

			<cpu:BranchToRelative8IfNotZero/>
			<addressOf ref="notCarry" type="Relative8"/>

			<cpu:IncrementImmediate8Address/>
			<hex>07</hex>

			<label id="notCarry"/>
		</scope>
	</xsl:template>

	<xsl:template match="scr:DeleteCharacter">
		<scope>
			<cpu:DecrementImmediate8Address/>
			<hex>04</hex>

			<cpu:DecrementImmediate8Address/>
			<hex>06</hex>

			<cpu:BranchToRelative8IfNotZero/>
			<addressOf ref="notCarry" type="Relative8"/>

			<cpu:DecrementImmediate8Address/>
			<hex>07</hex>

			<label id="notCarry"/>

			<cpu:CopyImmediate8ToAccumulator/>
			<string xml:space="preserve"> </string>

			<cpu:CopyImmediate8ToYIndex/>
			<byte>0</byte>

			<cpu:CopyAccumulatorToImmediate8PointerPlusYIndexAddress/>
			<hex>06</hex>
		</scope>
	</xsl:template>

	<xsl:template match="scr:NewLine">
		<scope>
			<cpu:CopyImmediate8ToAccumulator/>
			<byte>40</byte>

			<cpu:SetCarryFlag/>
			
			<cpu:SubtractImmediate8AddressFromAccumulator/>
			<hex>04</hex>

			<cpu:ClearCarryFlag/>
			
			<cpu:AddImmediate8AddressToAccumulator/>
			<hex>06</hex>

			<cpu:CopyAccumulatorToImmediate8Address/>
			<hex>06</hex>

			<cpu:CopyImmediate8ToAccumulator/>
			<byte>0</byte>

			<cpu:AddImmediate8AddressToAccumulator/>
			<hex>07</hex>

			<cpu:CopyAccumulatorToImmediate8Address/>
			<hex>07</hex>

			<cpu:IncrementImmediate8Address/>
			<hex>05</hex>

			<cpu:CopyImmediate8ToAccumulator/>
			<byte>0</byte>

			<cpu:CopyAccumulatorToImmediate8Address/>
			<hex>04</hex>
		</scope>
	</xsl:template>

	<xsl:template match="scr:Scroll">
		<scope>
			<cpu:DecrementImmediate8Address/>
			<hex>05</hex>

			<cpu:CopyImmediate8AddressToAccumulator/>
			<hex>06</hex>

			<cpu:SetCarryFlag/>
			
			<cpu:SubtractImmediate8FromAccumulator/>
			<byte>40</byte>

			<cpu:ClearCarryFlag/>

			<cpu:CopyAccumulatorToImmediate8Address/>
			<hex>06</hex>

			<cpu:CopyImmediate8ToAccumulator/>
			<byte>40</byte>

			<cpu:CopyAccumulatorToImmediate8Address/>
			<hex>80</hex>

			<cpu:CopyImmediate8ToAccumulator/>
			<hex>04</hex>

			<cpu:CopyAccumulatorToImmediate8Address/>
			<hex>81</hex>

			<cpu:CopyAccumulatorToImmediate8Address/>
			<hex>83</hex>

			<cpu:CopyImmediate8ToAccumulator/>
			<byte>0</byte>

			<cpu:CopyAccumulatorToImmediate8Address/>
			<hex>82</hex>
			
			<cpu:CopyImmediate8ToYIndex/>
			<byte>0</byte>

			<cpu:CopyImmediate8ToXIndex/>
			<byte>240</byte>

			<label id="forEachPixel"/>

			<cpu:CopyImmediate8PointerPlusYIndexAddressToAccumulator/>
			<hex>80</hex>

			<cpu:CopyAccumulatorToImmediate8PointerPlusYIndexAddress/>
			<hex>82</hex>

			<!--Increment Source-->
			<cpu:IncrementImmediate8Address/>
			<hex>80</hex>

			<cpu:BranchToRelative8IfNotZero/>
			<addressOf ref="notCarry" type="Relative8"/>

			<cpu:IncrementImmediate8Address/>
			<hex>81</hex>

			<label id="notCarry"/>

			<!--Increment Destination-->
			<cpu:IncrementImmediate8Address/>
			<hex>82</hex>

			<cpu:BranchToRelative8IfNotZero/>
			<addressOf ref="notCarry1" type="Relative8"/>

			<cpu:IncrementImmediate8Address/>
			<hex>83</hex>

			<label id="notCarry1"/>

			<cpu:DecrementXIndex/>

			<cpu:BranchToRelative8IfNotZero/>
			<addressOf ref="forEachPixel" type="Relative8"/>

			<cpu:CopyImmediate8ToXIndex/>
			<byte>240</byte>

			<label id="forEachPixel2"/>

			<cpu:CopyImmediate8PointerPlusYIndexAddressToAccumulator/>
			<hex>80</hex>

			<cpu:CopyAccumulatorToImmediate8PointerPlusYIndexAddress/>
			<hex>82</hex>

			<!--Increment Source-->
			<cpu:IncrementImmediate8Address/>
			<hex>80</hex>

			<cpu:BranchToRelative8IfNotZero/>
			<addressOf ref="notCarry2" type="Relative8"/>

			<cpu:IncrementImmediate8Address/>
			<hex>81</hex>

			<label id="notCarry2"/>

			<!--Increment Destination-->
			<cpu:IncrementImmediate8Address/>
			<hex>82</hex>

			<cpu:BranchToRelative8IfNotZero/>
			<addressOf ref="notCarry3" type="Relative8"/>

			<cpu:IncrementImmediate8Address/>
			<hex>83</hex>

			<label id="notCarry3"/>

			<cpu:DecrementXIndex/>

			<cpu:BranchToRelative8IfNotZero/>
			<addressOf ref="forEachPixel2" type="Relative8"/>

			<cpu:CopyImmediate8ToXIndex/>
			<byte>240</byte>

			<label id="forEachPixel3"/>

			<cpu:CopyImmediate8PointerPlusYIndexAddressToAccumulator/>
			<hex>80</hex>

			<cpu:CopyAccumulatorToImmediate8PointerPlusYIndexAddress/>
			<hex>82</hex>

			<!--Increment Source-->
			<cpu:IncrementImmediate8Address/>
			<hex>80</hex>

			<cpu:BranchToRelative8IfNotZero/>
			<addressOf ref="notCarry4" type="Relative8"/>

			<cpu:IncrementImmediate8Address/>
			<hex>81</hex>

			<label id="notCarry4"/>

			<!--Increment Destination-->
			<cpu:IncrementImmediate8Address/>
			<hex>82</hex>

			<cpu:BranchToRelative8IfNotZero/>
			<addressOf ref="notCarry5" type="Relative8"/>

			<cpu:IncrementImmediate8Address/>
			<hex>83</hex>

			<label id="notCarry5"/>

			<cpu:DecrementXIndex/>

			<cpu:BranchToRelative8IfNotZero/>
			<addressOf ref="forEachPixel3" type="Relative8"/>

			<cpu:CopyImmediate8ToXIndex/>
			<byte>240</byte>

			<label id="forEachPixel4"/>

			<cpu:CopyImmediate8PointerPlusYIndexAddressToAccumulator/>
			<hex>80</hex>

			<cpu:CopyAccumulatorToImmediate8PointerPlusYIndexAddress/>
			<hex>82</hex>

			<!--Increment Source-->
			<cpu:IncrementImmediate8Address/>
			<hex>80</hex>

			<cpu:BranchToRelative8IfNotZero/>
			<addressOf ref="notCarry6" type="Relative8"/>

			<cpu:IncrementImmediate8Address/>
			<hex>81</hex>

			<label id="notCarry6"/>

			<!--Increment Destination-->
			<cpu:IncrementImmediate8Address/>
			<hex>82</hex>

			<cpu:BranchToRelative8IfNotZero/>
			<addressOf ref="notCarry7" type="Relative8"/>

			<cpu:IncrementImmediate8Address/>
			<hex>83</hex>

			<label id="notCarry7"/>

			<cpu:DecrementXIndex/>

			<cpu:BranchToRelative8IfNotZero/>
			<addressOf ref="forEachPixel4" type="Relative8"/>

			<cpu:CopyImmediate8ToXIndex/>
			<byte>40</byte>

			<cpu:CopyImmediate8ToAccumulator/>
			<string xml:space="preserve"> </string>
			
			<label id="forEachPixel5"/>

			<cpu:CopyAccumulatorToImmediate8PointerPlusYIndexAddress/>
			<hex>82</hex>

			<cpu:IncrementImmediate8Address/>
			<hex>82</hex>

			<cpu:DecrementXIndex/>

			<cpu:BranchToRelative8IfNotZero/>
			<addressOf ref="forEachPixel5" type="Relative8"/>
		</scope>
	</xsl:template>

</xsl:stylesheet>
