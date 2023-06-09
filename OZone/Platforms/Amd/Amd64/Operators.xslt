<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:ns="http://metalx.org/Amd/Amd64/Operators" xmlns:prg="http://metalx.org/Program" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="ns:AddRegisterToOperand8">
		<xsl:element name="prg:hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddRegisterToOperand">
		<xsl:element name="prg:hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddOperandToRegister8">
		<xsl:element name="prg:hex">02</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddOperandToRegister">
		<xsl:element name="prg:hex">03</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddImmediateToAL">
		<xsl:element name="prg:hex">04</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddImmediateToAX">
		<xsl:element name="prg:hex">05</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushESToStack">
		<xsl:element name="prg:hex">06</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullESFromStack">
		<xsl:element name="prg:hex">07</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OrOperandWithRegister8">
		<xsl:element name="prg:hex">08</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OrOperandWithRegister">
		<xsl:element name="prg:hex">09</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OrRegisterWithOperand8">
		<xsl:element name="prg:hex">0A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OrRegisterWithOperand">
		<xsl:element name="prg:hex">0B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OrALWithImmediate">
		<xsl:element name="prg:hex">0C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OrAXWithImmediate">
		<xsl:element name="prg:hex">0D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushCSToStack">
		<xsl:element name="prg:hex">0E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddRegisterToOperandWithCarry8">
		<xsl:element name="prg:hex">10</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddRegisterToOperandWithCarry">
		<xsl:element name="prg:hex">11</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddOperandToRegisterWithCarry8">
		<xsl:element name="prg:hex">12</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddOperandToRegisterWithCarry">
		<xsl:element name="prg:hex">13</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddImmediateToALWithCarry">
		<xsl:element name="prg:hex">14</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddImmediateToAXWithCarry">
		<xsl:element name="prg:hex">15</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushSSToStack">
		<xsl:element name="prg:hex">16</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullSSFromStack">
		<xsl:element name="prg:hex">17</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractRegisterFromOperandWithBorrow8">
		<xsl:element name="prg:hex">18</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractRegisterFromOperandWithBorrow">
		<xsl:element name="prg:hex">19</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractOperandFromRegisterWithBorrow8">
		<xsl:element name="prg:hex">1A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractOperandFromRegisterWithBorrow">
		<xsl:element name="prg:hex">1B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractImmediateFromALWithBorrow">
		<xsl:element name="prg:hex">1C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractImmediateFromAXWithBorrow">
		<xsl:element name="prg:hex">1D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushDSToStack">
		<xsl:element name="prg:hex">1E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullDSFromStack">
		<xsl:element name="prg:hex">1F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AndOperandWithRegister8">
		<xsl:element name="prg:hex">20</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AndOperandWithRegister">
		<xsl:element name="prg:hex">21</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AndRegisterWithOperand8">
		<xsl:element name="prg:hex">22</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AndRegisterWithOperand">
		<xsl:element name="prg:hex">23</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AndALWithImmediate">
		<xsl:element name="prg:hex">24</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AndAXWithImmediate">
		<xsl:element name="prg:hex">25</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractRegisterFromOperand8">
		<xsl:element name="prg:hex">28</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractRegisterFromOperand">
		<xsl:element name="prg:hex">29</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractOperandFromRegister8">
		<xsl:element name="prg:hex">2A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractOperandFromRegister">
		<xsl:element name="prg:hex">2B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractImmediateFromAL">
		<xsl:element name="prg:hex">2C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractImmediateFromAX">
		<xsl:element name="prg:hex">2D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExclusiveOrOperandWithRegister8">
		<xsl:element name="prg:hex">30</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExclusiveOrOperandWithRegister">
		<xsl:element name="prg:hex">31</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExclusiveOrRegisterWithOperand8">
		<xsl:element name="prg:hex">32</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExclusiveOrRegisterWithOperand">
		<xsl:element name="prg:hex">33</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExclusiveOrALWithImmediate">
		<xsl:element name="prg:hex">34</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExclusiveOrAXWithImmediate">
		<xsl:element name="prg:hex">35</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareOperandToRegister8">
		<xsl:element name="prg:hex">38</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareOperandToRegister">
		<xsl:element name="prg:hex">39</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareRegisterToOperand8">
		<xsl:element name="prg:hex">3A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareRegisterToOperand">
		<xsl:element name="prg:hex">3B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareALToImmediate">
		<xsl:element name="prg:hex">3C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareAXToImmediate">
		<xsl:element name="prg:hex">3D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OperandDefault">
		<xsl:element name="prg:hex">40</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OperandDefaultBase">
		<xsl:element name="prg:hex">41</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OperandDefaultIndex">
		<xsl:element name="prg:hex">42</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OperandDefaultBaseIndex">
		<xsl:element name="prg:hex">43</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OperandDefaultRegister">
		<xsl:element name="prg:hex">44</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OperandDefaultRegisterBase">
		<xsl:element name="prg:hex">45</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OperandDefaultRegisterIndex">
		<xsl:element name="prg:hex">46</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OperandDefaultRegisterBaseIndex">
		<xsl:element name="prg:hex">47</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Operand64">
		<xsl:element name="prg:hex">48</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Operand64Base">
		<xsl:element name="prg:hex">49</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Operand64Index">
		<xsl:element name="prg:hex">4A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Operand64BaseIndex">
		<xsl:element name="prg:hex">4B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Operand64Register">
		<xsl:element name="prg:hex">4C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Operand64RegisterBase">
		<xsl:element name="prg:hex">4D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Operand64RegisterIndex">
		<xsl:element name="prg:hex">4E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Operand64RegisterBaseIndex">
		<xsl:element name="prg:hex">4F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushAXToStack">
		<xsl:element name="prg:hex">50</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushCXToStack">
		<xsl:element name="prg:hex">51</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushDXToStack">
		<xsl:element name="prg:hex">52</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushBXToStack">
		<xsl:element name="prg:hex">53</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushSPToStack">
		<xsl:element name="prg:hex">54</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushBPToStack">
		<xsl:element name="prg:hex">55</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushSIToStack">
		<xsl:element name="prg:hex">56</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushDIToStack">
		<xsl:element name="prg:hex">57</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullAXFromStack">
		<xsl:element name="prg:hex">58</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullCXFromStack">
		<xsl:element name="prg:hex">59</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullDXFromStack">
		<xsl:element name="prg:hex">5A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullBXFromStack">
		<xsl:element name="prg:hex">5B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullSPFromStack">
		<xsl:element name="prg:hex">5C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullBPFromStack">
		<xsl:element name="prg:hex">5D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullSIFromStack">
		<xsl:element name="prg:hex">5E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullDIFromStack">
		<xsl:element name="prg:hex">5F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushAllRegistersToStack">
		<xsl:element name="prg:hex">60</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullAllRegistersFromStack">
		<xsl:element name="prg:hex">61</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CheckBoundaries">
		<xsl:element name="prg:hex">62</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AdjustPrivilegeLevel">
		<xsl:element name="prg:hex">63</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushImmediateToStack">
		<xsl:element name="prg:hex">68</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetRegisterToOperandMultipliedByImmediateSigned">
		<xsl:element name="prg:hex">69</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushImmediateToStack8">
		<xsl:element name="prg:hex">6A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetRegisterToOperandMultipliedByImmediateSigned8">
		<xsl:element name="prg:hex">6B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ReadFromDXPortToDIAddressAndIncrementDI8">
		<xsl:element name="prg:hex">6C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ReadFromDXPortToDIAddressAndIncrementDI">
		<xsl:element name="prg:hex">6D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:WriteSIAddressToDXPortAndIncrementSI8">
		<xsl:element name="prg:hex">6E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:WriteSIAddressToDXPortAndIncrementSI">
		<xsl:element name="prg:hex">6F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfOverflow">
		<xsl:element name="prg:hex">70</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfNotOverflow">
		<xsl:element name="prg:hex">71</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfBelow">
		<xsl:element name="prg:hex">72</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfNotAboveOrEqual">
		<xsl:element name="prg:hex">72</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfCarry">
		<xsl:element name="prg:hex">72</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfAboveOrEqual">
		<xsl:element name="prg:hex">73</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfNotBelow">
		<xsl:element name="prg:hex">73</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfNotCarry">
		<xsl:element name="prg:hex">73</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfZero">
		<xsl:element name="prg:hex">74</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfEqual">
		<xsl:element name="prg:hex">74</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfNotZero">
		<xsl:element name="prg:hex">75</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfNotEqual">
		<xsl:element name="prg:hex">75</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfBelowOrEqual">
		<xsl:element name="prg:hex">76</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfNotAbove">
		<xsl:element name="prg:hex">76</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfAbove">
		<xsl:element name="prg:hex">77</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfNotBelowOrEqual">
		<xsl:element name="prg:hex">77</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfNegative">
		<xsl:element name="prg:hex">78</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfPositive">
		<xsl:element name="prg:hex">79</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfEven">
		<xsl:element name="prg:hex">7A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfOdd">
		<xsl:element name="prg:hex">7B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfLess">
		<xsl:element name="prg:hex">7C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfNotGreaterOrEqual">
		<xsl:element name="prg:hex">7C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfNotLess">
		<xsl:element name="prg:hex">7D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfGreaterOrEqual">
		<xsl:element name="prg:hex">7D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfLessOrEqual">
		<xsl:element name="prg:hex">7E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfNotGreater">
		<xsl:element name="prg:hex">7E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfNotLessOrEqual">
		<xsl:element name="prg:hex">7F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfGreater">
		<xsl:element name="prg:hex">7F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TestOperandWithRegister8">
		<xsl:element name="prg:hex">84</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TestOperandWithRegister">
		<xsl:element name="prg:hex">85</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExchangeOperandWithRegister8">
		<xsl:element name="prg:hex">86</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExchangeOperandWithRegister">
		<xsl:element name="prg:hex">87</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyRegisterToOperand8">
		<xsl:element name="prg:hex">88</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyRegisterToOperand">
		<xsl:element name="prg:hex">89</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyOperandToRegister8">
		<xsl:element name="prg:hex">8A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyOperandToRegister">
		<xsl:element name="prg:hex">8B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopySegmentRegisterToOperand">
		<xsl:element name="prg:hex">8C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetRegisterToEffectiveAddress">
		<xsl:element name="prg:hex">8D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyOperandToSegmentRegister">
		<xsl:element name="prg:hex">8E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:NoOperation">
		<xsl:element name="prg:hex">90</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExchangeCXWithAX">
		<xsl:element name="prg:hex">91</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExchangeDXWithAX">
		<xsl:element name="prg:hex">92</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExchangeBXWithAX">
		<xsl:element name="prg:hex">93</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExchangeSPWithAX">
		<xsl:element name="prg:hex">94</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExchangeBPWithAX">
		<xsl:element name="prg:hex">95</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExchangeSIWithAX">
		<xsl:element name="prg:hex">96</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExchangeDIWithAX">
		<xsl:element name="prg:hex">97</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExpandALToAX">
		<xsl:element name="prg:hex">98</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExpandAXToDXAX">
		<xsl:element name="prg:hex">99</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CallImmediatePointer">
		<xsl:element name="prg:hex">9A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:HandleFloatingPointExceptions">
		<xsl:element name="prg:hex">9B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushFlagsToStack">
		<xsl:element name="prg:hex">9C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullFlagsFromStack">
		<xsl:element name="prg:hex">9D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAHToFlags">
		<xsl:element name="prg:hex">9E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyFlagsToAH">
		<xsl:element name="prg:hex">9F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAbsoluteMemoryToAL">
		<xsl:element name="prg:hex">A0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAbsoluteMemoryToAX">
		<xsl:element name="prg:hex">A1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyALToAbsoluteMemory">
		<xsl:element name="prg:hex">A2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAXToAbsoluteMemory">
		<xsl:element name="prg:hex">A3</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopySIAddressToDIAddressAndIncrementSIAndDI8">
		<xsl:element name="prg:hex">A4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopySIAddressToDIAddressAndIncrementSIAndDI">
		<xsl:element name="prg:hex">A5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareSIAddressToDIAddressAndIncrementSIAndDI8">
		<xsl:element name="prg:hex">A6</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareSIAddressToDIAddressAndIncrementSIAndDI">
		<xsl:element name="prg:hex">A7</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TestALWithImmediate">
		<xsl:element name="prg:hex">A8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TestAXWithImmediate">
		<xsl:element name="prg:hex">A9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyALToDIAddressAndIncrementDI">
		<xsl:element name="prg:hex">AA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAXToDIAddressAndIncrementDI">
		<xsl:element name="prg:hex">AB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopySIAddressToALAndIncrementSI">
		<xsl:element name="prg:hex">AC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopySIAddressToAXAndIncrementSI">
		<xsl:element name="prg:hex">AD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareALToDIAddressAndIncrementDI">
		<xsl:element name="prg:hex">AE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareAXToDIAddressAndIncrementDI">
		<xsl:element name="prg:hex">AF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediateToAL">
		<xsl:element name="prg:hex">B0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediateToCL">
		<xsl:element name="prg:hex">B1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediateToDL">
		<xsl:element name="prg:hex">B2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediateToBL">
		<xsl:element name="prg:hex">B3</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediateToAH">
		<xsl:element name="prg:hex">B4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediateToCH">
		<xsl:element name="prg:hex">B5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediateToDH">
		<xsl:element name="prg:hex">B6</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediateToBH">
		<xsl:element name="prg:hex">B7</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediateToAX">
		<xsl:element name="prg:hex">B8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediateToCX">
		<xsl:element name="prg:hex">B9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediateToDX">
		<xsl:element name="prg:hex">BA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediateToBX">
		<xsl:element name="prg:hex">BB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediateToSP">
		<xsl:element name="prg:hex">BC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediateToBP">
		<xsl:element name="prg:hex">BD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediateToSI">
		<xsl:element name="prg:hex">BE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediateToDI">
		<xsl:element name="prg:hex">BF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ReturnToNearCallerAndPullImmediate">
		<xsl:element name="prg:hex">C2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ReturnToNearCaller">
		<xsl:element name="prg:hex">C3</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetESAndRegisterToFarPointer">
		<xsl:element name="prg:hex">C4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetDSAndRegisterToFarPointer">
		<xsl:element name="prg:hex">C5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:EnterStackFrame">
		<xsl:element name="prg:hex">C8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LeaveStackFrame">
		<xsl:element name="prg:hex">C9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ReturnToFarCallerAndPullImmediateFromStack">
		<xsl:element name="prg:hex">CA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ReturnToFarCaller">
		<xsl:element name="prg:hex">CB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CallDebuggerInterrupt">
		<xsl:element name="prg:hex">CC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CallImmediate8Interrupt">
		<xsl:element name="prg:hex">CD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CallInterruptIfOverflow">
		<xsl:element name="prg:hex">CE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ReturnFromInterrupt">
		<xsl:element name="prg:hex">CF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AdjustAXAfterMultiplyToBaseImmediate8">
		<xsl:element name="prg:hex">D4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AdjustAXBeforeDivideToBaseImmediate8">
		<xsl:element name="prg:hex">D5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyBXAddressPlusALToAL">
		<xsl:element name="prg:hex">D7</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LoopToRelativeWhileNotEqual8">
		<xsl:element name="prg:hex">E0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LoopToRelativeWhileNotZero8">
		<xsl:element name="prg:hex">E0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LoopToRelativeWhileEqual8">
		<xsl:element name="prg:hex">E1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LoopToRelativeWhileZero8">
		<xsl:element name="prg:hex">E1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LoopToRelative8">
		<xsl:element name="prg:hex">E2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelativeIfCXIsZero">
		<xsl:element name="prg:hex">E3</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ReadFromImmediate8PortToAL">
		<xsl:element name="prg:hex">E4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ReadFromImmediate8PortToAX">
		<xsl:element name="prg:hex">E5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:WriteALToImmediate8Port">
		<xsl:element name="prg:hex">E6</xsl:element>
	</xsl:template>
	<xsl:template match="ns:WriteAXToImmediate8Port">
		<xsl:element name="prg:hex">E7</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CallRelative">
		<xsl:element name="prg:hex">E8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:JumpToRelative">
		<xsl:element name="prg:hex">E9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:JumpToImmediatePointer">
		<xsl:element name="prg:hex">EA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:JumpToRelative8">
		<xsl:element name="prg:hex">EB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ReadFromDXPortToAL">
		<xsl:element name="prg:hex">EC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ReadFromDXPortToAX">
		<xsl:element name="prg:hex">ED</xsl:element>
	</xsl:template>
	<xsl:template match="ns:WriteALToDXPort">
		<xsl:element name="prg:hex">EE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:WriteAXToDXPort">
		<xsl:element name="prg:hex">EF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:WaitForInterrupt">
		<xsl:element name="prg:hex">F4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ComplementCarryFlag">
		<xsl:element name="prg:hex">F5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ClearCarryFlag">
		<xsl:element name="prg:hex">F8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetCarryFlag">
		<xsl:element name="prg:hex">F9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ClearInterruptFlag">
		<xsl:element name="prg:hex">FA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetInterruptFlag">
		<xsl:element name="prg:hex">FB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ClearDirectionFlag">
		<xsl:element name="prg:hex">FC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetDirectionFlag">
		<xsl:element name="prg:hex">FD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SegmentES">
		<xsl:element name="prg:hex">26</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SegmentSS">
		<xsl:element name="prg:hex">36</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SegmentCS">
		<xsl:element name="prg:hex">2E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SegmentDS">
		<xsl:element name="prg:hex">3E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Operand32">
		<xsl:element name="prg:hex">66</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Operand16">
		<xsl:element name="prg:hex">66</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Address32">
		<xsl:element name="prg:hex">67</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Address16">
		<xsl:element name="prg:hex">67</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExclusiveLock">
		<xsl:element name="prg:hex">F0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RepeatWhileNotEqual">
		<xsl:element name="prg:hex">F2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Repeat">
		<xsl:element name="prg:hex">F3</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RepeatWhileEqual">
		<xsl:element name="prg:hex">F3</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExtendedOperator">
		<xsl:element name="prg:hex">0F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MathImmediateToOperandFunction8">
		<xsl:element name="prg:hex">80</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MathImmediateToOperandFunction">
		<xsl:element name="prg:hex">81</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MathImmediate8ToOperandFunction">
		<xsl:element name="prg:hex">83</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ArithmeticAXOperandFunction">
		<xsl:element name="prg:hex">F6</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ArithmeticDXAXOperandFunction">
		<xsl:element name="prg:hex">F7</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftRegisterByImmediateFunction8">
		<xsl:element name="prg:hex">C0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftRegisterByImmediate8Function">
		<xsl:element name="prg:hex">C1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftRegisterByOneFunction8">
		<xsl:element name="prg:hex">D0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftRegisterByOneFunction">
		<xsl:element name="prg:hex">D1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftRegisterByCLFunction8">
		<xsl:element name="prg:hex">D2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftRegisterByCLFunction">
		<xsl:element name="prg:hex">D3</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediateToOperandFunction8">
		<xsl:element name="prg:hex">C6</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediateToOperandFunction">
		<xsl:element name="prg:hex">C7</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullOperandFromStackFunction">
		<xsl:element name="prg:hex">8F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IncrementFunction8">
		<xsl:element name="prg:hex">FE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IncrementFunction">
		<xsl:element name="prg:hex">FF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LogicFunction">
		<xsl:element name="prg:hex">FF</xsl:element>
	</xsl:template>
</xsl:stylesheet>