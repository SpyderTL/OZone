<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:ns="http://metalx.org/Intel/Pxe/Status" xmlns:prg="http://metalx.org/Program" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="ns:ExitSuccess">
		<xsl:element name="prg:hex">0000</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExitFailure">
		<xsl:element name="prg:hex">0001</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Success">
		<xsl:element name="prg:hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Failure">
		<xsl:element name="prg:hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BadFunctionNumber">
		<xsl:element name="prg:hex">02</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FunctionNotSupported">
		<xsl:element name="prg:hex">03</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DoNotUnloadUniversalNetwork">
		<xsl:element name="prg:hex">04</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DoNotUnload">
		<xsl:element name="prg:hex">05</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OutOfResources">
		<xsl:element name="prg:hex">06</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ArpTimeout">
		<xsl:element name="prg:hex">11</xsl:element>
	</xsl:template>
	<xsl:template match="ns:UdpClosed">
		<xsl:element name="prg:hex">18</xsl:element>
	</xsl:template>
	<xsl:template match="ns:UdpOpen">
		<xsl:element name="prg:hex">19</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TftpClosed">
		<xsl:element name="prg:hex">1a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TftpOpen">
		<xsl:element name="prg:hex">1b</xsl:element>
	</xsl:template>
	<xsl:template match="ns:McopyProblem">
		<xsl:element name="prg:hex">20</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BisIntegrityFailure">
		<xsl:element name="prg:hex">21</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BisValidateFailure">
		<xsl:element name="prg:hex">22</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BisInitializationFailure">
		<xsl:element name="prg:hex">23</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BisShutdownFailure">
		<xsl:element name="prg:hex">24</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BisGboaFailure">
		<xsl:element name="prg:hex">25</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BisFreeFailure">
		<xsl:element name="prg:hex">26</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BisGsiFailure">
		<xsl:element name="prg:hex">27</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BisBadChecksum">
		<xsl:element name="prg:hex">28</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TftpArpAddressFailure">
		<xsl:element name="prg:hex">30</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TftpOpenTimeout">
		<xsl:element name="prg:hex">32</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TftpUnknownOperator">
		<xsl:element name="prg:hex">33</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TftpReadTimeout">
		<xsl:element name="prg:hex">35</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TftpOperatorError">
		<xsl:element name="prg:hex">36</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TftpOpenConnectionError">
		<xsl:element name="prg:hex">38</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TftpReadError">
		<xsl:element name="prg:hex">39</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TftpTooManyPackets">
		<xsl:element name="prg:hex">3a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TftpFileNotFound">
		<xsl:element name="prg:hex">3b</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TftpAccessViolation">
		<xsl:element name="prg:hex">3c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TftpNoMulticastAddress">
		<xsl:element name="prg:hex">3d</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TftpNoFileSize">
		<xsl:element name="prg:hex">3e</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TftpInvalidPacketSize">
		<xsl:element name="prg:hex">3f</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DhcpTimeout">
		<xsl:element name="prg:hex">51</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DhcpNoIpAddress">
		<xsl:element name="prg:hex">52</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DhcpNoBootfileName">
		<xsl:element name="prg:hex">53</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DhcpBadIpAddress">
		<xsl:element name="prg:hex">54</xsl:element>
	</xsl:template>
	<xsl:template match="ns:UniversalNetworkInvalidFunction">
		<xsl:element name="prg:hex">60</xsl:element>
	</xsl:template>
	<xsl:template match="ns:UniversalNetworkMediatestFailed">
		<xsl:element name="prg:hex">61</xsl:element>
	</xsl:template>
	<xsl:template match="ns:UniversalNetworkMulticastInitializationError">
		<xsl:element name="prg:hex">62</xsl:element>
	</xsl:template>
	<xsl:template match="ns:UniversalNetworkAdapterInitializationError">
		<xsl:element name="prg:hex">63</xsl:element>
	</xsl:template>
	<xsl:template match="ns:UniversalNetworkLinkInitializationError">
		<xsl:element name="prg:hex">64</xsl:element>
	</xsl:template>
	<xsl:template match="ns:UniversalNetworkConfigurationReadError">
		<xsl:element name="prg:hex">65</xsl:element>
	</xsl:template>
	<xsl:template match="ns:UniversalNetworkInitializationReadError">
		<xsl:element name="prg:hex">66</xsl:element>
	</xsl:template>
	<xsl:template match="ns:UniversalNetworkBadMacAddress">
		<xsl:element name="prg:hex">67</xsl:element>
	</xsl:template>
	<xsl:template match="ns:UniversalNetworkBadEepromChecksum">
		<xsl:element name="prg:hex">68</xsl:element>
	</xsl:template>
	<xsl:template match="ns:UniversalNetworkErrorSettingInterruptServiceRoutine">
		<xsl:element name="prg:hex">69</xsl:element>
	</xsl:template>
	<xsl:template match="ns:UniversalNetworkInvalidState">
		<xsl:element name="prg:hex">6a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:UniversalNetworkTransmitError">
		<xsl:element name="prg:hex">6b</xsl:element>
	</xsl:template>
	<xsl:template match="ns:UniversalNetworkInvalidParameter">
		<xsl:element name="prg:hex">6c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BootstrapPromptMenu">
		<xsl:element name="prg:hex">74</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BootstrapMulticastAddress">
		<xsl:element name="prg:hex">76</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BootstrapMissingList">
		<xsl:element name="prg:hex">77</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BootstrapNoResponse">
		<xsl:element name="prg:hex">78</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BootstrapFileTooBig">
		<xsl:element name="prg:hex">79</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CanceledByKeystroke">
		<xsl:element name="prg:hex">a0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:NoPxeServer">
		<xsl:element name="prg:hex">a1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:NotAvailableInProtectedMode">
		<xsl:element name="prg:hex">a2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:NotAvailableInRealMode">
		<xsl:element name="prg:hex">a3</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DeviceNotSupported">
		<xsl:element name="prg:hex">b0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:NoFreeBaseMemory">
		<xsl:element name="prg:hex">c0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:NoRomID">
		<xsl:element name="prg:hex">c1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BadRomID">
		<xsl:element name="prg:hex">c2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BadRuntimeImage">
		<xsl:element name="prg:hex">c3</xsl:element>
	</xsl:template>
	<xsl:template match="ns:NoUniversalNetworkRomID">
		<xsl:element name="prg:hex">c4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BadUniversalNetworkRomID">
		<xsl:element name="prg:hex">c5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BadUniversalNetworkDriverImage">
		<xsl:element name="prg:hex">c6</xsl:element>
	</xsl:template>
	<xsl:template match="ns:NoPxeStructure">
		<xsl:element name="prg:hex">c8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:NoPxenvStructure">
		<xsl:element name="prg:hex">c9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:UniversalNetworkDriverStart">
		<xsl:element name="prg:hex">ca</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Start">
		<xsl:element name="prg:hex">cb</xsl:element>
	</xsl:template>
</xsl:stylesheet>