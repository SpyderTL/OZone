<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ns="http://metalx.org/Pc/Pata/DriveIdentity" xmlns:prg="http://metalx.org/Program">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="ns:Configuration">
		<xsl:element name="prg:hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TrackCount">
		<xsl:element name="prg:hex">02</xsl:element>
	</xsl:template>
	<xsl:template match="ns:HeadCount">
		<xsl:element name="prg:hex">06</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SectorCount">
		<xsl:element name="prg:hex">0C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SerialNumber">
		<xsl:element name="prg:hex">14</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BufferSize">
		<xsl:element name="prg:hex">2A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FirmwareVersion">
		<xsl:element name="prg:hex">2E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ModelNumber">
		<xsl:element name="prg:hex">36</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultipleReadWriteSupport">
		<xsl:element name="prg:hex">5E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DoublewordTransferSupport">
		<xsl:element name="prg:hex">60</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Capabilities">
		<xsl:element name="prg:hex">62</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SecurityMode">
		<xsl:element name="prg:hex">64</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PioDataTransferTiming">
		<xsl:element name="prg:hex">66</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DmaDataTransferTiming">
		<xsl:element name="prg:hex">68</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FieldValidity">
		<xsl:element name="prg:hex">6A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LogicalTrackCount">
		<xsl:element name="prg:hex">6C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LogicalHeadCount">
		<xsl:element name="prg:hex">6E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LogicalSecorCount">
		<xsl:element name="prg:hex">70</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CurrentSectorCapacity">
		<xsl:element name="prg:hex">72</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MutipleSectorSupport">
		<xsl:element name="prg:hex">76</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TotalSectorCount">
		<xsl:element name="prg:hex">78</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DmaTransferModes">
		<xsl:element name="prg:hex">7C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiwordDmaTransferModes">
		<xsl:element name="prg:hex">7E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PioFlowControlTransferModes">
		<xsl:element name="prg:hex">80</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiwordDmaTransferTimeMinimum">
		<xsl:element name="prg:hex">82</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiwordDmaTransferTimeRecommended">
		<xsl:element name="prg:hex">84</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PioTransferTimeMinimum">
		<xsl:element name="prg:hex">86</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PioFlowControlTransferTimeMinimum">
		<xsl:element name="prg:hex">88</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CommandQueue">
		<xsl:element name="prg:hex">92</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MajorRevision">
		<xsl:element name="prg:hex">A0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MinorRevision">
		<xsl:element name="prg:hex">A2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FeatureSet1Support">
		<xsl:element name="prg:hex">A4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FeatureSet2Support">
		<xsl:element name="prg:hex">A6</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FeatureSetSupportExtension">
		<xsl:element name="prg:hex">A8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FeatureSet1Enabled">
		<xsl:element name="prg:hex">AA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FeatureSet2Enabled">
		<xsl:element name="prg:hex">AC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FeatureSetEnabledExtension">
		<xsl:element name="prg:hex">AE</xsl:element>
	</xsl:template>
</xsl:stylesheet>