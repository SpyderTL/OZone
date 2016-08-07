<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:evt="http://metalx.org/Intel/80386/Events"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" indent="yes" />
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="evt:DivideByZero">
    <xsl:element name="hex">00</xsl:element>
  </xsl:template>
  <xsl:template match="evt:Trace">
    <xsl:element name="hex">01</xsl:element>
  </xsl:template>
  <xsl:template match="evt:HardwareFailure">
    <xsl:element name="hex">02</xsl:element>
  </xsl:template>
  <xsl:template match="evt:WatchdogTimer">
    <xsl:element name="hex">02</xsl:element>
  </xsl:template>
  <xsl:template match="evt:Debug">
    <xsl:element name="hex">03</xsl:element>
  </xsl:template>
  <xsl:template match="evt:Overflow">
    <xsl:element name="hex">04</xsl:element>
  </xsl:template>
  <xsl:template match="evt:PrintScreen">
    <xsl:element name="hex">05</xsl:element>
  </xsl:template>
  <xsl:template match="evt:InvalidInstruction">
    <xsl:element name="hex">06</xsl:element>
  </xsl:template>
  <xsl:template match="evt:MathCoprocessorUnavailable">
    <xsl:element name="hex">07</xsl:element>
  </xsl:template>
  <xsl:template match="evt:Timer">
    <xsl:element name="hex">08</xsl:element>
  </xsl:template>
  <xsl:template match="evt:HardwareInterruptRequest0">
    <xsl:element name="hex">08</xsl:element>
  </xsl:template>
  <xsl:template match="evt:Keyboard">
    <xsl:element name="hex">09</xsl:element>
  </xsl:template>
  <xsl:template match="evt:HardwareInterruptRequest1">
    <xsl:element name="hex">09</xsl:element>
  </xsl:template>
  <xsl:template match="evt:HardwareInterruptRequest2">
    <xsl:element name="hex">0A</xsl:element>
  </xsl:template>
  <xsl:template match="evt:SerialPort2or4">
    <xsl:element name="hex">0B</xsl:element>
  </xsl:template>
  <xsl:template match="evt:HardwareInterruptRequest3">
    <xsl:element name="hex">0B</xsl:element>
  </xsl:template>
  <xsl:template match="evt:SerialPort1or3">
    <xsl:element name="hex">0C</xsl:element>
  </xsl:template>
  <xsl:template match="evt:HardwareInterruptRequest4">
    <xsl:element name="hex">0C</xsl:element>
  </xsl:template>
  <xsl:template match="evt:HardDrive">
    <xsl:element name="hex">0D</xsl:element>
  </xsl:template>
  <xsl:template match="evt:HardwareInterruptRequest5">
    <xsl:element name="hex">0D</xsl:element>
  </xsl:template>
  <xsl:template match="evt:FloppyDrive">
    <xsl:element name="hex">0E</xsl:element>
  </xsl:template>
  <xsl:template match="evt:HardwareInterruptRequest6">
    <xsl:element name="hex">0E</xsl:element>
  </xsl:template>
  <xsl:template match="evt:Lpt1Printer">
    <xsl:element name="hex">0F</xsl:element>
  </xsl:template>
  <xsl:template match="evt:HardwareInterruptRequest7">
    <xsl:element name="hex">0F</xsl:element>
  </xsl:template>
  <xsl:template match="evt:ControlBreak">
    <xsl:element name="hex">1B</xsl:element>
  </xsl:template>
  <xsl:template match="evt:HardwareInterruptRequest8">
    <xsl:element name="hex">70</xsl:element>
  </xsl:template>
  <xsl:template match="evt:HardwareInterruptRequest9">
    <xsl:element name="hex">71</xsl:element>
  </xsl:template>
  <xsl:template match="evt:HardwareInterruptRequest10">
    <xsl:element name="hex">72</xsl:element>
  </xsl:template>
  <xsl:template match="evt:HardwareInterruptRequest11">
    <xsl:element name="hex">73</xsl:element>
  </xsl:template>
  <xsl:template match="evt:Mouse">
    <xsl:element name="hex">74</xsl:element>
  </xsl:template>
  <xsl:template match="evt:HardwareInterruptRequest12">
    <xsl:element name="hex">74</xsl:element>
  </xsl:template>
  <xsl:template match="evt:MathCoprocessors">
    <xsl:element name="hex">75</xsl:element>
  </xsl:template>
  <xsl:template match="evt:HardwareInterruptRequest13">
    <xsl:element name="hex">75</xsl:element>
  </xsl:template>
  <xsl:template match="evt:HardwareInterruptRequest14">
    <xsl:element name="hex">76</xsl:element>
  </xsl:template>
  <xsl:template match="evt:HardwareInterruptRequest15">
    <xsl:element name="hex">77</xsl:element>
  </xsl:template>
</xsl:stylesheet>