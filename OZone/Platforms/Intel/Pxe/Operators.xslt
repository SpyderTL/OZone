<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:ns="http://metalx.org/Intel/Pxe/Operators" xmlns:prg="http://metalx.org/Program" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="ns:UnloadStack">
		<xsl:element name="prg:hex">0070</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetCachedInfo">
		<xsl:element name="prg:hex">0071</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RestartTftp">
		<xsl:element name="prg:hex">0073</xsl:element>
	</xsl:template>
	<xsl:template match="ns:StartUniversalNetworkDriver">
		<xsl:element name="prg:hex">0000</xsl:element>
	</xsl:template>
	<xsl:template match="ns:StopUniversalNetworkDriver">
		<xsl:element name="prg:hex">0015</xsl:element>
	</xsl:template>
	<xsl:template match="ns:StartBase">
		<xsl:element name="prg:hex">0075</xsl:element>
	</xsl:template>
	<xsl:template match="ns:StopBase">
		<xsl:element name="prg:hex">0076</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OpenTftpConnection">
		<xsl:element name="prg:hex">0020</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CloseTftpConnection">
		<xsl:element name="prg:hex">0021</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ReadTftpPacket">
		<xsl:element name="prg:hex">0022</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ReadTftpFile">
		<xsl:element name="prg:hex">0023</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetTftpFileSize">
		<xsl:element name="prg:hex">0025</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OpenUdpConnection">
		<xsl:element name="prg:hex">0030</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CloseUdpConnection">
		<xsl:element name="prg:hex">0031</xsl:element>
	</xsl:template>
	<xsl:template match="ns:WriteUdpPacket">
		<xsl:element name="prg:hex">0033</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ReadUdpPacket">
		<xsl:element name="prg:hex">0032</xsl:element>
	</xsl:template>
	<xsl:template match="ns:StartUniversalNetwork">
		<xsl:element name="prg:hex">0001</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CleanupUniversalNetwork">
		<xsl:element name="prg:hex">0002</xsl:element>
	</xsl:template>
	<xsl:template match="ns:InitializeUniversalNetwork">
		<xsl:element name="prg:hex">0003</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ResetUniversalNetworkAdapter">
		<xsl:element name="prg:hex">0004</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShutdownUniversalNetwork">
		<xsl:element name="prg:hex">0005</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OpenUniversalNetwork">
		<xsl:element name="prg:hex">0006</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CloseUniversalNetwork">
		<xsl:element name="prg:hex">0007</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TransmitUniversalNetworkPacket">
		<xsl:element name="prg:hex">0008</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetUniversalNetworkMulticastAddress">
		<xsl:element name="prg:hex">0009</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetUniversalNetworkStationAddress">
		<xsl:element name="prg:hex">000a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetUniversalNetworkPacketFilter">
		<xsl:element name="prg:hex">000b</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetUniversalNetworkInformation">
		<xsl:element name="prg:hex">000c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetUniversalNetworkStatistics">
		<xsl:element name="prg:hex">000d</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ClearUniversalNetworkStatistics">
		<xsl:element name="prg:hex">000e</xsl:element>
	</xsl:template>
	<xsl:template match="ns:InitiateUniversalNetworkDiagnostics">
		<xsl:element name="prg:hex">000f</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ForceUniversalNetworkInterrupt">
		<xsl:element name="prg:hex">0010</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetUniversalNetworkMulticastAddress">
		<xsl:element name="prg:hex">0011</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetUniversalNetworkAdapterType">
		<xsl:element name="prg:hex">0012</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetUniversalNetworkInterfaceInformation">
		<xsl:element name="prg:hex">0013</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetUniversalNetworkState">
		<xsl:element name="prg:hex">0015</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExecuteInterruptServiceRoutine">
		<xsl:element name="prg:hex">0014</xsl:element>
	</xsl:template>
</xsl:stylesheet>