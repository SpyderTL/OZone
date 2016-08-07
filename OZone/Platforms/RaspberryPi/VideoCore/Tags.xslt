<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:ns="http://metalx.org/RaspberryPi/VideoCore/Tags" xmlns:prg="http://metalx.org/Program" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="ns:GetFirmwareRevision">
		<xsl:element name="prg:hex">00000001</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetBoardModel">
		<xsl:element name="prg:hex">00010001</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetBoardRevision">
		<xsl:element name="prg:hex">00010002</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetBoardMacAddress">
		<xsl:element name="prg:hex">00010003</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetBoardSerial">
		<xsl:element name="prg:hex">00010004</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetArmMemory">
		<xsl:element name="prg:hex">00010005</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetVideoCoreMemory">
		<xsl:element name="prg:hex">00010006</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetClocks">
		<xsl:element name="prg:hex">00010007</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetCommandLine">
		<xsl:element name="prg:hex">00050001</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetDmaChannels">
		<xsl:element name="prg:hex">00060001</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetPowerState">
		<xsl:element name="prg:hex">00020001</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetTiming">
		<xsl:element name="prg:hex">00020002</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetPowerState">
		<xsl:element name="prg:hex">00028001</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetClockState">
		<xsl:element name="prg:hex">00030001</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetClockState">
		<xsl:element name="prg:hex">00038001</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetClockRate">
		<xsl:element name="prg:hex">00030002</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetClockRate">
		<xsl:element name="prg:hex">00038002</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetMaximumClockRate">
		<xsl:element name="prg:hex">00030004</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetMinimumClockRate">
		<xsl:element name="prg:hex">00030007</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetTurbo">
		<xsl:element name="prg:hex">00030009</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetTurbo">
		<xsl:element name="prg:hex">00038009</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetVoltage">
		<xsl:element name="prg:hex">00030003</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetVoltage">
		<xsl:element name="prg:hex">00038003</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetMaximumVoltage">
		<xsl:element name="prg:hex">00030005</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetMinimumVoltage">
		<xsl:element name="prg:hex">00030008</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetTemperature">
		<xsl:element name="prg:hex">00030006</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetMaximumTemperature">
		<xsl:element name="prg:hex">0003000A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AllocateMemory">
		<xsl:element name="prg:hex">0003000C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LockMemory">
		<xsl:element name="prg:hex">0003000D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:UnlockMemory">
		<xsl:element name="prg:hex">0003000E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ReleaseMemory">
		<xsl:element name="prg:hex">0003000F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExecuteCode">
		<xsl:element name="prg:hex">00030010</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetEdidBlock">
		<xsl:element name="prg:hex">00030020</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AllocateBuffer">
		<xsl:element name="prg:hex">00040001</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ReleaseBuffer">
		<xsl:element name="prg:hex">00048001</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BlankScreen">
		<xsl:element name="prg:hex">00040002</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetPhysicalDisplaySize">
		<xsl:element name="prg:hex">00040003</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TestPhysicalDisplaySize">
		<xsl:element name="prg:hex">00044003</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetPhysicalDisplaySize">
		<xsl:element name="prg:hex">00048003</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetVirtualDisplaySize">
		<xsl:element name="prg:hex">00040004</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TestVirtualDisplaySize">
		<xsl:element name="prg:hex">00044004</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetVirtualDisplaySize">
		<xsl:element name="prg:hex">00048004</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetDepth">
		<xsl:element name="prg:hex">00040005</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TestDepth">
		<xsl:element name="prg:hex">00044005</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetDepth">
		<xsl:element name="prg:hex">00048005</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetPixelOrder">
		<xsl:element name="prg:hex">00040006</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TestPixelOrder">
		<xsl:element name="prg:hex">00044006</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetPixelOrder">
		<xsl:element name="prg:hex">00048006</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetAlphaMode">
		<xsl:element name="prg:hex">00040007</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TestAlphaMode">
		<xsl:element name="prg:hex">00044007</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetAlphaMode">
		<xsl:element name="prg:hex">00048007</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetPitch">
		<xsl:element name="prg:hex">00040008</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetVirtualOffset">
		<xsl:element name="prg:hex">00040009</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TestVirtualOffset">
		<xsl:element name="prg:hex">00044009</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetVirtualOffset">
		<xsl:element name="prg:hex">00048009</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetOverscan">
		<xsl:element name="prg:hex">0004000a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TestOverscan">
		<xsl:element name="prg:hex">0004400a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetOverscan">
		<xsl:element name="prg:hex">0004800a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetPalette">
		<xsl:element name="prg:hex">0004000b</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TestPalette">
		<xsl:element name="prg:hex">0004400b</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetPalette">
		<xsl:element name="prg:hex">0004800b</xsl:element>
	</xsl:template>
</xsl:stylesheet>