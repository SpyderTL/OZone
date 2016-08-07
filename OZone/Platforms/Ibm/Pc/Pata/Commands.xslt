<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ns="http://metalx.org/Pc/Pata/Commands" xmlns:prg="http://metalx.org/Program">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="ns:NoOperation">
		<xsl:element name="prg:hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ResetDevice">
		<xsl:element name="prg:hex">08</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Recalibrate">
		<xsl:element name="prg:hex">10</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ReadSectorsAndRetry">
		<xsl:element name="prg:hex">20</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ReadSectors">
		<xsl:element name="prg:hex">21</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ReadLongAndRetry">
		<xsl:element name="prg:hex">22</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ReadLong">
		<xsl:element name="prg:hex">23</xsl:element>
	</xsl:template>
	<xsl:template match="ns:WriteSectorsAndRetry">
		<xsl:element name="prg:hex">30</xsl:element>
	</xsl:template>
	<xsl:template match="ns:WriteSectors">
		<xsl:element name="prg:hex">31</xsl:element>
	</xsl:template>
	<xsl:template match="ns:WriteLongAndRetry">
		<xsl:element name="prg:hex">32</xsl:element>
	</xsl:template>
	<xsl:template match="ns:WriteLong">
		<xsl:element name="prg:hex">33</xsl:element>
	</xsl:template>
	<xsl:template match="ns:WriteVerify">
		<xsl:element name="prg:hex">3C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ReadVerifySectorsAndAndRetry">
		<xsl:element name="prg:hex">40</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ReadVerifySectors">
		<xsl:element name="prg:hex">41</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FormatTrack">
		<xsl:element name="prg:hex">50</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Seek">
		<xsl:element name="prg:hex">70</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExecuteDiagnostics">
		<xsl:element name="prg:hex">90</xsl:element>
	</xsl:template>
	<xsl:template match="ns:InitializeDriveParameters">
		<xsl:element name="prg:hex">91</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DownloadMicrocode">
		<xsl:element name="prg:hex">92</xsl:element>
	</xsl:template>
	<xsl:template match="ns:StandbyImmediate">
		<xsl:element name="prg:hex">94</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IdleImmediate">
		<xsl:element name="prg:hex">95</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Standby">
		<xsl:element name="prg:hex">96</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Idle">
		<xsl:element name="prg:hex">97</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CheckPowerMode">
		<xsl:element name="prg:hex">98</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetSleepMode">
		<xsl:element name="prg:hex">99</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Packet">
		<xsl:element name="prg:hex">A0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IdentifyAtapi">
		<xsl:element name="prg:hex">A1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SelfMonitor">
		<xsl:element name="prg:hex">B0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ReadMultiple">
		<xsl:element name="prg:hex">C4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:WriteMultiple">
		<xsl:element name="prg:hex">C5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetMultipleMode">
		<xsl:element name="prg:hex">C6</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ReadDmaOQ">
		<xsl:element name="prg:hex">C7</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ReadDmaAndRetry">
		<xsl:element name="prg:hex">C8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ReadDma">
		<xsl:element name="prg:hex">C9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:WriteDmaAndRetry">
		<xsl:element name="prg:hex">CA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:WriteDma">
		<xsl:element name="prg:hex">CB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:WriteDmaOQ">
		<xsl:element name="prg:hex">CC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetMediaStatus">
		<xsl:element name="prg:hex">DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AcknowledgeMediaChange">
		<xsl:element name="prg:hex">DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PostBoot">
		<xsl:element name="prg:hex">DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PreBoot">
		<xsl:element name="prg:hex">DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DoorLock">
		<xsl:element name="prg:hex">DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DoorUnlock">
		<xsl:element name="prg:hex">DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ReadBuffer">
		<xsl:element name="prg:hex">E4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:WriteBuffer">
		<xsl:element name="prg:hex">E8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:WriteSame">
		<xsl:element name="prg:hex">E9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SecureDisable">
		<xsl:element name="prg:hex">EA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SecureLock">
		<xsl:element name="prg:hex">EA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SecureState">
		<xsl:element name="prg:hex">EA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SecureEnableWriteProtect">
		<xsl:element name="prg:hex">EA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SecureEnable">
		<xsl:element name="prg:hex">EB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SecureUnlock">
		<xsl:element name="prg:hex">EB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IdentifyDrive">
		<xsl:element name="prg:hex">EC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MediaEject">
		<xsl:element name="prg:hex">ED</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IdentifyDeviceDma">
		<xsl:element name="prg:hex">EE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetFeatures">
		<xsl:element name="prg:hex">EF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SecuritySetPassword">
		<xsl:element name="prg:hex">F1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SecurityUnlock">
		<xsl:element name="prg:hex">F2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SecurityErasePrepare">
		<xsl:element name="prg:hex">F3</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SecurityEraseUnit">
		<xsl:element name="prg:hex">F4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SecurityFreezeLock">
		<xsl:element name="prg:hex">F5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SecurityDisablePassword">
		<xsl:element name="prg:hex">F6</xsl:element>
	</xsl:template>
</xsl:stylesheet>