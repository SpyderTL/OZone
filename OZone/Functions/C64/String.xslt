<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:cpu="http://metalx.org/Mos/6502/Operators"
	xmlns:mm="http://metalx.org/C64/Functions/MemoryManager"
	xmlns:str="http://metalx.org/C64/Functions/String">
	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="str:Create">
		<xsl:element name="mm:AllocateBlock">
			<xsl:attribute name="memoryManager">
				<xsl:value-of select="@memoryManager"/>
			</xsl:attribute>
			<xsl:attribute name="pointer">
				<xsl:value-of select="@pointer"/>
			</xsl:attribute>
		</xsl:element>
		<xsl:call-template name="Clear"/>
	</xsl:template>

	<xsl:template name="Clear" match="str:Clear">
		<xsl:element name="mm:SelectPointer">
			<xsl:attribute name="pointer">
				<xsl:value-of select="@pointer"/>
			</xsl:attribute>
		</xsl:element>
		<cpu:CopyImmediateToAccumulator />
		<byte>0</byte>
		<cpu:CopyAccumulatorToYIndex />
		<cpu:CopyAccumulatorToIndirectYIndexMemory/>
		<hex>FD</hex>
	</xsl:template>

	<xsl:template match="str:AppendCharacter">
		<cpu:PushAccumulatorToStack />

		<xsl:element name="mm:SelectPointer">
			<xsl:attribute name="pointer">
				<xsl:value-of select="@pointer"/>
			</xsl:attribute>
		</xsl:element>

		<cpu:CopyImmediateToYIndex />
		<byte>0</byte>

		<cpu:CopyIndirectYIndexMemoryToAccumulator />
		<mm:SelectedPointer />

		<cpu:AddImmediateToAccumulator />
		<byte>1</byte>

		<cpu:CopyAccumulatorToIndirectYIndexMemory	/>
		<mm:SelectedPointer />

		<cpu:CopyAccumulatorToYIndex />

		<cpu:PullAccumulatorFromStack />

		<cpu:CopyAccumulatorToIndirectYIndexMemory />
		<mm:SelectedPointer />
	</xsl:template>

	<xsl:template match="str:TrimLastCharacter">
		<scope>
			<xsl:element name="mm:SelectPointer">
				<xsl:attribute name="pointer">
					<xsl:value-of select="@pointer"/>
				</xsl:attribute>
			</xsl:element>

			<cpu:CopyImmediateToYIndex />
			<byte>0</byte>

			<cpu:CopyIndirectYIndexMemoryToAccumulator />
			<mm:SelectedPointer/>

			<cpu:BranchToRelativeMemoryIfZero />
			<addressOf ref="exitRoutine" type="Relative8"/>

			<cpu:SubtractImmediateFromAccumulator />
			<byte>1</byte>

			<cpu:CopyAccumulatorToIndirectYIndexMemory />
			<mm:SelectedPointer />

			<label id="exitRoutine"/>
		</scope>
	</xsl:template>

	<xsl:template match="str:GetLength">
		<xsl:element name="mm:SelectPointer">
			<xsl:attribute name="pointer">
				<xsl:value-of select="@pointer"/>
			</xsl:attribute>
		</xsl:element>
		<cpu:CopyImmediateToYIndex />
		<byte>0</byte>
		<cpu:CopyIndirectYIndexMemoryToAccumulator />
		<mm:SelectedPointer />
	</xsl:template>

</xsl:stylesheet>
