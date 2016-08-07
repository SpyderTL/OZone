<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:ns="http://metalx.org/Amd/PcNet/PhysicalInterface"
	xmlns:prg="http://metalx.org/Program">
	
	<xsl:output method="xml" indent="yes" />
	
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match="ns:Control">
		<xsl:element name="prg:hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Status">
		<xsl:element name="prg:hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Identifier0">
		<xsl:element name="prg:hex">02</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Identifier1">
		<xsl:element name="prg:hex">03</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AutoNegotiationAdvertisement">
		<xsl:element name="prg:hex">04</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AutoNegotiationLinkPartnerAbility">
		<xsl:element name="prg:hex">05</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AutoNegotiationExpansion">
		<xsl:element name="prg:hex">06</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AutoNegotiationNextPage">
		<xsl:element name="prg:hex">07</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Interrupt">
		<xsl:element name="prg:hex">10</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ControlStatus">
		<xsl:element name="prg:hex">11</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DescramblerResyncTimer">
		<xsl:element name="prg:hex">12</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ManagmentExtension">
		<xsl:element name="prg:hex">13</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SummaryStatus">
		<xsl:element name="prg:hex">18</xsl:element>
	</xsl:template>
</xsl:stylesheet>