<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:math="http://metalx.org/Intel/8086/Math">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="math:AddToBXSIAddress">
		<xsl:element name="hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBXDIAddress">
		<xsl:element name="hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBPSIAddress">
		<xsl:element name="hex">02</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBPDIAddress">
		<xsl:element name="hex">03</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToSIAddress">
		<xsl:element name="hex">04</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToDIAddress">
		<xsl:element name="hex">05</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToImmediate16Address">
		<xsl:element name="hex">06</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBXAddress">
		<xsl:element name="hex">07</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithBXSIAddress">
		<xsl:element name="hex">08</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithBXDIAddress">
		<xsl:element name="hex">09</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithBPSIAddress">
		<xsl:element name="hex">0A</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithBPDIAddress">
		<xsl:element name="hex">0B</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithSIAddress">
		<xsl:element name="hex">0C</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithDIAddress">
		<xsl:element name="hex">0D</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithImmediate16Address">
		<xsl:element name="hex">0E</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithBXAddress">
		<xsl:element name="hex">0F</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBXSIAddressWithCarry">
		<xsl:element name="hex">10</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBXDIAddressWithCarry">
		<xsl:element name="hex">11</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBPSIAddressWithCarry">
		<xsl:element name="hex">12</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBPDIAddressWithCarry">
		<xsl:element name="hex">13</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToSIAddressWithCarry">
		<xsl:element name="hex">14</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToDIAddressWithCarry">
		<xsl:element name="hex">15</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToImmediate16AddressWithCarry">
		<xsl:element name="hex">16</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBXAddressWithCarry">
		<xsl:element name="hex">17</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBXSIAddressWithBorrow">
		<xsl:element name="hex">18</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBXDIAddressWithBorrow">
		<xsl:element name="hex">19</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBPSIAddressWithBorrow">
		<xsl:element name="hex">1A</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBPDIAddressWithBorrow">
		<xsl:element name="hex">1B</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromSIAddressWithBorrow">
		<xsl:element name="hex">1C</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromDIAddressWithBorrow">
		<xsl:element name="hex">1D</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromImmediate16AddressWithBorrow">
		<xsl:element name="hex">1E</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBXAddressWithBorrow">
		<xsl:element name="hex">1F</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithBXSIAddress">
		<xsl:element name="hex">20</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithBXDIAddress">
		<xsl:element name="hex">21</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithBPSIAddress">
		<xsl:element name="hex">22</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithBPDIAddress">
		<xsl:element name="hex">23</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithSIAddress">
		<xsl:element name="hex">24</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithDIAddress">
		<xsl:element name="hex">25</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithImmediate16Address">
		<xsl:element name="hex">26</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithBXAddress">
		<xsl:element name="hex">27</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBXSIAddress">
		<xsl:element name="hex">28</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBXDIAddress">
		<xsl:element name="hex">29</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBPSIAddress">
		<xsl:element name="hex">2A</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBPDIAddress">
		<xsl:element name="hex">2B</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromSIAddress">
		<xsl:element name="hex">2C</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromDIAddress">
		<xsl:element name="hex">2D</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromImmediate16Address">
		<xsl:element name="hex">2E</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBXAddress">
		<xsl:element name="hex">2F</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithBXSIAddress">
		<xsl:element name="hex">30</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithBXDIAddress">
		<xsl:element name="hex">31</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithBPSIAddress">
		<xsl:element name="hex">32</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithBPDIAddress">
		<xsl:element name="hex">33</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithSIAddress">
		<xsl:element name="hex">34</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithDIAddress">
		<xsl:element name="hex">35</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithImmediate16Address">
		<xsl:element name="hex">36</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithBXAddress">
		<xsl:element name="hex">37</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithBXSIAddress">
		<xsl:element name="hex">38</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithBXDIAddress">
		<xsl:element name="hex">39</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithBPSIAddress">
		<xsl:element name="hex">3A</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithBPDIAddress">
		<xsl:element name="hex">3B</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithSIAddress">
		<xsl:element name="hex">3C</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithDIAddress">
		<xsl:element name="hex">3D</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithImmediate16Address">
		<xsl:element name="hex">3E</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithBXAddress">
		<xsl:element name="hex">3F</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBXSIAddressPlusImmediate8">
		<xsl:element name="hex">40</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBXDIAddressPlusImmediate8">
		<xsl:element name="hex">41</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBPSIAddressPlusImmediate8">
		<xsl:element name="hex">42</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBPDIAddressPlusImmediate8">
		<xsl:element name="hex">43</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToSIAddressPlusImmediate8">
		<xsl:element name="hex">44</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToDIAddressPlusImmediate8">
		<xsl:element name="hex">45</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToImmediate16AddressPlusImmediate8">
		<xsl:element name="hex">46</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBXAddressPlusImmediate8">
		<xsl:element name="hex">47</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithBXSIAddressPlusImmediate8">
		<xsl:element name="hex">48</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithBXDIAddressPlusImmediate8">
		<xsl:element name="hex">49</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithBPSIAddressPlusImmediate8">
		<xsl:element name="hex">4A</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithBPDIAddressPlusImmediate8">
		<xsl:element name="hex">4B</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithSIAddressPlusImmediate8">
		<xsl:element name="hex">4C</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithDIAddressPlusImmediate8">
		<xsl:element name="hex">4D</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithImmediate16AddressPlusImmediate8">
		<xsl:element name="hex">4E</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithBXAddressPlusImmediate8">
		<xsl:element name="hex">4F</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBXSIAddressPlusImmediate8WithCarry">
		<xsl:element name="hex">50</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBXDIAddressPlusImmediate8WithCarry">
		<xsl:element name="hex">51</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBPSIAddressPlusImmediate8WithCarry">
		<xsl:element name="hex">52</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBPDIAddressPlusImmediate8WithCarry">
		<xsl:element name="hex">53</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToSIAddressPlusImmediate8WithCarry">
		<xsl:element name="hex">54</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToDIAddressPlusImmediate8WithCarry">
		<xsl:element name="hex">55</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToImmediate16AddressPlusImmediate8WithCarry">
		<xsl:element name="hex">56</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBXAddressPlusImmediate8WithCarry">
		<xsl:element name="hex">57</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBXSIAddressPlusImmediate8WithBorrow">
		<xsl:element name="hex">58</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBXDIAddressPlusImmediate8WithBorrow">
		<xsl:element name="hex">59</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBPSIAddressPlusImmediate8WithBorrow">
		<xsl:element name="hex">5A</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBPDIAddressPlusImmediate8WithBorrow">
		<xsl:element name="hex">5B</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromSIAddressPlusImmediate8WithBorrow">
		<xsl:element name="hex">5C</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromDIAddressPlusImmediate8WithBorrow">
		<xsl:element name="hex">5D</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromImmediate16AddressPlusImmediate8WithBorrow">
		<xsl:element name="hex">5E</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBXAddressPlusImmediate8WithBorrow">
		<xsl:element name="hex">5F</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithBXSIAddressPlusImmediate8">
		<xsl:element name="hex">60</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithBXDIAddressPlusImmediate8">
		<xsl:element name="hex">61</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithBPSIAddressPlusImmediate8">
		<xsl:element name="hex">62</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithBPDIAddressPlusImmediate8">
		<xsl:element name="hex">63</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithSIAddressPlusImmediate8">
		<xsl:element name="hex">64</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithDIAddressPlusImmediate8">
		<xsl:element name="hex">65</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithImmediate16AddressPlusImmediate8">
		<xsl:element name="hex">66</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithBXAddressPlusImmediate8">
		<xsl:element name="hex">67</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBXSIAddressPlusImmediate8">
		<xsl:element name="hex">68</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBXDIAddressPlusImmediate8">
		<xsl:element name="hex">69</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBPSIAddressPlusImmediate8">
		<xsl:element name="hex">6A</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBPDIAddressPlusImmediate8">
		<xsl:element name="hex">6B</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromSIAddressPlusImmediate8">
		<xsl:element name="hex">6C</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromDIAddressPlusImmediate8">
		<xsl:element name="hex">6D</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromImmediate16AddressPlusImmediate8">
		<xsl:element name="hex">6E</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBXAddressPlusImmediate8">
		<xsl:element name="hex">6F</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithBXSIAddressPlusImmediate8">
		<xsl:element name="hex">70</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithBXDIAddressPlusImmediate8">
		<xsl:element name="hex">71</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithBPSIAddressPlusImmediate8">
		<xsl:element name="hex">72</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithBPDIAddressPlusImmediate8">
		<xsl:element name="hex">73</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithSIAddressPlusImmediate8">
		<xsl:element name="hex">74</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithDIAddressPlusImmediate8">
		<xsl:element name="hex">75</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithImmediate16AddressPlusImmediate8">
		<xsl:element name="hex">76</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithBXAddressPlusImmediate8">
		<xsl:element name="hex">77</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithBXSIAddressPlusImmediate8">
		<xsl:element name="hex">78</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithBXDIAddressPlusImmediate8">
		<xsl:element name="hex">79</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithBPSIAddressPlusImmediate8">
		<xsl:element name="hex">7A</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithBPDIAddressPlusImmediate8">
		<xsl:element name="hex">7B</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithSIAddressPlusImmediate8">
		<xsl:element name="hex">7C</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithDIAddressPlusImmediate8">
		<xsl:element name="hex">7D</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithImmediate16AddressPlusImmediate8">
		<xsl:element name="hex">7E</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithBXAddressPlusImmediate8">
		<xsl:element name="hex">7F</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBXSIAddressPlusImmediate16">
		<xsl:element name="hex">80</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBXDIAddressPlusImmediate16">
		<xsl:element name="hex">81</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBPSIAddressPlusImmediate16">
		<xsl:element name="hex">82</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBPDIAddressPlusImmediate16">
		<xsl:element name="hex">83</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToSIAddressPlusImmediate16">
		<xsl:element name="hex">84</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToDIAddressPlusImmediate16">
		<xsl:element name="hex">85</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToImmediate16AddressPlusImmediate16">
		<xsl:element name="hex">86</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBXAddressPlusImmediate16">
		<xsl:element name="hex">87</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithBXSIAddressPlusImmediate16">
		<xsl:element name="hex">88</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithBXDIAddressPlusImmediate16">
		<xsl:element name="hex">89</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithBPSIAddressPlusImmediate16">
		<xsl:element name="hex">8A</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithBPDIAddressPlusImmediate16">
		<xsl:element name="hex">8B</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithSIAddressPlusImmediate16">
		<xsl:element name="hex">8C</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithDIAddressPlusImmediate16">
		<xsl:element name="hex">8D</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithImmediate16AddressPlusImmediate16">
		<xsl:element name="hex">8E</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithBXAddressPlusImmediate16">
		<xsl:element name="hex">8F</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBXSIAddressPlusImmediate16WithCarry">
		<xsl:element name="hex">90</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBXDIAddressPlusImmediate16WithCarry">
		<xsl:element name="hex">91</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBPSIAddressPlusImmediate16WithCarry">
		<xsl:element name="hex">92</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBPDIAddressPlusImmediate16WithCarry">
		<xsl:element name="hex">93</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToSIAddressPlusImmediate16WithCarry">
		<xsl:element name="hex">94</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToDIAddressPlusImmediate16WithCarry">
		<xsl:element name="hex">95</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToImmediate16AddressPlusImmediate16WithCarry">
		<xsl:element name="hex">96</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBXAddressPlusImmediate16WithCarry">
		<xsl:element name="hex">97</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBXSIAddressPlusImmediate16WithBorrow">
		<xsl:element name="hex">98</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBXDIAddressPlusImmediate16WithBorrow">
		<xsl:element name="hex">99</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBPSIAddressPlusImmediate16WithBorrow">
		<xsl:element name="hex">9A</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBPDIAddressPlusImmediate16WithBorrow">
		<xsl:element name="hex">9B</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromSIAddressPlusImmediate16WithBorrow">
		<xsl:element name="hex">9C</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromDIAddressPlusImmediate16WithBorrow">
		<xsl:element name="hex">9D</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromImmediate16AddressPlusImmediate16WithBorrow">
		<xsl:element name="hex">9E</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBXAddressPlusImmediate16WithBorrow">
		<xsl:element name="hex">9F</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithBXSIAddressPlusImmediate16">
		<xsl:element name="hex">A0</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithBXDIAddressPlusImmediate16">
		<xsl:element name="hex">A1</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithBPSIAddressPlusImmediate16">
		<xsl:element name="hex">A2</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithBPDIAddressPlusImmediate16">
		<xsl:element name="hex">A3</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithSIAddressPlusImmediate16">
		<xsl:element name="hex">A4</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithDIAddressPlusImmediate16">
		<xsl:element name="hex">A5</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithImmediate16AddressPlusImmediate16">
		<xsl:element name="hex">A6</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithBXAddressPlusImmediate16">
		<xsl:element name="hex">A7</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBXSIAddressPlusImmediate16">
		<xsl:element name="hex">A8</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBXDIAddressPlusImmediate16">
		<xsl:element name="hex">A9</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBPSIAddressPlusImmediate16">
		<xsl:element name="hex">AA</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBPDIAddressPlusImmediate16">
		<xsl:element name="hex">AB</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromSIAddressPlusImmediate16">
		<xsl:element name="hex">AC</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromDIAddressPlusImmediate16">
		<xsl:element name="hex">AD</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromImmediate16AddressPlusImmediate16">
		<xsl:element name="hex">AE</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBXAddressPlusImmediate16">
		<xsl:element name="hex">AF</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithBXSIAddressPlusImmediate16">
		<xsl:element name="hex">B0</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithBXDIAddressPlusImmediate16">
		<xsl:element name="hex">B1</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithBPSIAddressPlusImmediate16">
		<xsl:element name="hex">B2</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithBPDIAddressPlusImmediate16">
		<xsl:element name="hex">B3</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithSIAddressPlusImmediate16">
		<xsl:element name="hex">B4</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithDIAddressPlusImmediate16">
		<xsl:element name="hex">B5</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithImmediate16AddressPlusImmediate16">
		<xsl:element name="hex">B6</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithBXAddressPlusImmediate16">
		<xsl:element name="hex">B7</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithBXSIAddressPlusImmediate16">
		<xsl:element name="hex">B8</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithBXDIAddressPlusImmediate16">
		<xsl:element name="hex">B9</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithBPSIAddressPlusImmediate16">
		<xsl:element name="hex">BA</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithBPDIAddressPlusImmediate16">
		<xsl:element name="hex">BB</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithSIAddressPlusImmediate16">
		<xsl:element name="hex">BC</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithDIAddressPlusImmediate16">
		<xsl:element name="hex">BD</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithImmediate16AddressPlusImmediate16">
		<xsl:element name="hex">BE</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithBXAddressPlusImmediate16">
		<xsl:element name="hex">BF</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToALRegister">
		<xsl:element name="hex">C0</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToCLRegister">
		<xsl:element name="hex">C1</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToDLRegister">
		<xsl:element name="hex">C2</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBLRegister">
		<xsl:element name="hex">C3</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToAHRegister">
		<xsl:element name="hex">C4</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToCHRegister">
		<xsl:element name="hex">C5</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToDHRegister">
		<xsl:element name="hex">C6</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBHRegister">
		<xsl:element name="hex">C7</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToAXRegister">
		<xsl:element name="hex">C0</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToCXRegister">
		<xsl:element name="hex">C1</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToDXRegister">
		<xsl:element name="hex">C2</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBXRegister">
		<xsl:element name="hex">C3</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToSPRegister">
		<xsl:element name="hex">C4</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBPRegister">
		<xsl:element name="hex">C5</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToSIRegister">
		<xsl:element name="hex">C6</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToDIRegister">
		<xsl:element name="hex">C7</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithALRegister">
		<xsl:element name="hex">C8</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithCLRegister">
		<xsl:element name="hex">C9</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithDLRegister">
		<xsl:element name="hex">CA</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithBLRegister">
		<xsl:element name="hex">CB</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithAHRegister">
		<xsl:element name="hex">CC</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithCHRegister">
		<xsl:element name="hex">CD</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithDHRegister">
		<xsl:element name="hex">CE</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithBHRegister">
		<xsl:element name="hex">CF</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithAXRegister">
		<xsl:element name="hex">C8</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithCXRegister">
		<xsl:element name="hex">C9</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithDXRegister">
		<xsl:element name="hex">CA</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithBXRegister">
		<xsl:element name="hex">CB</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithSPRegister">
		<xsl:element name="hex">CC</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithBPRegister">
		<xsl:element name="hex">CD</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithSIRegister">
		<xsl:element name="hex">CE</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithDIRegister">
		<xsl:element name="hex">CF</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToALRegisterWithCarry">
		<xsl:element name="hex">D0</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToCLRegisterWithCarry">
		<xsl:element name="hex">D1</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToDLRegisterWithCarry">
		<xsl:element name="hex">D2</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBLRegisterWithCarry">
		<xsl:element name="hex">D3</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToAHRegisterWithCarry">
		<xsl:element name="hex">D4</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToCHRegisterWithCarry">
		<xsl:element name="hex">D5</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToDHRegisterWithCarry">
		<xsl:element name="hex">D6</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBHRegisterWithCarry">
		<xsl:element name="hex">D7</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToAXRegisterWithCarry">
		<xsl:element name="hex">D0</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToCXRegisterWithCarry">
		<xsl:element name="hex">D1</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToDXRegisterWithCarry">
		<xsl:element name="hex">D2</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBXRegisterWithCarry">
		<xsl:element name="hex">D3</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToSPRegisterWithCarry">
		<xsl:element name="hex">D4</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBPRegisterWithCarry">
		<xsl:element name="hex">D5</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToSIRegisterWithCarry">
		<xsl:element name="hex">D6</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToDIRegisterWithCarry">
		<xsl:element name="hex">D7</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromALRegisterWithBorrow">
		<xsl:element name="hex">D8</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromCLRegisterWithBorrow">
		<xsl:element name="hex">D9</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromDLRegisterWithBorrow">
		<xsl:element name="hex">DA</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBLRegisterWithBorrow">
		<xsl:element name="hex">DB</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromAHRegisterWithBorrow">
		<xsl:element name="hex">DC</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromCHRegisterWithBorrow">
		<xsl:element name="hex">DD</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromDHRegisterWithBorrow">
		<xsl:element name="hex">DE</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBHRegisterWithBorrow">
		<xsl:element name="hex">DF</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromAXRegisterWithBorrow">
		<xsl:element name="hex">D8</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromCXRegisterWithBorrow">
		<xsl:element name="hex">D9</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromDXRegisterWithBorrow">
		<xsl:element name="hex">DA</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBXRegisterWithBorrow">
		<xsl:element name="hex">DB</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromSPRegisterWithBorrow">
		<xsl:element name="hex">DC</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBPRegisterWithBorrow">
		<xsl:element name="hex">DD</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromSIRegisterWithBorrow">
		<xsl:element name="hex">DE</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromDIRegisterWithBorrow">
		<xsl:element name="hex">DF</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithALRegister">
		<xsl:element name="hex">E0</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithCLRegister">
		<xsl:element name="hex">E1</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithDLRegister">
		<xsl:element name="hex">E2</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithBLRegister">
		<xsl:element name="hex">E3</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithAHRegister">
		<xsl:element name="hex">E4</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithCHRegister">
		<xsl:element name="hex">E5</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithDHRegister">
		<xsl:element name="hex">E6</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithBHRegister">
		<xsl:element name="hex">E7</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithAXRegister">
		<xsl:element name="hex">E0</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithCXRegister">
		<xsl:element name="hex">E1</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithDXRegister">
		<xsl:element name="hex">E2</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithBXRegister">
		<xsl:element name="hex">E3</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithSPRegister">
		<xsl:element name="hex">E4</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithBPRegister">
		<xsl:element name="hex">E5</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithSIRegister">
		<xsl:element name="hex">E6</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithDIRegister">
		<xsl:element name="hex">E7</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromALRegister">
		<xsl:element name="hex">E8</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromCLRegister">
		<xsl:element name="hex">E9</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromDLRegister">
		<xsl:element name="hex">EA</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBLRegister">
		<xsl:element name="hex">EB</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromAHRegister">
		<xsl:element name="hex">EC</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromCHRegister">
		<xsl:element name="hex">ED</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromDHRegister">
		<xsl:element name="hex">EE</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBHRegister">
		<xsl:element name="hex">EF</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromAXRegister">
		<xsl:element name="hex">E8</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromCXRegister">
		<xsl:element name="hex">E9</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromDXRegister">
		<xsl:element name="hex">EA</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBXRegister">
		<xsl:element name="hex">EB</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromSPRegister">
		<xsl:element name="hex">EC</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBPRegister">
		<xsl:element name="hex">ED</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromSIRegister">
		<xsl:element name="hex">EE</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromDIRegister">
		<xsl:element name="hex">EF</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithALRegister">
		<xsl:element name="hex">F0</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithCLRegister">
		<xsl:element name="hex">F1</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithDLRegister">
		<xsl:element name="hex">F2</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithBLRegister">
		<xsl:element name="hex">F3</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithAHRegister">
		<xsl:element name="hex">F4</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithCHRegister">
		<xsl:element name="hex">F5</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithDHRegister">
		<xsl:element name="hex">F6</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithBHRegister">
		<xsl:element name="hex">F7</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithAXRegister">
		<xsl:element name="hex">F0</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithCXRegister">
		<xsl:element name="hex">F1</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithDXRegister">
		<xsl:element name="hex">F2</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithBXRegister">
		<xsl:element name="hex">F3</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithSPRegister">
		<xsl:element name="hex">F4</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithBPRegister">
		<xsl:element name="hex">F5</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithSIRegister">
		<xsl:element name="hex">F6</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithDIRegister">
		<xsl:element name="hex">F7</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithALRegister">
		<xsl:element name="hex">F8</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithCLRegister">
		<xsl:element name="hex">F9</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithDLRegister">
		<xsl:element name="hex">FA</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithBLRegister">
		<xsl:element name="hex">FB</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithAHRegister">
		<xsl:element name="hex">FC</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithCHRegister">
		<xsl:element name="hex">FD</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithDHRegister">
		<xsl:element name="hex">FE</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithBHRegister">
		<xsl:element name="hex">FF</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithAXRegister">
		<xsl:element name="hex">F8</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithCXRegister">
		<xsl:element name="hex">F9</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithDXRegister">
		<xsl:element name="hex">FA</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithBXRegister">
		<xsl:element name="hex">FB</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithSPRegister">
		<xsl:element name="hex">FC</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithBPRegister">
		<xsl:element name="hex">FD</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithSIRegister">
		<xsl:element name="hex">FE</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithDIRegister">
		<xsl:element name="hex">FF</xsl:element>
	</xsl:template>
</xsl:stylesheet>