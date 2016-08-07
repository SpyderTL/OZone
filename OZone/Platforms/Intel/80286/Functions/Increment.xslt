<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:inc="http://metalx.org/Intel/80286/Increment">
  <xsl:output method="xml" indent="yes" />
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="inc:IncrementBXSIAddress">
    <xsl:element name="hex">00</xsl:element>
  </xsl:template>
  <xsl:template match="inc:IncrementBXDIAddress">
    <xsl:element name="hex">01</xsl:element>
  </xsl:template>
  <xsl:template match="inc:IncrementBPSIAddress">
    <xsl:element name="hex">02</xsl:element>
  </xsl:template>
  <xsl:template match="inc:IncrementBPDIAddress">
    <xsl:element name="hex">03</xsl:element>
  </xsl:template>
  <xsl:template match="inc:IncrementSIAddress">
    <xsl:element name="hex">04</xsl:element>
  </xsl:template>
  <xsl:template match="inc:IncrementDIAddress">
    <xsl:element name="hex">05</xsl:element>
  </xsl:template>
  <xsl:template match="inc:IncrementImmediate16Address">
    <xsl:element name="hex">06</xsl:element>
  </xsl:template>
  <xsl:template match="inc:IncrementBXAddress">
    <xsl:element name="hex">07</xsl:element>
  </xsl:template>
  <xsl:template match="inc:DecrementBXSIAddress">
    <xsl:element name="hex">08</xsl:element>
  </xsl:template>
  <xsl:template match="inc:DecrementBXDIAddress">
    <xsl:element name="hex">09</xsl:element>
  </xsl:template>
  <xsl:template match="inc:DecrementBPSIAddress">
    <xsl:element name="hex">0A</xsl:element>
  </xsl:template>
  <xsl:template match="inc:DecrementBPDIAddress">
    <xsl:element name="hex">0B</xsl:element>
  </xsl:template>
  <xsl:template match="inc:DecrementSIAddress">
    <xsl:element name="hex">0C</xsl:element>
  </xsl:template>
  <xsl:template match="inc:DecrementDIAddress">
    <xsl:element name="hex">0D</xsl:element>
  </xsl:template>
  <xsl:template match="inc:DecrementImmediate16Address">
    <xsl:element name="hex">0E</xsl:element>
  </xsl:template>
  <xsl:template match="inc:DecrementBXAddress">
    <xsl:element name="hex">0F</xsl:element>
  </xsl:template>
  <xsl:template match="inc:IncrementBXSIAddressPlusImmediate8">
    <xsl:element name="hex">40</xsl:element>
  </xsl:template>
  <xsl:template match="inc:IncrementBXDIAddressPlusImmediate8">
    <xsl:element name="hex">41</xsl:element>
  </xsl:template>
  <xsl:template match="inc:IncrementBPSIAddressPlusImmediate8">
    <xsl:element name="hex">42</xsl:element>
  </xsl:template>
  <xsl:template match="inc:IncrementBPDIAddressPlusImmediate8">
    <xsl:element name="hex">43</xsl:element>
  </xsl:template>
  <xsl:template match="inc:IncrementSIAddressPlusImmediate8">
    <xsl:element name="hex">44</xsl:element>
  </xsl:template>
  <xsl:template match="inc:IncrementDIAddressPlusImmediate8">
    <xsl:element name="hex">45</xsl:element>
  </xsl:template>
  <xsl:template match="inc:IncrementBPAddressPlusImmediate8">
    <xsl:element name="hex">46</xsl:element>
  </xsl:template>
  <xsl:template match="inc:IncrementBXAddressPlusImmediate8">
    <xsl:element name="hex">47</xsl:element>
  </xsl:template>
  <xsl:template match="inc:DecrementBXSIAddressPlusImmediate8">
    <xsl:element name="hex">48</xsl:element>
  </xsl:template>
  <xsl:template match="inc:DecrementBXDIAddressPlusImmediate8">
    <xsl:element name="hex">49</xsl:element>
  </xsl:template>
  <xsl:template match="inc:DecrementBPSIAddressPlusImmediate8">
    <xsl:element name="hex">4A</xsl:element>
  </xsl:template>
  <xsl:template match="inc:DecrementBPDIAddressPlusImmediate8">
    <xsl:element name="hex">4B</xsl:element>
  </xsl:template>
  <xsl:template match="inc:DecrementSIAddressPlusImmediate8">
    <xsl:element name="hex">4C</xsl:element>
  </xsl:template>
  <xsl:template match="inc:DecrementDIAddressPlusImmediate8">
    <xsl:element name="hex">4D</xsl:element>
  </xsl:template>
  <xsl:template match="inc:DecrementBPAddressPlusImmediate8">
    <xsl:element name="hex">4E</xsl:element>
  </xsl:template>
  <xsl:template match="inc:DecrementBXAddressPlusImmediate8">
    <xsl:element name="hex">4F</xsl:element>
  </xsl:template>
  <xsl:template match="inc:IncrementBXSIAddressPlusImmediate16">
    <xsl:element name="hex">80</xsl:element>
  </xsl:template>
  <xsl:template match="inc:IncrementBXDIAddressPlusImmediate16">
    <xsl:element name="hex">81</xsl:element>
  </xsl:template>
  <xsl:template match="inc:IncrementBPSIAddressPlusImmediate16">
    <xsl:element name="hex">82</xsl:element>
  </xsl:template>
  <xsl:template match="inc:IncrementBPDIAddressPlusImmediate16">
    <xsl:element name="hex">83</xsl:element>
  </xsl:template>
  <xsl:template match="inc:IncrementSIAddressPlusImmediate16">
    <xsl:element name="hex">84</xsl:element>
  </xsl:template>
  <xsl:template match="inc:IncrementDIAddressPlusImmediate16">
    <xsl:element name="hex">85</xsl:element>
  </xsl:template>
  <xsl:template match="inc:IncrementBPAddressPlusImmediate16">
    <xsl:element name="hex">86</xsl:element>
  </xsl:template>
  <xsl:template match="inc:IncrementBXAddressPlusImmediate16">
    <xsl:element name="hex">87</xsl:element>
  </xsl:template>
  <xsl:template match="inc:DecrementBXSIAddressPlusImmediate16">
    <xsl:element name="hex">88</xsl:element>
  </xsl:template>
  <xsl:template match="inc:DecrementBXDIAddressPlusImmediate16">
    <xsl:element name="hex">89</xsl:element>
  </xsl:template>
  <xsl:template match="inc:DecrementBPSIAddressPlusImmediate16">
    <xsl:element name="hex">8A</xsl:element>
  </xsl:template>
  <xsl:template match="inc:DecrementBPDIAddressPlusImmediate16">
    <xsl:element name="hex">8B</xsl:element>
  </xsl:template>
  <xsl:template match="inc:DecrementSIAddressPlusImmediate16">
    <xsl:element name="hex">8C</xsl:element>
  </xsl:template>
  <xsl:template match="inc:DecrementDIAddressPlusImmediate16">
    <xsl:element name="hex">8D</xsl:element>
  </xsl:template>
  <xsl:template match="inc:DecrementBPAddressPlusImmediate16">
    <xsl:element name="hex">8E</xsl:element>
  </xsl:template>
  <xsl:template match="inc:DecrementBXAddressPlusImmediate16">
    <xsl:element name="hex">8F</xsl:element>
  </xsl:template>
  <xsl:template match="inc:IncrementALRegister">
    <xsl:element name="hex">C0</xsl:element>
  </xsl:template>
  <xsl:template match="inc:IncrementCLRegister">
    <xsl:element name="hex">C1</xsl:element>
  </xsl:template>
  <xsl:template match="inc:IncrementDLRegister">
    <xsl:element name="hex">C2</xsl:element>
  </xsl:template>
  <xsl:template match="inc:IncrementBLRegister">
    <xsl:element name="hex">C3</xsl:element>
  </xsl:template>
  <xsl:template match="inc:IncrementAHRegister">
    <xsl:element name="hex">C4</xsl:element>
  </xsl:template>
  <xsl:template match="inc:IncrementCHRegister">
    <xsl:element name="hex">C5</xsl:element>
  </xsl:template>
  <xsl:template match="inc:IncrementDHRegister">
    <xsl:element name="hex">C6</xsl:element>
  </xsl:template>
  <xsl:template match="inc:IncrementBHRegister">
    <xsl:element name="hex">C7</xsl:element>
  </xsl:template>
  <xsl:template match="inc:IncrementAXRegister">
    <xsl:element name="hex">C0</xsl:element>
  </xsl:template>
  <xsl:template match="inc:IncrementCXRegister">
    <xsl:element name="hex">C1</xsl:element>
  </xsl:template>
  <xsl:template match="inc:IncrementDXRegister">
    <xsl:element name="hex">C2</xsl:element>
  </xsl:template>
  <xsl:template match="inc:IncrementBXRegister">
    <xsl:element name="hex">C3</xsl:element>
  </xsl:template>
  <xsl:template match="inc:IncrementSPRegister">
    <xsl:element name="hex">C4</xsl:element>
  </xsl:template>
  <xsl:template match="inc:IncrementBPRegister">
    <xsl:element name="hex">C5</xsl:element>
  </xsl:template>
  <xsl:template match="inc:IncrementSIRegister">
    <xsl:element name="hex">C6</xsl:element>
  </xsl:template>
  <xsl:template match="inc:IncrementDIRegister">
    <xsl:element name="hex">C7</xsl:element>
  </xsl:template>
  <xsl:template match="inc:DecrementALRegister">
    <xsl:element name="hex">C8</xsl:element>
  </xsl:template>
  <xsl:template match="inc:DecrementCLRegister">
    <xsl:element name="hex">C9</xsl:element>
  </xsl:template>
  <xsl:template match="inc:DecrementDLRegister">
    <xsl:element name="hex">CA</xsl:element>
  </xsl:template>
  <xsl:template match="inc:DecrementBLRegister">
    <xsl:element name="hex">CB</xsl:element>
  </xsl:template>
  <xsl:template match="inc:DecrementAHRegister">
    <xsl:element name="hex">CC</xsl:element>
  </xsl:template>
  <xsl:template match="inc:DecrementCHRegister">
    <xsl:element name="hex">CD</xsl:element>
  </xsl:template>
  <xsl:template match="inc:DecrementDHRegister">
    <xsl:element name="hex">CE</xsl:element>
  </xsl:template>
  <xsl:template match="inc:DecrementBHRegister">
    <xsl:element name="hex">CF</xsl:element>
  </xsl:template>
  <xsl:template match="inc:DecrementAXRegister">
    <xsl:element name="hex">C8</xsl:element>
  </xsl:template>
  <xsl:template match="inc:DecrementCXRegister">
    <xsl:element name="hex">C9</xsl:element>
  </xsl:template>
  <xsl:template match="inc:DecrementDXRegister">
    <xsl:element name="hex">CA</xsl:element>
  </xsl:template>
  <xsl:template match="inc:DecrementBXRegister">
    <xsl:element name="hex">CB</xsl:element>
  </xsl:template>
  <xsl:template match="inc:DecrementSPRegister">
    <xsl:element name="hex">CC</xsl:element>
  </xsl:template>
  <xsl:template match="inc:DecrementBPRegister">
    <xsl:element name="hex">CD</xsl:element>
  </xsl:template>
  <xsl:template match="inc:DecrementSIRegister">
    <xsl:element name="hex">CE</xsl:element>
  </xsl:template>
  <xsl:template match="inc:DecrementDIRegister">
    <xsl:element name="hex">CF</xsl:element>
  </xsl:template>
</xsl:stylesheet>