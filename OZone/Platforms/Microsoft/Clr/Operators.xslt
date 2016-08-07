<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:cpu="http://metalx.org/Microsoft/Clr">

	<xsl:output method="xml" indent="yes" />

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="cpu:AddValues">
		<xsl:element name="hex">58</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:AddSignedIntegerValuesAndCheckOverflow">
		<xsl:element name="hex">D6</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:AddUnsignedIntegerValuesAndCheckOverflow">
		<xsl:element name="hex">D7</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:AndIntegerValues">
		<xsl:element name="hex">5F</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:GetArgumentListHandle">
		<xsl:element name="hex">FE00</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchIfEqual32">
		<xsl:element name="hex">3B</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchIfEqual8">
		<xsl:element name="hex">2E</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchIfGreaterThanOrEqualTo32">
		<xsl:element name="hex">3C</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchIfGreaterThanOrEqualTo8">
		<xsl:element name="hex">2F</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchIfGreaterThanOrEqualToUnsigned32">
		<xsl:element name="hex">41</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchIfGreaterThanOrEqualToUnsigned8">
		<xsl:element name="hex">34</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchIfGreaterThan32">
		<xsl:element name="hex">3D</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchIfGreaterThan8">
		<xsl:element name="hex">30</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchIfGreaterThanUnsigned32">
		<xsl:element name="hex">42</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchIfGreaterThanUnsigned8">
		<xsl:element name="hex">35</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchIfLessThanOrEqualTo32">
		<xsl:element name="hex">3E</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchIfLessThanOrEqualTo8">
		<xsl:element name="hex">31</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchIfLessThanOrEqualToUnsigned32">
		<xsl:element name="hex">43</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchIfLessThanOrEqualToUnsigned8">
		<xsl:element name="hex">36</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchIfLessThan32">
		<xsl:element name="hex">3F</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchIfLessThan8">
		<xsl:element name="hex">32</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchIfLessThanUnsigned32">
		<xsl:element name="hex">44</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchIfLessThanUnsigned8">
		<xsl:element name="hex">37</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchIfNotEqual32">
		<xsl:element name="hex">40</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchIfNotEqual8">
		<xsl:element name="hex">33</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BoxValue">
		<xsl:element name="hex">8C</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:JumpTo32">
		<xsl:element name="hex">38</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:JumpTo8">
		<xsl:element name="hex">2B</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:Break">
		<xsl:element name="hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchIfFalse32">
		<xsl:element name="hex">39</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchIfFalse8">
		<xsl:element name="hex">2C</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchIfNotNull32">
		<xsl:element name="hex">3A</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchIfNotNull8">
		<xsl:element name="hex">2D</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchIfNull32">
		<xsl:element name="hex">39</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchIfNull8">
		<xsl:element name="hex">2C</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchIfTrue32">
		<xsl:element name="hex">3A</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchIfTrue8">
		<xsl:element name="hex">2D</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchIfZero32">
		<xsl:element name="hex">39</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:BranchIfZero8">
		<xsl:element name="hex">2C</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CallMethod">
		<xsl:element name="hex">28</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CallSite">
		<xsl:element name="hex">29</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CallObjectMethod">
		<xsl:element name="hex">6F</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CastObject">
		<xsl:element name="hex">74</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushEqual">
		<xsl:element name="hex">FE01</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushGreaterThan">
		<xsl:element name="hex">FE02</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushGreaterThanUnsigned">
		<xsl:element name="hex">FE03</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CheckFiniteNumber">
		<xsl:element name="hex">C3</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushLessThan">
		<xsl:element name="hex">FE04</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushLessThanUnordered">
		<xsl:element name="hex">FE05</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CallVirtualMethodForType">
		<xsl:element name="hex">FE16</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ConvertToNativeInteger">
		<xsl:element name="hex">D3</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ConvertToByte">
		<xsl:element name="hex">67</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ConvertToShort">
		<xsl:element name="hex">68</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ConvertToInteger">
		<xsl:element name="hex">69</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ConvertToLong">
		<xsl:element name="hex">6A</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ConvertToNativeIntegerAndCheckOverflow">
		<xsl:element name="hex">D4</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ConvertUnsignedToNativeIntegerAndCheckOverflow">
		<xsl:element name="hex">8A</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ConvertToByteAndCheckOverflow">
		<xsl:element name="hex">B3</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ConvertUnsignedToByteAndCheckOverflow">
		<xsl:element name="hex">82</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ConvertToShortAndCheckOverflow">
		<xsl:element name="hex">B5</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ConvertUnsignedToShortAndCheckOverflow">
		<xsl:element name="hex">83</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ConvertToIntegerAndCheckOverflow">
		<xsl:element name="hex">B7</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ConvertUnsignedToIntegerAndCheckOverflow">
		<xsl:element name="hex">84</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ConvertToLongAndCheckOverflow">
		<xsl:element name="hex">B9</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ConvertUnsignedToLongAndCheckOverflow">
		<xsl:element name="hex">85</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ConvertToNativeUnsignedIntegerAndCheckOverflow">
		<xsl:element name="hex">D5</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ConvertUnsignedToNativeUnsignedIntegerAndCheckOverflow">
		<xsl:element name="hex">8B</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ConvertToUnsignedByteAndCheckOverflow">
		<xsl:element name="hex">B4</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ConvertUnsignedToUnsignedByteAndCheckOverflow">
		<xsl:element name="hex">86</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ConvertToUnsignedShortAndCheckOverflow">
		<xsl:element name="hex">B6</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ConvertUnsignedToUnsignedShortAndCheckOverflow">
		<xsl:element name="hex">87</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ConvertToUnsignedIntegerAndCheckOverflow">
		<xsl:element name="hex">B8</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ConvertUnsignedToUnsignedIntegerAndCheckOverflow">
		<xsl:element name="hex">88</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ConvertToUnsignedLongAndCheckOverflow">
		<xsl:element name="hex">BA</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ConvertUnsignedToUnsignedLongAndCheckOverflow">
		<xsl:element name="hex">89</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ConvertUnsignedToFloat">
		<xsl:element name="hex">76</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ConvertToFloat">
		<xsl:element name="hex">6B</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ConvertToDouble">
		<xsl:element name="hex">6C</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ConvertToNativeUnsignedInteger">
		<xsl:element name="hex">E0</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ConvertToUnsignedByte">
		<xsl:element name="hex">D2</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ConvertToUnsignedShort">
		<xsl:element name="hex">D1</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ConvertToUnsignedInteger">
		<xsl:element name="hex">6D</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ConvertToUnsignedLong">
		<xsl:element name="hex">6E</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyMemory">
		<xsl:element name="hex">FE17</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CopyValue">
		<xsl:element name="hex">70</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:DivideValues">
		<xsl:element name="hex">5B</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:DivideUnsignedValues">
		<xsl:element name="hex">5C</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:DuplicateValue">
		<xsl:element name="hex">25</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:EndFault">
		<xsl:element name="hex">DC</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:EndFilter">
		<xsl:element name="hex">FE11</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:EndFinally">
		<xsl:element name="hex">DC</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushLongValue">
		<xsl:element name="hex">4C</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SetMemory">
		<xsl:element name="hex">FE18</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:InitializeMemory">
		<xsl:element name="hex">FE15</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:GetObjectAsType">
		<xsl:element name="hex">75</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:JumpToMethod">
		<xsl:element name="hex">27</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushArgumentToStack16">
		<xsl:element name="hex">FE09</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushArgument0ToStack">
		<xsl:element name="hex">02</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushArgument1ToStack">
		<xsl:element name="hex">03</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushArgument2ToStack">
		<xsl:element name="hex">04</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushArgument3ToStack">
		<xsl:element name="hex">05</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushArgumentToStack8">
		<xsl:element name="hex">0E</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:GetArgumentAddress16">
		<xsl:element name="hex">FE0A</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:GetArgumentAddress8">
		<xsl:element name="hex">0F</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushIntegerValueToStack">
		<xsl:element name="hex">20</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushZeroToStack32">
		<xsl:element name="hex">16</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushOneToStack32">
		<xsl:element name="hex">17</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushTwoToStack32">
		<xsl:element name="hex">18</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushThreeToStack32">
		<xsl:element name="hex">19</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushFourToStack32">
		<xsl:element name="hex">1A</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushFiveToStack32">
		<xsl:element name="hex">1B</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushSixToStack32">
		<xsl:element name="hex">1C</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushSevenToStack32">
		<xsl:element name="hex">1D</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushEightToStack32">
		<xsl:element name="hex">1E</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushNegativeOneToStack32">
		<xsl:element name="hex">15</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushIntegerNegativeOneToStack32">
		<xsl:element name="hex">15</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushByteValueToStack32">
		<xsl:element name="hex">1F</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushLongValueToStack64">
		<xsl:element name="hex">21</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushFloatValueToStack32">
		<xsl:element name="hex">22</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushDoubleValueToStack32">
		<xsl:element name="hex">23</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:GetArrayItem">
		<xsl:element name="hex">A3</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:GetArrayNativeInteger">
		<xsl:element name="hex">97</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:GetArrayByte">
		<xsl:element name="hex">90</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:GetArrayShort">
		<xsl:element name="hex">92</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:GetArrayInteger">
		<xsl:element name="hex">94</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:GetArrayLong">
		<xsl:element name="hex">96</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:GetArrayFloat">
		<xsl:element name="hex">98</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:GetArrayDouble">
		<xsl:element name="hex">99</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:GetArrayObject">
		<xsl:element name="hex">9A</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:GetArrayUnsignedByte">
		<xsl:element name="hex">91</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:GetArrayUnsignedShort">
		<xsl:element name="hex">93</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:GetArrayUnsignedInteger">
		<xsl:element name="hex">95</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:GetArrayUnsignedLong">
		<xsl:element name="hex">96</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:GetArrayItemAddress">
		<xsl:element name="hex">8F</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushFieldValueToStack">
		<xsl:element name="hex">7B</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushFieldAddressToStack">
		<xsl:element name="hex">7C</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushMethodPointerToStack">
		<xsl:element name="hex">FE06</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushNativeIntegerToStack">
		<xsl:element name="hex">4D</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushByteToStack32">
		<xsl:element name="hex">46</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushShortToStack32">
		<xsl:element name="hex">48</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushIntegerToStack32">
		<xsl:element name="hex">4A</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushLongToStack64">
		<xsl:element name="hex">4C</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushFloatToStack32">
		<xsl:element name="hex">4E</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushDoubleToStack64">
		<xsl:element name="hex">4F</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushObjectToStack">
		<xsl:element name="hex">50</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushUnsignedByteToStack32">
		<xsl:element name="hex">47</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushUnsignedShortToStack32">
		<xsl:element name="hex">49</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushUnsignedIntegerToStack32">
		<xsl:element name="hex">4B</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:GetArrayLength">
		<xsl:element name="hex">8E</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushVariableToStack16">
		<xsl:element name="hex">FE0C</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushVariable0ToStack">
		<xsl:element name="hex">06</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushVariable1ToStack">
		<xsl:element name="hex">07</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushVariable2ToStack">
		<xsl:element name="hex">08</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushVariable3ToStack">
		<xsl:element name="hex">09</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushVariableToStack8">
		<xsl:element name="hex">11</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushVariableAddressToStack16">
		<xsl:element name="hex">FE0D</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushVariableAddressToStack8">
		<xsl:element name="hex">12</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushNullToStack">
		<xsl:element name="hex">14</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushMemoryValueToStack">
		<xsl:element name="hex">71</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushFieldValueToStack">
		<xsl:element name="hex">7E</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushFieldAddressToStack">
		<xsl:element name="hex">7F</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushStringToStack">
		<xsl:element name="hex">72</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:GetRuntimeMetadata">
		<xsl:element name="hex">D0</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushVirtualAddressToStack">
		<xsl:element name="hex">FE07</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:LeaveProtectedCode32">
		<xsl:element name="hex">DD</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:LeaveProtectedCode8">
		<xsl:element name="hex">DE</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:AllocateLocalMemory">
		<xsl:element name="hex">FE0F</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushTypedReference">
		<xsl:element name="hex">C6</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:MultiplyValues">
		<xsl:element name="hex">5A</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:MultiplySignedIntegerValues">
		<xsl:element name="hex">D8</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:MultiplyUnsignedIntegerValues">
		<xsl:element name="hex">D9</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:NegateValue">
		<xsl:element name="hex">65</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CreateArray">
		<xsl:element name="hex">8D</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:CreateObject">
		<xsl:element name="hex">73</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SkipCheck">
		<xsl:element name="hex">FE19</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:NoOperation">
		<xsl:element name="hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:NotValues">
		<xsl:element name="hex">66</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:OrValues32">
		<xsl:element name="hex">60</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PullValueFromStack">
		<xsl:element name="hex">26</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ReadOnly">
		<xsl:element name="hex">FE1E</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushTypeIDToStack">
		<xsl:element name="hex">FE1D</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PushAddressToStack">
		<xsl:element name="hex">C2</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:DivideValuesAndGetRemainder">
		<xsl:element name="hex">5D</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:DivideUnsignedValuesAndGetRemainder">
		<xsl:element name="hex">5E</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:Return">
		<xsl:element name="hex">2A</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:RethrowException">
		<xsl:element name="hex">FE1A</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ShiftIntegerLeft">
		<xsl:element name="hex">62</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ShiftIntegerRight">
		<xsl:element name="hex">63</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ShiftUnsignedIntegerRight">
		<xsl:element name="hex">64</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:GetTypeSize">
		<xsl:element name="hex">FE1C</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PullArgumentFromStack16">
		<xsl:element name="hex">FE0B</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PullArgumentFromStack8">
		<xsl:element name="hex">10</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PullArrayItemFromStack">
		<xsl:element name="hex">A4</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PullArrayNativeIntegerFromStack">
		<xsl:element name="hex">9B</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PullArrayByteFromStack">
		<xsl:element name="hex">9C</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PullArrayShortFromStack">
		<xsl:element name="hex">9D</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PullArrayIntegerFromStack">
		<xsl:element name="hex">9E</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PullArrayLongFromStack">
		<xsl:element name="hex">9F</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PullArrayFloatFromStack">
		<xsl:element name="hex">A0</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PullArrayDoubleFromStack">
		<xsl:element name="hex">A1</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PullArrayReferenceFromStack">
		<xsl:element name="hex">A2</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SetFieldValue">
		<xsl:element name="hex">7D</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SetNativeIntegerAtAddress">
		<xsl:element name="hex">DF</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SetByteAtAddress">
		<xsl:element name="hex">52</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SetShortAtAddress">
		<xsl:element name="hex">53</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SetIntegerAtAddress">
		<xsl:element name="hex">54</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SetLongAtAddress">
		<xsl:element name="hex">55</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SetFloatAtAddress">
		<xsl:element name="hex">56</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SetDoubleAtAddress">
		<xsl:element name="hex">57</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SetReferenceAtAddress">
		<xsl:element name="hex">51</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PullVariableFromStack16">
		<xsl:element name="hex">FE0E</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PullVariable0FromStack">
		<xsl:element name="hex">0A</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PullVariable1FromStack">
		<xsl:element name="hex">0B</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PullVariable2FromStack">
		<xsl:element name="hex">0C</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PullVariable3FromStack">
		<xsl:element name="hex">0D</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:PullVariableFromStack8">
		<xsl:element name="hex">13</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SetTypeAtAddress">
		<xsl:element name="hex">81</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SetFieldValue">
		<xsl:element name="hex">80</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SubtractValues">
		<xsl:element name="hex">59</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SubtractNativeIntegers">
		<xsl:element name="hex">DA</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:SubtractUnsignedNativeIntegers">
		<xsl:element name="hex">DB</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:Switch">
		<xsl:element name="hex">45</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:EndMethod">
		<xsl:element name="hex">FE14</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ThrowException">
		<xsl:element name="hex">7A</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:Unaligned">
		<xsl:element name="hex">FE12</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:Unbox">
		<xsl:element name="hex">79</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:UnboxAny">
		<xsl:element name="hex">A5</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:Volatile">
		<xsl:element name="hex">FE13</xsl:element>
	</xsl:template>
	<xsl:template match="cpu:ExclusiveOrValues">
		<xsl:element name="hex">61</xsl:element>
	</xsl:template>
</xsl:stylesheet>