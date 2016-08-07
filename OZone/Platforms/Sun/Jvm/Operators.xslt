<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:jvm="http://metalx.org/Sun/Jvm"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="xml" indent="yes" />

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template

	<xsl:template match="jvm:NoOperation">
		<xsl:element name="hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushNullToStack">
		<xsl:element name="hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushIntegerNegativeOneToStack">
		<xsl:element name="hex">02</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushIntegerZeroToStack">
		<xsl:element name="hex">03</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushIntegerOneToStack">
		<xsl:element name="hex">04</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushIntegerTwoToStack">
		<xsl:element name="hex">05</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushIntegerThreeToStack">
		<xsl:element name="hex">06</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushIntegerFourToStack">
		<xsl:element name="hex">07</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushIntegerFiveToStack">
		<xsl:element name="hex">08</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushLongFromVariable0ToStack">
		<xsl:element name="hex">09</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushLongFromVariable1ToStack">
		<xsl:element name="hex">0a</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushFloatZeroToStack">
		<xsl:element name="hex">0b</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushFloatOneToStack">
		<xsl:element name="hex">0c</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushFloatTwoToStack">
		<xsl:element name="hex">0d</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushDoubleZeroToStack">
		<xsl:element name="hex">0e</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushDoubleOneToStack">
		<xsl:element name="hex">0f</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushImmediate8ToStack16">
		<xsl:element name="hex">10</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushImmediate16ToStack">
		<xsl:element name="hex">11</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushConstant16AtImmediate8IndexToStack">
		<xsl:element name="hex">12</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushConstantAtImmediateIndexToStack16">
		<xsl:element name="hex">13</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushConstant32AtImmediate16IndexToStack">
		<xsl:element name="hex">14</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushIntegerFromImmediate8VariableToStack">
		<xsl:element name="hex">15</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushLongFromImmediate8VariableToStack">
		<xsl:element name="hex">16</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushFloatFromImmediate8VariableToStack">
		<xsl:element name="hex">17</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushDoubleFromImmediate8VariableToStack">
		<xsl:element name="hex">18</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushObjectFromImmediate8VariableToStack">
		<xsl:element name="hex">19</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushIntegerFromVariable0ToStack">
		<xsl:element name="hex">1a</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushIntegerFromVariable1ToStack">
		<xsl:element name="hex">1b</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushIntegerFromVariable2ToStack">
		<xsl:element name="hex">1c</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushIntegerFromVariable3ToStack">
		<xsl:element name="hex">1d</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushLongFromVariable0ToStack">
		<xsl:element name="hex">1e</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushLongFromVariable1ToStack">
		<xsl:element name="hex">1f</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushLongFromVariable2ToStack">
		<xsl:element name="hex">20</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushLongFromVariable3ToStack">
		<xsl:element name="hex">21</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushFloatFromVariable0ToStack">
		<xsl:element name="hex">22</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushFloatFromVariable1ToStack">
		<xsl:element name="hex">23</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushFloatFromVariable2ToStack">
		<xsl:element name="hex">24</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushFloatFromVariable3ToStack">
		<xsl:element name="hex">25</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushDoubleFromVariable0ToStack">
		<xsl:element name="hex">26</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushDoubleFromVariable1ToStack">
		<xsl:element name="hex">27</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushDoubleFromVariable2ToStack">
		<xsl:element name="hex">28</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushDoubleFromVariable3ToStack">
		<xsl:element name="hex">29</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushObjectFromVariable0ToStack">
		<xsl:element name="hex">2a</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushObjectFromVariable1ToStack">
		<xsl:element name="hex">2b</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushObjectFromVariable2ToStack">
		<xsl:element name="hex">2c</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushObjectFromVariable3ToStack">
		<xsl:element name="hex">2d</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:GetArrayInteger">
		<xsl:element name="hex">2e</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:GetArrayLong">
		<xsl:element name="hex">2f</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:GetArrayFloat">
		<xsl:element name="hex">30</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:GetArrayDouble">
		<xsl:element name="hex">31</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:GetArrayObject">
		<xsl:element name="hex">32</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:GetArrayByte">
		<xsl:element name="hex">33</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:GetArrayCharacter">
		<xsl:element name="hex">34</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:GetArrayShort">
		<xsl:element name="hex">35</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushIntegerFromImmediate8VariableToStack">
		<xsl:element name="hex">36</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PullLongFromStackToImmediate8Variable">
		<xsl:element name="hex">37</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PullFloatFromStackToImmediate8Variable">
		<xsl:element name="hex">38</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PullDoubleFromStackToImmediate8Variable">
		<xsl:element name="hex">39</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PullObjectFromStackToImmediate8Variable">
		<xsl:element name="hex">3a</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushIntegerFromVariable0ToStack">
		<xsl:element name="hex">3b</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushIntegerFromVariable1ToStack">
		<xsl:element name="hex">3c</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushIntegerFromVariable2ToStack">
		<xsl:element name="hex">3d</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PushIntegerFromVariable3ToStack">
		<xsl:element name="hex">3e</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PullLongFromStackToVariable0">
		<xsl:element name="hex">3f</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PullLongFromStackToVariable1">
		<xsl:element name="hex">40</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PullLongFromStackToVariable2">
		<xsl:element name="hex">41</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PullLongFromStackToVariable3">
		<xsl:element name="hex">42</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PullFloatFromStackToVariable0">
		<xsl:element name="hex">43</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PullFloatFromStackToVariable1">
		<xsl:element name="hex">44</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PullFloatFromStackToVariable2">
		<xsl:element name="hex">45</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PullFloatFromStackToVariable3">
		<xsl:element name="hex">46</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PullDoubleFromStackToVariable0">
		<xsl:element name="hex">47</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PullDoubleFromStackToVariable1">
		<xsl:element name="hex">48</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PullDoubleFromStackToVariable2">
		<xsl:element name="hex">49</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PullDoubleFromStackToVariable3">
		<xsl:element name="hex">4a</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PullObjectFromStackToVariable0">
		<xsl:element name="hex">4b</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PullObjectFromStackToVariable1">
		<xsl:element name="hex">4c</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PullObjectFromStackToVariable2">
		<xsl:element name="hex">4d</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PullObjectFromStackToVariable3">
		<xsl:element name="hex">4e</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:SetArrayInteger">
		<xsl:element name="hex">4f</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:SetArrayLong">
		<xsl:element name="hex">50</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:SetArrayFloat">
		<xsl:element name="hex">51</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:SetArrayDouble">
		<xsl:element name="hex">52</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:SetArrayObject">
		<xsl:element name="hex">53</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:SetArrayByte">
		<xsl:element name="hex">54</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:SetArrayCharacter">
		<xsl:element name="hex">55</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:SetArrayShort">
		<xsl:element name="hex">56</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PullValueFromStack">
		<xsl:element name="hex">57</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:PullTwoValuesFromStack">
		<xsl:element name="hex">58</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:CopyValue">
		<xsl:element name="hex">59</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:CopyValueSkipOne">
		<xsl:element name="hex">5a</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:CopyValueSkipTwo">
		<xsl:element name="hex">5b</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:CopyTwoValues">
		<xsl:element name="hex">5c</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:CopyTwoValuesSkipOne">
		<xsl:element name="hex">5d</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:CopyTwoValuesSkipTwo">
		<xsl:element name="hex">5e</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:SwapIntegers">
		<xsl:element name="hex">5f</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:AddIntegers">
		<xsl:element name="hex">60</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:AddLongs">
		<xsl:element name="hex">61</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:AddFloats">
		<xsl:element name="hex">62</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:AddDoubles">
		<xsl:element name="hex">63</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:SubtractIntegers">
		<xsl:element name="hex">64</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:SubtractLongs">
		<xsl:element name="hex">65</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:SubtractFloats">
		<xsl:element name="hex">66</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:SubtractDoubles">
		<xsl:element name="hex">67</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:MultiplyIntegers">
		<xsl:element name="hex">68</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:MultiplyLongs">
		<xsl:element name="hex">69</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:MultiplyFloats">
		<xsl:element name="hex">6a</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:MultiplyDoubles">
		<xsl:element name="hex">6b</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:DivideIntegers">
		<xsl:element name="hex">6c</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:DivideLongs">
		<xsl:element name="hex">6d</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:DivideFloats">
		<xsl:element name="hex">6e</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:DivideDoubles">
		<xsl:element name="hex">6f</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:ModuloIntegers">
		<xsl:element name="hex">70</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:ModuloLongs">
		<xsl:element name="hex">71</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:ModuloFloats">
		<xsl:element name="hex">72</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:ModuloDoubles">
		<xsl:element name="hex">73</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:NegateInteger">
		<xsl:element name="hex">74</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:NegateLong">
		<xsl:element name="hex">75</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:NegateFloat">
		<xsl:element name="hex">76</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:NegateDouble">
		<xsl:element name="hex">77</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:ShiftIntegerLeft">
		<xsl:element name="hex">78</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:ShiftLongLeft">
		<xsl:element name="hex">79</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:ShiftIntegerRight">
		<xsl:element name="hex">7a</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:ShiftLongRight">
		<xsl:element name="hex">7b</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:ShiftUnsignedIntegerRight">
		<xsl:element name="hex">7c</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:ShiftUnsignedLongRight">
		<xsl:element name="hex">7d</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:AndIntegers">
		<xsl:element name="hex">7e</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:AndLongs">
		<xsl:element name="hex">7f</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:OrIntegers">
		<xsl:element name="hex">80</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:OrLongs">
		<xsl:element name="hex">81</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:ExclusiveOrIntegers">
		<xsl:element name="hex">82</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:ExclusiveOrLongs">
		<xsl:element name="hex">83</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:IncrementImmediate8VariableByImmediate8">
		<xsl:element name="hex">84</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:ConvertIntegerToLong">
		<xsl:element name="hex">85</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:ConvertIntegerToFloat">
		<xsl:element name="hex">86</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:ConvertIntegerToDouble">
		<xsl:element name="hex">87</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:ConvertLongToInt">
		<xsl:element name="hex">88</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:ConvertLongToFloat">
		<xsl:element name="hex">89</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:ConvertLongToDouble">
		<xsl:element name="hex">8a</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:ConvertFloatToInteger">
		<xsl:element name="hex">8b</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:ConvertFloatToLong">
		<xsl:element name="hex">8c</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:ConvertFloatToDouble">
		<xsl:element name="hex">8d</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:ConvertDoubleToInteger">
		<xsl:element name="hex">8e</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:ConvertDoubleToLong">
		<xsl:element name="hex">8f</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:ConvertDoubleToFloat">
		<xsl:element name="hex">90</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:ConvertIntegerToByte">
		<xsl:element name="hex">91</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:ConvertIntegerToCharacter">
		<xsl:element name="hex">92</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:ConvertIntegerToShort">
		<xsl:element name="hex">93</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:CompareLongs">
		<xsl:element name="hex">94</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:CompareFloatsNaNNegative">
		<xsl:element name="hex">95</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:CompareFloatsNaNPositive">
		<xsl:element name="hex">96</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:CompareDoublesNaNNegative">
		<xsl:element name="hex">97</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:CompareDoublesNaNPositive">
		<xsl:element name="hex">98</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:BranchToRelativeIfZero16">
		<xsl:element name="hex">99</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:BranchToRelativeIfNotZero16">
		<xsl:element name="hex">9a</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:BranchToRelativeIfNegative16">
		<xsl:element name="hex">9b</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:BranchToRelativeIfPositiveOrZero16">
		<xsl:element name="hex">9c</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:BranchToRelativeIfPositive16">
		<xsl:element name="hex">9d</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:BranchToRelativeIfNegativeOrZero16">
		<xsl:element name="hex">9e</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:BranchToRelativeIfIntegersEqual16">
		<xsl:element name="hex">9f</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:BranchToRelativeIfIntegersNotEqual16">
		<xsl:element name="hex">a0</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:BranchToRelativeIfIntegerLessThan16">
		<xsl:element name="hex">a1</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:BranchToRelativeIfIntegerGreaterOrEqual16">
		<xsl:element name="hex">a2</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:BranchToRelativeIfIntegerGreaterThan16">
		<xsl:element name="hex">a3</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:BranchToRelativeIfIntegerLessOrEqual16">
		<xsl:element name="hex">a4</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:BranchToRelativeIfReferencesEqual16">
		<xsl:element name="hex">a5</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:BranchToRelativeIfReferencesNotEqual16">
		<xsl:element name="hex">a6</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:JumpToRelative16">
		<xsl:element name="hex">a7</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:CallRelative16">
		<xsl:element name="hex">a8</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:ReturnToImmediate8VariableAddress">
		<xsl:element name="hex">a9</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:SwitchToImmediateTable">
		<xsl:element name="hex">aa</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:SwitchToImmediateDictionary">
		<xsl:element name="hex">ab</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:ReturnInteger">
		<xsl:element name="hex">ac</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:ReturnLong">
		<xsl:element name="hex">ad</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:ReturnFloat">
		<xsl:element name="hex">ae</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:ReturnDouble">
		<xsl:element name="hex">af</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:ReturnObject">
		<xsl:element name="hex">b0</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:Return">
		<xsl:element name="hex">b1</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:GetImmediate16StaticFieldValue">
		<xsl:element name="hex">b2</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:SetImmediate16StaticFieldValue">
		<xsl:element name="hex">b3</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:GetImmediate16FieldValue">
		<xsl:element name="hex">b4</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:SetImmediate16FieldValue">
		<xsl:element name="hex">b5</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:InvokeImmediate16VirtualMethodOnObject">
		<xsl:element name="hex">b6</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:InvokeImmediate16MethodOnObject">
		<xsl:element name="hex">b7</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:InvokeImmediate16StaticMethod">
		<xsl:element name="hex">b8</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:InvokeImmediate16InterfaceMethodOnObject">
		<xsl:element name="hex">b9</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:CreateImmediate16TypeObject">
		<xsl:element name="hex">bb</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:CreateImmediate8PrimitiveTypeArray">
		<xsl:element name="hex">bc</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:CreateImmediate16TypeArray">
		<xsl:element name="hex">bd</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:GetArrayLength">
		<xsl:element name="hex">be</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:ThrowException">
		<xsl:element name="hex">bf</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:TryCastImmediate16Type">
		<xsl:element name="hex">c0</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:CompareObjectToImmediate16Type">
		<xsl:element name="hex">c1</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:LockObject">
		<xsl:element name="hex">c2</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:ReleaseObject">
		<xsl:element name="hex">c3</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:Operand16">
		<xsl:element name="hex">c4</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:CreateImmediate16TypeImmediate8DimensionArray">
		<xsl:element name="hex">c5</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:BranchToRelativeIfNull16">
		<xsl:element name="hex">c6</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:BranchToRelativeIfNotNull16">
		<xsl:element name="hex">c7</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:JumpToRelative32">
		<xsl:element name="hex">c8</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:CallRelative32">
		<xsl:element name="hex">c9</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:Breakpoint">
		<xsl:element name="hex">ca</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:Debug0">
		<xsl:element name="hex">fe</xsl:element>
	</xsl:template>
	<xsl:template match="jvm:Debug1">
		<xsl:element name="hex">ff</xsl:element>
	</xsl:template>
</xsl:stylesheet>