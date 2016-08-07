<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns="http://metalx.org/Program" xmlns:cpu="http://metalx.org/Intel/80386/Operators" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="cpu:AddRegisterToOperand8">
		<xsl:element name="hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:AddRegisterToOperand">
		<xsl:element name="hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:AddOperandToRegister8">
		<xsl:element name="hex">02</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:AddOperandToRegister">
		<xsl:element name="hex">03</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:AddImmediateToAL">
		<xsl:element name="hex">04</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:AddImmediateToAX">
		<xsl:element name="hex">05</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushESToStack">
		<xsl:element name="hex">06</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PullESFromStack">
		<xsl:element name="hex">07</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:OrOperandWithRegister8">
		<xsl:element name="hex">08</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:OrOperandWithRegister">
		<xsl:element name="hex">09</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:OrRegisterWithOperand8">
		<xsl:element name="hex">0A</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:OrRegisterWithOperand">
		<xsl:element name="hex">0B</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:OrALWithImmediate">
		<xsl:element name="hex">0C</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:OrAXWithImmediate">
		<xsl:element name="hex">0D</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushCSToStack">
		<xsl:element name="hex">0E</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:AddRegisterToOperandWithCarry8">
		<xsl:element name="hex">10</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:AddRegisterToOperandWithCarry">
		<xsl:element name="hex">11</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:AddOperandToRegisterWithCarry8">
		<xsl:element name="hex">12</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:AddOperandToRegisterWithCarry">
		<xsl:element name="hex">13</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:AddImmediateToALWithCarry">
		<xsl:element name="hex">14</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:AddImmediateToAXWithCarry">
		<xsl:element name="hex">15</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushSSToStack">
		<xsl:element name="hex">16</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PullSSFromStack">
		<xsl:element name="hex">17</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SubtractRegisterFromOperandWithBorrow8">
		<xsl:element name="hex">18</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SubtractRegisterFromOperandWithBorrow">
		<xsl:element name="hex">19</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SubtractOperandFromRegisterWithBorrow8">
		<xsl:element name="hex">1A</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SubtractOperandFromRegisterWithBorrow">
		<xsl:element name="hex">1B</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SubtractImmediateFromALWithBorrow">
		<xsl:element name="hex">1C</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SubtractImmediateFromAXWithBorrow">
		<xsl:element name="hex">1D</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushDSToStack">
		<xsl:element name="hex">1E</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PullDSFromStack">
		<xsl:element name="hex">1F</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:AndOperandWithRegister8">
		<xsl:element name="hex">20</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:AndOperandWithRegister">
		<xsl:element name="hex">21</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:AndRegisterWithOperand8">
		<xsl:element name="hex">22</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:AndRegisterWithOperand">
		<xsl:element name="hex">23</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:AndALWithImmediate">
		<xsl:element name="hex">24</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:AndAXWithImmediate">
		<xsl:element name="hex">25</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SubtractRegisterFromOperand8">
		<xsl:element name="hex">28</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SubtractRegisterFromOperand">
		<xsl:element name="hex">29</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SubtractOperandFromRegister8">
		<xsl:element name="hex">2A</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SubtractOperandFromRegister">
		<xsl:element name="hex">2B</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SubtractImmediateFromAL">
		<xsl:element name="hex">2C</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SubtractImmediateFromAX">
		<xsl:element name="hex">2D</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ExclusiveOrOperandWithRegister8">
		<xsl:element name="hex">30</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ExclusiveOrOperandWithRegister">
		<xsl:element name="hex">31</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ExclusiveOrRegisterWithOperand8">
		<xsl:element name="hex">32</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ExclusiveOrRegisterWithOperand">
		<xsl:element name="hex">33</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ExclusiveOrALWithImmediate">
		<xsl:element name="hex">34</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ExclusiveOrAXWithImmediate">
		<xsl:element name="hex">35</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CompareOperandToRegister8">
		<xsl:element name="hex">38</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CompareOperandToRegister">
		<xsl:element name="hex">39</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CompareRegisterToOperand8">
		<xsl:element name="hex">3A</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CompareRegisterToOperand">
		<xsl:element name="hex">3B</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CompareALToImmediate">
		<xsl:element name="hex">3C</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CompareAXToImmediate">
		<xsl:element name="hex">3D</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:IncrementAX">
		<xsl:element name="hex">40</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:IncrementCX">
		<xsl:element name="hex">41</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:IncrementDX">
		<xsl:element name="hex">42</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:IncrementBX">
		<xsl:element name="hex">43</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:IncrementSP">
		<xsl:element name="hex">44</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:IncrementBP">
		<xsl:element name="hex">45</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:IncrementSI">
		<xsl:element name="hex">46</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:IncrementDI">
		<xsl:element name="hex">47</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:DecrementAX">
		<xsl:element name="hex">48</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:DecrementCX">
		<xsl:element name="hex">49</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:DecrementDX">
		<xsl:element name="hex">4A</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:DecrementBX">
		<xsl:element name="hex">4B</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:DecrementSP">
		<xsl:element name="hex">4C</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:DecrementBP">
		<xsl:element name="hex">4D</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:DecrementSI">
		<xsl:element name="hex">4E</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:DecrementDI">
		<xsl:element name="hex">4F</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushAXToStack">
		<xsl:element name="hex">50</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushCXToStack">
		<xsl:element name="hex">51</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushDXToStack">
		<xsl:element name="hex">52</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushBXToStack">
		<xsl:element name="hex">53</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushSPToStack">
		<xsl:element name="hex">54</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushBPToStack">
		<xsl:element name="hex">55</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushSIToStack">
		<xsl:element name="hex">56</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushDIToStack">
		<xsl:element name="hex">57</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PullAXFromStack">
		<xsl:element name="hex">58</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PullCXFromStack">
		<xsl:element name="hex">59</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PullDXFromStack">
		<xsl:element name="hex">5A</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PullBXFromStack">
		<xsl:element name="hex">5B</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PullSPFromStack">
		<xsl:element name="hex">5C</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PullBPFromStack">
		<xsl:element name="hex">5D</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PullSIFromStack">
		<xsl:element name="hex">5E</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PullDIFromStack">
		<xsl:element name="hex">5F</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushAllRegistersToStack">
		<xsl:element name="hex">60</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PullAllRegistersFromStack">
		<xsl:element name="hex">61</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CheckBoundaries">
		<xsl:element name="hex">62</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:AdjustPrivilegeLevel">
		<xsl:element name="hex">63</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushImmediateToStack">
		<xsl:element name="hex">68</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SetRegisterToOperandMultipliedByImmediateSigned">
		<xsl:element name="hex">69</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushImmediateToStack8">
		<xsl:element name="hex">6A</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SetRegisterToOperandMultipliedByImmediateSigned8">
		<xsl:element name="hex">6B</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ReadFromDXPortToDIAddressAndIncrementDI8">
		<xsl:element name="hex">6C</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ReadFromDXPortToDIAddressAndIncrementDI">
		<xsl:element name="hex">6D</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:WriteSIAddressToDXPortAndIncrementSI8">
		<xsl:element name="hex">6E</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:WriteSIAddressToDXPortAndIncrementSI">
		<xsl:element name="hex">6F</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchToRelative8IfOverflow">
		<xsl:element name="hex">70</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchToRelative8IfNotOverflow">
		<xsl:element name="hex">71</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchToRelative8IfBelow">
		<xsl:element name="hex">72</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchToRelative8IfNotAboveOrEqual">
		<xsl:element name="hex">72</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchToRelative8IfCarry">
		<xsl:element name="hex">72</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchToRelative8IfAboveOrEqual">
		<xsl:element name="hex">73</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchToRelative8IfNotBelow">
		<xsl:element name="hex">73</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchToRelative8IfNotCarry">
		<xsl:element name="hex">73</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchToRelative8IfZero">
		<xsl:element name="hex">74</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchToRelative8IfEqual">
		<xsl:element name="hex">74</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchToRelative8IfNotZero">
		<xsl:element name="hex">75</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchToRelative8IfNotEqual">
		<xsl:element name="hex">75</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchToRelative8IfBelowOrEqual">
		<xsl:element name="hex">76</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchToRelative8IfNotAbove">
		<xsl:element name="hex">76</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchToRelative8IfAbove">
		<xsl:element name="hex">77</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchToRelative8IfNotBelowOrEqual">
		<xsl:element name="hex">77</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchToRelative8IfNegative">
		<xsl:element name="hex">78</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchToRelative8IfPositive">
		<xsl:element name="hex">79</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchToRelative8IfEven">
		<xsl:element name="hex">7A</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchToRelative8IfOdd">
		<xsl:element name="hex">7B</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchToRelative8IfLess">
		<xsl:element name="hex">7C</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchToRelative8IfNotGreaterOrEqual">
		<xsl:element name="hex">7C</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchToRelative8IfNotLess">
		<xsl:element name="hex">7D</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchToRelative8IfGreaterOrEqual">
		<xsl:element name="hex">7D</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchToRelative8IfLessOrEqual">
		<xsl:element name="hex">7E</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchToRelative8IfNotGreater">
		<xsl:element name="hex">7E</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchToRelative8IfNotLessOrEqual">
		<xsl:element name="hex">7F</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchToRelative8IfGreater">
		<xsl:element name="hex">7F</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:TestOperandWithRegister8">
		<xsl:element name="hex">84</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:TestOperandWithRegister">
		<xsl:element name="hex">85</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ExchangeOperandWithRegister8">
		<xsl:element name="hex">86</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ExchangeOperandWithRegister">
		<xsl:element name="hex">87</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyRegisterToOperand8">
		<xsl:element name="hex">88</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyRegisterToOperand">
		<xsl:element name="hex">89</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyOperandToRegister8">
		<xsl:element name="hex">8A</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyOperandToRegister">
		<xsl:element name="hex">8B</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopySegmentRegisterToOperand">
		<xsl:element name="hex">8C</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SetRegisterToEffectiveAddress">
		<xsl:element name="hex">8D</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyOperandToSegmentRegister">
		<xsl:element name="hex">8E</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:NoOperation">
		<xsl:element name="hex">90</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ExchangeCXWithAX">
		<xsl:element name="hex">91</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ExchangeDXWithAX">
		<xsl:element name="hex">92</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ExchangeBXWithAX">
		<xsl:element name="hex">93</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ExchangeSPWithAX">
		<xsl:element name="hex">94</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ExchangeBPWithAX">
		<xsl:element name="hex">95</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ExchangeSIWithAX">
		<xsl:element name="hex">96</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ExchangeDIWithAX">
		<xsl:element name="hex">97</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ExpandALToAX">
		<xsl:element name="hex">98</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ExpandAXToDXAX">
		<xsl:element name="hex">99</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CallImmediatePointer">
		<xsl:element name="hex">9A</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:WaitForFloatingPointUnit">
		<xsl:element name="hex">9B</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushFlagsToStack">
		<xsl:element name="hex">9C</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PullFlagsFromStack">
		<xsl:element name="hex">9D</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyAHToFlags">
		<xsl:element name="hex">9E</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyFlagsToAH">
		<xsl:element name="hex">9F</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyAbsoluteMemoryToAL">
		<xsl:element name="hex">A0</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyAbsoluteMemoryToAX">
		<xsl:element name="hex">A1</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyALToAbsoluteMemory">
		<xsl:element name="hex">A2</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyAXToAbsoluteMemory">
		<xsl:element name="hex">A3</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopySIAddressToDIAddressAndIncrementSIAndDI8">
		<xsl:element name="hex">A4</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopySIAddressToDIAddressAndIncrementSIAndDI">
		<xsl:element name="hex">A5</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CompareSIAddressToDIAddressAndIncrementSIAndDI8">
		<xsl:element name="hex">A6</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CompareSIAddressToDIAddressAndIncrementSIAndDI">
		<xsl:element name="hex">A7</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:TestALWithImmediate">
		<xsl:element name="hex">A8</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:TestAXWithImmediate">
		<xsl:element name="hex">A9</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyALToDIAddressAndIncrementDI">
		<xsl:element name="hex">AA</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyAXToDIAddressAndIncrementDI">
		<xsl:element name="hex">AB</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopySIAddressToALAndIncrementSI">
		<xsl:element name="hex">AC</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopySIAddressToAXAndIncrementSI">
		<xsl:element name="hex">AD</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CompareALToDIAddressAndIncrementDI">
		<xsl:element name="hex">AE</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CompareAXToDIAddressAndIncrementDI">
		<xsl:element name="hex">AF</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyImmediateToAL">
		<xsl:element name="hex">B0</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyImmediateToCL">
		<xsl:element name="hex">B1</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyImmediateToDL">
		<xsl:element name="hex">B2</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyImmediateToBL">
		<xsl:element name="hex">B3</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyImmediateToAH">
		<xsl:element name="hex">B4</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyImmediateToCH">
		<xsl:element name="hex">B5</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyImmediateToDH">
		<xsl:element name="hex">B6</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyImmediateToBH">
		<xsl:element name="hex">B7</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyImmediateToAX">
		<xsl:element name="hex">B8</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyImmediateToCX">
		<xsl:element name="hex">B9</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyImmediateToDX">
		<xsl:element name="hex">BA</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyImmediateToBX">
		<xsl:element name="hex">BB</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyImmediateToSP">
		<xsl:element name="hex">BC</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyImmediateToBP">
		<xsl:element name="hex">BD</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyImmediateToSI">
		<xsl:element name="hex">BE</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyImmediateToDI">
		<xsl:element name="hex">BF</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ReturnToNearCallerAndPullImmediate">
		<xsl:element name="hex">C2</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ReturnToNearCaller">
		<xsl:element name="hex">C3</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SetESAndRegisterToFarPointer">
		<xsl:element name="hex">C4</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SetDSAndRegisterToFarPointer">
		<xsl:element name="hex">C5</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:EnterStackFrame">
		<xsl:element name="hex">C8</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:LeaveStackFrame">
		<xsl:element name="hex">C9</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ReturnToFarCallerAndPullImmediateFromStack">
		<xsl:element name="hex">CA</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ReturnToFarCaller">
		<xsl:element name="hex">CB</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CallDebuggerInterrupt">
		<xsl:element name="hex">CC</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CallImmediate8Interrupt">
		<xsl:element name="hex">CD</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CallInterruptIfOverflow">
		<xsl:element name="hex">CE</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ReturnFromInterrupt">
		<xsl:element name="hex">CF</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:AdjustAXAfterMultiplyToBaseImmediate8">
		<xsl:element name="hex">D4</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:AdjustAXBeforeDivideToBaseImmediate8">
		<xsl:element name="hex">D5</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyBXAddressPlusALToAL">
		<xsl:element name="hex">D7</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:LoopToRelative8WhileNotEqual">
		<xsl:element name="hex">E0</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:LoopToRelative8WhileNotZero">
		<xsl:element name="hex">E0</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:LoopToRelative8WhileEqual">
		<xsl:element name="hex">E1</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:LoopToRelative8WhileZero">
		<xsl:element name="hex">E1</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:LoopToRelative8">
		<xsl:element name="hex">E2</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchToRelative8IfCXIsZero">
		<xsl:element name="hex">E3</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ReadFromImmediate8PortToAL">
		<xsl:element name="hex">E4</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ReadFromImmediate8PortToAX">
		<xsl:element name="hex">E5</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:WriteALToImmediate8Port">
		<xsl:element name="hex">E6</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:WriteAXToImmediate8Port">
		<xsl:element name="hex">E7</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CallRelative">
		<xsl:element name="hex">E8</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:JumpToRelative">
		<xsl:element name="hex">E9</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:JumpToImmediatePointer">
		<xsl:element name="hex">EA</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:JumpToRelative8">
		<xsl:element name="hex">EB</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ReadFromDXPortToAL">
		<xsl:element name="hex">EC</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ReadFromDXPortToAX">
		<xsl:element name="hex">ED</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:WriteALToDXPort">
		<xsl:element name="hex">EE</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:WriteAXToDXPort">
		<xsl:element name="hex">EF</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:WaitForInterrupt">
		<xsl:element name="hex">F4</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ComplementCarryFlag">
		<xsl:element name="hex">F5</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ClearCarryFlag">
		<xsl:element name="hex">F8</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SetCarryFlag">
		<xsl:element name="hex">F9</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ClearInterruptFlag">
		<xsl:element name="hex">FA</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SetInterruptFlag">
		<xsl:element name="hex">FB</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ClearDirectionFlag">
		<xsl:element name="hex">FC</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SetDirectionFlag">
		<xsl:element name="hex">FD</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SegmentES">
		<xsl:element name="hex">26</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SegmentSS">
		<xsl:element name="hex">36</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SegmentCS">
		<xsl:element name="hex">2E</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SegmentDS">
		<xsl:element name="hex">3E</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:Operand32">
		<xsl:element name="hex">66</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:Operand16">
		<xsl:element name="hex">66</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:Address32">
		<xsl:element name="hex">67</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:Address16">
		<xsl:element name="hex">67</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ExclusiveLock">
		<xsl:element name="hex">F0</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:RepeatWhileNotEqual">
		<xsl:element name="hex">F2</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:Repeat">
		<xsl:element name="hex">F3</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:RepeatWhileEqual">
		<xsl:element name="hex">F3</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ExtendedOperator">
		<xsl:element name="hex">0F</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:MathImmediateToOperandFunction8">
		<xsl:element name="hex">80</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:MathImmediateToOperandFunction">
		<xsl:element name="hex">81</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:MathImmediate8ToOperandFunction">
		<xsl:element name="hex">83</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ArithmeticAXOperandFunction">
		<xsl:element name="hex">F6</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ArithmeticDXAXOperandFunction">
		<xsl:element name="hex">F7</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ShiftRegisterByImmediateFunction8">
		<xsl:element name="hex">C0</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ShiftRegisterByImmediate8Function">
		<xsl:element name="hex">C1</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ShiftRegisterByOneFunction8">
		<xsl:element name="hex">D0</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ShiftRegisterByOneFunction">
		<xsl:element name="hex">D1</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ShiftRegisterByCLFunction8">
		<xsl:element name="hex">D2</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ShiftRegisterByCLFunction">
		<xsl:element name="hex">D3</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyImmediateToOperandFunction8">
		<xsl:element name="hex">C6</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyImmediateToOperandFunction">
		<xsl:element name="hex">C7</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PullOperandFromStackFunction">
		<xsl:element name="hex">8F</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:IncrementFunction8">
		<xsl:element name="hex">FE</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:IncrementFunction">
		<xsl:element name="hex">FF</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:LogicFunction">
		<xsl:element name="hex">FF</xsl:element>
	</xsl:template>
</xsl:stylesheet>