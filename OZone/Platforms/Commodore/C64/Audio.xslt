<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:ns="http://metalx.org/Commodore64/Audio" xmlns:prg="http://metalx.org/Program" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="ns:Channel0FrequencyLow">
		<xsl:element name="prg:label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">D400</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel0FrequencyHigh">
		<xsl:element name="prg:label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">D401</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel0PulseWaveDutyCycleLow">
		<xsl:element name="prg:label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">D402</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel0PulseWaveDutyCycleHigh">
		<xsl:element name="prg:label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">D403</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel0Control">
		<xsl:element name="prg:label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">D404</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel0AttackDelay">
		<xsl:element name="prg:label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">D405</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel0SustainRelease">
		<xsl:element name="prg:label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">D406</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel1FrequencyLow">
		<xsl:element name="prg:label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">D407</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel1FrequencyHigh">
		<xsl:element name="prg:label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">D408</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel1PulseWaveDutyCycleLow">
		<xsl:element name="prg:label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">D409</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel1PulseWaveDutyCycleHigh">
		<xsl:element name="prg:label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">D40A</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel1Control">
		<xsl:element name="prg:label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">D40B</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel1AttackDelay">
		<xsl:element name="prg:label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">D40C</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel1SustainRelease">
		<xsl:element name="prg:label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">D40D</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel2FrequencyLow">
		<xsl:element name="prg:label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">D40E</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel2FrequencyHigh">
		<xsl:element name="prg:label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">D40F</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel2PulseWaveDutyCycleLow">
		<xsl:element name="prg:label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">D410</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel2PulseWaveDutyCycleHigh">
		<xsl:element name="prg:label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">D411</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel2Control">
		<xsl:element name="prg:label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">D412</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel2AttackDelay">
		<xsl:element name="prg:label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">D413</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel2SustainRelease">
		<xsl:element name="prg:label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">D414</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FilterCutoffFrequencyLow">
		<xsl:element name="prg:label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">D415</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FilterCutoffFrequencyHigh">
		<xsl:element name="prg:label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">D416</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FilterControl">
		<xsl:element name="prg:label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">D417</xsl:attribute>
		</xsl:element>
	</xsl:template>
	<xsl:template match="ns:VolumeControl">
		<xsl:element name="prg:label">
			<xsl:attribute name="id">
				<xsl:value-of select="@id" />
			</xsl:attribute>
			<xsl:attribute name="offset">D418</xsl:attribute>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>