<?xml version="1.0" encoding="utf-16"?>
<xsl:stylesheet version="1.0" xmlns:ns="http://metalx.org/Wdc/65C02/Operators" xmlns:prg="http://metalx.org/Program" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="ns:Break">
		<xsl:element name="prg:hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="ns:NoOperation">
		<xsl:element name="prg:hex">EA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareAccumulatorToImmediate8">
		<xsl:element name="prg:hex">C9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareAccumulatorToImmediate8Address">
		<xsl:element name="prg:hex">C5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareAccumulatorToImmediate8PlusXIndexAddress">
		<xsl:element name="prg:hex">D5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareAccumulatorToImmediate16Address">
		<xsl:element name="prg:hex">CD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareAccumulatorToImmediate16PlusXIndexAddress">
		<xsl:element name="prg:hex">DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareAccumulatorToImmediate16PlusYIndexAddress">
		<xsl:element name="prg:hex">D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareAccumulatorToImmediate8PlusXIndexPointerAddress">
		<xsl:element name="prg:hex">C1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareAccumulatorToImmediate8PointerPlusYIndexAddress">
		<xsl:element name="prg:hex">D1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareAccumulatorToImmediate8PointerAddress">
		<xsl:element name="prg:hex">D2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareXIndexToImmediate8">
		<xsl:element name="prg:hex">E0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareXIndexToImmediate8Address">
		<xsl:element name="prg:hex">E4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareXIndexToImmediate16Address">
		<xsl:element name="prg:hex">EC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareYIndexToImmediate8">
		<xsl:element name="prg:hex">C0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareYIndexToImmediate8Address">
		<xsl:element name="prg:hex">C4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareYIndexToImmediate16Address">
		<xsl:element name="prg:hex">CC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TestSubtractImmediate8FromAccumulator">
		<xsl:element name="prg:hex">C9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TestSubtractImmediate8AddressFromAccumulator">
		<xsl:element name="prg:hex">C5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TestSubtractImmediate8PlusXIndexAddressFromAccumulator">
		<xsl:element name="prg:hex">D5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TestSubtractImmediate16AddressFromAccumulator">
		<xsl:element name="prg:hex">CD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TestSubtractImmediate16PlusXIndexAddressFromAccumulator">
		<xsl:element name="prg:hex">DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TestSubtractImmediate16PlusYIndexAddressFromAccumulator">
		<xsl:element name="prg:hex">D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TestSubtractImmediate8PlusXIndexPointerAddressFromAccumulator">
		<xsl:element name="prg:hex">C1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TestSubtractImmediate8PointerPlusYIndexAddressFromAccumulator">
		<xsl:element name="prg:hex">D1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TestSubtractImmediate8PointerAddressFromAccumulator">
		<xsl:element name="prg:hex">D2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TestSubtractImmediate8FromXIndex">
		<xsl:element name="prg:hex">E0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TestSubtractImmediate8AddressFromXIndex">
		<xsl:element name="prg:hex">E4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TestSubtractImmediate16AddressFromXIndex">
		<xsl:element name="prg:hex">EC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TestSubtractImmediate8FromYIndex">
		<xsl:element name="prg:hex">C0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TestSubtractImmediate8AddressFromYIndex">
		<xsl:element name="prg:hex">C4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TestSubtractImmediate16AddressFromYIndex">
		<xsl:element name="prg:hex">CC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TestAndAccumulatorWithImmediate8Address">
		<xsl:element name="prg:hex">24</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TestAndAccumulatorWithImmediate16Address">
		<xsl:element name="prg:hex">2C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TestAndAccumulatorWithImmediate8">
		<xsl:element name="prg:hex">89</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TestAndAccumulatorWithImmediate8PlusXAddress">
		<xsl:element name="prg:hex">34</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TestAndAccumulatorWithImmediate16PlusXAddress">
		<xsl:element name="prg:hex">3C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TestAndAccumulatorWithImmediate8AddressWithClear">
		<xsl:element name="prg:hex">14</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TestAndAccumulatorWithImmediate16AddressWithClear">
		<xsl:element name="prg:hex">1C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TestAndAccumulatorWithImmediate8AddressWithSet">
		<xsl:element name="prg:hex">04</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TestAndAccumulatorWithImmediate16AddressWithSet">
		<xsl:element name="prg:hex">0C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfImmediate8AddressBit0Clear">
		<xsl:element name="prg:hex">0F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfImmediate8AddressBit1Clear">
		<xsl:element name="prg:hex">1F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfImmediate8AddressBit2Clear">
		<xsl:element name="prg:hex">2F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfImmediate8AddressBit3Clear">
		<xsl:element name="prg:hex">3F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfImmediate8AddressBit4Clear">
		<xsl:element name="prg:hex">4F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfImmediate8AddressBit5Clear">
		<xsl:element name="prg:hex">5F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfImmediate8AddressBit6Clear">
		<xsl:element name="prg:hex">6F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfImmediate8AddressBit7Clear">
		<xsl:element name="prg:hex">7F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfImmediate8AddressBit0Set">
		<xsl:element name="prg:hex">8F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfImmediate8AddressBit1Set">
		<xsl:element name="prg:hex">9F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfImmediate8AddressBit2Set">
		<xsl:element name="prg:hex">AF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfImmediate8AddressBit3Set">
		<xsl:element name="prg:hex">BF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfImmediate8AddressBit4Set">
		<xsl:element name="prg:hex">CF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfImmediate8AddressBit5Set">
		<xsl:element name="prg:hex">DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfImmediate8AddressBit6Set">
		<xsl:element name="prg:hex">EF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfImmediate8AddressBit7Set">
		<xsl:element name="prg:hex">FF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ClearImmediate8AddressBit0">
		<xsl:element name="prg:hex">07</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ClearImmediate8AddressBit1">
		<xsl:element name="prg:hex">17</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ClearImmediate8AddressBit2">
		<xsl:element name="prg:hex">27</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ClearImmediate8AddressBit3">
		<xsl:element name="prg:hex">37</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ClearImmediate8AddressBit4">
		<xsl:element name="prg:hex">47</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ClearImmediate8AddressBit5">
		<xsl:element name="prg:hex">57</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ClearImmediate8AddressBit6">
		<xsl:element name="prg:hex">67</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ClearImmediate8AddressBit7">
		<xsl:element name="prg:hex">77</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetImmediate8AddressBit0">
		<xsl:element name="prg:hex">87</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetImmediate8AddressBit1">
		<xsl:element name="prg:hex">97</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetImmediate8AddressBit2">
		<xsl:element name="prg:hex">A7</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetImmediate8AddressBit3">
		<xsl:element name="prg:hex">B7</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetImmediate8AddressBit4">
		<xsl:element name="prg:hex">C7</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetImmediate8AddressBit5">
		<xsl:element name="prg:hex">D7</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetImmediate8AddressBit6">
		<xsl:element name="prg:hex">E7</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetImmediate8AddressBit7">
		<xsl:element name="prg:hex">F7</xsl:element>
	</xsl:template>
	<xsl:template match="ns:StopProcessor">
		<xsl:element name="prg:hex">DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:WaitForInterrupt">
		<xsl:element name="prg:hex">CB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IncrementImmediate8Address">
		<xsl:element name="prg:hex">E6</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IncrementImmediate8PlusXIndexAddress">
		<xsl:element name="prg:hex">F6</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IncrementImmediate16Address">
		<xsl:element name="prg:hex">EE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IncrementImmediate16PlusXIndexAddress">
		<xsl:element name="prg:hex">FE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IncrementAccumulator">
		<xsl:element name="prg:hex">1A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IncrementXIndex">
		<xsl:element name="prg:hex">E8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IncrementYIndex">
		<xsl:element name="prg:hex">C8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DecrementImmediate8Address">
		<xsl:element name="prg:hex">C6</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DecrementImmediate8PlusXIndexAddress">
		<xsl:element name="prg:hex">D6</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DecrementImmediate16Address">
		<xsl:element name="prg:hex">CE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DecrementImmediate16PlusXIndexAddress">
		<xsl:element name="prg:hex">DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DecrementAccumulator">
		<xsl:element name="prg:hex">3A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DecrementXIndex">
		<xsl:element name="prg:hex">CA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DecrementYIndex">
		<xsl:element name="prg:hex">88</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OrAccumulatorWithImmediate8">
		<xsl:element name="prg:hex">09</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OrAccumulatorWithImmediate8Address">
		<xsl:element name="prg:hex">05</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OrAccumulatorWithImmediate8PlusXIndexAddress">
		<xsl:element name="prg:hex">15</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OrAccumulatorWithImmediate16Address">
		<xsl:element name="prg:hex">0D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OrAccumulatorWithImmediate16PlusXIndexAddress">
		<xsl:element name="prg:hex">1D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OrAccumulatorWithImmediate16PlusYIndexAddress">
		<xsl:element name="prg:hex">19</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OrAccumulatorWithImmediate8PlusXIndexPointerAddress">
		<xsl:element name="prg:hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OrAccumulatorWithImmediate8PointerPlusYIndexAddress">
		<xsl:element name="prg:hex">11</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OrAccumulatorWithImmediate8PointerAddress">
		<xsl:element name="prg:hex">12</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExclusiveOrAccumulatorWithImmediate8">
		<xsl:element name="prg:hex">49</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExclusiveOrAccumulatorWithImmediate8Address">
		<xsl:element name="prg:hex">45</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExclusiveOrAccumulatorWithImmediate8PlusXIndexAddress">
		<xsl:element name="prg:hex">55</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExclusiveOrAccumulatorWithImmediate16Address">
		<xsl:element name="prg:hex">4D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExclusiveOrAccumulatorWithImmediate16PlusXIndexAddress">
		<xsl:element name="prg:hex">5D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExclusiveOrAccumulatorWithImmediate16PlusYIndexAddress">
		<xsl:element name="prg:hex">59</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExclusiveOrAccumulatorWithImmediate8PlusXIndexPointerAddress">
		<xsl:element name="prg:hex">41</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExclusiveOrAccumulatorWithImmediate8PointerPlusYIndexAddress">
		<xsl:element name="prg:hex">51</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExclusiveOrAccumulatorWithImmediate8PointerAddress">
		<xsl:element name="prg:hex">52</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftAccumulatorLeft">
		<xsl:element name="prg:hex">0A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftImmediate8AddressLeft">
		<xsl:element name="prg:hex">06</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftImmediate8PlusXIndexAddressLeft">
		<xsl:element name="prg:hex">16</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftImmediate16AddressLeft">
		<xsl:element name="prg:hex">0E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftImmediate16PlusXIndexAddressLeft">
		<xsl:element name="prg:hex">1E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftAccumulatorRight">
		<xsl:element name="prg:hex">4A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftImmediate8AddressRight">
		<xsl:element name="prg:hex">46</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftImmediate8PlusXIndexAddressRight">
		<xsl:element name="prg:hex">56</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftImmediate16AddressRight">
		<xsl:element name="prg:hex">4E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftImmediate16PlusXIndexAddressRight">
		<xsl:element name="prg:hex">5E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RollAccumulatorLeft">
		<xsl:element name="prg:hex">2A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RollImmediate8AddressLeft">
		<xsl:element name="prg:hex">26</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RollImmediate8PlusXIndexAddressLeft">
		<xsl:element name="prg:hex">36</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RollImmediate16AddressLeft">
		<xsl:element name="prg:hex">2E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RollImmediate16PlusXIndexAddressLeft">
		<xsl:element name="prg:hex">3E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RollAccumulatorRight">
		<xsl:element name="prg:hex">6A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RollImmediate8AddressRight">
		<xsl:element name="prg:hex">66</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RollImmediate8PlusXIndexAddressRight">
		<xsl:element name="prg:hex">76</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RollImmediate16AddressRight">
		<xsl:element name="prg:hex">6E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RollImmediate16PlusXIndexAddressRight">
		<xsl:element name="prg:hex">7E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullStatusFromStack">
		<xsl:element name="prg:hex">28</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullAccumulatorFromStack">
		<xsl:element name="prg:hex">68</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullXIndexFromStack">
		<xsl:element name="prg:hex">FA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullYIndexFromStack">
		<xsl:element name="prg:hex">7A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushStatusToStack">
		<xsl:element name="prg:hex">08</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushAccumulatorToStack">
		<xsl:element name="prg:hex">48</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushXIndexToStack">
		<xsl:element name="prg:hex">DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushYIndexToStack">
		<xsl:element name="prg:hex">5A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ClearCarryFlag">
		<xsl:element name="prg:hex">18</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetCarryFlag">
		<xsl:element name="prg:hex">38</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ClearDecimalFlag">
		<xsl:element name="prg:hex">D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetDecimalFlag">
		<xsl:element name="prg:hex">F8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ClearInterruptDisableFlag">
		<xsl:element name="prg:hex">58</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetInterruptDisableFlag">
		<xsl:element name="prg:hex">78</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ClearOverflowFlag">
		<xsl:element name="prg:hex">B8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfPositive">
		<xsl:element name="prg:hex">10</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfNegative">
		<xsl:element name="prg:hex">30</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfNotCarry">
		<xsl:element name="prg:hex">90</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfLess">
		<xsl:element name="prg:hex">90</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfCarry">
		<xsl:element name="prg:hex">B0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfGreaterOrEqual">
		<xsl:element name="prg:hex">B0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfEqual">
		<xsl:element name="prg:hex">F0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfNotEqual">
		<xsl:element name="prg:hex">D0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfZero">
		<xsl:element name="prg:hex">F0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfNotZero">
		<xsl:element name="prg:hex">D0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfNotOverflow">
		<xsl:element name="prg:hex">50</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelative8IfOverflow">
		<xsl:element name="prg:hex">70</xsl:element>
	</xsl:template>
	<xsl:template match="ns:JumpToImmediate16Address">
		<xsl:element name="prg:hex">4C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:JumpToImmediate16PlusXIndexAddress">
		<xsl:element name="prg:hex">7C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:JumpToImmediate8PointerAddress">
		<xsl:element name="prg:hex">6C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:JumpToRelative8Address">
		<xsl:element name="prg:hex">80</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CallImmediate16Address">
		<xsl:element name="prg:hex">20</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ReturnFromInterrupt">
		<xsl:element name="prg:hex">40</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ReturnFromSubroutine">
		<xsl:element name="prg:hex">60</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TestImmediate8AddressWithAccumulator">
		<xsl:element name="prg:hex">24</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TestImmediate16AddressWithAccumulator">
		<xsl:element name="prg:hex">2C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddImmediate8ToAccumulator">
		<xsl:element name="prg:hex">69</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddImmediate8AddressToAccumulator">
		<xsl:element name="prg:hex">65</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddImmediate8PlusXIndexAddressToAccumulator">
		<xsl:element name="prg:hex">75</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddImmediate16AddressToAccumulator">
		<xsl:element name="prg:hex">6D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddImmediate16PlusXIndexAddressToAccumulator">
		<xsl:element name="prg:hex">7D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddImmediate16PlusYIndexAddressToAccumulator">
		<xsl:element name="prg:hex">79</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddImmediate8PlusXIndexPointerAddressToAccumulator">
		<xsl:element name="prg:hex">61</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddImmediate8PointerPlusYIndexAddressToAccumulator">
		<xsl:element name="prg:hex">71</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddImmediate8PointerAddressToAccumulator">
		<xsl:element name="prg:hex">72</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractImmediate8FromAccumulator">
		<xsl:element name="prg:hex">E9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractImmediate8AddressFromAccumulator">
		<xsl:element name="prg:hex">E5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractImmediate8PlusXIndexAddressFromAccumulator">
		<xsl:element name="prg:hex">F5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractImmediate16AddressFromAccumulator">
		<xsl:element name="prg:hex">ED</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractImmediate16PlusXIndexAddressFromAccumulator">
		<xsl:element name="prg:hex">FD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractImmediate16PlusYIndexAddressFromAccumulator">
		<xsl:element name="prg:hex">F9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractImmediate8PlusXIndexPointerAddressFromAccumulator">
		<xsl:element name="prg:hex">E1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractImmediate8PointerPlusYIndexAddressFromAccumulator">
		<xsl:element name="prg:hex">F1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractImmediate8PointerAddressFromAccumulator">
		<xsl:element name="prg:hex">F2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AndAccumulatorWithImmediate8">
		<xsl:element name="prg:hex">29</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AndAccumulatorWithImmediate8Address">
		<xsl:element name="prg:hex">25</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AndAccumulatorWithImmediate8PlusXIndexAddress">
		<xsl:element name="prg:hex">35</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AndAccumulatorWithImmediate16Address">
		<xsl:element name="prg:hex">2D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AndAccumulatorWithImmediate16PlusXIndexAddress">
		<xsl:element name="prg:hex">3D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AndAccumulatorWithImmediate16PlusYIndexAddress">
		<xsl:element name="prg:hex">39</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AndAccumulatorWithImmediate8PlusXIndexPointerAddress">
		<xsl:element name="prg:hex">21</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AndAccumulatorWithImmediate8PointerPlusYIndexAddress">
		<xsl:element name="prg:hex">31</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AndAccumulatorWithImmediate8PointerAddress">
		<xsl:element name="prg:hex">32</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediate8ToAccumulator">
		<xsl:element name="prg:hex">A9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediate8AddressToAccumulator">
		<xsl:element name="prg:hex">A5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediate8PlusXIndexAddressToAccumulator">
		<xsl:element name="prg:hex">B5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediate16AddressToAccumulator">
		<xsl:element name="prg:hex">AD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediate16PlusXIndexAddressToAccumulator">
		<xsl:element name="prg:hex">BD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediate16PlusYIndexAddressToAccumulator">
		<xsl:element name="prg:hex">B9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediate8PlusXIndexPointerAddressToAccumulator">
		<xsl:element name="prg:hex">A1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediate8PointerPlusYIndexAddressToAccumulator">
		<xsl:element name="prg:hex">B1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediate8PointerAddressToAccumulator">
		<xsl:element name="prg:hex">B2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediate8ToXIndex">
		<xsl:element name="prg:hex">A2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediate8AddressToXIndex">
		<xsl:element name="prg:hex">A6</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediate8PlusYIndexAddressToXIndex">
		<xsl:element name="prg:hex">B6</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediate16AddressToXIndex">
		<xsl:element name="prg:hex">AE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediate16PlusYIndexAddressToXIndex">
		<xsl:element name="prg:hex">BE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediate8ToYIndex">
		<xsl:element name="prg:hex">A0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediate8AddressToYIndex">
		<xsl:element name="prg:hex">A4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediate8PlusXIndexAddressToYIndex">
		<xsl:element name="prg:hex">B4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediate16AddressToYIndex">
		<xsl:element name="prg:hex">AC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediate16PlusXIndexAddressToYIndex">
		<xsl:element name="prg:hex">BC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAccumulatorToImmediate8Address">
		<xsl:element name="prg:hex">85</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAccumulatorToImmediate8PlusXIndexAddress">
		<xsl:element name="prg:hex">95</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAccumulatorToImmediate16Address">
		<xsl:element name="prg:hex">8D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAccumulatorToImmediate16PlusXIndexAddress">
		<xsl:element name="prg:hex">9D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAccumulatorToImmediate16PlusYIndexAddress">
		<xsl:element name="prg:hex">99</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAccumulatorToImmediate8PlusXIndexPointerAddress">
		<xsl:element name="prg:hex">81</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAccumulatorToImmediate8PointerPlusYIndexAddress">
		<xsl:element name="prg:hex">91</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAccumulatorToImmediate8PointerAddress">
		<xsl:element name="prg:hex">92</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyXIndexToImmediate8Address">
		<xsl:element name="prg:hex">86</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyXIndexToImmediate8PlusYIndexAddress">
		<xsl:element name="prg:hex">96</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyXIndexToImmediate16Address">
		<xsl:element name="prg:hex">8E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyYIndexToImmediate8Address">
		<xsl:element name="prg:hex">84</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyYIndexToImmediate8PlusYIndexAddress">
		<xsl:element name="prg:hex">94</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyYIndexToImmediate16Address">
		<xsl:element name="prg:hex">8C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAccumulatorToXIndex">
		<xsl:element name="prg:hex">AA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAccumulatorToYIndex">
		<xsl:element name="prg:hex">A8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyStackPointerToXIndex">
		<xsl:element name="prg:hex">BA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyXIndexToAccumulator">
		<xsl:element name="prg:hex">8A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyXIndexToStackPointer">
		<xsl:element name="prg:hex">9A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyYIndexToAccumulator">
		<xsl:element name="prg:hex">98</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyZeroToImmediate8Address">
		<xsl:element name="prg:hex">64</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyZeroToImmediate8PlusXIndexAddress">
		<xsl:element name="prg:hex">74</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyZeroToImmediate16Address">
		<xsl:element name="prg:hex">9C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyZeroToImmediate16PlusXIndexAddress">
		<xsl:element name="prg:hex">9E</xsl:element>
	</xsl:template>
</xsl:stylesheet>