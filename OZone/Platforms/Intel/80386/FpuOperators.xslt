<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:ns="http://metalx.org/Intel/80386/FpuOperators" xmlns:prg="http://metalx.org/Program" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="ns:AddFloatAtAXAddressToST0">
		<xsl:element name="prg:hex">00D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddFloatAtCXAddressToST0">
		<xsl:element name="prg:hex">01D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddFloatAtDXAddressToST0">
		<xsl:element name="prg:hex">02D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddFloatAtBXAddressToST0">
		<xsl:element name="prg:hex">03D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddFloatAtIndexAddressToST0">
		<xsl:element name="prg:hex">04D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddFloatAtImmediateAddressToST0">
		<xsl:element name="prg:hex">05D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddFloatAtSIAddressToST0">
		<xsl:element name="prg:hex">06D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddFloatAtDIAddressToST0">
		<xsl:element name="prg:hex">07D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddFloatAtAXAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">40D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddFloatAtCXAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">41D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddFloatAtDXAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">42D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddFloatAtBXAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">43D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddFloatAtIndexAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">44D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddFloatAtImmediateAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">45D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddFloatAtSIAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">46D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddFloatAtDIAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">47D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddFloatAtAXAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">80D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddFloatAtCXAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">81D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddFloatAtDXAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">82D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddFloatAtBXAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">83D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddFloatAtIndexAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">84D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddFloatAtImmediateAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">85D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddFloatAtSIAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">86D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddFloatAtDIAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">87D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddST0ToST0">
		<xsl:element name="prg:hex">C0D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddST1ToST0">
		<xsl:element name="prg:hex">C1D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddST2ToST0">
		<xsl:element name="prg:hex">C2D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddST3ToST0">
		<xsl:element name="prg:hex">C3D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddST4ToST0">
		<xsl:element name="prg:hex">C4D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddST5ToST0">
		<xsl:element name="prg:hex">C5D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddST6ToST0">
		<xsl:element name="prg:hex">C6D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddST7ToST0">
		<xsl:element name="prg:hex">C7D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST0ByFloatAtAXAddress">
		<xsl:element name="prg:hex">00D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST0ByFloatAtCXAddress">
		<xsl:element name="prg:hex">01D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST0ByFloatAtDXAddress">
		<xsl:element name="prg:hex">02D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST0ByFloatAtBXAddress">
		<xsl:element name="prg:hex">03D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST0ByFloatAtIndexAddress">
		<xsl:element name="prg:hex">04D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST0ByFloatAtImmediateAddress">
		<xsl:element name="prg:hex">05D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST0ByFloatAtSIAddress">
		<xsl:element name="prg:hex">06D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST0ByFloatAtDIAddress">
		<xsl:element name="prg:hex">07D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST0ByFloatAtAXAddressPlusImmediate8">
		<xsl:element name="prg:hex">40D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST0ByFloatAtCXAddressPlusImmediate8">
		<xsl:element name="prg:hex">41D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST0ByFloatAtDXAddressPlusImmediate8">
		<xsl:element name="prg:hex">42D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST0ByFloatAtBXAddressPlusImmediate8">
		<xsl:element name="prg:hex">43D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST0ByFloatAtIndexAddressPlusImmediate8">
		<xsl:element name="prg:hex">44D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST0ByFloatAtImmediateAddressPlusImmediate8">
		<xsl:element name="prg:hex">45D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST0ByFloatAtSIAddressPlusImmediate8">
		<xsl:element name="prg:hex">46D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST0ByFloatAtDIAddressPlusImmediate8">
		<xsl:element name="prg:hex">47D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST0ByFloatAtAXAddressPlusImmediate32">
		<xsl:element name="prg:hex">80D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST0ByFloatAtCXAddressPlusImmediate32">
		<xsl:element name="prg:hex">81D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST0ByFloatAtDXAddressPlusImmediate32">
		<xsl:element name="prg:hex">82D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST0ByFloatAtBXAddressPlusImmediate32">
		<xsl:element name="prg:hex">83D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST0ByFloatAtIndexAddressPlusImmediate32">
		<xsl:element name="prg:hex">84D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST0ByFloatAtImmediateAddressPlusImmediate32">
		<xsl:element name="prg:hex">85D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST0ByFloatAtSIAddressPlusImmediate32">
		<xsl:element name="prg:hex">86D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST0ByFloatAtDIAddressPlusImmediate32">
		<xsl:element name="prg:hex">87D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST0ByST0">
		<xsl:element name="prg:hex">C8D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST0ByST1">
		<xsl:element name="prg:hex">C9D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST0ByST2">
		<xsl:element name="prg:hex">CAD8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST0ByST3">
		<xsl:element name="prg:hex">CBD8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST0ByST4">
		<xsl:element name="prg:hex">CCD8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST0ByST5">
		<xsl:element name="prg:hex">CDD8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST0ByST6">
		<xsl:element name="prg:hex">CED8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST0ByST7">
		<xsl:element name="prg:hex">CFD8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST0ToST0">
		<xsl:element name="prg:hex">D0D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST1ToST0">
		<xsl:element name="prg:hex">D1D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST2ToST0">
		<xsl:element name="prg:hex">D2D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST3ToST0">
		<xsl:element name="prg:hex">D3D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST4ToST0">
		<xsl:element name="prg:hex">D4D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST5ToST0">
		<xsl:element name="prg:hex">D5D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST6ToST0">
		<xsl:element name="prg:hex">D6D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST7ToST0">
		<xsl:element name="prg:hex">D7D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractST0FromST0">
		<xsl:element name="prg:hex">E0D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractST1FromST0">
		<xsl:element name="prg:hex">E1D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractST2FromST0">
		<xsl:element name="prg:hex">E2D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractST3FromST0">
		<xsl:element name="prg:hex">E3D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractST4FromST0">
		<xsl:element name="prg:hex">E4D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractST5FromST0">
		<xsl:element name="prg:hex">E5D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractST6FromST0">
		<xsl:element name="prg:hex">E6D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractST7FromST0">
		<xsl:element name="prg:hex">E7D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DivideST0ByST0">
		<xsl:element name="prg:hex">F0D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DivideST0ByST1">
		<xsl:element name="prg:hex">F1D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DivideST0ByST2">
		<xsl:element name="prg:hex">F2D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DivideST0ByST3">
		<xsl:element name="prg:hex">F3D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DivideST0ByST4">
		<xsl:element name="prg:hex">F4D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DivideST0ByST5">
		<xsl:element name="prg:hex">F5D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DivideST0ByST6">
		<xsl:element name="prg:hex">F6D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DivideST0ByST7">
		<xsl:element name="prg:hex">F7D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST0ToST0AndIncrementST">
		<xsl:element name="prg:hex">D8D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST1ToST0AndIncrementST">
		<xsl:element name="prg:hex">D9D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST2ToST0AndIncrementST">
		<xsl:element name="prg:hex">DAD8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST3ToST0AndIncrementST">
		<xsl:element name="prg:hex">DBD8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST4ToST0AndIncrementST">
		<xsl:element name="prg:hex">DCD8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST5ToST0AndIncrementST">
		<xsl:element name="prg:hex">DDD8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST6ToST0AndIncrementST">
		<xsl:element name="prg:hex">DED8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST7ToST0AndIncrementST">
		<xsl:element name="prg:hex">DFD8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST0ToST0MinusST0">
		<xsl:element name="prg:hex">E8D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST0ToST1MinusST0">
		<xsl:element name="prg:hex">E9D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST0ToST2MinusST0">
		<xsl:element name="prg:hex">EAD8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST0ToST3MinusST0">
		<xsl:element name="prg:hex">EBD8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST0ToST4MinusST0">
		<xsl:element name="prg:hex">ECD8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST0ToST5MinusST0">
		<xsl:element name="prg:hex">EDD8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST0ToST6MinusST0">
		<xsl:element name="prg:hex">EED8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST0ToST7MinusST0">
		<xsl:element name="prg:hex">EFD8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST0ToST0DividedByST0">
		<xsl:element name="prg:hex">F8D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST0ToST1DividedByST0">
		<xsl:element name="prg:hex">F9D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST0ToST2DividedByST0">
		<xsl:element name="prg:hex">FAD8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST0ToST3DividedByST0">
		<xsl:element name="prg:hex">FBD8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST0ToST4DividedByST0">
		<xsl:element name="prg:hex">FCD8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST0ToST5DividedByST0">
		<xsl:element name="prg:hex">FDD8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST0ToST6DividedByST0">
		<xsl:element name="prg:hex">FED8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST0ToST7DividedByST0">
		<xsl:element name="prg:hex">FFD8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushFloatAtAXAddressToST0">
		<xsl:element name="prg:hex">00D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushFloatAtCXAddressToST0">
		<xsl:element name="prg:hex">01D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushFloatAtDXAddressToST0">
		<xsl:element name="prg:hex">02D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushFloatAtBXAddressToST0">
		<xsl:element name="prg:hex">03D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushFloatAtIndexAddressToST0">
		<xsl:element name="prg:hex">04D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushFloatAtImmediateAddressToST0">
		<xsl:element name="prg:hex">05D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushFloatAtSIAddressToST0">
		<xsl:element name="prg:hex">06D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushFloatAtDIAddressToST0">
		<xsl:element name="prg:hex">07D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushFloatAtAXAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">40D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushFloatAtCXAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">41D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushFloatAtDXAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">42D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushFloatAtBXAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">43D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushFloatAtIndexAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">44D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushFloatAtImmediateAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">45D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushFloatAtSIAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">46D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushFloatAtDIAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">47D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushFloatAtAXAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">80D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushFloatAtCXAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">81D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushFloatAtDXAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">82D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushFloatAtBXAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">83D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushFloatAtIndexAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">84D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushFloatAtImmediateAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">85D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushFloatAtSIAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">86D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushFloatAtDIAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">87D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToFloatAtAXAddress">
		<xsl:element name="prg:hex">10D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToFloatAtCXAddress">
		<xsl:element name="prg:hex">11D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToFloatAtDXAddress">
		<xsl:element name="prg:hex">12D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToFloatAtBXAddress">
		<xsl:element name="prg:hex">13D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToFloatAtIndexAddress">
		<xsl:element name="prg:hex">14D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToFloatAtImmediateAddress">
		<xsl:element name="prg:hex">15D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToFloatAtSIAddress">
		<xsl:element name="prg:hex">16D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToFloatAtDIAddress">
		<xsl:element name="prg:hex">17D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToFloatAtAXAddressPlusImmediate8">
		<xsl:element name="prg:hex">50D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToFloatAtCXAddressPlusImmediate8">
		<xsl:element name="prg:hex">51D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToFloatAtDXAddressPlusImmediate8">
		<xsl:element name="prg:hex">52D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToFloatAtBXAddressPlusImmediate8">
		<xsl:element name="prg:hex">53D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToFloatAtIndexAddressPlusImmediate8">
		<xsl:element name="prg:hex">54D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToFloatAtImmediateAddressPlusImmediate8">
		<xsl:element name="prg:hex">55D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToFloatAtSIAddressPlusImmediate8">
		<xsl:element name="prg:hex">56D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToFloatAtDIAddressPlusImmediate8">
		<xsl:element name="prg:hex">57D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToFloatAtAXAddressPlusImmediate32">
		<xsl:element name="prg:hex">90D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToFloatAtCXAddressPlusImmediate32">
		<xsl:element name="prg:hex">91D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToFloatAtDXAddressPlusImmediate32">
		<xsl:element name="prg:hex">92D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToFloatAtBXAddressPlusImmediate32">
		<xsl:element name="prg:hex">93D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToFloatAtIndexAddressPlusImmediate32">
		<xsl:element name="prg:hex">94D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToFloatAtImmediateAddressPlusImmediate32">
		<xsl:element name="prg:hex">95D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToFloatAtSIAddressPlusImmediate32">
		<xsl:element name="prg:hex">96D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToFloatAtDIAddressPlusImmediate32">
		<xsl:element name="prg:hex">97D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullFloatAtAXAddressFromST0">
		<xsl:element name="prg:hex">18D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullFloatAtCXAddressFromST0">
		<xsl:element name="prg:hex">19D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullFloatAtDXAddressFromST0">
		<xsl:element name="prg:hex">1AD9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullFloatAtBXAddressFromST0">
		<xsl:element name="prg:hex">1BD9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullFloatAtIndexAddressFromST0">
		<xsl:element name="prg:hex">1CD9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullFloatAtImmediateAddressFromST0">
		<xsl:element name="prg:hex">1DD9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullFloatAtSIAddressFromST0">
		<xsl:element name="prg:hex">1ED9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullFloatAtDIAddressFromST0">
		<xsl:element name="prg:hex">1FD9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullFloatAtAXAddressPlusImmediate8FromST0">
		<xsl:element name="prg:hex">58D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullFloatAtCXAddressPlusImmediate8FromST0">
		<xsl:element name="prg:hex">59D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullFloatAtDXAddressPlusImmediate8FromST0">
		<xsl:element name="prg:hex">5AD9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullFloatAtBXAddressPlusImmediate8FromST0">
		<xsl:element name="prg:hex">5BD9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullFloatAtIndexAddressPlusImmediate8FromST0">
		<xsl:element name="prg:hex">5CD9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullFloatAtImmediateAddressPlusImmediate8FromST0">
		<xsl:element name="prg:hex">5DD9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullFloatAtSIAddressPlusImmediate8FromST0">
		<xsl:element name="prg:hex">5ED9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullFloatAtDIAddressPlusImmediate8FromST0">
		<xsl:element name="prg:hex">5FD9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullFloatAtAXAddressPlusImmediate32FromST0">
		<xsl:element name="prg:hex">98D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullFloatAtCXAddressPlusImmediate32FromST0">
		<xsl:element name="prg:hex">99D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullFloatAtDXAddressPlusImmediate32FromST0">
		<xsl:element name="prg:hex">9AD9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullFloatAtBXAddressPlusImmediate32FromST0">
		<xsl:element name="prg:hex">9BD9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullFloatAtIndexAddressPlusImmediate32FromST0">
		<xsl:element name="prg:hex">9CD9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullFloatAtImmediateAddressPlusImmediate32FromST0">
		<xsl:element name="prg:hex">9DD9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullFloatAtSIAddressPlusImmediate32FromST0">
		<xsl:element name="prg:hex">9ED9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullFloatAtDIAddressPlusImmediate32FromST0">
		<xsl:element name="prg:hex">9FD9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetControlToShortAtAXAddress">
		<xsl:element name="prg:hex">28D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetControlToShortAtCXAddress">
		<xsl:element name="prg:hex">29D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetControlToShortAtDXAddress">
		<xsl:element name="prg:hex">2AD9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetControlToShortAtBXAddress">
		<xsl:element name="prg:hex">2BD9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetControlToShortAtIndexAddress">
		<xsl:element name="prg:hex">2CD9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetControlToShortAtImmediateAddress">
		<xsl:element name="prg:hex">2DD9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetControlToShortAtSIAddress">
		<xsl:element name="prg:hex">2ED9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetControlToShortAtDIAddress">
		<xsl:element name="prg:hex">2FD9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetControlToShortAtAXAddressPlusImmediate8">
		<xsl:element name="prg:hex">68D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetControlToShortAtCXAddressPlusImmediate8">
		<xsl:element name="prg:hex">69D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetControlToShortAtDXAddressPlusImmediate8">
		<xsl:element name="prg:hex">6AD9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetControlToShortAtBXAddressPlusImmediate8">
		<xsl:element name="prg:hex">6BD9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetControlToShortAtIndexAddressPlusImmediate8">
		<xsl:element name="prg:hex">6CD9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetControlToShortAtImmediateAddressPlusImmediate8">
		<xsl:element name="prg:hex">6DD9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetControlToShortAtSIAddressPlusImmediate8">
		<xsl:element name="prg:hex">6ED9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetControlToShortAtDIAddressPlusImmediate8">
		<xsl:element name="prg:hex">6FD9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetControlToShortAtAXAddressPlusImmediate32">
		<xsl:element name="prg:hex">A8D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetControlToShortAtCXAddressPlusImmediate32">
		<xsl:element name="prg:hex">A9D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetControlToShortAtDXAddressPlusImmediate32">
		<xsl:element name="prg:hex">AAD9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetControlToShortAtBXAddressPlusImmediate32">
		<xsl:element name="prg:hex">ABD9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetControlToShortAtIndexAddressPlusImmediate32">
		<xsl:element name="prg:hex">ACD9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetControlToShortAtImmediateAddressPlusImmediate32">
		<xsl:element name="prg:hex">ADD9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetControlToShortAtSIAddressPlusImmediate32">
		<xsl:element name="prg:hex">AED9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetControlToShortAtDIAddressPlusImmediate32">
		<xsl:element name="prg:hex">AFD9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushST0">
		<xsl:element name="prg:hex">C0D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushST1">
		<xsl:element name="prg:hex">C1D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushST2">
		<xsl:element name="prg:hex">C2D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushST3">
		<xsl:element name="prg:hex">C3D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushST4">
		<xsl:element name="prg:hex">C4D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushST5">
		<xsl:element name="prg:hex">C5D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushST6">
		<xsl:element name="prg:hex">C6D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushST7">
		<xsl:element name="prg:hex">C7D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExchangeST0WithST0">
		<xsl:element name="prg:hex">C8D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExchangeST1WithST0">
		<xsl:element name="prg:hex">C9D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExchangeST2WithST0">
		<xsl:element name="prg:hex">CAD9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExchangeST3WithST0">
		<xsl:element name="prg:hex">CBD9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExchangeST4WithST0">
		<xsl:element name="prg:hex">CCD9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExchangeST5WithST0">
		<xsl:element name="prg:hex">CDD9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExchangeST6WithST0">
		<xsl:element name="prg:hex">CED9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExchangeST7WithST0">
		<xsl:element name="prg:hex">CFD9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TwoToThePowerOfST0MinusOne">
		<xsl:element name="prg:hex">F0D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AbsoluteValue">
		<xsl:element name="prg:hex">E1D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ChangeSign">
		<xsl:element name="prg:hex">E0D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Cosine">
		<xsl:element name="prg:hex">FFD9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DecrementST">
		<xsl:element name="prg:hex">F6D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IncrementST">
		<xsl:element name="prg:hex">F7D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:One">
		<xsl:element name="prg:hex">E8D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LogBaseTwoEpsilon">
		<xsl:element name="prg:hex">EAD9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LogBaseTwoTen">
		<xsl:element name="prg:hex">E9D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LogBaseTenTwo">
		<xsl:element name="prg:hex">ECD9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LogBaseEpsilonTwo">
		<xsl:element name="prg:hex">EDD9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Pi">
		<xsl:element name="prg:hex">EBD9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Zero">
		<xsl:element name="prg:hex">EED9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:NoOperation">
		<xsl:element name="prg:hex">E0D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Arctangent">
		<xsl:element name="prg:hex">F3D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RemainderLegacy">
		<xsl:element name="prg:hex">F8D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Remainder">
		<xsl:element name="prg:hex">F5D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Tangent">
		<xsl:element name="prg:hex">F2D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Round">
		<xsl:element name="prg:hex">FCD9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Scale">
		<xsl:element name="prg:hex">FDD9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Sine">
		<xsl:element name="prg:hex">FED9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SineAndCosine">
		<xsl:element name="prg:hex">FBD9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SquareRoot">
		<xsl:element name="prg:hex">FAD9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TestST0">
		<xsl:element name="prg:hex">E4D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExamineST0">
		<xsl:element name="prg:hex">E5D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExtractST0">
		<xsl:element name="prg:hex">F4D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LogBaseTwoOfST0TimesST1">
		<xsl:element name="prg:hex">F1D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LogBaseTwoOfST0PlusOneTimesST1">
		<xsl:element name="prg:hex">F9D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddIntegerAtAXAddressToST0">
		<xsl:element name="prg:hex">00DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddIntegerAtCXAddressToST0">
		<xsl:element name="prg:hex">01DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddIntegerAtDXAddressToST0">
		<xsl:element name="prg:hex">02DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddIntegerAtBXAddressToST0">
		<xsl:element name="prg:hex">03DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddIntegerAtIndexAddressToST0">
		<xsl:element name="prg:hex">04DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddIntegerAtImmediateAddressToST0">
		<xsl:element name="prg:hex">05DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddIntegerAtSIAddressToST0">
		<xsl:element name="prg:hex">06DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddIntegerAtDIAddressToST0">
		<xsl:element name="prg:hex">07DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddIntegerAtAXAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">40DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddIntegerAtCXAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">41DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddIntegerAtDXAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">42DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddIntegerAtBXAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">43DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddIntegerAtIndexAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">44DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddIntegerAtImmediateAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">45DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddIntegerAtSIAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">46DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddIntegerAtDIAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">47DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddIntegerAtAXAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">80DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddIntegerAtCXAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">81DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddIntegerAtDXAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">82DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddIntegerAtBXAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">83DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddIntegerAtIndexAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">84DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddIntegerAtImmediateAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">85DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddIntegerAtSIAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">86DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddIntegerAtDIAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">87DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToST0IfBelow">
		<xsl:element name="prg:hex">C0DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST1ToST0IfBelow">
		<xsl:element name="prg:hex">C1DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST2ToST0IfBelow">
		<xsl:element name="prg:hex">C2DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST3ToST0IfBelow">
		<xsl:element name="prg:hex">C3DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST4ToST0IfBelow">
		<xsl:element name="prg:hex">C4DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST5ToST0IfBelow">
		<xsl:element name="prg:hex">C5DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST6ToST0IfBelow">
		<xsl:element name="prg:hex">C6DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST7ToST0IfBelow">
		<xsl:element name="prg:hex">C7DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToST0IfEqual">
		<xsl:element name="prg:hex">C8DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST1ToST0IfEqual">
		<xsl:element name="prg:hex">C9DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST2ToST0IfEqual">
		<xsl:element name="prg:hex">CADA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST3ToST0IfEqual">
		<xsl:element name="prg:hex">CBDA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST4ToST0IfEqual">
		<xsl:element name="prg:hex">CCDA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST5ToST0IfEqual">
		<xsl:element name="prg:hex">CDDA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST6ToST0IfEqual">
		<xsl:element name="prg:hex">CEDA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST7ToST0IfEqual">
		<xsl:element name="prg:hex">CFDA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToST0IfBelowOrEqual">
		<xsl:element name="prg:hex">D0DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST1ToST0IfBelowOrEqual">
		<xsl:element name="prg:hex">D1DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST2ToST0IfBelowOrEqual">
		<xsl:element name="prg:hex">D2DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST3ToST0IfBelowOrEqual">
		<xsl:element name="prg:hex">D3DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST4ToST0IfBelowOrEqual">
		<xsl:element name="prg:hex">D4DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST5ToST0IfBelowOrEqual">
		<xsl:element name="prg:hex">D5DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST6ToST0IfBelowOrEqual">
		<xsl:element name="prg:hex">D6DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST7ToST0IfBelowOrEqual">
		<xsl:element name="prg:hex">D7DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToST0IfUnordered">
		<xsl:element name="prg:hex">D8DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST1ToST0IfUnordered">
		<xsl:element name="prg:hex">D9DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST2ToST0IfUnordered">
		<xsl:element name="prg:hex">DADA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST3ToST0IfUnordered">
		<xsl:element name="prg:hex">DBDA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST4ToST0IfUnordered">
		<xsl:element name="prg:hex">DCDA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST5ToST0IfUnordered">
		<xsl:element name="prg:hex">DDDA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST6ToST0IfUnordered">
		<xsl:element name="prg:hex">DEDA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST7ToST0IfUnordered">
		<xsl:element name="prg:hex">DFDA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareAndPopTwiceUnordered">
		<xsl:element name="prg:hex">E9DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushIntegerAtAXAddressToST0">
		<xsl:element name="prg:hex">00DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushIntegerAtCXAddressToST0">
		<xsl:element name="prg:hex">01DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushIntegerAtDXAddressToST0">
		<xsl:element name="prg:hex">02DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushIntegerAtBXAddressToST0">
		<xsl:element name="prg:hex">03DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushIntegerAtIndexAddressToST0">
		<xsl:element name="prg:hex">04DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushIntegerAtImmediateAddressToST0">
		<xsl:element name="prg:hex">05DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushIntegerAtSIAddressToST0">
		<xsl:element name="prg:hex">06DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushIntegerAtDIAddressToST0">
		<xsl:element name="prg:hex">07DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushIntegerAtAXAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">40DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushIntegerAtCXAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">41DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushIntegerAtDXAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">42DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushIntegerAtBXAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">43DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushIntegerAtIndexAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">44DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushIntegerAtImmediateAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">45DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushIntegerAtSIAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">46DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushIntegerAtDIAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">47DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushIntegerAtAXAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">80DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushIntegerAtCXAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">81DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushIntegerAtDXAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">82DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushIntegerAtBXAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">83DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushIntegerAtIndexAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">84DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushIntegerAtImmediateAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">85DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushIntegerAtSIAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">86DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushIntegerAtDIAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">87DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToIntegerAtAXAddress">
		<xsl:element name="prg:hex">10DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToIntegerAtCXAddress">
		<xsl:element name="prg:hex">11DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToIntegerAtDXAddress">
		<xsl:element name="prg:hex">12DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToIntegerAtBXAddress">
		<xsl:element name="prg:hex">13DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToIntegerAtIndexAddress">
		<xsl:element name="prg:hex">14DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToIntegerAtImmediateAddress">
		<xsl:element name="prg:hex">15DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToIntegerAtSIAddress">
		<xsl:element name="prg:hex">16DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToIntegerAtDIAddress">
		<xsl:element name="prg:hex">17DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToIntegerAtAXAddressPlusImmediate8">
		<xsl:element name="prg:hex">50DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToIntegerAtCXAddressPlusImmediate8">
		<xsl:element name="prg:hex">51DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToIntegerAtDXAddressPlusImmediate8">
		<xsl:element name="prg:hex">52DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToIntegerAtBXAddressPlusImmediate8">
		<xsl:element name="prg:hex">53DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToIntegerAtIndexAddressPlusImmediate8">
		<xsl:element name="prg:hex">54DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToIntegerAtImmediateAddressPlusImmediate8">
		<xsl:element name="prg:hex">55DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToIntegerAtSIAddressPlusImmediate8">
		<xsl:element name="prg:hex">56DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToIntegerAtDIAddressPlusImmediate8">
		<xsl:element name="prg:hex">57DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToIntegerAtAXAddressPlusImmediate32">
		<xsl:element name="prg:hex">90DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToIntegerAtCXAddressPlusImmediate32">
		<xsl:element name="prg:hex">91DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToIntegerAtDXAddressPlusImmediate32">
		<xsl:element name="prg:hex">92DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToIntegerAtBXAddressPlusImmediate32">
		<xsl:element name="prg:hex">93DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToIntegerAtIndexAddressPlusImmediate32">
		<xsl:element name="prg:hex">94DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToIntegerAtImmediateAddressPlusImmediate32">
		<xsl:element name="prg:hex">95DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToIntegerAtSIAddressPlusImmediate32">
		<xsl:element name="prg:hex">96DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToIntegerAtDIAddressPlusImmediate32">
		<xsl:element name="prg:hex">97DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullIntegerAtAXAddressFromST0">
		<xsl:element name="prg:hex">18DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullIntegerAtCXAddressFromST0">
		<xsl:element name="prg:hex">19DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullIntegerAtDXAddressFromST0">
		<xsl:element name="prg:hex">1ADB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullIntegerAtBXAddressFromST0">
		<xsl:element name="prg:hex">1BDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullIntegerAtIndexAddressFromST0">
		<xsl:element name="prg:hex">1CDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullIntegerAtImmediateAddressFromST0">
		<xsl:element name="prg:hex">1DDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullIntegerAtSIAddressFromST0">
		<xsl:element name="prg:hex">1EDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullIntegerAtDIAddressFromST0">
		<xsl:element name="prg:hex">1FDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullIntegerAtAXAddressPlusImmediate8FromST0">
		<xsl:element name="prg:hex">58DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullIntegerAtCXAddressPlusImmediate8FromST0">
		<xsl:element name="prg:hex">59DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullIntegerAtDXAddressPlusImmediate8FromST0">
		<xsl:element name="prg:hex">5ADB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullIntegerAtBXAddressPlusImmediate8FromST0">
		<xsl:element name="prg:hex">5BDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullIntegerAtIndexAddressPlusImmediate8FromST0">
		<xsl:element name="prg:hex">5CDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullIntegerAtImmediateAddressPlusImmediate8FromST0">
		<xsl:element name="prg:hex">5DDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullIntegerAtSIAddressPlusImmediate8FromST0">
		<xsl:element name="prg:hex">5EDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullIntegerAtDIAddressPlusImmediate8FromST0">
		<xsl:element name="prg:hex">5FDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullIntegerAtAXAddressPlusImmediate32FromST0">
		<xsl:element name="prg:hex">98DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullIntegerAtCXAddressPlusImmediate32FromST0">
		<xsl:element name="prg:hex">99DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullIntegerAtDXAddressPlusImmediate32FromST0">
		<xsl:element name="prg:hex">9ADB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullIntegerAtBXAddressPlusImmediate32FromST0">
		<xsl:element name="prg:hex">9BDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullIntegerAtIndexAddressPlusImmediate32FromST0">
		<xsl:element name="prg:hex">9CDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullIntegerAtImmediateAddressPlusImmediate32FromST0">
		<xsl:element name="prg:hex">9DDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullIntegerAtSIAddressPlusImmediate32FromST0">
		<xsl:element name="prg:hex">9EDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullIntegerAtDIAddressPlusImmediate32FromST0">
		<xsl:element name="prg:hex">9FDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushRealAtAXAddressToST0">
		<xsl:element name="prg:hex">28DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushRealAtCXAddressToST0">
		<xsl:element name="prg:hex">29DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushRealAtDXAddressToST0">
		<xsl:element name="prg:hex">2ADB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushRealAtBXAddressToST0">
		<xsl:element name="prg:hex">2BDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushRealAtIndexAddressToST0">
		<xsl:element name="prg:hex">2CDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushRealAtImmediateAddressToST0">
		<xsl:element name="prg:hex">2DDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushRealAtSIAddressToST0">
		<xsl:element name="prg:hex">2EDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushRealAtDIAddressToST0">
		<xsl:element name="prg:hex">2FDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushRealAtAXAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">68DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushRealAtCXAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">69DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushRealAtDXAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">6ADB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushRealAtBXAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">6BDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushRealAtIndexAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">6CDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushRealAtImmediateAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">6DDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushRealAtSIAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">6EDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushRealAtDIAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">6FDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushRealAtAXAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">A8DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushRealAtCXAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">A9DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushRealAtDXAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">AADB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushRealAtBXAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">ABDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushRealAtIndexAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">ACDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushRealAtImmediateAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">ADDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushRealAtSIAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">AEDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushRealAtDIAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">AFDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullRealAtAXAddressFromST0">
		<xsl:element name="prg:hex">38DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullRealAtCXAddressFromST0">
		<xsl:element name="prg:hex">39DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullRealAtDXAddressFromST0">
		<xsl:element name="prg:hex">3ADB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullRealAtBXAddressFromST0">
		<xsl:element name="prg:hex">3BDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullRealAtIndexAddressFromST0">
		<xsl:element name="prg:hex">3CDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullRealAtImmediateAddressFromST0">
		<xsl:element name="prg:hex">3DDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullRealAtSIAddressFromST0">
		<xsl:element name="prg:hex">3EDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullRealAtDIAddressFromST0">
		<xsl:element name="prg:hex">3FDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullRealAtAXAddressPlusImmediate8FromST0">
		<xsl:element name="prg:hex">78DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullRealAtCXAddressPlusImmediate8FromST0">
		<xsl:element name="prg:hex">79DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullRealAtDXAddressPlusImmediate8FromST0">
		<xsl:element name="prg:hex">7ADB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullRealAtBXAddressPlusImmediate8FromST0">
		<xsl:element name="prg:hex">7BDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullRealAtIndexAddressPlusImmediate8FromST0">
		<xsl:element name="prg:hex">7CDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullRealAtImmediateAddressPlusImmediate8FromST0">
		<xsl:element name="prg:hex">7DDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullRealAtSIAddressPlusImmediate8FromST0">
		<xsl:element name="prg:hex">7EDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullRealAtDIAddressPlusImmediate8FromST0">
		<xsl:element name="prg:hex">7FDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullRealAtAXAddressPlusImmediate32FromST0">
		<xsl:element name="prg:hex">B8DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullRealAtCXAddressPlusImmediate32FromST0">
		<xsl:element name="prg:hex">B9DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullRealAtDXAddressPlusImmediate32FromST0">
		<xsl:element name="prg:hex">BADB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullRealAtBXAddressPlusImmediate32FromST0">
		<xsl:element name="prg:hex">BBDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullRealAtIndexAddressPlusImmediate32FromST0">
		<xsl:element name="prg:hex">BCDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullRealAtImmediateAddressPlusImmediate32FromST0">
		<xsl:element name="prg:hex">BDDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullRealAtSIAddressPlusImmediate32FromST0">
		<xsl:element name="prg:hex">BEDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullRealAtDIAddressPlusImmediate32FromST0">
		<xsl:element name="prg:hex">BFDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToST0IfNotBelow">
		<xsl:element name="prg:hex">C0DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST1ToST0IfNotBelow">
		<xsl:element name="prg:hex">C1DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST2ToST0IfNotBelow">
		<xsl:element name="prg:hex">C2DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST3ToST0IfNotBelow">
		<xsl:element name="prg:hex">C3DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST4ToST0IfNotBelow">
		<xsl:element name="prg:hex">C4DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST5ToST0IfNotBelow">
		<xsl:element name="prg:hex">C5DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST6ToST0IfNotBelow">
		<xsl:element name="prg:hex">C6DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST7ToST0IfNotBelow">
		<xsl:element name="prg:hex">C7DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToST0IfNotEqual">
		<xsl:element name="prg:hex">C8DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST1ToST0IfNotEqual">
		<xsl:element name="prg:hex">C9DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST2ToST0IfNotEqual">
		<xsl:element name="prg:hex">CADB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST3ToST0IfNotEqual">
		<xsl:element name="prg:hex">CBDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST4ToST0IfNotEqual">
		<xsl:element name="prg:hex">CCDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST5ToST0IfNotEqual">
		<xsl:element name="prg:hex">CDDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST6ToST0IfNotEqual">
		<xsl:element name="prg:hex">CEDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST7ToST0IfNotEqual">
		<xsl:element name="prg:hex">CFDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToST0IfNotBelowOrEqual">
		<xsl:element name="prg:hex">D0DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST1ToST0IfNotBelowOrEqual">
		<xsl:element name="prg:hex">D1DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST2ToST0IfNotBelowOrEqual">
		<xsl:element name="prg:hex">D2DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST3ToST0IfNotBelowOrEqual">
		<xsl:element name="prg:hex">D3DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST4ToST0IfNotBelowOrEqual">
		<xsl:element name="prg:hex">D4DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST5ToST0IfNotBelowOrEqual">
		<xsl:element name="prg:hex">D5DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST6ToST0IfNotBelowOrEqual">
		<xsl:element name="prg:hex">D6DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST7ToST0IfNotBelowOrEqual">
		<xsl:element name="prg:hex">D7DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToST0IfNotUnordered">
		<xsl:element name="prg:hex">D8DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST1ToST0IfNotUnordered">
		<xsl:element name="prg:hex">D9DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST2ToST0IfNotUnordered">
		<xsl:element name="prg:hex">DADB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST3ToST0IfNotUnordered">
		<xsl:element name="prg:hex">DBDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST4ToST0IfNotUnordered">
		<xsl:element name="prg:hex">DCDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST5ToST0IfNotUnordered">
		<xsl:element name="prg:hex">DDDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST6ToST0IfNotUnordered">
		<xsl:element name="prg:hex">DEDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST7ToST0IfNotUnordered">
		<xsl:element name="prg:hex">DFDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST0ToST0AndSetCpuFlagsWithExceptions">
		<xsl:element name="prg:hex">E8DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST1ToST0AndSetCpuFlagsWithExceptions">
		<xsl:element name="prg:hex">E9DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST2ToST0AndSetCpuFlagsWithExceptions">
		<xsl:element name="prg:hex">EADB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST3ToST0AndSetCpuFlagsWithExceptions">
		<xsl:element name="prg:hex">EBDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST4ToST0AndSetCpuFlagsWithExceptions">
		<xsl:element name="prg:hex">ECDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST5ToST0AndSetCpuFlagsWithExceptions">
		<xsl:element name="prg:hex">EDDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST6ToST0AndSetCpuFlagsWithExceptions">
		<xsl:element name="prg:hex">EEDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST7ToST0AndSetCpuFlagsWithExceptions">
		<xsl:element name="prg:hex">EFDB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST0ToST0AndSetCpuFlags">
		<xsl:element name="prg:hex">F0DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST1ToST0AndSetCpuFlags">
		<xsl:element name="prg:hex">F1DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST2ToST0AndSetCpuFlags">
		<xsl:element name="prg:hex">F2DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST3ToST0AndSetCpuFlags">
		<xsl:element name="prg:hex">F3DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST4ToST0AndSetCpuFlags">
		<xsl:element name="prg:hex">F4DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST5ToST0AndSetCpuFlags">
		<xsl:element name="prg:hex">F5DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST6ToST0AndSetCpuFlags">
		<xsl:element name="prg:hex">F6DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST7ToST0AndSetCpuFlags">
		<xsl:element name="prg:hex">F7DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ResetFpu">
		<xsl:element name="prg:hex">E3DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ClearExceptions">
		<xsl:element name="prg:hex">E2DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddDoubleAtAXAddressToST0">
		<xsl:element name="prg:hex">00DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddDoubleAtCXAddressToST0">
		<xsl:element name="prg:hex">01DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddDoubleAtDXAddressToST0">
		<xsl:element name="prg:hex">02DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddDoubleAtBXAddressToST0">
		<xsl:element name="prg:hex">03DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddDoubleAtIndexAddressToST0">
		<xsl:element name="prg:hex">04DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddDoubleAtImmediateAddressToST0">
		<xsl:element name="prg:hex">05DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddDoubleAtSIAddressToST0">
		<xsl:element name="prg:hex">06DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddDoubleAtDIAddressToST0">
		<xsl:element name="prg:hex">07DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddDoubleAtAXAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">40DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddDoubleAtCXAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">41DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddDoubleAtDXAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">42DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddDoubleAtBXAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">43DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddDoubleAtIndexAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">44DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddDoubleAtImmediateAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">45DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddDoubleAtSIAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">46DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddDoubleAtDIAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">47DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddDoubleAtAXAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">80DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddDoubleAtCXAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">81DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddDoubleAtDXAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">82DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddDoubleAtBXAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">83DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddDoubleAtIndexAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">84DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddDoubleAtImmediateAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">85DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddDoubleAtSIAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">86DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddDoubleAtDIAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">87DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddST0ToST1">
		<xsl:element name="prg:hex">C1DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddST0ToST2">
		<xsl:element name="prg:hex">C2DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddST0ToST3">
		<xsl:element name="prg:hex">C3DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddST0ToST4">
		<xsl:element name="prg:hex">C4DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddST0ToST5">
		<xsl:element name="prg:hex">C5DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddST0ToST6">
		<xsl:element name="prg:hex">C6DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddST0ToST7">
		<xsl:element name="prg:hex">C7DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST1ByST0">
		<xsl:element name="prg:hex">C9DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST2ByST0">
		<xsl:element name="prg:hex">CADC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST3ByST0">
		<xsl:element name="prg:hex">CBDC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST4ByST0">
		<xsl:element name="prg:hex">CCDC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST5ByST0">
		<xsl:element name="prg:hex">CDDC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST6ByST0">
		<xsl:element name="prg:hex">CEDC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST7ByST0">
		<xsl:element name="prg:hex">CFDC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST1ToST0MinusST1">
		<xsl:element name="prg:hex">E1DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST2ToST0MinusST2">
		<xsl:element name="prg:hex">E2DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST3ToST0MinusST3">
		<xsl:element name="prg:hex">E3DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST4ToST0MinusST4">
		<xsl:element name="prg:hex">E4DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST5ToST0MinusST5">
		<xsl:element name="prg:hex">E5DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST6ToST0MinusST6">
		<xsl:element name="prg:hex">E6DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST7ToST0MinusST7">
		<xsl:element name="prg:hex">E7DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractST0FromST1">
		<xsl:element name="prg:hex">D1DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractST0FromST2">
		<xsl:element name="prg:hex">D2DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractST0FromST3">
		<xsl:element name="prg:hex">D3DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractST0FromST4">
		<xsl:element name="prg:hex">D4DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractST0FromST5">
		<xsl:element name="prg:hex">D5DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractST0FromST6">
		<xsl:element name="prg:hex">D6DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractST0FromST7">
		<xsl:element name="prg:hex">D7DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST1ToST0DividedByST1">
		<xsl:element name="prg:hex">F1DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST2ToST0DividedByST2">
		<xsl:element name="prg:hex">F2DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST3ToST0DividedByST3">
		<xsl:element name="prg:hex">F3DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST4ToST0DividedByST4">
		<xsl:element name="prg:hex">F4DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST5ToST0DividedByST5">
		<xsl:element name="prg:hex">F5DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST6ToST0DividedByST6">
		<xsl:element name="prg:hex">F6DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST7ToST0DividedByST7">
		<xsl:element name="prg:hex">F7DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DivideST1ByST0">
		<xsl:element name="prg:hex">F9DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DivideST2ByST0">
		<xsl:element name="prg:hex">FADC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DivideST3ByST0">
		<xsl:element name="prg:hex">FBDC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DivideST4ByST0">
		<xsl:element name="prg:hex">FCDC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DivideST5ByST0">
		<xsl:element name="prg:hex">FDDC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DivideST6ByST0">
		<xsl:element name="prg:hex">FEDC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DivideST7ByST0">
		<xsl:element name="prg:hex">FFDC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushDoubleAtAXAddressToST0">
		<xsl:element name="prg:hex">00DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushDoubleAtCXAddressToST0">
		<xsl:element name="prg:hex">01DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushDoubleAtDXAddressToST0">
		<xsl:element name="prg:hex">02DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushDoubleAtBXAddressToST0">
		<xsl:element name="prg:hex">03DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushDoubleAtIndexAddressToST0">
		<xsl:element name="prg:hex">04DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushDoubleAtImmediateAddressToST0">
		<xsl:element name="prg:hex">05DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushDoubleAtSIAddressToST0">
		<xsl:element name="prg:hex">06DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushDoubleAtDIAddressToST0">
		<xsl:element name="prg:hex">07DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushDoubleAtAXAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">40DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushDoubleAtCXAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">41DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushDoubleAtDXAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">42DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushDoubleAtBXAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">43DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushDoubleAtIndexAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">44DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushDoubleAtImmediateAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">45DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushDoubleAtSIAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">46DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushDoubleAtDIAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">47DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushDoubleAtAXAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">80DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushDoubleAtCXAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">81DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushDoubleAtDXAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">82DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushDoubleAtBXAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">83DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushDoubleAtIndexAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">84DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushDoubleAtImmediateAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">85DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushDoubleAtSIAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">86DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushDoubleAtDIAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">87DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToDoubleAtAXAddress">
		<xsl:element name="prg:hex">10DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToDoubleAtCXAddress">
		<xsl:element name="prg:hex">11DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToDoubleAtDXAddress">
		<xsl:element name="prg:hex">12DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToDoubleAtBXAddress">
		<xsl:element name="prg:hex">13DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToDoubleAtIndexAddress">
		<xsl:element name="prg:hex">14DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToDoubleAtImmediateAddress">
		<xsl:element name="prg:hex">15DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToDoubleAtSIAddress">
		<xsl:element name="prg:hex">16DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToDoubleAtDIAddress">
		<xsl:element name="prg:hex">17DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToDoubleAtAXAddressPlusImmediate8">
		<xsl:element name="prg:hex">50DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToDoubleAtCXAddressPlusImmediate8">
		<xsl:element name="prg:hex">51DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToDoubleAtDXAddressPlusImmediate8">
		<xsl:element name="prg:hex">52DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToDoubleAtBXAddressPlusImmediate8">
		<xsl:element name="prg:hex">53DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToDoubleAtIndexAddressPlusImmediate8">
		<xsl:element name="prg:hex">54DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToDoubleAtImmediateAddressPlusImmediate8">
		<xsl:element name="prg:hex">55DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToDoubleAtSIAddressPlusImmediate8">
		<xsl:element name="prg:hex">56DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToDoubleAtDIAddressPlusImmediate8">
		<xsl:element name="prg:hex">57DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToDoubleAtAXAddressPlusImmediate32">
		<xsl:element name="prg:hex">90DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToDoubleAtCXAddressPlusImmediate32">
		<xsl:element name="prg:hex">91DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToDoubleAtDXAddressPlusImmediate32">
		<xsl:element name="prg:hex">92DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToDoubleAtBXAddressPlusImmediate32">
		<xsl:element name="prg:hex">93DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToDoubleAtIndexAddressPlusImmediate32">
		<xsl:element name="prg:hex">94DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToDoubleAtImmediateAddressPlusImmediate32">
		<xsl:element name="prg:hex">95DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToDoubleAtSIAddressPlusImmediate32">
		<xsl:element name="prg:hex">96DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToDoubleAtDIAddressPlusImmediate32">
		<xsl:element name="prg:hex">97DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullDoubleAtAXAddressFromST0">
		<xsl:element name="prg:hex">18DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullDoubleAtCXAddressFromST0">
		<xsl:element name="prg:hex">19DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullDoubleAtDXAddressFromST0">
		<xsl:element name="prg:hex">1ADD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullDoubleAtBXAddressFromST0">
		<xsl:element name="prg:hex">1BDD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullDoubleAtIndexAddressFromST0">
		<xsl:element name="prg:hex">1CDD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullDoubleAtImmediateAddressFromST0">
		<xsl:element name="prg:hex">1DDD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullDoubleAtSIAddressFromST0">
		<xsl:element name="prg:hex">1EDD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullDoubleAtDIAddressFromST0">
		<xsl:element name="prg:hex">1FDD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullDoubleAtAXAddressPlusImmediate8FromST0">
		<xsl:element name="prg:hex">58DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullDoubleAtCXAddressPlusImmediate8FromST0">
		<xsl:element name="prg:hex">59DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullDoubleAtDXAddressPlusImmediate8FromST0">
		<xsl:element name="prg:hex">5ADD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullDoubleAtBXAddressPlusImmediate8FromST0">
		<xsl:element name="prg:hex">5BDD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullDoubleAtIndexAddressPlusImmediate8FromST0">
		<xsl:element name="prg:hex">5CDD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullDoubleAtImmediateAddressPlusImmediate8FromST0">
		<xsl:element name="prg:hex">5DDD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullDoubleAtSIAddressPlusImmediate8FromST0">
		<xsl:element name="prg:hex">5EDD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullDoubleAtDIAddressPlusImmediate8FromST0">
		<xsl:element name="prg:hex">5FDD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullDoubleAtAXAddressPlusImmediate32FromST0">
		<xsl:element name="prg:hex">98DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullDoubleAtCXAddressPlusImmediate32FromST0">
		<xsl:element name="prg:hex">99DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullDoubleAtDXAddressPlusImmediate32FromST0">
		<xsl:element name="prg:hex">9ADD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullDoubleAtBXAddressPlusImmediate32FromST0">
		<xsl:element name="prg:hex">9BDD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullDoubleAtIndexAddressPlusImmediate32FromST0">
		<xsl:element name="prg:hex">9CDD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullDoubleAtImmediateAddressPlusImmediate32FromST0">
		<xsl:element name="prg:hex">9DDD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullDoubleAtSIAddressPlusImmediate32FromST0">
		<xsl:element name="prg:hex">9EDD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullDoubleAtDIAddressPlusImmediate32FromST0">
		<xsl:element name="prg:hex">9FDD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FreeST0">
		<xsl:element name="prg:hex">C0DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FreeST1">
		<xsl:element name="prg:hex">C1DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FreeST2">
		<xsl:element name="prg:hex">C2DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FreeST3">
		<xsl:element name="prg:hex">C3DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FreeST4">
		<xsl:element name="prg:hex">C4DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FreeST5">
		<xsl:element name="prg:hex">C5DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FreeST6">
		<xsl:element name="prg:hex">C6DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FreeST7">
		<xsl:element name="prg:hex">C7DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToST0">
		<xsl:element name="prg:hex">D0DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToST1">
		<xsl:element name="prg:hex">D1DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToST2">
		<xsl:element name="prg:hex">D2DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToST3">
		<xsl:element name="prg:hex">D3DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToST4">
		<xsl:element name="prg:hex">D4DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToST5">
		<xsl:element name="prg:hex">D5DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToST6">
		<xsl:element name="prg:hex">D6DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToST7">
		<xsl:element name="prg:hex">D7DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullST0">
		<xsl:element name="prg:hex">D8DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullST1">
		<xsl:element name="prg:hex">D9DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullST2">
		<xsl:element name="prg:hex">DADD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullST3">
		<xsl:element name="prg:hex">DBDD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullST4">
		<xsl:element name="prg:hex">DCDD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullST5">
		<xsl:element name="prg:hex">DDDD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullST6">
		<xsl:element name="prg:hex">DEDD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullST7">
		<xsl:element name="prg:hex">DFDD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST0WithST0Unordered">
		<xsl:element name="prg:hex">E0DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST0WithST1Unordered">
		<xsl:element name="prg:hex">E1DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST0WithST2Unordered">
		<xsl:element name="prg:hex">E2DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST0WithST3Unordered">
		<xsl:element name="prg:hex">E3DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST0WithST4Unordered">
		<xsl:element name="prg:hex">E4DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST0WithST5Unordered">
		<xsl:element name="prg:hex">E5DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST0WithST6Unordered">
		<xsl:element name="prg:hex">E6DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST0WithST7Unordered">
		<xsl:element name="prg:hex">E7DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST0WithST0UnorderedAndIncrementST">
		<xsl:element name="prg:hex">E8DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST0WithST1UnorderedAndIncrementST">
		<xsl:element name="prg:hex">E9DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST0WithST2UnorderedAndIncrementST">
		<xsl:element name="prg:hex">EADD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST0WithST3UnorderedAndIncrementST">
		<xsl:element name="prg:hex">EBDD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST0WithST4UnorderedAndIncrementST">
		<xsl:element name="prg:hex">ECDD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST0WithST5UnorderedAndIncrementST">
		<xsl:element name="prg:hex">EDDD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST0WithST6UnorderedAndIncrementST">
		<xsl:element name="prg:hex">EEDD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST0WithST7UnorderedAndIncrementST">
		<xsl:element name="prg:hex">EFDD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddShortAtAXAddressToST0">
		<xsl:element name="prg:hex">00DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddShortAtCXAddressToST0">
		<xsl:element name="prg:hex">01DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddShortAtDXAddressToST0">
		<xsl:element name="prg:hex">02DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddShortAtBXAddressToST0">
		<xsl:element name="prg:hex">03DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddShortAtIndexAddressToST0">
		<xsl:element name="prg:hex">04DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddShortAtImmediateAddressToST0">
		<xsl:element name="prg:hex">05DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddShortAtSIAddressToST0">
		<xsl:element name="prg:hex">06DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddShortAtDIAddressToST0">
		<xsl:element name="prg:hex">07DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddShortAtAXAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">40DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddShortAtCXAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">41DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddShortAtDXAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">42DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddShortAtBXAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">43DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddShortAtIndexAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">44DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddShortAtImmediateAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">45DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddShortAtSIAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">46DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddShortAtDIAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">47DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddShortAtAXAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">80DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddShortAtCXAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">81DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddShortAtDXAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">82DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddShortAtBXAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">83DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddShortAtIndexAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">84DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddShortAtImmediateAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">85DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddShortAtSIAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">86DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddShortAtDIAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">87DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddST0ToST0AndIncrementST">
		<xsl:element name="prg:hex">C0DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddST0ToST1AndIncrementST">
		<xsl:element name="prg:hex">C1DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddST0ToST2AndIncrementST">
		<xsl:element name="prg:hex">C2DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddST0ToST3AndIncrementST">
		<xsl:element name="prg:hex">C3DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddST0ToST4AndIncrementST">
		<xsl:element name="prg:hex">C4DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddST0ToST5AndIncrementST">
		<xsl:element name="prg:hex">C5DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddST0ToST6AndIncrementST">
		<xsl:element name="prg:hex">C6DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddST0ToST7AndIncrementST">
		<xsl:element name="prg:hex">C7DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST0ByST0AndIncrementST">
		<xsl:element name="prg:hex">C8DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST1ByST0AndIncrementST">
		<xsl:element name="prg:hex">C9DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST2ByST0AndIncrementST">
		<xsl:element name="prg:hex">CADE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST3ByST0AndIncrementST">
		<xsl:element name="prg:hex">CBDE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST4ByST0AndIncrementST">
		<xsl:element name="prg:hex">CCDE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST5ByST0AndIncrementST">
		<xsl:element name="prg:hex">CDDE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST6ByST0AndIncrementST">
		<xsl:element name="prg:hex">CEDE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyST7ByST0AndIncrementST">
		<xsl:element name="prg:hex">CFDE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST0ToST0MinusST0AndIncrementST">
		<xsl:element name="prg:hex">E0DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST1ToST0MinusST1AndIncrementST">
		<xsl:element name="prg:hex">E1DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST2ToST0MinusST2AndIncrementST">
		<xsl:element name="prg:hex">E2DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST3ToST0MinusST3AndIncrementST">
		<xsl:element name="prg:hex">E3DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST4ToST0MinusST4AndIncrementST">
		<xsl:element name="prg:hex">E4DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST5ToST0MinusST5AndIncrementST">
		<xsl:element name="prg:hex">E5DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST6ToST0MinusST6AndIncrementST">
		<xsl:element name="prg:hex">E6DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST7ToST0MinusST7AndIncrementST">
		<xsl:element name="prg:hex">E7DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractST0FromST0AndIncrementST">
		<xsl:element name="prg:hex">E8DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractST0FromST1AndIncrementST">
		<xsl:element name="prg:hex">E9DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractST0FromST2AndIncrementST">
		<xsl:element name="prg:hex">EADE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractST0FromST3AndIncrementST">
		<xsl:element name="prg:hex">EBDE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractST0FromST4AndIncrementST">
		<xsl:element name="prg:hex">ECDE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractST0FromST5AndIncrementST">
		<xsl:element name="prg:hex">EDDE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractST0FromST6AndIncrementST">
		<xsl:element name="prg:hex">EEDE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractST0FromST7AndIncrementST">
		<xsl:element name="prg:hex">EFDE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST0ToST0DividedByST0AndIncrementST">
		<xsl:element name="prg:hex">F0DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST1ToST0DividedByST1AndIncrementST">
		<xsl:element name="prg:hex">F1DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST2ToST0DividedByST2AndIncrementST">
		<xsl:element name="prg:hex">F2DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST3ToST0DividedByST3AndIncrementST">
		<xsl:element name="prg:hex">F3DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST4ToST0DividedByST4AndIncrementST">
		<xsl:element name="prg:hex">F4DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST5ToST0DividedByST5AndIncrementST">
		<xsl:element name="prg:hex">F5DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST6ToST0DividedByST6AndIncrementST">
		<xsl:element name="prg:hex">F6DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetST7ToST0DividedByST7AndIncrementST">
		<xsl:element name="prg:hex">F7DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DivideST0ByST0AndIncrementST">
		<xsl:element name="prg:hex">F8DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DivideST1ByST0AndIncrementST">
		<xsl:element name="prg:hex">F9DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DivideST2ByST0AndIncrementST">
		<xsl:element name="prg:hex">FADE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DivideST3ByST0AndIncrementST">
		<xsl:element name="prg:hex">FBDE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DivideST4ByST0AndIncrementST">
		<xsl:element name="prg:hex">FCDE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DivideST5ByST0AndIncrementST">
		<xsl:element name="prg:hex">FDDE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DivideST6ByST0AndIncrementST">
		<xsl:element name="prg:hex">FEDE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DivideST7ByST0AndIncrementST">
		<xsl:element name="prg:hex">FFDE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareAndPopTwice">
		<xsl:element name="prg:hex">D9DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushShortAtAXAddressToST0">
		<xsl:element name="prg:hex">00DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushShortAtCXAddressToST0">
		<xsl:element name="prg:hex">01DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushShortAtDXAddressToST0">
		<xsl:element name="prg:hex">02DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushShortAtBXAddressToST0">
		<xsl:element name="prg:hex">03DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushShortAtIndexAddressToST0">
		<xsl:element name="prg:hex">04DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushShortAtImmediateAddressToST0">
		<xsl:element name="prg:hex">05DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushShortAtSIAddressToST0">
		<xsl:element name="prg:hex">06DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushShortAtDIAddressToST0">
		<xsl:element name="prg:hex">07DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushShortAtAXAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">40DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushShortAtCXAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">41DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushShortAtDXAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">42DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushShortAtBXAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">43DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushShortAtIndexAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">44DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushShortAtImmediateAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">45DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushShortAtSIAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">46DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushShortAtDIAddressPlusImmediate8ToST0">
		<xsl:element name="prg:hex">47DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushShortAtAXAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">80DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushShortAtCXAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">81DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushShortAtDXAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">82DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushShortAtBXAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">83DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushShortAtIndexAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">84DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushShortAtImmediateAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">85DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushShortAtSIAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">86DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushShortAtDIAddressPlusImmediate32ToST0">
		<xsl:element name="prg:hex">87DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToShortAtAXAddress">
		<xsl:element name="prg:hex">10DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToShortAtCXAddress">
		<xsl:element name="prg:hex">11DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToShortAtDXAddress">
		<xsl:element name="prg:hex">12DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToShortAtBXAddress">
		<xsl:element name="prg:hex">13DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToShortAtIndexAddress">
		<xsl:element name="prg:hex">14DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToShortAtImmediateAddress">
		<xsl:element name="prg:hex">15DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToShortAtSIAddress">
		<xsl:element name="prg:hex">16DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToShortAtDIAddress">
		<xsl:element name="prg:hex">17DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToShortAtAXAddressPlusImmediate8">
		<xsl:element name="prg:hex">50DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToShortAtCXAddressPlusImmediate8">
		<xsl:element name="prg:hex">51DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToShortAtDXAddressPlusImmediate8">
		<xsl:element name="prg:hex">52DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToShortAtBXAddressPlusImmediate8">
		<xsl:element name="prg:hex">53DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToShortAtIndexAddressPlusImmediate8">
		<xsl:element name="prg:hex">54DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToShortAtImmediateAddressPlusImmediate8">
		<xsl:element name="prg:hex">55DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToShortAtSIAddressPlusImmediate8">
		<xsl:element name="prg:hex">56DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToShortAtDIAddressPlusImmediate8">
		<xsl:element name="prg:hex">57DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToShortAtAXAddressPlusImmediate32">
		<xsl:element name="prg:hex">90DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToShortAtCXAddressPlusImmediate32">
		<xsl:element name="prg:hex">91DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToShortAtDXAddressPlusImmediate32">
		<xsl:element name="prg:hex">92DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToShortAtBXAddressPlusImmediate32">
		<xsl:element name="prg:hex">93DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToShortAtIndexAddressPlusImmediate32">
		<xsl:element name="prg:hex">94DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToShortAtImmediateAddressPlusImmediate32">
		<xsl:element name="prg:hex">95DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToShortAtSIAddressPlusImmediate32">
		<xsl:element name="prg:hex">96DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyST0ToShortAtDIAddressPlusImmediate32">
		<xsl:element name="prg:hex">97DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullShortAtAXAddressFromST0">
		<xsl:element name="prg:hex">18DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullShortAtCXAddressFromST0">
		<xsl:element name="prg:hex">19DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullShortAtDXAddressFromST0">
		<xsl:element name="prg:hex">1ADF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullShortAtBXAddressFromST0">
		<xsl:element name="prg:hex">1BDF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullShortAtIndexAddressFromST0">
		<xsl:element name="prg:hex">1CDF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullShortAtImmediateAddressFromST0">
		<xsl:element name="prg:hex">1DDF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullShortAtSIAddressFromST0">
		<xsl:element name="prg:hex">1EDF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullShortAtDIAddressFromST0">
		<xsl:element name="prg:hex">1FDF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullShortAtAXAddressPlusImmediate8FromST0">
		<xsl:element name="prg:hex">58DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullShortAtCXAddressPlusImmediate8FromST0">
		<xsl:element name="prg:hex">59DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullShortAtDXAddressPlusImmediate8FromST0">
		<xsl:element name="prg:hex">5ADF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullShortAtBXAddressPlusImmediate8FromST0">
		<xsl:element name="prg:hex">5BDF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullShortAtIndexAddressPlusImmediate8FromST0">
		<xsl:element name="prg:hex">5CDF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullShortAtImmediateAddressPlusImmediate8FromST0">
		<xsl:element name="prg:hex">5DDF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullShortAtSIAddressPlusImmediate8FromST0">
		<xsl:element name="prg:hex">5EDF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullShortAtDIAddressPlusImmediate8FromST0">
		<xsl:element name="prg:hex">5FDF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullShortAtAXAddressPlusImmediate32FromST0">
		<xsl:element name="prg:hex">98DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullShortAtCXAddressPlusImmediate32FromST0">
		<xsl:element name="prg:hex">99DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullShortAtDXAddressPlusImmediate32FromST0">
		<xsl:element name="prg:hex">9ADF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullShortAtBXAddressPlusImmediate32FromST0">
		<xsl:element name="prg:hex">9BDF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullShortAtIndexAddressPlusImmediate32FromST0">
		<xsl:element name="prg:hex">9CDF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullShortAtImmediateAddressPlusImmediate32FromST0">
		<xsl:element name="prg:hex">9DDF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullShortAtSIAddressPlusImmediate32FromST0">
		<xsl:element name="prg:hex">9EDF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullShortAtDIAddressPlusImmediate32FromST0">
		<xsl:element name="prg:hex">9FDF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyStatusToAX">
		<xsl:element name="prg:hex">E0DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST0ToST0AndSetCpuFlagsAndIncrementSTWithExceptions">
		<xsl:element name="prg:hex">E8DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST1ToST0AndSetCpuFlagsAndIncrementSTWithExceptions">
		<xsl:element name="prg:hex">E9DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST2ToST0AndSetCpuFlagsAndIncrementSTWithExceptions">
		<xsl:element name="prg:hex">EADF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST3ToST0AndSetCpuFlagsAndIncrementSTWithExceptions">
		<xsl:element name="prg:hex">EBDF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST4ToST0AndSetCpuFlagsAndIncrementSTWithExceptions">
		<xsl:element name="prg:hex">ECDF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST5ToST0AndSetCpuFlagsAndIncrementSTWithExceptions">
		<xsl:element name="prg:hex">EDDF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST6ToST0AndSetCpuFlagsAndIncrementSTWithExceptions">
		<xsl:element name="prg:hex">EEDF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST7ToST0AndSetCpuFlagsAndIncrementSTWithExceptions">
		<xsl:element name="prg:hex">EFDF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST0ToST0AndSetCpuFlagsAndIncrementST">
		<xsl:element name="prg:hex">F0DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST1ToST0AndSetCpuFlagsAndIncrementST">
		<xsl:element name="prg:hex">F1DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST2ToST0AndSetCpuFlagsAndIncrementST">
		<xsl:element name="prg:hex">F2DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST3ToST0AndSetCpuFlagsAndIncrementST">
		<xsl:element name="prg:hex">F3DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST4ToST0AndSetCpuFlagsAndIncrementST">
		<xsl:element name="prg:hex">F4DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST5ToST0AndSetCpuFlagsAndIncrementST">
		<xsl:element name="prg:hex">F5DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST6ToST0AndSetCpuFlagsAndIncrementST">
		<xsl:element name="prg:hex">F6DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareST7ToST0AndSetCpuFlagsAndIncrementST">
		<xsl:element name="prg:hex">F7DF</xsl:element>
	</xsl:template>
</xsl:stylesheet>