<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:cpu="http://metalx.org/Mos/6502/Operators"
	xmlns:mm="http://metalx.org/6502/Functions/MemoryManager"
	xmlns:str="http://metalx.org/6502/Functions/String">
	
	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="str:Create">
		<mm:CheckOut length="2"/>
		<mm:CheckOut/>

		<cpu:IncrementXIndex/>
		<cpu:IncrementXIndex/>

		<xsl:call-template name="Clear"/>
	</xsl:template>

	<xsl:template name="Clear" match="str:Clear">
		<cpu:CopyImmediate8PlusXIndexAddressToAccumulator/>
		<byte>0</byte>

		<cpu:CopyAccumulatorToImmediate8Address/>
		<hex>02</hex>

		<cpu:CopyImmediate8PlusXIndexAddressToAccumulator/>
		<byte>1</byte>

		<cpu:CopyAccumulatorToImmediate8Address/>
		<hex>03</hex>

		<cpu:CopyImmediate8ToAccumulator/>
		<byte>0</byte>

		<cpu:CopyAccumulatorToYIndex/>

		<cpu:CopyAccumulatorToImmediate8PointerPlusYIndexAddress/>
		<hex>02</hex>

		<cpu:IncrementYIndex/>

		<cpu:CopyAccumulatorToImmediate8PointerPlusYIndexAddress/>
		<hex>02</hex>
	</xsl:template>

	<xsl:template match="str:AppendCharacter">
		<cpu:CopyImmediate8PlusXIndexAddressToAccumulator/>
		<byte>0</byte>

		<cpu:CopyAccumulatorToImmediate8Address/>
		<hex>02</hex>

		<cpu:CopyImmediate8PlusXIndexAddressToAccumulator/>
		<byte>1</byte>

		<cpu:CopyAccumulatorToImmediate8Address/>
		<hex>03</hex>

		<cpu:CopyImmediate8ToYIndex/>
		<byte>0</byte>

		<cpu:ClearCarryFlag/>
		
		<cpu:CopyImmediate8PointerPlusYIndexAddressToAccumulator/>
		<hex>02</hex>

		<cpu:AddImmediate8ToAccumulator/>
		<hex>01</hex>

		<cpu:CopyAccumulatorToImmediate8PointerPlusYIndexAddress/>
		<hex>02</hex>

		<cpu:PushStatusToStack/>
		
		<cpu:IncrementYIndex/>

		<cpu:PullStatusFromStack/>

		<cpu:CopyImmediate8PointerPlusYIndexAddressToAccumulator/>
		<hex>02</hex>

		<cpu:AddImmediate8ToAccumulator/>
		<hex>00</hex>

		<cpu:CopyAccumulatorToImmediate8PointerPlusYIndexAddress/>
		<hex>02</hex>

		<cpu:DecrementYIndex/>
		
		<cpu:ClearCarryFlag/>

		<cpu:CopyImmediate8AddressToAccumulator/>
		<hex>02</hex>

		<cpu:AddImmediate8PointerPlusYIndexAddressToAccumulator/>
		<hex>02</hex>

		<cpu:CopyAccumulatorToImmediate8Address/>
		<hex>04</hex>

		<cpu:PushStatusToStack/>
		
		<cpu:IncrementYIndex/>
		
		<cpu:PullStatusFromStack/>
		
		<cpu:CopyImmediate8AddressToAccumulator/>
		<hex>03</hex>

		<cpu:AddImmediate8PointerPlusYIndexAddressToAccumulator/>
		<hex>02</hex>

		<cpu:CopyAccumulatorToImmediate8Address/>
		<hex>05</hex>

		<cpu:PullAccumulatorFromStack/>

		<cpu:CopyAccumulatorToImmediate8PointerPlusYIndexAddress/>
		<hex>04</hex>
	</xsl:template>

	<xsl:template match="str:TrimLastCharacter">
		<cpu:CopyImmediate8PlusXIndexAddressToAccumulator/>
		<byte>0</byte>

		<cpu:CopyAccumulatorToImmediate8Address/>
		<hex>02</hex>

		<cpu:CopyImmediate8PlusXIndexAddressToAccumulator/>
		<byte>1</byte>

		<cpu:CopyAccumulatorToImmediate8Address/>
		<hex>03</hex>

		<cpu:CopyImmediate8ToYIndex/>
		<byte>0</byte>

		<cpu:SetCarryFlag/>

		<cpu:CopyImmediate8PointerPlusYIndexAddressToAccumulator/>
		<hex>02</hex>

		<cpu:SubtractImmediate8FromAccumulator/>
		<hex>01</hex>

		<cpu:CopyAccumulatorToImmediate8PointerPlusYIndexAddress/>
		<hex>02</hex>

		<cpu:PushStatusToStack/>
		
		<cpu:IncrementYIndex/>
		
		<cpu:PullStatusFromStack/>

		<cpu:CopyImmediate8PointerPlusYIndexAddressToAccumulator/>
		<hex>02</hex>

		<cpu:SubtractImmediate8FromAccumulator/>
		<hex>00</hex>

		<cpu:CopyAccumulatorToImmediate8PointerPlusYIndexAddress/>
		<hex>02</hex>
	</xsl:template>

	<xsl:template match="str:GetLength">
		<cpu:CopyImmediate8PlusXIndexAddressToAccumulator/>
		<byte>0</byte>

		<cpu:CopyAccumulatorToImmediate8Address/>
		<hex>04</hex>

		<cpu:CopyImmediate8PlusXIndexAddressToAccumulator/>
		<byte>1</byte>

		<cpu:CopyAccumulatorToImmediate8Address/>
		<hex>05</hex>

		<cpu:CopyImmediate8ToYIndex/>
		<byte>0</byte>

		<cpu:CopyImmediate8PointerPlusYIndexAddressToAccumulator/>
		<hex>04</hex>

		<cpu:CopyAccumulatorToImmediate8Address/>
		<hex>02</hex>

		<cpu:IncrementYIndex/>

		<cpu:CopyImmediate8PointerPlusYIndexAddressToAccumulator/>
		<hex>04</hex>

		<cpu:CopyAccumulatorToImmediate8Address/>
		<hex>03</hex>
	</xsl:template>
</xsl:stylesheet>
