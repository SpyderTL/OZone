<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:ns="http://metalx.org/Intel/HdAudio/Registers" xmlns:prg="http://metalx.org/Program" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="ns:GlobalCapabilities">
		<xsl:element name="prg:hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MinorVersion">
		<xsl:element name="prg:hex">02</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MajorVersion">
		<xsl:element name="prg:hex">03</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OutputCapabilities">
		<xsl:element name="prg:hex">04</xsl:element>
	</xsl:template>
	<xsl:template match="ns:InputCapabilities">
		<xsl:element name="prg:hex">06</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GlobalControl">
		<xsl:element name="prg:hex">08</xsl:element>
	</xsl:template>
	<xsl:template match="ns:WakeEnable">
		<xsl:element name="prg:hex">0c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:StateChangeStatus">
		<xsl:element name="prg:hex">0e</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GlobalStatus">
		<xsl:element name="prg:hex">10</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OutputStreamCapabilities">
		<xsl:element name="prg:hex">18</xsl:element>
	</xsl:template>
	<xsl:template match="ns:InputStreamCapabilities">
		<xsl:element name="prg:hex">1a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:InterruptControl">
		<xsl:element name="prg:hex">20</xsl:element>
	</xsl:template>
	<xsl:template match="ns:InterruptStatus">
		<xsl:element name="prg:hex">24</xsl:element>
	</xsl:template>
	<xsl:template match="ns:WallClockCounter">
		<xsl:element name="prg:hex">30</xsl:element>
	</xsl:template>
	<xsl:template match="ns:StreamSynchronization">
		<xsl:element name="prg:hex">34</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CommandBufferLowerBaseAddress">
		<xsl:element name="prg:hex">40</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CommandBufferUpperBaseAddress">
		<xsl:element name="prg:hex">44</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CommandBufferWritePointer">
		<xsl:element name="prg:hex">48</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CommandBufferReadPointer">
		<xsl:element name="prg:hex">4a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CommandBufferControl">
		<xsl:element name="prg:hex">4c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CommandBufferStatus">
		<xsl:element name="prg:hex">4d</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CommandBufferSize">
		<xsl:element name="prg:hex">4e</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ResponseBufferLowerBaseAddress">
		<xsl:element name="prg:hex">50</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ResponseBufferUpperBaseAddress">
		<xsl:element name="prg:hex">54</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ResponseBufferWritePointer">
		<xsl:element name="prg:hex">58</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ResponseInterruptCount">
		<xsl:element name="prg:hex">5a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ResponseBufferControl">
		<xsl:element name="prg:hex">5c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ResponseBufferStatus">
		<xsl:element name="prg:hex">5d</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ResponseBufferSize">
		<xsl:element name="prg:hex">5e</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ImmediateCommand">
		<xsl:element name="prg:hex">60</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ImmediateResponse">
		<xsl:element name="prg:hex">64</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ImmediateStatus">
		<xsl:element name="prg:hex">68</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DmaLowerBaseAddress">
		<xsl:element name="prg:hex">70</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DmaUpperBaseAddress">
		<xsl:element name="prg:hex">74</xsl:element>
	</xsl:template>
	<xsl:template match="ns:StreamDescriptors">
		<xsl:element name="prg:hex">80</xsl:element>
	</xsl:template>
	<xsl:template match="ns:WallClockCounter">
		<xsl:element name="prg:hex">2030</xsl:element>
	</xsl:template>
	<xsl:template match="ns:StreamBufferPositions">
		<xsl:element name="prg:hex">2084</xsl:element>
	</xsl:template>
</xsl:stylesheet>