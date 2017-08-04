<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:cpu="http://metalx.org/Mos/6502/Operators"
	xmlns:mm="http://metalx.org/C64/Functions/MemoryManager">
	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="mm:SelectedPointer">
		<hex>FD</hex>
	</xsl:template>

	<xsl:template match="mm:AllocateBlock">

		<cpu:CopyAbsoluteMemoryToAccumulator/>
		<xsl:element name="addressOf">
			<xsl:attribute name="ref">
				<xsl:value-of select="@memoryManager"/>
			</xsl:attribute>
			<xsl:attribute name="type">Absolute16</xsl:attribute>
		</xsl:element>

		<cpu:CopyAccumulatorToAbsoluteMemory/>
		<xsl:element name="addressOf">
			<xsl:attribute name="ref">
				<xsl:value-of select="@pointer"/>
			</xsl:attribute>
			<xsl:attribute name="type">Absolute16</xsl:attribute>
		</xsl:element>

		<cpu:CopyAbsoluteMemoryToAccumulator/>
		<xsl:element name="addressOf">
			<xsl:attribute name="ref">
				<xsl:value-of select="@memoryManager"/>
			</xsl:attribute>
			<xsl:attribute name="type">Absolute16</xsl:attribute>
			<xsl:attribute name="offset">1</xsl:attribute>
		</xsl:element>

		<cpu:CopyAccumulatorToAbsoluteMemory/>
		<xsl:element name="addressOf">
			<xsl:attribute name="ref">
				<xsl:value-of select="@pointer"/>
			</xsl:attribute>
			<xsl:attribute name="type">Absolute16</xsl:attribute>
			<xsl:attribute name="offset">1</xsl:attribute>
		</xsl:element>

		<cpu:IncrementAbsoluteMemory/>
		<xsl:element name="addressOf">
			<xsl:attribute name="ref">
				<xsl:value-of select="@memoryManager"/>
			</xsl:attribute>
			<xsl:attribute name="type">Absolute16</xsl:attribute>
			<xsl:attribute name="offset">1</xsl:attribute>
		</xsl:element>

	</xsl:template>


	<xsl:template match="mm:Reset">
		<cpu:CopyImmediateToAccumulator/>
		<addressOf ref="{@memory}" type="Absolute16Low8"/>
		<!--<xsl:element name="addressOf">
			<xsl:attribute name="ref">
				<xsl:value-of select="@memory"/>
			</xsl:attribute>
			<xsl:attribute name="type">AbsoluteLow</xsl:attribute>
		</xsl:element>-->

		<cpu:CopyAccumulatorToAbsoluteMemory/>
		<addressOf ref="{@memoryManager}" type="Absolute16"/>
		<!--<xsl:element name="addressOf">
			<xsl:attribute name="ref">
				<xsl:value-of select="@memoryManager"/>
			</xsl:attribute>
			<xsl:attribute name="type">Absolute16</xsl:attribute>
		</xsl:element>-->

		<cpu:CopyImmediateToAccumulator/>
		<addressOf ref="{@memory}" type="Absolute16High8"/>
		<!--<xsl:element name="addressOf">
			<xsl:attribute name="ref">
				<xsl:value-of select="@memory"/>
			</xsl:attribute>
			<xsl:attribute name="type">AbsoluteHigh</xsl:attribute>
		</xsl:element>-->

		<cpu:CopyAccumulatorToAbsoluteMemory/>
		<addressOf ref="{@memoryManager}" type="Absolute16" offset="1"/>
		<!--<xsl:element name="addressOf">
			<xsl:attribute name="ref">
				<xsl:value-of select="@memoryManager"/>
			</xsl:attribute>
			<xsl:attribute name="type">Absolute16</xsl:attribute>
			<xsl:attribute name="offset">1</xsl:attribute>
		</xsl:element>-->
	</xsl:template>

	<xsl:template match="mm:SelectPointer">
		<scope>
			<cpu:CopyAbsoluteMemoryToAccumulator/>
			<xsl:element name="addressOf">
				<xsl:attribute name="ref">
					<xsl:value-of select="@pointer"/>
				</xsl:attribute>
				<xsl:attribute name="type">Absolute16</xsl:attribute>
				<xsl:attribute name="parameter">true</xsl:attribute>
			</xsl:element>

			<cpu:CopyAccumulatorToAbsoluteMemory/>
			<hex>00FD</hex>

			<cpu:CopyAbsoluteMemoryToAccumulator/>
			<xsl:element name="addressOf">
				<xsl:attribute name="ref">
					<xsl:value-of select="@pointer"/>
				</xsl:attribute>
				<xsl:attribute name="type">Absolute16</xsl:attribute>
				<xsl:attribute name="offset">1</xsl:attribute>
				<xsl:attribute name="parameter">true</xsl:attribute>
			</xsl:element>

			<cpu:CopyAccumulatorToAbsoluteMemory/>
			<hex>00FE</hex>
		</scope>
	</xsl:template>

	<xsl:template match="mm:PushSelectedPointer">
		<cpu:CopyZeroPageMemoryToAccumulator/>
		<hex>FD</hex>
		<cpu:PushAccumulatorToStack/>

		<cpu:CopyZeroPageMemoryToAccumulator/>
		<hex>FE</hex>
		<cpu:PushAccumulatorToStack/>

		<cpu:CopyYIndexToAccumulator/>
		<cpu:PushAccumulatorToStack/>
	</xsl:template>

	<xsl:template match="mm:PullSelectedPointer">
		<cpu:PullAccumulatorFromStack/>
		<cpu:CopyAccumulatorToYIndex/>

		<cpu:PullAccumulatorFromStack/>
		<cpu:CopyAccumulatorToZeroPageMemory/>
		<hex>FE</hex>

		<cpu:PullAccumulatorFromStack/>
		<cpu:CopyAccumulatorToZeroPageMemory/>
		<hex>FD</hex>
	</xsl:template>

	<xsl:template match="mm:SelectReference">
		<cpu:CopyIndirectYIndexMemoryToAccumulator/>
		<hex>FD</hex>
		<cpu:PushAccumulatorToStack/>

		<cpu:IncrementYIndex/>

		<cpu:CopyIndirectYIndexMemoryToAccumulator/>
		<hex>FD</hex>

		<cpu:CopyAccumulatorToZeroPageMemory/>
		<hex>FE</hex>

		<cpu:PullAccumulatorFromStack/>

		<cpu:CopyAccumulatorToZeroPageMemory/>
		<hex>FD</hex>

		<cpu:CopyImmediateToYIndex/>
		<byte>0</byte>
	</xsl:template>

</xsl:stylesheet>
