<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:ns="http://metalx.org/Novell/Ne2000/Registers/Page0" xmlns:prg="http://metalx.org/Program" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="ns:Command">
		<xsl:element name="prg:hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetLocalDmaAddress0">
		<xsl:element name="prg:hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetLocalDmaAddress1">
		<xsl:element name="prg:hex">02</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetRingBufferBoundary">
		<xsl:element name="prg:hex">03</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetTransmitStatus">
		<xsl:element name="prg:hex">04</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetCollisionCounter">
		<xsl:element name="prg:hex">05</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetFifo">
		<xsl:element name="prg:hex">06</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetInterruptStatus">
		<xsl:element name="prg:hex">07</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetRemoteDmaAddress0">
		<xsl:element name="prg:hex">08</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetRemoteDmaAddress1">
		<xsl:element name="prg:hex">09</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetReceiveStatus">
		<xsl:element name="prg:hex">0c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetPageStart">
		<xsl:element name="prg:hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetPageStop">
		<xsl:element name="prg:hex">02</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetTransmitPageStartAddress">
		<xsl:element name="prg:hex">04</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetTransmitByteCountLow">
		<xsl:element name="prg:hex">05</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetTransmitByteCountHigh">
		<xsl:element name="prg:hex">06</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetRemoteStartAddressLow">
		<xsl:element name="prg:hex">08</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetRemoteStartAddressHigh">
		<xsl:element name="prg:hex">09</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetRemoteByteCountLow">
		<xsl:element name="prg:hex">0a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetRemoteByteCountHigh">
		<xsl:element name="prg:hex">0b</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetReceiveConfiguration">
		<xsl:element name="prg:hex">0c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetTransmitConfiguration">
		<xsl:element name="prg:hex">0d</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetDataConfiguration">
		<xsl:element name="prg:hex">0e</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetInterruptMask">
		<xsl:element name="prg:hex">0f</xsl:element>
	</xsl:template>
</xsl:stylesheet>