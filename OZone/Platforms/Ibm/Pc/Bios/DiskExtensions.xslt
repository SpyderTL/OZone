<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:ns="http://metalx.org/Pc/Bios/DiskExtensions" xmlns:prg="http://metalx.org/Program" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="ns:GetVersion">
		<xsl:element name="prg:hex">41</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ReadSectorsFromDrive">
		<xsl:element name="prg:hex">42</xsl:element>
	</xsl:template>
	<xsl:template match="ns:WriteSectorsToDrive">
		<xsl:element name="prg:hex">43</xsl:element>
	</xsl:template>
	<xsl:template match="ns:VerifySectorsOnDrive">
		<xsl:element name="prg:hex">44</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LockUnlockDrive">
		<xsl:element name="prg:hex">45</xsl:element>
	</xsl:template>
	<xsl:template match="ns:EjectMedia">
		<xsl:element name="prg:hex">46</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Seek">
		<xsl:element name="prg:hex">47</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetDriveParameters">
		<xsl:element name="prg:hex">48</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MediaChange">
		<xsl:element name="prg:hex">49</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetHardwareConfiguration">
		<xsl:element name="prg:hex">4e</xsl:element>
	</xsl:template>
</xsl:stylesheet>