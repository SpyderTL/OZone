<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:cls="http://metalx.org/C64/Functions/Class"
	xmlns:mm="http://metalx.org/C64/Functions/MemoryManager"
	xmlns:cpu="http://metalx.org/Mos/6502/Operators">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="cls:FindMethod">
		<scope>
			<xsl:element name="mm:SelectPointer">
				<xsl:attribute name="pointer">
					<xsl:value-of select="@class"/>
				</xsl:attribute>
			</xsl:element>

			<!--Get Method Count-->
			<cpu:CopyImmediateToYIndex />
			<byte>4</byte>

			<cpu:CopyIndirectYIndexMemoryToAccumulator />
			<mm:SelectedPointer />

			<cpu:CopyAccumulatorToXIndex />

			<!--Test Next Method-->
			<label id="nextMethod"/>

			<cpu:IncrementYIndex />

			<!--Save Method Count-->
			<cpu:CopyXIndexToAccumulator/>
			<cpu:PushAccumulatorToStack/>

			<!--Save Current Method Pointer-->
			<mm:PushSelectedPointer />

			<!--Select Method-->
			<mm:SelectReference />

			<!--Save Current Method Address-->
			<mm:PushSelectedPointer />

			<!--Select Method Name-->
			<mm:SelectReference />

			<!--Get Method Name Length-->
			<cpu:CopyIndirectYIndexMemoryToAccumulator />
			<mm:SelectedPointer />
			
			<cpu:CopyAccumulatorToXIndex />

			<!--Save Method Name Length-->
			<cpu:PushAccumulatorToStack />

			<xsl:element name="mm:SelectPointer">
				<xsl:attribute name="pointer">
					<xsl:value-of select="@methodName"/>
				</xsl:attribute>
			</xsl:element>

			<!--Restore Method Name Length-->
			<cpu:PullAccumulatorFromStack />

			<!--Compare Method Name Length-->
			<cpu:CompareAccumulatorToIndirectYIndexMemory />
			<mm:SelectedPointer />

			<cpu:BranchToRelativeMemoryIfNotEqual />
			<addressOf ref="methodNameNotEqual" type="Relative8"/>

			<!--Compare Each Character-->
			<label id="nextCharacter"/>

			<cpu:IncrementYIndex />

			<!--Load Next Character From Method Name-->
			<cpu:CopyIndirectYIndexMemoryToAccumulator />
			<mm:SelectedPointer />

			<!--Load Next Character From Request-->

			<!--Compare Character-->

			<!--Method Found-->

			<!--Restore Method Address-->
			<mm:PullSelectedPointer />

			<!--Skip Method Name Pointer-->
			<cpu:IncrementYIndex/>
			<cpu:IncrementYIndex/>

			<!--Clean Up Stack-->
			<cpu:PullAccumulatorFromStack/>
			<cpu:PullAccumulatorFromStack/>
			<cpu:PullAccumulatorFromStack/>
			<cpu:CopyAccumulatorToXIndex />

			<cpu:JumpToAbsoluteMemory />
			<addressOf ref="exitRoutine" type="Absolute16"/>

			<!--Method Not Found-->
			<label id="methodNameNotEqual"/>

			<!--Restore Method Pointer-->
			<mm:PullSelectedPointer />
			<mm:PullSelectedPointer />

			<!--Restore Method Count-->
			<cpu:PullAccumulatorFromStack />
			<cpu:CopyAccumulatorToXIndex />
			<cpu:DecrementXIndex />

			<cpu:BranchToRelativeMemoryIfNotZero/>
			<addressOf ref="nextMethod" type="Relative8"/>

			<cpu:CopyImmediateToAccumulator />
			<byte>0</byte>

			<cpu:CopyAccumulatorToZeroPageMemory/>
			<hex>FD</hex>

			<cpu:CopyAccumulatorToZeroPageMemory />
			<hex>FE</hex>

			<label id="exitRoutine"/>
		</scope>

	</xsl:template>
</xsl:stylesheet>
