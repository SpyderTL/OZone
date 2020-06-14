<xsl:stylesheet version="1.0" xmlns:cpu="http://metalx.org/Mos/6502/Operators" xmlns:prg="http://metalx.org/Program" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="text" />

	<xsl:template match="cpu:ClearCarryFlag">clc</xsl:template>
	<xsl:template match="cpu:SetCarryFlag">sec</xsl:template>
	<xsl:template match="cpu:PullAccumulatorFromStack">pla</xsl:template>
	<xsl:template match="cpu:PushAccumulatorToStack">pha</xsl:template>
	<xsl:template match="cpu:IncrementXIndex">inx</xsl:template>
	<xsl:template match="cpu:IncrementYIndex">iny</xsl:template>
	<xsl:template match="cpu:DecrementXIndex">dex</xsl:template>
	<xsl:template match="cpu:DecrementYIndex">dey</xsl:template>
	<xsl:template match="cpu:CopyImmediate8ToAccumulator">lda </xsl:template>
	<xsl:template match="cpu:CopyImmediate8ToXIndex">ldx </xsl:template>
	<xsl:template match="cpu:CopyImmediate8ToYIndex">ldy </xsl:template>
	<xsl:template match="cpu:CopyImmediate16PlusXIndexAddressToAccumulator">lda , X</xsl:template>
	<xsl:template match="cpu:CopyAccumulatorToImmediate16PlusXIndexAddress">sta , X</xsl:template>
	<xsl:template match="cpu:CopyImmediate16PlusYIndexAddressToAccumulator">lda , Y</xsl:template>
	<xsl:template match="cpu:CopyAccumulatorToImmediate16PlusYIndexAddress">sta , Y</xsl:template>

	<xsl:template match="cpu:AddImmediate8ToAccumulator">adc </xsl:template>
	<xsl:template match="cpu:SubtractImmediate8FromAccumulator">sbb </xsl:template>
	<xsl:template match="cpu:CompareAccumulatorToImmediate16PlusYIndexAddress">cmp , Y</xsl:template>

	<xsl:template match="cpu:BranchToRelative8IfZero">bz </xsl:template>
	<xsl:template match="cpu:BranchToRelative8IfEqual">be </xsl:template>
	<xsl:template match="cpu:BranchToRelative8IfNotEqual">bne </xsl:template>
	<xsl:template match="cpu:BranchToRelative8IfNotZero">bne </xsl:template>
	<xsl:template match="cpu:BranchToRelative8IfCarry">bcs </xsl:template>
	<xsl:template match="cpu:BranchToRelative8IfNotCarry">bcc </xsl:template>
	<xsl:template match="cpu:BranchToRelative8IfPositive">bcc </xsl:template>
	<xsl:template match="cpu:BranchToRelative8IfNegative">bcs </xsl:template>

	<xsl:template match="cpu:CallImmediate16Address">jsr </xsl:template>
	<xsl:template match="cpu:ReturnFromSubroutine">rts</xsl:template>

	<xsl:template match="prg:byte">#<xsl:value-of select="text()"/></xsl:template>
	<xsl:template match="prg:hex">#$<xsl:value-of select="text()"/></xsl:template>
	<xsl:template match="prg:binary">%<xsl:value-of select="text()"/></xsl:template>

	<xsl:template match="prg:label">
		<xsl:choose>
			<xsl:when test="@offset">
				<xsl:value-of select="@id"/> = $<xsl:value-of select="@offset"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="@id"/>:
				<xsl:apply-templates select="node()" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="prg:addressOf">
		<xsl:value-of select="@ref"/>
	</xsl:template>
</xsl:stylesheet>