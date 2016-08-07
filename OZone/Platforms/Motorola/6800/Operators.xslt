<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:cpu="http://metalx.org/Motorola/6800">
	
  <xsl:output method="xml" indent="yes" />
	
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" />
    </xsl:copy>
  </xsl:template>
	
  <xsl:template match="cpu:NoOperation">
    <xsl:element name="hex">01</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:CopyAccumulatorAToFlags">
    <xsl:element name="hex">06</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:CopyFlagsToAccumulatorA">
    <xsl:element name="hex">07</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:IncrementIndex">
    <xsl:element name="hex">08</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:DecrementIndex">
    <xsl:element name="hex">09</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:ClearOverflowFlag">
    <xsl:element name="hex">0A</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:SetOverflowFlag">
    <xsl:element name="hex">0B</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:ClearCarryFlag">
    <xsl:element name="hex">0C</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:SetCarryFlag">
    <xsl:element name="hex">0D</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:ClearInterruptFlag">
    <xsl:element name="hex">0E</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:SetInterruptFlag">
    <xsl:element name="hex">0F</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:SubtractAccumulatorBFromAccumulatorA">
    <xsl:element name="hex">10</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:CompareAccumulatorBToAccumulatorA">
    <xsl:element name="hex">11</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:CopyAccumulatorAToAccumulatorB">
    <xsl:element name="hex">16</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:CopyAccumulatorBToAccumulatorA">
    <xsl:element name="hex">17</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:DecimalAdjustAccumulatorA">
    <xsl:element name="hex">19</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:AddAccumulatorBToAccumulatorA">
    <xsl:element name="hex">1B</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:JumpToRelative">
    <xsl:element name="hex">20</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:BranchIfLessThanOrEqual">
    <xsl:element name="hex">23</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:BranchIfNotCarry">
    <xsl:element name="hex">24</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:BranchIfCarry">
    <xsl:element name="hex">25</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:BranchIfNotEqual">
    <xsl:element name="hex">26</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:BranchIfEqual">
    <xsl:element name="hex">27</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:BranchIfNotOverflow">
    <xsl:element name="hex">28</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:BranchIfOverflow">
    <xsl:element name="hex">29</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:BranchIfPositive">
    <xsl:element name="hex">2A</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:BranchIfNegative">
    <xsl:element name="hex">2B</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:BranchIfGreaterThanOrEqualToZero">
    <xsl:element name="hex">2C</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:BranchIfLessThanZero">
    <xsl:element name="hex">2D</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:BranchIfGreaterThanZero">
    <xsl:element name="hex">2E</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:BranchIfLessThanOrEqualToZero">
    <xsl:element name="hex">2F</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:CopyStackPointerToIndex">
    <xsl:element name="hex">30</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:IncrementStackPointer">
    <xsl:element name="hex">31</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:PullAccumulatorAFromStack">
    <xsl:element name="hex">32</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:PullAccumulatorBFromStack">
    <xsl:element name="hex">33</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:DecrementStackPointer">
    <xsl:element name="hex">34</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:CopyIndexToStackPointer">
    <xsl:element name="hex">35</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:PushAccumulatorAToStack">
    <xsl:element name="hex">36</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:PushAccumulatorBToStack">
    <xsl:element name="hex">37</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:ReturnFromSubroutine">
    <xsl:element name="hex">39</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:ReturnFromInterrupt">
    <xsl:element name="hex">3B</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:WaitForInterrupt">
    <xsl:element name="hex">3E</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:SoftwareInterrupt">
    <xsl:element name="hex">3F</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:NegateAccumulatorA">
    <xsl:element name="hex">40</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:ComplementAccumulatorA">
    <xsl:element name="hex">43</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:ShiftAccumulatorARight">
    <xsl:element name="hex">44</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:RotateAccumulatorARight">
    <xsl:element name="hex">46</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:HalfAccumulatorA">
    <xsl:element name="hex">47</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:DoubleAccumulatorA">
    <xsl:element name="hex">48</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:RotateAccumulatorALeft">
    <xsl:element name="hex">49</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:DecrementAccumulatorA">
    <xsl:element name="hex">4A</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:IncrementAccumulatorA">
    <xsl:element name="hex">4C</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:TestAccumulatorA">
    <xsl:element name="hex">4D</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:ClearAccumulatorA">
    <xsl:element name="hex">4F</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:NegateAccumulatorB">
    <xsl:element name="hex">50</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:ComplementAccumulatorB">
    <xsl:element name="hex">53</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:ShiftAccumulatorBRight">
    <xsl:element name="hex">54</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:RotateAccumulatorBRight">
    <xsl:element name="hex">56</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:HalfAccumulatorB">
    <xsl:element name="hex">57</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:DoubleAccumulatorB">
    <xsl:element name="hex">58</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:RotateAccumulatorBLeft">
    <xsl:element name="hex">59</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:DecrementAccumulatorB">
    <xsl:element name="hex">5A</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:IncrementAccumulatorB">
    <xsl:element name="hex">5C</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:TestAccumulatorB">
    <xsl:element name="hex">5D</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:ClearAccumulatorB">
    <xsl:element name="hex">5F</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:NegateIndexMemory">
    <xsl:element name="hex">60</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:ComplementIndexMemory">
    <xsl:element name="hex">63</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:ShiftIndexMemoryRight">
    <xsl:element name="hex">64</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:RotateIndexMemoryRight">
    <xsl:element name="hex">66</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:HalfIndexMemory">
    <xsl:element name="hex">67</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:DoubleIndexMemory">
    <xsl:element name="hex">68</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:RotateIndexMemoryLeft">
    <xsl:element name="hex">69</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:DecrementIndexMemory">
    <xsl:element name="hex">6A</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:IncrementIndexMemory">
    <xsl:element name="hex">6C</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:TestIndexMemory">
    <xsl:element name="hex">6D</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:JumpToIndexMemory">
    <xsl:element name="hex">6E</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:ClearIndexMemory">
    <xsl:element name="hex">6F</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:NegateExtendedMemory">
    <xsl:element name="hex">70</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:ComplementExtendedMemory">
    <xsl:element name="hex">73</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:ShiftExtendedMemoryRight">
    <xsl:element name="hex">74</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:CopyStackPointerToZeroPageMemory">
    <xsl:element name="hex">9F</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:SubtractIndexMemoryFromAccumulatorA">
    <xsl:element name="hex">A0</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:CompareIndexMemoryToAccumulatorA">
    <xsl:element name="hex">A1</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:SubtractIndexMemoryFromAccumulatorAWithCarry">
    <xsl:element name="hex">A2</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:AndAccumulatorAWithIndexMemory">
    <xsl:element name="hex">A4</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:TestAccumulatorAWithIndexMemory">
    <xsl:element name="hex">A5</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:CopyIndexMemoryToAccumulatorA">
    <xsl:element name="hex">A6</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:CopyAccumulatorAToIndex">
    <xsl:element name="hex">A7</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:ExclusiveOrAccumulatorAWithIndexMemory">
    <xsl:element name="hex">A8</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:AddIndexMemoryToAccumulatorAWithCarry">
    <xsl:element name="hex">A9</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:OrAccumulatorAWithIndexMemory">
    <xsl:element name="hex">AA</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:AddIndexMemoryToAccumulatorA">
    <xsl:element name="hex">AB</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:CompareIndexRegisterWithIndexMemory">
    <xsl:element name="hex">AC</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:JumpToSubroutineAtIndexMemory">
    <xsl:element name="hex">AD</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:CopyIndexMemoryToStackPointer">
    <xsl:element name="hex">AE</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:CopyStackPointerToIndexMemory">
    <xsl:element name="hex">AF</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:SubtractExtendedMemoryFromAccumulatorA">
    <xsl:element name="hex">B0</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:CompareExtendedMemoryToAccumulatorA">
    <xsl:element name="hex">B1</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:SubtractExtendedMemoryFromAccumulatorAWithCarry">
    <xsl:element name="hex">B2</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:AndAccumulatorAWithExtendedMemory">
    <xsl:element name="hex">B4</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:TestAccumulatorAWithExtendedMemory">
    <xsl:element name="hex">B5</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:CopyExtendedMemoryToAccumulatorA">
    <xsl:element name="hex">B6</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:CopyAccumulatorAToExtendedMemory">
    <xsl:element name="hex">B7</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:ExclusiveOrAccumulatorAWithExtendedMemory">
    <xsl:element name="hex">B8</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:AddExtendedMemoryToAccumulatorAWithCarry">
    <xsl:element name="hex">B9</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:OrAccumulatorAWithExtendedMemory">
    <xsl:element name="hex">BA</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:AddExtendedMemoryToAccumulatorA">
    <xsl:element name="hex">BB</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:CompareExtendedMemoryToIndex">
    <xsl:element name="hex">BC</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:CallRoutineAtExtendedMemory">
    <xsl:element name="hex">BD</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:CopyExtendedMemoryToStackPointer">
    <xsl:element name="hex">BE</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:CopyStackPointerToExtendedMemory">
    <xsl:element name="hex">BF</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:SubtractImmediate8FromAccumulatorB">
    <xsl:element name="hex">C0</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:CompareImmedate8ToAccumulatorB">
    <xsl:element name="hex">C1</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:SubtractImmediate8FromAccumulatorBWithCarry">
    <xsl:element name="hex">C2</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:AndAccumulatorBWithImmediate8">
    <xsl:element name="hex">C4</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:TestAccumulatorBWithImmediate8">
    <xsl:element name="hex">C5</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:CopyImmediate8ToAccumulatorB">
    <xsl:element name="hex">C6</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:ExclusiveOrAccumulatorBWithImmediate8">
    <xsl:element name="hex">C8</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:AddImmediate8ToAccumulatorBWithCarry">
    <xsl:element name="hex">C9</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:OrAccumulatorBWithImmediate8">
    <xsl:element name="hex">CA</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:AddImmediate8ToAccumulatorB">
    <xsl:element name="hex">CB</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:CopyImmediate8ToIndex">
    <xsl:element name="hex">CE</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:SubtractZeroPageMemoryFromAccumulatorB">
    <xsl:element name="hex">D0</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:CompareZeroPageMemoryToAccumulatorB">
    <xsl:element name="hex">D1</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:SubtractZeroPageMemroyFromAccumulatorBWithCarry">
    <xsl:element name="hex">D2</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:AndAccumulatorBWithZeroPageMemory">
    <xsl:element name="hex">D4</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:TestAccumulatorBWithZeroPageMemory">
    <xsl:element name="hex">D5</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:CopyZeroPageMemoryToAccumulatorB">
    <xsl:element name="hex">D6</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:CopyAccumulatorBToZeroPageMemory">
    <xsl:element name="hex">D7</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:ExclusiveOrAccumulatorBWithZeroPageMemory">
    <xsl:element name="hex">D8</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:AddZeroPageMemoryToAccumulatorBWithCarry">
    <xsl:element name="hex">D9</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:OrAccumulatorBWithZeroPageMemory">
    <xsl:element name="hex">DA</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:AddZeroPageMemoryToAccumulatorB">
    <xsl:element name="hex">DB</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:CopyZeroPageMemoryToIndex">
    <xsl:element name="hex">DE</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:CopyIndexToZeroPageMemory">
    <xsl:element name="hex">DF</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:SubtractIndexMemoryFromAccumulatorB">
    <xsl:element name="hex">E0</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:CompareIndexMemoryToAccumulatorB">
    <xsl:element name="hex">E1</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:SubtractIndexMemoryFromAccumulatorBWithCarry">
    <xsl:element name="hex">E2</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:AndAccumulatorBWithIndexMemory">
    <xsl:element name="hex">E4</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:TestAccumulatorBWithIndexMemory">
    <xsl:element name="hex">E5</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:CopyIndexMemoryToAccumulatorB">
    <xsl:element name="hex">E6</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:CopyAccumulatorBToIndex">
    <xsl:element name="hex">E7</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:ExclusiveOrAccumulatorBWithIndexMemory">
    <xsl:element name="hex">E8</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:AddIndexMemoryToAccumulatorBWithCarry">
    <xsl:element name="hex">E9</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:OrAccumulatorBWithIndexMemory">
    <xsl:element name="hex">EA</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:AddIndexMemoryToAccumulatorB">
    <xsl:element name="hex">EB</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:CopyIndexMemoryToIndex">
    <xsl:element name="hex">EE</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:CopyIndexToIndexMemory">
    <xsl:element name="hex">EF</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:SubtractExtendedMemoryFromAccumulatorB">
    <xsl:element name="hex">F0</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:CompareExtendedMemoryToAccumulatorB">
    <xsl:element name="hex">F1</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:SubtractExtendedMemoryFromAccumulatorBWithCarry">
    <xsl:element name="hex">F2</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:AndAccumulatorBWithExtendedMemory">
    <xsl:element name="hex">F4</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:TestAccumulatorBWithExtendedMemory">
    <xsl:element name="hex">F5</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:CopyExtendedMemoryToAccumulatorB">
    <xsl:element name="hex">F6</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:CopyAccumulatorBToExtendedMemory">
    <xsl:element name="hex">F7</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:ExclusiveOrAccumulatorBWithExtendedMemory">
    <xsl:element name="hex">F8</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:AddExtendedMemoryToAccumulatorBWithCarry">
    <xsl:element name="hex">F9</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:OrAccumulatorBWithExtendedMemory">
    <xsl:element name="hex">FA</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:AddExtendedMemoryToAccumulatorB">
    <xsl:element name="hex">FB</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:CopyExtendedMemoryToIndex">
    <xsl:element name="hex">FE</xsl:element>
  </xsl:template>
  <xsl:template match="cpu:CopyIndexToExtendedMemory">
    <xsl:element name="hex">FF</xsl:element>
  </xsl:template>
</xsl:stylesheet>