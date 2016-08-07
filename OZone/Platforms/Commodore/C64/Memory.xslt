<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:ns="http://metalx.org/Commodore64/Memory"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:output method="xml" indent="yes" />
	
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match="ns:SystemCharacterColor">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">0286</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SystemBackgroundCursorColor">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">0287</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SystemLowerCaseMode">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">0291</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:VideoBorderColor">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">D020</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:VideoBackgroundColor0">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">D021</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:VideoBackgroundColor1">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">D022</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:VideoBackgroundColor2">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">D023</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:VideoBackgroundColor3">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">D024</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:VideoCharacterSettings">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">D018</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:KernelInitializeScreenAndKeyboard">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">FF81</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:KernelInitializeIODevices">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">FF84</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:KernelInitializeMemoryPointers">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">FF87</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:KernelRestoreIOVectors">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">FF8A</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:KernelSetIOVectors">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">FF8D</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:KernelControlKernelMessages">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">FE18</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:KernelScanKeyboard">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">FF9F</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:KernelReadIODeviceBaseAddress">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">FFF3</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:KernelNonMaskableInterrupt">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">FFFA</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:KernelReset">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">FFFC</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:KernelInterrupt">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">FFFE</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:KernelWriteCharacterToScreen">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">E716</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:KernelGetCharacterFromKeyboard">
		<xsl:element name="label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">F13E</xsl:attribute>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>