<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:asc="http://metalx.org/Ansi/Ascii"
	xmlns:con="http://metalx.org/i286/Functions/Console"
	xmlns:cpu="http://metalx.org/Intel/80286/Operators"
	xmlns:op="http://metalx.org/Intel/80286/Operands"
	xmlns:vid="http://metalx.org/Pc/Bios/Video"
	xmlns:int="http://metalx.org/Pc/Bios/Functions"
	xmlns:ari="http://metalx.org/Intel/80286/Arithmetic"
	xmlns:math="http://metalx.org/Intel/80286/Math">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="con:WriteString">
		<scope>
			<cpu:CopyImmediateToAH/>
			<vid:TeletypeOutput/>

			<cpu:CopyOperandToRegister16/>
			<op:CX-SIAddress/>

			<cpu:MathImmediateToOperandFunction16/>
			<math:CompareWithCXRegister/>
			<short>0</short>

			<cpu:BranchToRelativeIfEqual8/>
			<addressOf ref="exitFunction" type="Relative8"/>

			<cpu:IncrementSI/>
			
			<label id="nextCharacter"/>

			<cpu:IncrementSI/>

			<cpu:CopyOperandToRegister8/>
			<op:AL-SIAddress/>

			<cpu:CallImmediate8Interrupt/>
			<int:VideoFunctions/>

			<cpu:LoopToRelative8/>
			<addressOf ref="nextCharacter" type="Relative8"/>

			<label id="exitFunction"/>
			
			<xsl:if test="@endLine='true'">
				<cpu:CopyImmediateToAL/>
				<hex>0D</hex>

				<cpu:CallImmediate8Interrupt/>
				<int:VideoFunctions/>

				<cpu:CopyImmediateToAL/>
				<hex>0A</hex>

				<cpu:CallImmediate8Interrupt/>
				<int:VideoFunctions/>
			</xsl:if>
		</scope>
	</xsl:template>

	<xsl:template match="con:WriteStream">
		<scope>
			<cpu:CopyImmediateToAH/>
			<vid:TeletypeOutput/>

			<label id="nextCharacter"/>

			<cpu:CopyOperandToRegister8/>
			<op:AL-SIAddress/>

			<cpu:CompareALToImmediate/>
			<byte>0</byte>

			<cpu:BranchToRelativeIfEqual8/>
			<addressOf ref="end" type="Relative8"/>

			<cpu:CallImmediate8Interrupt/>
			<int:VideoFunctions/>

			<cpu:IncrementSI/>

			<cpu:JumpToRelative8/>
			<addressOf ref="nextCharacter" type="Relative8"/>

			<label id="end"/>

			<xsl:if test="@endLine='true'">
				<cpu:CopyImmediateToAL/>
				<hex>0D</hex>

				<cpu:CallImmediate8Interrupt/>
				<int:VideoFunctions/>

				<cpu:CopyImmediateToAL/>
				<hex>0A</hex>

				<cpu:CallImmediate8Interrupt/>
				<int:VideoFunctions/>
			</xsl:if>
		</scope>
	</xsl:template>
	
	<xsl:template match="con:WriteCharacterArray">
		<scope>
			<cpu:CopyImmediateToAH/>
			<vid:TeletypeOutput/>

			<label id="nextCharacter"/>

			<cpu:CopyOperandToRegister8/>
			<op:AL-SIAddress/>

			<cpu:CallImmediate8Interrupt/>
			<int:VideoFunctions/>

			<cpu:IncrementSI/>

			<cpu:LoopToRelative8/>
			<addressOf ref="nextCharacter" type="Relative8"/>

			<xsl:if test="@endLine='true'">
				<cpu:CopyImmediateToAL/>
				<hex>0D</hex>

				<cpu:CallImmediate8Interrupt/>
				<int:VideoFunctions/>

				<cpu:CopyImmediateToAL/>
				<hex>0A</hex>

				<cpu:CallImmediate8Interrupt/>
				<int:VideoFunctions/>
			</xsl:if>
		</scope>
	</xsl:template>

	<xsl:template match="con:WriteText">
		<scope>
			<cpu:CopyImmediateToAH/>
			<vid:TeletypeOutput/>

			<cpu:CopyImmediateToBX/>
			<addressOf ref="value" type="Absolute16"/>

			<cpu:CopyImmediateToCX/>
			<short>
				<xsl:choose>
					<xsl:when test="@endLine='true'">
						<xsl:value-of select="string-length()+2"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="string-length()"/>
					</xsl:otherwise>
				</xsl:choose>
			</short>

			<label id="nextCharacter"/>

			<cpu:CopyOperandToRegister8/>
			<op:AL-BXAddress/>

			<cpu:CallImmediate8Interrupt/>
			<int:VideoFunctions/>

			<cpu:IncrementBX/>

			<cpu:LoopToRelative8/>
			<addressOf ref="nextCharacter" type="Relative8"/>

			<cpu:JumpToRelative8/>
			<addressOf ref="exit" type="Relative8"/>

			<label id="value"/>
			<string>
				<xsl:value-of select="text()"/>
			</string>
			<xsl:if test="@endLine='true'">
				<hex>0D0A</hex>
			</xsl:if>

			<label id="exit"/>
		</scope>
	</xsl:template>

	<xsl:template match="con:WriteCharacter">
		<cpu:CopyImmediateToAH/>
		<vid:TeletypeOutput/>

		<cpu:CallImmediate8Interrupt/>
		<int:VideoFunctions/>
	</xsl:template>

	<xsl:template match="con:WriteCharacters">
		<cpu:CopyImmediateToAH/>
		<vid:TeletypeOutput/>

		<xsl:call-template name="WriteNextCharacter">
			<xsl:with-param name="Value" select="text()" />
		</xsl:call-template>

		<xsl:if test="@endLine='true'">
			<cpu:CopyImmediateToAL/>
			<hex>0D</hex>

			<cpu:CallImmediate8Interrupt/>
			<int:VideoFunctions/>

			<cpu:CopyImmediateToAL/>
			<hex>0A</hex>

			<cpu:CallImmediate8Interrupt/>
			<int:VideoFunctions/>
		</xsl:if>
	</xsl:template>

	<xsl:template name="WriteNextCharacter">
		<xsl:param name="Value" select="."/>

		<xsl:if test="$Value">
			<cpu:CopyImmediateToAL/>
			<string xml:space="preserve"><xsl:value-of select="substring($Value, 1, 1)"/></string>

			<cpu:CallImmediate8Interrupt/>
			<int:VideoFunctions/>

			<xsl:call-template name="WriteNextCharacter">
				<xsl:with-param name="Value" select="substring($Value, 2)" />
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<xsl:template match="con:WriteShort">
		<scope>
			<cpu:CompareAXToImmediate/>
			<short>0</short>

			<cpu:BranchToRelativeIfNotEqual8/>
			<addressOf ref="start" type="Relative8"/>

			<cpu:CopyImmediateToAH/>
			<vid:TeletypeOutput/>

			<cpu:CopyImmediateToAL/>
			<string>0</string>

			<cpu:CallImmediate8Interrupt/>
			<int:VideoFunctions/>

			<cpu:JumpToRelative8/>
			<addressOf ref="end" type="Relative8"/>

			<label id="start"/>

			<cpu:CopyImmediateToDX/>
			<short>0</short>

			<cpu:CopyImmediateToBX/>
			<short>10</short>

			<cpu:CopyImmediateToCX/>
			<short>0</short>

			<label id="nextCharacter"/>

			<cpu:ArithmeticDXAXOperandFunction/>
			<ari:DivideByBXRegister/>

			<cpu:PushDXToStack/>

			<cpu:IncrementCX/>

			<cpu:CompareAXToImmediate/>
			<short>0</short>

			<cpu:BranchToRelativeIfEqual8/>
			<addressOf ref="drawCharacters" type="Relative8"/>

			<cpu:CopyImmediateToDX/>
			<short>0</short>

			<cpu:JumpToRelative8/>
			<addressOf ref="nextCharacter" type="Relative8"/>

			<label id="drawCharacters"/>
			<cpu:PullAXFromStack/>

			<cpu:AddImmediateToAL/>
			<asc:Zero/>

			<cpu:CopyImmediateToAH/>
			<vid:TeletypeOutput/>

			<cpu:CallImmediate8Interrupt/>
			<int:VideoFunctions/>

			<cpu:LoopToRelative8/>
			<addressOf ref="drawCharacters" type="Relative8"/>

			<label id="end"/>

			<xsl:if test="@endLine='true'">
				<cpu:CopyImmediateToAL/>
				<asc:CarriageReturn/>

				<cpu:CallImmediate8Interrupt/>
				<int:VideoFunctions/>

				<cpu:CopyImmediateToAL/>
				<asc:LineFeed/>

				<cpu:CallImmediate8Interrupt/>
				<int:VideoFunctions/>
			</xsl:if>
		</scope>
	</xsl:template>

	<xsl:template match="con:WriteShortHex">
		<scope>
			<cpu:CopyImmediateToDX/>
			<short>0</short>

			<cpu:CopyImmediateToBX/>
			<hex>0010</hex>

			<cpu:CopyImmediateToCX/>
			<short>0</short>

			<label id="nextCharacter"/>

			<cpu:ArithmeticDXAXOperandFunction/>
			<ari:DivideByBXRegister/>

			<cpu:PushDXToStack/>

			<cpu:IncrementCX/>

			<cpu:CopyImmediateToDX/>
			<short>0</short>

			<cpu:CompareAXToImmediate/>
			<short>0</short>

			<cpu:BranchToRelativeIfNotEqual8/>
			<addressOf ref="nextCharacter" type="Relative8"/>

			<xsl:if test="@digits">
				<label id="padCharacters"/>
				
				<cpu:MathImmediate8ToOperand16Function/>
				<math:CompareWithCXRegister/>
				<byte>
					<xsl:value-of select="@digits"/>
				</byte>

				<cpu:BranchToRelativeIfGreaterOrEqual8/>
				<addressOf ref="drawCharacters" type='Relative8'/>

				<cpu:CopyImmediateToDX/>
				<short>0</short>

				<cpu:PushDXToStack/>
	
				<cpu:IncrementCX/>

				<cpu:JumpToRelative8/>
				<addressOf ref="padCharacters" type="Relative8"/>
			</xsl:if>

			<label id="drawCharacters"/>

			<cpu:PullAXFromStack/>

			<cpu:CompareALToImmediate/>
			<hex>0a</hex>

			<cpu:BranchToRelativeIfGreaterOrEqual8/>
			<addressOf ref="letter" type="Relative8"/>

			<cpu:AddImmediateToAL/>
			<asc:Zero/>

			<cpu:JumpToRelative8/>
			<addressOf ref="print" type="Relative8"/>

			<label id="letter"/>

			<cpu:AddImmediateToAL/>
			<asc:Seven/>

			<label id="print"/>

			<cpu:CopyImmediateToAH/>
			<vid:TeletypeOutput/>

			<cpu:CallImmediate8Interrupt/>
			<int:VideoFunctions/>

			<cpu:LoopToRelative8/>
			<addressOf ref="drawCharacters" type="Relative8"/>

			<xsl:if test="@endLine='true'">
				<cpu:CopyImmediateToAL/>
				<asc:CarriageReturn/>

				<cpu:CallImmediate8Interrupt/>
				<int:VideoFunctions/>

				<cpu:CopyImmediateToAL/>
				<asc:LineFeed/>

				<cpu:CallImmediate8Interrupt/>
				<int:VideoFunctions/>
			</xsl:if>
		</scope>
	</xsl:template>
</xsl:stylesheet>