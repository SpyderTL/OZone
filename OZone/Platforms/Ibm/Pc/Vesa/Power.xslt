<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:pwr="http://metalx.org/Pc/Vesa/Power"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" indent="yes" />
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="pwr:InstallationCheck">
    <xsl:element name="hex">5300</xsl:element>
  </xsl:template>
  <xsl:template match="pwr:Connect">
    <xsl:element name="hex">5301</xsl:element>
  </xsl:template>
  <xsl:template match="pwr:ConnectProtected16">
    <xsl:element name="hex">5302</xsl:element>
  </xsl:template>
  <xsl:template match="pwr:ConnectProtected32">
    <xsl:element name="hex">5303</xsl:element>
  </xsl:template>
  <xsl:template match="pwr:Disconnect">
    <xsl:element name="hex">5304</xsl:element>
  </xsl:template>
  <xsl:template match="pwr:CpuIdle">
    <xsl:element name="hex">5305</xsl:element>
  </xsl:template>
  <xsl:template match="pwr:CpuBusy">
    <xsl:element name="hex">5306</xsl:element>
  </xsl:template>
  <xsl:template match="pwr:SetState">
    <xsl:element name="hex">5307</xsl:element>
  </xsl:template>
  <xsl:template match="pwr:Enable">
    <xsl:element name="hex">5308</xsl:element>
  </xsl:template>
  <xsl:template match="pwr:Reset">
    <xsl:element name="hex">5309</xsl:element>
  </xsl:template>
  <xsl:template match="pwr:GetStatus">
    <xsl:element name="hex">530A</xsl:element>
  </xsl:template>
  <xsl:template match="pwr:GetEvent">
    <xsl:element name="hex">530B</xsl:element>
  </xsl:template>
  <xsl:template match="pwr:GetState">
    <xsl:element name="hex">530C</xsl:element>
  </xsl:template>
  <xsl:template match="pwr:EnableDevice">
    <xsl:element name="hex">530D</xsl:element>
  </xsl:template>
  <xsl:template match="pwr:SetDriverVersion">
    <xsl:element name="hex">530E</xsl:element>
  </xsl:template>
  <xsl:template match="pwr:Engage">
    <xsl:element name="hex">530F</xsl:element>
  </xsl:template>
  <xsl:template match="pwr:GetCapabilities">
    <xsl:element name="hex">5310</xsl:element>
  </xsl:template>
  <xsl:template match="pwr:ResumeTimer">
    <xsl:element name="hex">5311</xsl:element>
  </xsl:template>
  <xsl:template match="pwr:ResumeOnRing">
    <xsl:element name="hex">5312</xsl:element>
  </xsl:template>
  <xsl:template match="pwr:TimerRequests">
    <xsl:element name="hex">5313</xsl:element>
  </xsl:template>
</xsl:stylesheet>