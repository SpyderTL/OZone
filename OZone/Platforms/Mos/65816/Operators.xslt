<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:ns="http://metalx.org/Mos/65816/Operators" xmlns:prg="http://metalx.org/Program" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="ns:AddDirectAddressPlusXIndexPointerToAccumulator">
		<xsl:element name="prg:hex">61</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddStackRelativeAddressToAccumulator">
		<xsl:element name="prg:hex">63</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddDirectAddressToAccumulator">
		<xsl:element name="prg:hex">65</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddDirectAddressLongPointerToAccumulator">
		<xsl:element name="prg:hex">67</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddImmediateToAccumulator">
		<xsl:element name="prg:hex">69</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddAbsoluteAddressToAccumulator">
		<xsl:element name="prg:hex">6D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddAbsoluteLongAddressToAccumulator">
		<xsl:element name="prg:hex">6F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddDirectAddressPointerPlusYIndexToAccumulator">
		<xsl:element name="prg:hex">71</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddDirectAddressPointerToAccumulator">
		<xsl:element name="prg:hex">72</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddStackRelativePointerPlusYIndexToAccumulator">
		<xsl:element name="prg:hex">73</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddDirectAddressPlusXIndexToAccumulator">
		<xsl:element name="prg:hex">75</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddDirectAddressLongPointerPlusYIndexToAccumulator">
		<xsl:element name="prg:hex">77</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddAbsoluteAddressPlusYIndexToAccumulator">
		<xsl:element name="prg:hex">79</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddAbsoluteAddressPlusXIndexToAccumulator">
		<xsl:element name="prg:hex">7D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddAbsoluteLongAddressPlusXIndexToAccumulator">
		<xsl:element name="prg:hex">7F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AndAccumulatorWithDirectAddressPlusXIndexPointer">
		<xsl:element name="prg:hex">21</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AndAccumulatorWithStackRelativeAddress">
		<xsl:element name="prg:hex">23</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AndAccumulatorWithDirectAddress">
		<xsl:element name="prg:hex">25</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AndAccumulatorWithDirectAddressLongPointer">
		<xsl:element name="prg:hex">27</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AndAccumulatorWithImmediate">
		<xsl:element name="prg:hex">29</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AndAccumulatorWithAbsoluteAddress">
		<xsl:element name="prg:hex">2D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AndAccumulatorWithAbsoluteLongAddress">
		<xsl:element name="prg:hex">2F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AndAccumulatorWithDirectAddressPointerPlusYIndex">
		<xsl:element name="prg:hex">31</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AndAccumulatorWithDirectAddressPointer">
		<xsl:element name="prg:hex">32</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AndAccumulatorWithStackRelativePointerPlusYIndex">
		<xsl:element name="prg:hex">33</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AndAccumulatorWithDirectAddressPlusXIndex">
		<xsl:element name="prg:hex">35</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AndAccumulatorWithDirectAddressLongPointerPlusYIndex">
		<xsl:element name="prg:hex">37</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AndAccumulatorWithAbsoluteAddressPlusYIndex">
		<xsl:element name="prg:hex">39</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AndAccumulatorWithAbsoluteAddressPlusXIndex">
		<xsl:element name="prg:hex">3D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AndAccumulatorWithAbsoluteLongAddressPlusXIndex">
		<xsl:element name="prg:hex">3F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftDirectAddressLeft">
		<xsl:element name="prg:hex">06</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftAccumulatorLeft">
		<xsl:element name="prg:hex">0A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftAbsoluteAddressLeft">
		<xsl:element name="prg:hex">0E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftDirectAddressPlusXIndexLeft">
		<xsl:element name="prg:hex">16</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftAbsoluteAddressPlusXIndexLeft">
		<xsl:element name="prg:hex">1E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelativeIfLessThan">
		<xsl:element name="prg:hex">90</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelativeIfGreaterOrEqual">
		<xsl:element name="prg:hex">B0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelativeIfEqual">
		<xsl:element name="prg:hex">F0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TestDirectAddress">
		<xsl:element name="prg:hex">24</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TestAbsoluteAddress">
		<xsl:element name="prg:hex">2C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TestDirectAddressPlusXIndex">
		<xsl:element name="prg:hex">34</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TestAbsoluteAddressPlusXIndex">
		<xsl:element name="prg:hex">3C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TestImmediate">
		<xsl:element name="prg:hex">89</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelativeIfNegative">
		<xsl:element name="prg:hex">30</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelativeIfNotEqual">
		<xsl:element name="prg:hex">D0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelativeIfPositive">
		<xsl:element name="prg:hex">10</xsl:element>
	</xsl:template>
	<xsl:template match="ns:JumpToRelative">
		<xsl:element name="prg:hex">80</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Break">
		<xsl:element name="prg:hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="ns:JumpToRelativeLong">
		<xsl:element name="prg:hex">82</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelativeIfNotOverflow">
		<xsl:element name="prg:hex">50</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelativeIfOverflow">
		<xsl:element name="prg:hex">70</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ClearCarryFlag">
		<xsl:element name="prg:hex">18</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ClearDecimalFlag">
		<xsl:element name="prg:hex">D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ClearInterruptDisableFlag">
		<xsl:element name="prg:hex">58</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CleareOverflowFlag">
		<xsl:element name="prg:hex">B8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareAccumulatorToDirectAddressPlusXIndexPointer">
		<xsl:element name="prg:hex">C1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareAccumulatorToStackRelativeAddress">
		<xsl:element name="prg:hex">C3</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareAccumulatorToDirectAddress">
		<xsl:element name="prg:hex">C5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareAccumulatorToDirectAddressLongPointer">
		<xsl:element name="prg:hex">C7</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareAccumulatorToImmediate">
		<xsl:element name="prg:hex">C9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareAccumulatorToAbsoluteAddress">
		<xsl:element name="prg:hex">CD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareAccumulatorToAbsoluteLongAddress">
		<xsl:element name="prg:hex">CF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareAccumulatorToDirectAddressPointerPlusYIndex">
		<xsl:element name="prg:hex">D1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareAccumulatorToDirectAddressPointer">
		<xsl:element name="prg:hex">D2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareAccumulatorToStackRelativePointerPlusYIndex">
		<xsl:element name="prg:hex">D3</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareAccumulatorToDirectAddressPlusXIndex">
		<xsl:element name="prg:hex">D5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareAccumulatorToDirectAddressLongPointerPlusYIndex">
		<xsl:element name="prg:hex">D7</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareAccumulatorToAbsoluteAddressPlusYIndex">
		<xsl:element name="prg:hex">D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareAccumulatorToAbsoluteAddressPlusXIndex">
		<xsl:element name="prg:hex">DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareAccumulatorToAbsoluteLongAddressPlusXIndex">
		<xsl:element name="prg:hex">DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:EnableCoprocessor">
		<xsl:element name="prg:hex">02</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareIndexXToImmediate ">
		<xsl:element name="prg:hex">E0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareIndexXToDirectAddress">
		<xsl:element name="prg:hex">E4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareIndexXToAbsoluteAddress">
		<xsl:element name="prg:hex">EC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareIndexYToImmediate">
		<xsl:element name="prg:hex">C0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareIndexYToDirectAddress">
		<xsl:element name="prg:hex">C4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareIndexYToAbsoluteAddress">
		<xsl:element name="prg:hex">CC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DecrementAccumulator">
		<xsl:element name="prg:hex">3A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DecrementDirectAddress">
		<xsl:element name="prg:hex">C6</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DecrementAbsoluteAddress">
		<xsl:element name="prg:hex">CE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DecrementDirectAddressPlusXIndex">
		<xsl:element name="prg:hex">D6</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DecrementAbsoluteAddressPlusXIndex">
		<xsl:element name="prg:hex">DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DecrementXIndex">
		<xsl:element name="prg:hex">CA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DecrementYIndex">
		<xsl:element name="prg:hex">88</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExclusiveOrAccumulatorWithDirectAddressPlusXIndexPointer">
		<xsl:element name="prg:hex">41</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExclusiveOrAccumulatorWithStackRelativeAddress">
		<xsl:element name="prg:hex">43</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExclusiveOrAccumulatorWithDirectAddress">
		<xsl:element name="prg:hex">45</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExclusiveOrAccumulatorWithDirectAddressLongPointer">
		<xsl:element name="prg:hex">47</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExclusiveOrAccumulatorWithImmediate">
		<xsl:element name="prg:hex">49</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExclusiveOrAccumulatorWithAbsoluteAddress">
		<xsl:element name="prg:hex">4D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExclusiveOrAccumulatorWithAbsoluteLongAddress">
		<xsl:element name="prg:hex">4F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExclusiveOrAccumulatorWithDirectAddressPointerPlusYIndex">
		<xsl:element name="prg:hex">51</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExclusiveOrAccumulatorWithDirectAddressPointer">
		<xsl:element name="prg:hex">52</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExclusiveOrAccumulatorWithStackRelativePointerPlusYIndex">
		<xsl:element name="prg:hex">53</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExclusiveOrAccumulatorWithDirectAddressPlusXIndex">
		<xsl:element name="prg:hex">55</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExclusiveOrAccumulatorWithDirectAddressLongPointerPlusYIndex">
		<xsl:element name="prg:hex">57</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExclusiveOrAccumulatorWithAbsoluteAddressPlusYIndex">
		<xsl:element name="prg:hex">59</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExclusiveOrAccumulatorWithAbsoluteAddressPlusXIndex">
		<xsl:element name="prg:hex">5D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExclusiveOrAccumulatorWithAbsoluteLongAddressPlusXIndex">
		<xsl:element name="prg:hex">5F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IncrementAccumulator">
		<xsl:element name="prg:hex">1A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IncrementDirectAddress">
		<xsl:element name="prg:hex">E6</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IncrementAbsoluteAddress">
		<xsl:element name="prg:hex">EE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IncrementDirectAddressPlusXIndex">
		<xsl:element name="prg:hex">F6</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IncrementAbsoluteAddressPlusXIndex">
		<xsl:element name="prg:hex">FE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IncrementXIndex">
		<xsl:element name="prg:hex">E8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IncrementYIndex">
		<xsl:element name="prg:hex">C8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:JumpToAbsoluteAddress">
		<xsl:element name="prg:hex">4C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:JumpToAbsoluteLongAddress">
		<xsl:element name="prg:hex">5C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:JumpToAbsoluteAddressPointer">
		<xsl:element name="prg:hex">6C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:JumpToAbsoluteAddressPlusXIndexPointer">
		<xsl:element name="prg:hex">7C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:JumpToAbsoluteLongAddressPointer">
		<xsl:element name="prg:hex">DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CallAbsoluteAddress">
		<xsl:element name="prg:hex">20</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CallAbsoluteLongAddress">
		<xsl:element name="prg:hex">22</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CallAbsoluteAddressPlusXIndex">
		<xsl:element name="prg:hex">FC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyDirectAddressPlusXIndexPointerToAccumulator">
		<xsl:element name="prg:hex">A1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyStackRelativeAddressToAccumulator">
		<xsl:element name="prg:hex">A3</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyDirectAddressToAccumulator">
		<xsl:element name="prg:hex">A5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyDirectAddressLongPointerToAccumulator">
		<xsl:element name="prg:hex">A7</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediateToAccumulator">
		<xsl:element name="prg:hex">A9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAbsoluteAddressToAccumulator">
		<xsl:element name="prg:hex">AD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAbsoluteLongAddressToAccumulator">
		<xsl:element name="prg:hex">AF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyDirectAddressPointerPlusYIndexToAccumulator">
		<xsl:element name="prg:hex">B1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyDirectAddressPointerToAccumulator">
		<xsl:element name="prg:hex">B2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyStackRelativePointerPlusYIndexToAccumulator">
		<xsl:element name="prg:hex">B3</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyDirectAddressPlusXIndexToAccumulator">
		<xsl:element name="prg:hex">B5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyDirectAddressLongPointerPlusYIndexToAccumulator">
		<xsl:element name="prg:hex">B7</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAbsoluteAddressPlusYIndexToAccumulator">
		<xsl:element name="prg:hex">B9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAbsoluteAddressPlusXIndexToAccumulator">
		<xsl:element name="prg:hex">BD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAbsoluteLongAddressPlusXIndexToAccumulator">
		<xsl:element name="prg:hex">BF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediateToXIndex">
		<xsl:element name="prg:hex">A2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyDirectAddressToXIndex">
		<xsl:element name="prg:hex">A6</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAbsoluteAddressToXIndex">
		<xsl:element name="prg:hex">AE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyDirectAddresPlusYIndexToXIndex">
		<xsl:element name="prg:hex">B6</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAbsoluteAddressPlusYIndexToXIndex">
		<xsl:element name="prg:hex">BE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediateToYIndex">
		<xsl:element name="prg:hex">A0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyDirectAddressToYIndex">
		<xsl:element name="prg:hex">A4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAbsoluteAddressToYIndex">
		<xsl:element name="prg:hex">AC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyDirectAddressPlusXIndexToYIndex">
		<xsl:element name="prg:hex">B4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAbsoluteAddressPlusXIndexToYIndex">
		<xsl:element name="prg:hex">BC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftDirectAddressRight">
		<xsl:element name="prg:hex">46</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftAccumulatorRight">
		<xsl:element name="prg:hex">4A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftAbsoluteAddressRight">
		<xsl:element name="prg:hex">4E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftDirectAddressPlusXIndexRight">
		<xsl:element name="prg:hex">56</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftAbsoluteAddressPlusXIndexRight">
		<xsl:element name="prg:hex">5E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyBytesFromImmeidateBlockPlusXIndexToImmediateBlockPlusYIndexReverse">
		<xsl:element name="prg:hex">54</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyBytesFromImmeidateBlockPlusXIndexToImmediateBlockPlusYIndex">
		<xsl:element name="prg:hex">44</xsl:element>
	</xsl:template>
	<xsl:template match="ns:NoOperation">
		<xsl:element name="prg:hex">EA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OrAccumulatorWithDirectAddressPlusXIndexPointer">
		<xsl:element name="prg:hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OrAccumulatorWithStackRelativeAddress">
		<xsl:element name="prg:hex">03</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OrAccumulatorWithDirectAddress">
		<xsl:element name="prg:hex">05</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OrAccumulatorWithDirectAddressLongPointer">
		<xsl:element name="prg:hex">07</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OrAccumulatorWithImmediate">
		<xsl:element name="prg:hex">09</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OrAccumulatorWithAbsoluteAddress">
		<xsl:element name="prg:hex">0D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OrAccumulatorWithAbsoluteLongAddress">
		<xsl:element name="prg:hex">0F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OrAccumulatorWithDirectAddressPointerPlusYIndex">
		<xsl:element name="prg:hex">11</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OrAccumulatorWithDirectAddressPointer">
		<xsl:element name="prg:hex">12</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OrAccumulatorWithStackRelativePointerPlusYIndex">
		<xsl:element name="prg:hex">13</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OrAccumulatorWithDirectAddressPlusXIndex">
		<xsl:element name="prg:hex">15</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OrAccumulatorWithDirectAddressLongPointerPlusYIndex">
		<xsl:element name="prg:hex">17</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OrAccumulatorWithAbsoluteAddressPlusYIndex">
		<xsl:element name="prg:hex">19</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OrAccumulatorWithAbsoluteAddressPlusXIndex">
		<xsl:element name="prg:hex">1D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OrAccumulatorWithAbsoluteLongAddressPlusXIndex">
		<xsl:element name="prg:hex">1F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushImmediate">
		<xsl:element name="prg:hex">F4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushPointer">
		<xsl:element name="prg:hex">D4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushRelativeLongPointer">
		<xsl:element name="prg:hex">62</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushAccumulator">
		<xsl:element name="prg:hex">48</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushDataBank">
		<xsl:element name="prg:hex">8B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushDirectPage">
		<xsl:element name="prg:hex">0B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushProgramBank">
		<xsl:element name="prg:hex">4B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushFlags">
		<xsl:element name="prg:hex">08</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushXIndex">
		<xsl:element name="prg:hex">DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushYIndex">
		<xsl:element name="prg:hex">5A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullAccumulator">
		<xsl:element name="prg:hex">68</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullDataBank">
		<xsl:element name="prg:hex">AB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullDirectPage">
		<xsl:element name="prg:hex">2B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullFlags">
		<xsl:element name="prg:hex">28</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullXIndex">
		<xsl:element name="prg:hex">FA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullYIndex">
		<xsl:element name="prg:hex">7A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ClearImmediateFlags">
		<xsl:element name="prg:hex">C2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RotateDirectAddressLeft">
		<xsl:element name="prg:hex">26</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RotateAccumulatorLeft">
		<xsl:element name="prg:hex">2A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RotateAbsoluteAddressLeft">
		<xsl:element name="prg:hex">2E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RotateDirectAddressPlusXIndexLeft">
		<xsl:element name="prg:hex">36</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RotateAbsoluteAddressPlusXIndexLeft">
		<xsl:element name="prg:hex">3E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RotateDirectAddressRight">
		<xsl:element name="prg:hex">66</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RotateAccumulatorRight">
		<xsl:element name="prg:hex">6A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RotateAbsoluteAddressRight">
		<xsl:element name="prg:hex">6E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RotateDirectAddressPlusXIndexRight">
		<xsl:element name="prg:hex">76</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RotateAbsoluteAddressPlusXIndexRight">
		<xsl:element name="prg:hex">7E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ReturnFromInterrupt">
		<xsl:element name="prg:hex">40</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ReturnToLongCaller">
		<xsl:element name="prg:hex">6B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ReturnToCaller">
		<xsl:element name="prg:hex">60</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractDirectSubtractressPlusXIndexPointerFromAccumulator">
		<xsl:element name="prg:hex">E1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractStackRelativeSubtractressFromAccumulator">
		<xsl:element name="prg:hex">E3</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractDirectSubtractressFromAccumulator">
		<xsl:element name="prg:hex">E5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractDirectSubtractressLongPointerFromAccumulator">
		<xsl:element name="prg:hex">E7</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractImmediateFromAccumulator">
		<xsl:element name="prg:hex">E9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractAbsoluteSubtractressFromAccumulator">
		<xsl:element name="prg:hex">ED</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractAbsoluteLongSubtractressFromAccumulator">
		<xsl:element name="prg:hex">EF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractDirectSubtractressPointerPlusYIndexFromAccumulator">
		<xsl:element name="prg:hex">F1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractDirectSubtractressPointerFromAccumulator">
		<xsl:element name="prg:hex">F2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractStackRelativePointerPlusYIndexFromAccumulator">
		<xsl:element name="prg:hex">F3</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractDirectSubtractressPlusXIndexFromAccumulator">
		<xsl:element name="prg:hex">F5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractDirectSubtractressLongPointerPlusYIndexFromAccumulator">
		<xsl:element name="prg:hex">F7</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractAbsoluteSubtractressPlusYIndexFromAccumulator">
		<xsl:element name="prg:hex">F9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractAbsoluteSubtractressPlusXIndexFromAccumulator">
		<xsl:element name="prg:hex">FD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractAbsoluteLongSubtractressPlusXIndexFromAccumulator">
		<xsl:element name="prg:hex">FF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetCarryFlag">
		<xsl:element name="prg:hex">38</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetDecimalFlag">
		<xsl:element name="prg:hex">F8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetInterruptDisableFlag">
		<xsl:element name="prg:hex">78</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetImmediateFlags">
		<xsl:element name="prg:hex">E2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAccumulatorToDirectAddressPlusXIndexPointer">
		<xsl:element name="prg:hex">81</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAccumulatorToStackRelativeAddress">
		<xsl:element name="prg:hex">83</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAccumulatorToDirectAddress">
		<xsl:element name="prg:hex">85</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAccumulatorToDirectAddressLongPointer">
		<xsl:element name="prg:hex">87</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAccumulatorToAbsoluteAddress">
		<xsl:element name="prg:hex">8D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAccumulatorToAbsoluteLongAddress">
		<xsl:element name="prg:hex">8F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAccumulatorToDirectAddressPointerPlusYIndex">
		<xsl:element name="prg:hex">91</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAccumulatorToDirectAddressPointer">
		<xsl:element name="prg:hex">92</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAccumulatorToStackRelativePointerPlusYIndex">
		<xsl:element name="prg:hex">93</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAccumulatorToDirectAddressPlusXIndex">
		<xsl:element name="prg:hex">95</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAccumulatorToDirectAddressLongPointerPlusYIndex">
		<xsl:element name="prg:hex">97</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAccumulatorToAbsoluteAddressPlusYIndex">
		<xsl:element name="prg:hex">99</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAccumulatorToAbsoluteAddressPlusXIndex">
		<xsl:element name="prg:hex">9D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAccumulatorToAbsoluteLongAddressPlusXIndex">
		<xsl:element name="prg:hex">9F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:StopProcessor">
		<xsl:element name="prg:hex">DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyXIndexToDirectAddress">
		<xsl:element name="prg:hex">86</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyXIndexToAbsoluteAddress">
		<xsl:element name="prg:hex">8E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyXIndexToDirectAddressPlusYIndex">
		<xsl:element name="prg:hex">96</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyYIndexToDirectAddress">
		<xsl:element name="prg:hex">84</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyYIndexToAbsoluteAddress">
		<xsl:element name="prg:hex">8C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyYIndexToDirectAddressPlusXIndex">
		<xsl:element name="prg:hex">94</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetDirectAddressToZero">
		<xsl:element name="prg:hex">64</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetDirectAddressPlusXIndexToZero">
		<xsl:element name="prg:hex">74</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetAbsoluteAddressToZero">
		<xsl:element name="prg:hex">9C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetAbsoluteAddressPlusXIndexToZero">
		<xsl:element name="prg:hex">9E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAccumulatorToXIndex">
		<xsl:element name="prg:hex">AA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAccumulatorToYIndex">
		<xsl:element name="prg:hex">A8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAccumulatorToDirectPage">
		<xsl:element name="prg:hex">5B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAccumulatorToStackPointer">
		<xsl:element name="prg:hex">1B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyDirectPageToAccumulator">
		<xsl:element name="prg:hex">7B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareAccumulatorToDirectAddressAndClearBits">
		<xsl:element name="prg:hex">14</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareAccumulatorToAbsoluteAddressAndClearBits">
		<xsl:element name="prg:hex">1C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareAccumulatorToDirectAddressAndSetBits">
		<xsl:element name="prg:hex">04</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareAccumulatorToAbsoluteAddressAndSetBits">
		<xsl:element name="prg:hex">0C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyStackPointerToAccumulator">
		<xsl:element name="prg:hex">3B</xsl:element>
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
	<xsl:template match="ns:CopyXIndexToYIndex">
		<xsl:element name="prg:hex">9B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyYIndexToAccumulator">
		<xsl:element name="prg:hex">98</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyYIndexToXIndex">
		<xsl:element name="prg:hex">BB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:WaitForInterrupt">
		<xsl:element name="prg:hex">CB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExtendedOperation">
		<xsl:element name="prg:hex">42</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExchangeAccumulators">
		<xsl:element name="prg:hex">EB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExchangeCarryFlagWithEmulationFlag">
		<xsl:element name="prg:hex">FB</xsl:element>
	</xsl:template>
</xsl:stylesheet>