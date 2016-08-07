<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:ns="http://metalx.org/Creative/SoundBlaster/Mixer" xmlns:prg="http://metalx.org/Program" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="ns:Reset">
		<xsl:element name="prg:hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LegacyVoiceVolume">
		<xsl:element name="prg:hex">04</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LegacyMasterVolume">
		<xsl:element name="prg:hex">22</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LegacyMidiVolume">
		<xsl:element name="prg:hex">26</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LegacyCdVolume">
		<xsl:element name="prg:hex">28</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LegacyLineVolume">
		<xsl:element name="prg:hex">2e</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LegacyMicVolume">
		<xsl:element name="prg:hex">0a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MasterVolumeLeft">
		<xsl:element name="prg:hex">30</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MasterVolumeRight">
		<xsl:element name="prg:hex">31</xsl:element>
	</xsl:template>
	<xsl:template match="ns:VoiceVolumeLeft">
		<xsl:element name="prg:hex">32</xsl:element>
	</xsl:template>
	<xsl:template match="ns:VoiceVolumeRight">
		<xsl:element name="prg:hex">33</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MidiVolumeLeft">
		<xsl:element name="prg:hex">34</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MidiVolumeRight">
		<xsl:element name="prg:hex">35</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CdVolumeLeft">
		<xsl:element name="prg:hex">36</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CdVolumeRight">
		<xsl:element name="prg:hex">37</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LineVolumeLeft">
		<xsl:element name="prg:hex">38</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LineVolumeRight">
		<xsl:element name="prg:hex">39</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MicVolume">
		<xsl:element name="prg:hex">3a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PcSpeakerVolume">
		<xsl:element name="prg:hex">3b</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OutputMixer">
		<xsl:element name="prg:hex">3c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:InputMixerLeft">
		<xsl:element name="prg:hex">3d</xsl:element>
	</xsl:template>
	<xsl:template match="ns:InputMixerRight">
		<xsl:element name="prg:hex">3e</xsl:element>
	</xsl:template>
	<xsl:template match="ns:InputGainLeft">
		<xsl:element name="prg:hex">3f</xsl:element>
	</xsl:template>
	<xsl:template match="ns:InputGainRight">
		<xsl:element name="prg:hex">40</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OutputGainLeft">
		<xsl:element name="prg:hex">41</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OutputGainRight">
		<xsl:element name="prg:hex">42</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MicAutoGain">
		<xsl:element name="prg:hex">43</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TrebleLeft">
		<xsl:element name="prg:hex">44</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TrebleRight">
		<xsl:element name="prg:hex">45</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BassLeft">
		<xsl:element name="prg:hex">46</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BassRight">
		<xsl:element name="prg:hex">47</xsl:element>
	</xsl:template>
	<xsl:template match="ns:InterruptSetup">
		<xsl:element name="prg:hex">80</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DmaSetup">
		<xsl:element name="prg:hex">81</xsl:element>
	</xsl:template>
	<xsl:template match="ns:InterruptStatus">
		<xsl:element name="prg:hex">82</xsl:element>
	</xsl:template>
</xsl:stylesheet>