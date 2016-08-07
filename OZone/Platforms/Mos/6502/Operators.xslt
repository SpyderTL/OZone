<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:cpu="http://metalx.org/Mos/6502/Operators" xmlns="http://metalx.org/Program">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="cpu:Break">
		<xsl:element name="hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:NoOperation">
		<xsl:element name="hex">EA</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CompareAccumulatorToImmediate">
		<xsl:element name="hex">C9</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CompareAccumulatorToZeroPageMemory">
		<xsl:element name="hex">C5</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CompareAccumulatorToZeroPageXIndexMemory">
		<xsl:element name="hex">D5</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CompareAccumulatorToAbsoluteMemory">
		<xsl:element name="hex">CD</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CompareAccumulatorToAbsoluteXIndexMemory">
		<xsl:element name="hex">DD</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CompareAccumulatorToAbsoluteYIndexMemory">
		<xsl:element name="hex">D9</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CompareAccumulatorToIndirectXIndexMemory">
		<xsl:element name="hex">C1</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CompareAccumulatorToIndirectYIndexMemory">
		<xsl:element name="hex">D1</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CompareXIndexToImmediate">
		<xsl:element name="hex">E0</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CompareXIndexToZeroPageMemory">
		<xsl:element name="hex">E4</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CompareXIndexToAbsoluteMemory">
		<xsl:element name="hex">EC</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CompareYIndexToImmediate">
		<xsl:element name="hex">C0</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CompareYIndexToZeroPageMemory">
		<xsl:element name="hex">C4</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CompareYIndexToAbsoluteMemory">
		<xsl:element name="hex">CC</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:IncrementZeroPageMemory">
		<xsl:element name="hex">E6</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:IncrementZeroPageXIndexMemory">
		<xsl:element name="hex">F6</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:IncrementAbsoluteMemory">
		<xsl:element name="hex">EE</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:IncrementAbsoluteXIndexMemory">
		<xsl:element name="hex">FE</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:IncrementXIndex">
		<xsl:element name="hex">E8</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:IncrementYIndex">
		<xsl:element name="hex">C8</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:DecrementZeroPageMemory">
		<xsl:element name="hex">C6</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:DecrementZeroPageXIndexMemory">
		<xsl:element name="hex">D6</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:DecrementAbsoluteMemory">
		<xsl:element name="hex">CE</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:DecrementAbsoluteXIndexMemory">
		<xsl:element name="hex">DE</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:DecrementXIndex">
		<xsl:element name="hex">CA</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:DecrementYIndex">
		<xsl:element name="hex">88</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:OrImmediateWithAccumulator">
		<xsl:element name="hex">09</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:OrZeroPageMemoryWithAccumulator">
		<xsl:element name="hex">05</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:OrZeroPageXIndexMemoryWithAccumulator">
		<xsl:element name="hex">15</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:OrAbsoluteMemoryWithAccumulator">
		<xsl:element name="hex">0D</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:OrAbsoluteMemoryXIndexWithAccumulator">
		<xsl:element name="hex">1D</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:OrAbsoluteMemoryYIndexWithAccumulator">
		<xsl:element name="hex">19</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:OrIndirectXIndexWithAccumulator">
		<xsl:element name="hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:OrIndirectYIndexWithAccumulator">
		<xsl:element name="hex">11</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ExclusiveOrImmediateWithAccumulator">
		<xsl:element name="hex">49</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ExclusiveOrZeroPageMemoryWithAccumulator">
		<xsl:element name="hex">45</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ExclusiveOrZeroPageXIndexMemoryWithAccumulator">
		<xsl:element name="hex">55</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ExclusiveOrAbsoluteMemoryWithAccumulator">
		<xsl:element name="hex">4D</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ExclusiveOrAbsoluteMemoryXIndexWithAccumulator">
		<xsl:element name="hex">5D</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ExclusiveOrAbsoluteMemoryYIndexWithAccumulator">
		<xsl:element name="hex">59</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ExclusiveOrIndirectXIndexWithAccumulator">
		<xsl:element name="hex">41</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ExclusiveOrIndirectYIndexWithAccumulator">
		<xsl:element name="hex">51</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ShiftAccumulatorLeft">
		<xsl:element name="hex">0A</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ShiftZeroPageMemoryLeft">
		<xsl:element name="hex">06</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ShiftZeroPageXIndexMemoryLeft">
		<xsl:element name="hex">16</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ShiftAbsoluteMemoryLeft">
		<xsl:element name="hex">0E</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ShiftAbsoluteXIndexMemoryLeft">
		<xsl:element name="hex">1E</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PullProcessorStatusFromStack">
		<xsl:element name="hex">28</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PullAccumulatorFromStack">
		<xsl:element name="hex">68</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushProcessorStatusToStack">
		<xsl:element name="hex">08</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushAccumulatorToStack">
		<xsl:element name="hex">48</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ClearCarryFlag">
		<xsl:element name="hex">18</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ClearDecimalFlag">
		<xsl:element name="hex">D8</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SetInterruptDisableFlag">
		<xsl:element name="hex">78</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ClearInterruptDisableFlag">
		<xsl:element name="hex">58</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ClearOverflowFlag">
		<xsl:element name="hex">B8</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchToRelativeMemoryIfPositive">
		<xsl:element name="hex">10</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchToRelativeMemoryIfNegative">
		<xsl:element name="hex">30</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchToRelativeMemoryIfNotCarry">
		<xsl:element name="hex">90</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchToRelativeMemoryIfCarry">
		<xsl:element name="hex">B0</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchToRelativeMemoryIfEqual">
		<xsl:element name="hex">F0</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchToRelativeMemoryIfNotEqual">
		<xsl:element name="hex">D0</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchToRelativeMemoryIfZero">
		<xsl:element name="hex">F0</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchToRelativeMemoryIfNotZero">
		<xsl:element name="hex">D0</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchToRelativeMemoryIfNotOverflow">
		<xsl:element name="hex">50</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchToRelativeMemoryIfOverflow">
		<xsl:element name="hex">70</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:JumpToAbsoluteMemory">
		<xsl:element name="hex">4C</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:JumpToIndirectMemory">
		<xsl:element name="hex">6C</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CallProcedureAtAbsoluteMemory">
		<xsl:element name="hex">20</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:TestZeroPageMemoryWithAccumulator">
		<xsl:element name="hex">24</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:TestAbsoluteMemoryWithAccumulator">
		<xsl:element name="hex">2C</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:AddImmediateToAccumulator">
		<xsl:element name="hex">69</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:AddZeroPageMemoryToAccumulator">
		<xsl:element name="hex">65</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:AddZeroPageXIndexMemoryToAccumulator">
		<xsl:element name="hex">75</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:AddAbsoluteMemoryToAccumulator">
		<xsl:element name="hex">6D</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:AddAbsoluteXIndexMemoryToAccumulator">
		<xsl:element name="hex">7D</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:AddAbsoluteYIndexMemoryToAccumulator">
		<xsl:element name="hex">79</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:AddIndirectXIndexMemoryToAccumulator">
		<xsl:element name="hex">61</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:AddIndirectYIndexMemoryToAccumulator">
		<xsl:element name="hex">71</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SubtractImmediateFromAccumulator">
		<xsl:element name="hex">E9</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SubtractZeroPageMemoryFromAccumulator">
		<xsl:element name="hex">E5</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SubtractZeroPageXIndexMemoryFromAccumulator">
		<xsl:element name="hex">F5</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SubtractAbsoluteMemoryFromAccumulator">
		<xsl:element name="hex">ED</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SubtractAbsoluteXIndexMemoryFromAccumulator">
		<xsl:element name="hex">FD</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SubtractAbsoluteYIndexMemoryFromAccumulator">
		<xsl:element name="hex">F9</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SubtractIndirectXIndexMemoryFromAccumulator">
		<xsl:element name="hex">E1</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SubtractIndirectYIndexMemoryFromAccumulator">
		<xsl:element name="hex">F1</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:AndImmediateWithAccumulator">
		<xsl:element name="hex">29</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:AndZeroPageMemoryWithAccumulator">
		<xsl:element name="hex">25</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:AndZeroPageXIndexMemoryWithAccumulator">
		<xsl:element name="hex">35</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:AndAbsoluteMemoryWithAccumulator">
		<xsl:element name="hex">2D</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:AndAbsoluteXIndexMemoryWithAccumulator">
		<xsl:element name="hex">3D</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:AndAbsoluteYIndexMemoryWithAccumulator">
		<xsl:element name="hex">39</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:AndIndirectXIndexMemoryWithAccumulator">
		<xsl:element name="hex">21</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:AndIndirectYIndexMemoryWithAccumulator">
		<xsl:element name="hex">31</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyImmediateToAccumulator">
		<xsl:element name="hex">A9</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyZeroPageMemoryToAccumulator">
		<xsl:element name="hex">A5</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyZeroPageXIndexMemoryToAccumulator">
		<xsl:element name="hex">B5</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyAbsoluteMemoryToAccumulator">
		<xsl:element name="hex">AD</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyAbsoluteXIndexMemoryToAccumulator">
		<xsl:element name="hex">BD</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyAbsoluteYIndexMemoryToAccumulator">
		<xsl:element name="hex">B9</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyIndirectXIndexMemoryToAccumulator">
		<xsl:element name="hex">A1</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyIndirectYIndexMemoryToAccumulator">
		<xsl:element name="hex">B1</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyImmediateToXIndex">
		<xsl:element name="hex">A2</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyZeroPageMemoryToXIndex">
		<xsl:element name="hex">A6</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyZeroPageYIndexMemoryToXIndex">
		<xsl:element name="hex">B6</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyAbsoluteMemoryToXIndex">
		<xsl:element name="hex">AE</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyAbsoluteYIndexMemoryToXIndex">
		<xsl:element name="hex">BE</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyImmediateToYIndex">
		<xsl:element name="hex">A0</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyZeroPageMemoryToYIndex">
		<xsl:element name="hex">A4</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyZeroPageXIndexMemoryToYIndex">
		<xsl:element name="hex">B4</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyAbsoluteMemoryToYIndex">
		<xsl:element name="hex">AC</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyAbsoluteXIndexMemoryToYIndex">
		<xsl:element name="hex">BC</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyAccumulatorToZeroPageMemory">
		<xsl:element name="hex">85</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyAccumulatorToZeroPageXIndexMemory">
		<xsl:element name="hex">95</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyAccumulatorToAbsoluteMemory">
		<xsl:element name="hex">8D</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyAccumulatorToAbsoluteXIndexMemory">
		<xsl:element name="hex">9D</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyAccumulatorToAbsoluteYIndexMemory">
		<xsl:element name="hex">99</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyAccumulatorToIndirectXIndexMemory">
		<xsl:element name="hex">81</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyAccumulatorToIndirectYIndexMemory">
		<xsl:element name="hex">91</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyXIndexToZeroPageMemory">
		<xsl:element name="hex">86</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyXIndexToZeroPageYIndexMemory">
		<xsl:element name="hex">96</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyXIndexToAbsoluteMemory">
		<xsl:element name="hex">8E</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyYIndexToZeroPageMemory">
		<xsl:element name="hex">84</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyYIndexToZeroPageYIndexMemory">
		<xsl:element name="hex">94</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyYIndexToAbsoluteMemory">
		<xsl:element name="hex">8C</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyAccumulatorToXIndex">
		<xsl:element name="hex">AA</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyAccumulatorToYIndex">
		<xsl:element name="hex">A8</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyStackPointerToXIndex">
		<xsl:element name="hex">BA</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyXIndexToAccumulator">
		<xsl:element name="hex">8A</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyXIndexToStackPointer">
		<xsl:element name="hex">9A</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyYIndexToAccumulator">
		<xsl:element name="hex">98</xsl:element>
	</xsl:template>
</xsl:stylesheet>