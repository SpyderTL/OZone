<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:ns="http://metalx.org/Commodore64/Kernel" xmlns:prg="http://metalx.org/Program" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="ns:InitializeScreenAndKeyboard">
		<xsl:element name="prg:label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">FF81</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:InitializeIODevices">
		<xsl:element name="prg:label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">FF84</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:InitializeMemoryPointers">
		<xsl:element name="prg:label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">FF87</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RestoreIOVectors">
		<xsl:element name="prg:label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">FF8A</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetIOVectors">
		<xsl:element name="prg:label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">FF8D</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ControlKernelMessages">
		<xsl:element name="prg:label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">FE18</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ScanKeyboard">
		<xsl:element name="prg:label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">FF9F</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ReadIODeviceBaseAddress">
		<xsl:element name="prg:label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">FFF3</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:NonMaskableInterrupt">
		<xsl:element name="prg:label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">FFFA</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Reset">
		<xsl:element name="prg:label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">FFFC</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Interrupt">
		<xsl:element name="prg:label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">FFFE</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:WriteCharacterToScreen">
		<xsl:element name="prg:label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">E716</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetCharacterFromKeyboard">
		<xsl:element name="prg:label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">F13E</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ReadStringCharacter">
		<xsl:element name="prg:label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">FFCF</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:WriteCharacter">
		<xsl:element name="prg:label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">FFD2</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ReadCharacter">
		<xsl:element name="prg:label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">FFE4</xsl:attribute>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>