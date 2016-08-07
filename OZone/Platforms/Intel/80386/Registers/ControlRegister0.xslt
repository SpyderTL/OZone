<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:ns="http://metalx.org/Intel/80386/Registers/ControlRegister0" xmlns:prg="http://metalx.org/Program" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="ns:ProtectionEnabled">
		<xsl:element name="prg:hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MonitorCoprocessor">
		<xsl:element name="prg:hex">02</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FpuEmulation">
		<xsl:element name="prg:hex">04</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TaskSwitchDetected">
		<xsl:element name="prg:hex">08</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FpuSupported">
		<xsl:element name="prg:hex">10</xsl:element>
	</xsl:template>
	<xsl:template match="ns:NativeFpuErrorsEnabled">
		<xsl:element name="prg:hex">20</xsl:element>
	</xsl:template>
	<xsl:template match="ns:WriteProtectEnabled">
		<xsl:element name="prg:hex">00010000</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AutomaticAlignmentCheckingEnabled">
		<xsl:element name="prg:hex">00040000</xsl:element>
	</xsl:template>
	<xsl:template match="ns:WriteThroughDisabled">
		<xsl:element name="prg:hex">20000000</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CacheDisabled">
		<xsl:element name="prg:hex">40000000</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PagingEnabled">
		<xsl:element name="prg:hex">80000000</xsl:element>
	</xsl:template>
</xsl:stylesheet>