<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:pcs="http://metalx.org/Amd/PcNet/ControlStatus"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="xml" indent="yes" />

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="pcs:ControlAndStatus">
		<xsl:element name="hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:InitializationAddress0">
		<xsl:element name="hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:InitializationAddress1">
		<xsl:element name="hex">02</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:InterruptMaskAndDeferral">
		<xsl:element name="hex">03</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:TestAndFeatureControl">
		<xsl:element name="hex">04</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:ExtendedControlAndInterrupt1">
		<xsl:element name="hex">05</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:DescriptorTableLengths">
		<xsl:element name="hex">06</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:ExtendedControlAndInterrupt2">
		<xsl:element name="hex">07</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:LogicalAddressFilter0">
		<xsl:element name="hex">08</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:LogicalAddressFilter1">
		<xsl:element name="hex">09</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:LogicalAddressFilter2">
		<xsl:element name="hex">0a</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:LogicalAddressFilter3">
		<xsl:element name="hex">0b</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:PhysicalAddress0">
		<xsl:element name="hex">0c</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:PhysicalAddress1">
		<xsl:element name="hex">0d</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:PhysicalAddress2">
		<xsl:element name="hex">0e</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:Mode">
		<xsl:element name="hex">0f</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:InitializationAddressLower">
		<xsl:element name="hex">10</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:InitializationAddressUpper">
		<xsl:element name="hex">11</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:CurrentReceiveBufferLower">
		<xsl:element name="hex">12</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:CurrentReceiveBufferUpper">
		<xsl:element name="hex">13</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:CurrentTransmitBufferLower">
		<xsl:element name="hex">14</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:CurrentTransmitBufferUpper">
		<xsl:element name="hex">15</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:NextReceiveBufferLower">
		<xsl:element name="hex">16</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:NextReceiveBufferUpper">
		<xsl:element name="hex">17</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:ReceiveRingLower">
		<xsl:element name="hex">18</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:ReceiveRingUpper">
		<xsl:element name="hex">19</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:NextReceiveDescriptorLower">
		<xsl:element name="hex">1a</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:NextReceiveDescriptorUpper">
		<xsl:element name="hex">1b</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:CurrentReceiveDescriptorLower">
		<xsl:element name="hex">1c</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:CurrentReceiveDescriptorUpper">
		<xsl:element name="hex">1d</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:TransmitRingLower">
		<xsl:element name="hex">1e</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:TransmitRingUpper">
		<xsl:element name="hex">1f</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:NextTransmitDescriptorLower">
		<xsl:element name="hex">20</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:NextTransmitDescriptorUpper">
		<xsl:element name="hex">21</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:CurrentTransmitDescriptorLower">
		<xsl:element name="hex">22</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:CurrentTransmitDescriptorUpper">
		<xsl:element name="hex">23</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:NextNextReceiveDescriptorLower">
		<xsl:element name="hex">24</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:NextNextReceiveDescriptorUpper">
		<xsl:element name="hex">25</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:NextNextTransmitDescriptorLower">
		<xsl:element name="hex">26</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:NextNextTransmitDescriptorUpper">
		<xsl:element name="hex">27</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:CurrentReceivedByteCount">
		<xsl:element name="hex">28</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:CurrentReceiveStatus">
		<xsl:element name="hex">29</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:TransmitByteCount">
		<xsl:element name="hex">2a</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:TransmitStatus">
		<xsl:element name="hex">2b</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:NextReceivedByteCount">
		<xsl:element name="hex">2c</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:NextReceiveStatus">
		<xsl:element name="hex">2d</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:TransmitPollCounter">
		<xsl:element name="hex">2e</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:TransmitPollInterval">
		<xsl:element name="hex">2f</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:ReceivePollCounter">
		<xsl:element name="hex">30</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:ReceivePollInterval">
		<xsl:element name="hex">31</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:SoftwareStyle">
		<xsl:element name="hex">3a</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:PreviousTransmitDescriptorLower">
		<xsl:element name="hex">3c</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:PreviousTransmitDescriptorUpper">
		<xsl:element name="hex">3d</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:PreviousTransmitByteCount">
		<xsl:element name="hex">3e</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:PreviousTransmitStatus">
		<xsl:element name="hex">3f</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:NextTransmitBufferLower">
		<xsl:element name="hex">40</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:NextTransmitBufferUpper">
		<xsl:element name="hex">41</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:NextTransmitByteCount">
		<xsl:element name="hex">42</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:NextTransmitStatus">
		<xsl:element name="hex">43</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:ReceiveRingCounter">
		<xsl:element name="hex">48</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:TransmitRingCounter">
		<xsl:element name="hex">4a</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:ReceiveRingLength">
		<xsl:element name="hex">4c</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:TransmitRingLength">
		<xsl:element name="hex">4e</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:DmaTransferAndFifoThreshold">
		<xsl:element name="hex">50</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:TransmitDescriptorLower">
		<xsl:element name="hex">52</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:DmaRegisterLower">
		<xsl:element name="hex">54</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:DmaRegisterUpper">
		<xsl:element name="hex">55</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:BufferByteCounter">
		<xsl:element name="hex">56</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:ChipIDRegisterLower">
		<xsl:element name="hex">58</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:ChipIDRegisterUpper">
		<xsl:element name="hex">59</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:RingLengthConversion">
		<xsl:element name="hex">6c</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:BusTimeout">
		<xsl:element name="hex">64</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:MissedFrameCount">
		<xsl:element name="hex">70</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:ReceiveCollisionCount">
		<xsl:element name="hex">72</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:OnNowPowerMode">
		<xsl:element name="hex">74</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:AdvancedFeatures">
		<xsl:element name="hex">7a</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:TestRegister1">
		<xsl:element name="hex">7c</xsl:element>
	</xsl:template>
	<xsl:template match="pcs:MacEnhancedConfiguration">
		<xsl:element name="hex">7d</xsl:element>
	</xsl:template>
</xsl:stylesheet>