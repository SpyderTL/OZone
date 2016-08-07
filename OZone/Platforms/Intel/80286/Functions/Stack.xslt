<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:pop="http://metalx.org/Intel/80286/Stack">

	<xsl:output method="xml" indent="yes" />

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="pop:PullBXSIAddressFromStack">
		<xsl:element name="hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="pop:PullBXDIAddressFromStack">
		<xsl:element name="hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="pop:PullBPSIAddressFromStack">
		<xsl:element name="hex">02</xsl:element>
	</xsl:template>
	<xsl:template match="pop:PullBPDIAddressFromStack">
		<xsl:element name="hex">03</xsl:element>
	</xsl:template>
	<xsl:template match="pop:PullSIAddressFromStack">
		<xsl:element name="hex">04</xsl:element>
	</xsl:template>
	<xsl:template match="pop:PullDIAddressFromStack">
		<xsl:element name="hex">05</xsl:element>
	</xsl:template>
	<xsl:template match="pop:PullImmediate16AddressFromStack">
		<xsl:element name="hex">06</xsl:element>
	</xsl:template>
	<xsl:template match="pop:PullBXAddressFromStack">
		<xsl:element name="hex">07</xsl:element>
	</xsl:template>
	<xsl:template match="pop:PullBXSIAddressPlusImmediate8FromStack">
		<xsl:element name="hex">40</xsl:element>
	</xsl:template>
	<xsl:template match="pop:PullBXDIAddressPlusImmediate8FromStack">
		<xsl:element name="hex">41</xsl:element>
	</xsl:template>
	<xsl:template match="pop:PullBPSIAddressPlusImmediate8FromStack">
		<xsl:element name="hex">42</xsl:element>
	</xsl:template>
	<xsl:template match="pop:PullBPDIAddressPlusImmediate8FromStack">
		<xsl:element name="hex">43</xsl:element>
	</xsl:template>
	<xsl:template match="pop:PullSIAddressPlusImmediate8FromStack">
		<xsl:element name="hex">44</xsl:element>
	</xsl:template>
	<xsl:template match="pop:PullDIAddressPlusImmediate8FromStack">
		<xsl:element name="hex">45</xsl:element>
	</xsl:template>
	<xsl:template match="pop:PullBPAddressPlusImmediate8FromStack">
		<xsl:element name="hex">46</xsl:element>
	</xsl:template>
	<xsl:template match="pop:PullBXAddressPlusImmediate8FromStack">
		<xsl:element name="hex">47</xsl:element>
	</xsl:template>
	<xsl:template match="pop:PullBXSIAddressPlusImmediate16FromStack">
		<xsl:element name="hex">80</xsl:element>
	</xsl:template>
	<xsl:template match="pop:PullBXDIAddressPlusImmediate16FromStack">
		<xsl:element name="hex">81</xsl:element>
	</xsl:template>
	<xsl:template match="pop:PullBPSIAddressPlusImmediate16FromStack">
		<xsl:element name="hex">82</xsl:element>
	</xsl:template>
	<xsl:template match="pop:PullBPDIAddressPlusImmediate16FromStack">
		<xsl:element name="hex">83</xsl:element>
	</xsl:template>
	<xsl:template match="pop:PullSIAddressPlusImmediate16FromStack">
		<xsl:element name="hex">84</xsl:element>
	</xsl:template>
	<xsl:template match="pop:PullDIAddressPlusImmediate16FromStack">
		<xsl:element name="hex">85</xsl:element>
	</xsl:template>
	<xsl:template match="pop:PullBPAddressPlusImmediate16FromStack">
		<xsl:element name="hex">86</xsl:element>
	</xsl:template>
	<xsl:template match="pop:PullBXAddressPlusImmediate16FromStack">
		<xsl:element name="hex">87</xsl:element>
	</xsl:template>
	<xsl:template match="pop:PullALRegisterFromStack">
		<xsl:element name="hex">C0</xsl:element>
	</xsl:template>
	<xsl:template match="pop:PullCLRegisterFromStack">
		<xsl:element name="hex">C1</xsl:element>
	</xsl:template>
	<xsl:template match="pop:PullDLRegisterFromStack">
		<xsl:element name="hex">C2</xsl:element>
	</xsl:template>
	<xsl:template match="pop:PullBLRegisterFromStack">
		<xsl:element name="hex">C3</xsl:element>
	</xsl:template>
	<xsl:template match="pop:PullAHRegisterFromStack">
		<xsl:element name="hex">C4</xsl:element>
	</xsl:template>
	<xsl:template match="pop:PullCHRegisterFromStack">
		<xsl:element name="hex">C5</xsl:element>
	</xsl:template>
	<xsl:template match="pop:PullDHRegisterFromStack">
		<xsl:element name="hex">C6</xsl:element>
	</xsl:template>
	<xsl:template match="pop:PullBHRegisterFromStack">
		<xsl:element name="hex">C7</xsl:element>
	</xsl:template>
	<xsl:template match="pop:PullAXRegisterFromStack">
		<xsl:element name="hex">C0</xsl:element>
	</xsl:template>
	<xsl:template match="pop:PullCXRegisterFromStack">
		<xsl:element name="hex">C1</xsl:element>
	</xsl:template>
	<xsl:template match="pop:PullDXRegisterFromStack">
		<xsl:element name="hex">C2</xsl:element>
	</xsl:template>
	<xsl:template match="pop:PullBXRegisterFromStack">
		<xsl:element name="hex">C3</xsl:element>
	</xsl:template>
	<xsl:template match="pop:PullSPRegisterFromStack">
		<xsl:element name="hex">C4</xsl:element>
	</xsl:template>
	<xsl:template match="pop:PullBPRegisterFromStack">
		<xsl:element name="hex">C5</xsl:element>
	</xsl:template>
	<xsl:template match="pop:PullSIRegisterFromStack">
		<xsl:element name="hex">C6</xsl:element>
	</xsl:template>
	<xsl:template match="pop:PullDIRegisterFromStack">
		<xsl:element name="hex">C7</xsl:element>
	</xsl:template>
</xsl:stylesheet>