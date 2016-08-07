<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:ns="http://metalx.org/Intel/Ac97/BusMaster" xmlns:prg="http://metalx.org/Program" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="ns:PrimaryCodec">
		<xsl:element name="prg:hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SecondaryCodec">
		<xsl:element name="prg:hex">80</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TertiaryCodec">
		<xsl:element name="prg:hex">0100</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PcmInBufferListAddress">
		<xsl:element name="prg:hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PcmInCurrentIndex">
		<xsl:element name="prg:hex">04</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PcmInLastValidIndex">
		<xsl:element name="prg:hex">05</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PcmInStatus">
		<xsl:element name="prg:hex">06</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PcmInPositionInCurrentBuffer">
		<xsl:element name="prg:hex">08</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PcmInPrefetchIndex">
		<xsl:element name="prg:hex">0A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PcmInControl">
		<xsl:element name="prg:hex">0B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PcmOutBufferListAddress">
		<xsl:element name="prg:hex">10</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PcmOutCurrentIndex">
		<xsl:element name="prg:hex">14</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PcmOutLastValidIndex">
		<xsl:element name="prg:hex">15</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PcmOutStatus">
		<xsl:element name="prg:hex">16</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PcmOutPositionInCurrentBuffer">
		<xsl:element name="prg:hex">18</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PcmOutPrefetchIndex">
		<xsl:element name="prg:hex">1A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PcmOutControl">
		<xsl:element name="prg:hex">1B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MicrophoneBufferListAddress">
		<xsl:element name="prg:hex">20</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MicrophoneCurrentIndex">
		<xsl:element name="prg:hex">24</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MicrophoneLastValidIndex">
		<xsl:element name="prg:hex">25</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MicrophoneStatus">
		<xsl:element name="prg:hex">26</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MicrophonePositionInCurrentBuffer">
		<xsl:element name="prg:hex">28</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MicrophonePrefetchIndex">
		<xsl:element name="prg:hex">2A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MicrophoneControl">
		<xsl:element name="prg:hex">2B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GlobalControl">
		<xsl:element name="prg:hex">2C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GlobalStatus">
		<xsl:element name="prg:hex">30</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CodecAccessSemiphore">
		<xsl:element name="prg:hex">34</xsl:element>
	</xsl:template>
</xsl:stylesheet>