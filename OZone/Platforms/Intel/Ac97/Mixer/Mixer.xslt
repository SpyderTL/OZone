<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:ns="http://metalx.org/Intel/Ac97/Mixer" xmlns:prg="http://metalx.org/Program" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="ns:Reset">
		<xsl:element name="prg:hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MasterVolume">
		<xsl:element name="prg:hex">02</xsl:element>
	</xsl:template>
	<xsl:template match="ns:HeadphoneVolume">
		<xsl:element name="prg:hex">04</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MonoVolume">
		<xsl:element name="prg:hex">06</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MasterToneRightLeft">
		<xsl:element name="prg:hex">08</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PcSpeakerVolume">
		<xsl:element name="prg:hex">0a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PhonePolume">
		<xsl:element name="prg:hex">0c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MicrophoneVolume">
		<xsl:element name="prg:hex">0e</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LineInVolume">
		<xsl:element name="prg:hex">10</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CdVolume">
		<xsl:element name="prg:hex">12</xsl:element>
	</xsl:template>
	<xsl:template match="ns:VideoVolume">
		<xsl:element name="prg:hex">14</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AuxVolume">
		<xsl:element name="prg:hex">16</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PcmOutVolumeLeftRight">
		<xsl:element name="prg:hex">18</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RecordSelect">
		<xsl:element name="prg:hex">1a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RecordGain">
		<xsl:element name="prg:hex">1c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RecordGainMicrophone">
		<xsl:element name="prg:hex">1e</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GeneralPurpose">
		<xsl:element name="prg:hex">20</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Control3d">
		<xsl:element name="prg:hex">22</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Paging">
		<xsl:element name="prg:hex">24</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PowerDown">
		<xsl:element name="prg:hex">26</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExtendedAudioID">
		<xsl:element name="prg:hex">28</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExtendedAudio">
		<xsl:element name="prg:hex">2a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PcmOutRateLeftRight">
		<xsl:element name="prg:hex">2c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PcmOutRateSurround">
		<xsl:element name="prg:hex">2e</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PcmOutRateCenterSub">
		<xsl:element name="prg:hex">30</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PcmInRate">
		<xsl:element name="prg:hex">32</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PcmOutVolumeCenterSub">
		<xsl:element name="prg:hex">36</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PcmOutVolumeSurround">
		<xsl:element name="prg:hex">38</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SpdifControl">
		<xsl:element name="prg:hex">3a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:EqualizerControl">
		<xsl:element name="prg:hex">60</xsl:element>
	</xsl:template>
	<xsl:template match="ns:EqualizerData">
		<xsl:element name="prg:hex">62</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FeatureCsr1">
		<xsl:element name="prg:hex">6a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FeatureCsr2">
		<xsl:element name="prg:hex">6c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MiscellaneousControl2">
		<xsl:element name="prg:hex">70</xsl:element>
	</xsl:template>
	<xsl:template match="ns:JackSense">
		<xsl:element name="prg:hex">72</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SerialConfiguration">
		<xsl:element name="prg:hex">74</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MiscellaneousControl1">
		<xsl:element name="prg:hex">76</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AdvancedJackSense">
		<xsl:element name="prg:hex">78</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MiscellaneousControl3">
		<xsl:element name="prg:hex">7a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:VendorID1">
		<xsl:element name="prg:hex">7c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:VendorID2">
		<xsl:element name="prg:hex">7e</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CodecClassRevision">
		<xsl:element name="prg:hex">0601</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PciSvid">
		<xsl:element name="prg:hex">0621</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PciSid">
		<xsl:element name="prg:hex">0641</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FunctionSelect">
		<xsl:element name="prg:hex">0661</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FunctionInformation">
		<xsl:element name="prg:hex">0681</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SenseRegister">
		<xsl:element name="prg:hex">06a1</xsl:element>
	</xsl:template>
</xsl:stylesheet>