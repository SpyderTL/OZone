<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:ns="http://metalx.org/Novell/Ne2000/Registers/Page2" xmlns:prg="http://metalx.org/Program" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="ns:Command">
		<xsl:element name="prg:hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RemoteNextPacketPointer">
		<xsl:element name="prg:hex">03</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LocalNextPacketPointer">
		<xsl:element name="prg:hex">05</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddressCounterHigh">
		<xsl:element name="prg:hex">06</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddressCounterLow">
		<xsl:element name="prg:hex">07</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetPageStart">
		<xsl:element name="prg:hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetPageStop">
		<xsl:element name="prg:hex">02</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetTransmitPageStartAddress">
		<xsl:element name="prg:hex">04</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetReceiveConfiguration">
		<xsl:element name="prg:hex">0c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetTransmitConfiguration">
		<xsl:element name="prg:hex">0d</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetDataConfiguration">
		<xsl:element name="prg:hex">0e</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetInterruptMask">
		<xsl:element name="prg:hex">0f</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetLocalDmaAddress0">
		<xsl:element name="prg:hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetLocalDmaAddress1">
		<xsl:element name="prg:hex">02</xsl:element>
	</xsl:template>
</xsl:stylesheet>