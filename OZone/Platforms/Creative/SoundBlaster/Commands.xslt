<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:sbc="http://metalx.org/Creative/SoundBlaster/Commands">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="sbc:OutputPcm8">
		<xsl:element name="hex">10</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:InputPcm8">
		<xsl:element name="hex">20</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:SetTimeConstant">
		<xsl:element name="hex">40</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:DmaOutputPcm8">
		<xsl:element name="hex">14</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:DmaInputPcm8">
		<xsl:element name="hex">24</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:DmaOutputAdpcm4">
		<xsl:element name="hex">74</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:DmaOutputAdpcmReference4">
		<xsl:element name="hex">75</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:DmaOutputAdpcm3">
		<xsl:element name="hex">76</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:DmaOutputAdpcmReference3">
		<xsl:element name="hex">77</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:DmaOutputAdpcm2">
		<xsl:element name="hex">16</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:DmaOutputAdpcmReference2">
		<xsl:element name="hex">17</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:PauseDma">
		<xsl:element name="hex">D0</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:ResumeDma">
		<xsl:element name="hex">D4</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:SpeakerOn">
		<xsl:element name="hex">D1</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:SpeakerOff">
		<xsl:element name="hex">D3</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:InputMidiPolling">
		<xsl:element name="hex">30</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:InputMidiInterrupt">
		<xsl:element name="hex">31</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:OutputMidi">
		<xsl:element name="hex">38</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:PauseDsp">
		<xsl:element name="hex">80</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:GetDspVersion">
		<xsl:element name="hex">E1</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:AutoDmaOutputPcm8">
		<xsl:element name="hex">1C</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:AutoDmaInputPcm8">
		<xsl:element name="hex">2C</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:AutoDmaOutputAdpcmReference4">
		<xsl:element name="hex">7D</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:AutoDmaOutputAdpcmReference3">
		<xsl:element name="hex">7F</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:AutoDmaOutputAdpcmReference2">
		<xsl:element name="hex">1F</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:StopAutoDma8">
		<xsl:element name="hex">DA</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:SetBlockTransferSize">
		<xsl:element name="hex">48</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:UartMidiPolling">
		<xsl:element name="hex">34</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:UartMidiInterrupt">
		<xsl:element name="hex">35</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:UartMidiPollingTimeStamp">
		<xsl:element name="hex">36</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:UartMidiInterruptTimeStamp">
		<xsl:element name="hex">37</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:GetSpeakerStatus">
		<xsl:element name="hex">D8</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:FastAutoDmaOutputPcm8">
		<xsl:element name="hex">90</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:FastAutoDmaInputPcm8">
		<xsl:element name="hex">98</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:FastDmaOutputPcm8">
		<xsl:element name="hex">91</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:FastDmaInputPcm8">
		<xsl:element name="hex">99</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:SetMonoMode">
		<xsl:element name="hex">A0</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:SetStereoMode">
		<xsl:element name="hex">A8</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:SetOutputSampleRate">
		<xsl:element name="hex">41</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:SetInputSampleRate">
		<xsl:element name="hex">42</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:ProgramDma8">
		<xsl:element name="hex">C0</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:ProgramDma16">
		<xsl:element name="hex">B0</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:ProgramInput">
		<xsl:element name="hex">08</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:ProgramAutoDma">
		<xsl:element name="hex">04</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:ProgramFifo">
		<xsl:element name="hex">02</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:ModeStereo">
		<xsl:element name="hex">20</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:ModeSigned">
		<xsl:element name="hex">10</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:PauseDma16">
		<xsl:element name="hex">D5</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:ResumeDma16">
		<xsl:element name="hex">D6</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:StopAutoDma16">
		<xsl:element name="hex">D9</xsl:element>
	</xsl:template>
	<xsl:template match="sbc:ReadyFlag">
		<xsl:element name="hex">80</xsl:element>
	</xsl:template>
</xsl:stylesheet>