<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:math="http://metalx.org/Amd/Amd64/Math">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="math:AddToAXAddress">
		<xsl:element name="hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToCXAddress">
		<xsl:element name="hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToDXAddress">
		<xsl:element name="hex">02</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBXAddress">
		<xsl:element name="hex">03</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToIndexAddress">
		<xsl:element name="hex">04</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToImmediateAddress">
		<xsl:element name="hex">05</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToSIAddress">
		<xsl:element name="hex">06</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToDIAddress">
		<xsl:element name="hex">07</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithAXAddress">
		<xsl:element name="hex">08</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithCXAddress">
		<xsl:element name="hex">09</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithDXAddress">
		<xsl:element name="hex">0A</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithBXAddress">
		<xsl:element name="hex">0B</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithIndexAddress">
		<xsl:element name="hex">0C</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithImmediateAddress">
		<xsl:element name="hex">0D</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithSIAddress">
		<xsl:element name="hex">0E</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithDIAddress">
		<xsl:element name="hex">0F</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToAXAddressWithCarry">
		<xsl:element name="hex">10</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToCXAddressWithCarry">
		<xsl:element name="hex">11</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToDXAddressWithCarry">
		<xsl:element name="hex">12</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBXAddressWithCarry">
		<xsl:element name="hex">13</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToIndexAddressWithCarry">
		<xsl:element name="hex">14</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToImmediateAddressWithCarry">
		<xsl:element name="hex">15</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToSIAddressWithCarry">
		<xsl:element name="hex">16</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToDIAddressWithCarry">
		<xsl:element name="hex">17</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromAXAddressWithBorrow">
		<xsl:element name="hex">18</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromCXAddressWithBorrow">
		<xsl:element name="hex">19</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromDXAddressWithBorrow">
		<xsl:element name="hex">1A</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBXAddressWithBorrow">
		<xsl:element name="hex">1B</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromIndexAddressWithBorrow">
		<xsl:element name="hex">1C</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromImmediateAddressWithBorrow">
		<xsl:element name="hex">1D</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromSIAddressWithBorrow">
		<xsl:element name="hex">1E</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromDIAddressWithBorrow">
		<xsl:element name="hex">1F</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithAXAddress">
		<xsl:element name="hex">20</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithCXAddress">
		<xsl:element name="hex">21</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithDXAddress">
		<xsl:element name="hex">22</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithBXAddress">
		<xsl:element name="hex">23</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithIndexAddress">
		<xsl:element name="hex">24</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithImmediateAddress">
		<xsl:element name="hex">25</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithSIAddress">
		<xsl:element name="hex">26</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithDIAddress">
		<xsl:element name="hex">27</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromAXAddress">
		<xsl:element name="hex">28</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromCXAddress">
		<xsl:element name="hex">29</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromDXAddress">
		<xsl:element name="hex">2A</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBXAddress">
		<xsl:element name="hex">2B</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromIndexAddress">
		<xsl:element name="hex">2C</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromImmediateAddress">
		<xsl:element name="hex">2D</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromSIAddress">
		<xsl:element name="hex">2E</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromDIAddress">
		<xsl:element name="hex">2F</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithAXAddress">
		<xsl:element name="hex">30</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithCXAddress">
		<xsl:element name="hex">31</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithDXAddress">
		<xsl:element name="hex">32</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithBXAddress">
		<xsl:element name="hex">33</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithIndexAddress">
		<xsl:element name="hex">34</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithImmediateAddress">
		<xsl:element name="hex">35</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithSIAddress">
		<xsl:element name="hex">36</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithDIAddress">
		<xsl:element name="hex">37</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithAXAddress">
		<xsl:element name="hex">38</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithCXAddress">
		<xsl:element name="hex">39</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithDXAddress">
		<xsl:element name="hex">3A</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithBXAddress">
		<xsl:element name="hex">3B</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithIndexAddress">
		<xsl:element name="hex">3C</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithImmediateAddress">
		<xsl:element name="hex">3D</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithSIAddress">
		<xsl:element name="hex">3E</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithDIAddress">
		<xsl:element name="hex">3F</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToAXAddressPlusImmediate8">
		<xsl:element name="hex">40</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToCXAddressPlusImmediate8">
		<xsl:element name="hex">41</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToDXAddressPlusImmediate8">
		<xsl:element name="hex">42</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBXAddressPlusImmediate8">
		<xsl:element name="hex">43</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToIndexAddressPlusImmediate8">
		<xsl:element name="hex">44</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBPAddressPlusImmediate8">
		<xsl:element name="hex">45</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToSIAddressPlusImmediate8">
		<xsl:element name="hex">46</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToDIAddressPlusImmediate8">
		<xsl:element name="hex">47</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithAXAddressPlusImmediate8">
		<xsl:element name="hex">48</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithCXAddressPlusImmediate8">
		<xsl:element name="hex">49</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithDXAddressPlusImmediate8">
		<xsl:element name="hex">4A</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithBXAddressPlusImmediate8">
		<xsl:element name="hex">4B</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithIndexAddressPlusImmediate8">
		<xsl:element name="hex">4C</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithBPAddressPlusImmediate8">
		<xsl:element name="hex">4D</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithSIAddressPlusImmediate8">
		<xsl:element name="hex">4E</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithDIAddressPlusImmediate8">
		<xsl:element name="hex">4F</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToAXAddressPlusImmediate8WithCarry">
		<xsl:element name="hex">50</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToCXAddressPlusImmediate8WithCarry">
		<xsl:element name="hex">51</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToDXAddressPlusImmediate8WithCarry">
		<xsl:element name="hex">52</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBXAddressPlusImmediate8WithCarry">
		<xsl:element name="hex">53</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToIndexAddressPlusImmediate8WithCarry">
		<xsl:element name="hex">54</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBPAddressPlusImmediate8WithCarry">
		<xsl:element name="hex">55</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToSIAddressPlusImmediate8WithCarry">
		<xsl:element name="hex">56</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToDIAddressPlusImmediate8WithCarry">
		<xsl:element name="hex">57</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromAXAddressPlusImmediate8WithBorrow">
		<xsl:element name="hex">58</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromCXAddressPlusImmediate8WithBorrow">
		<xsl:element name="hex">59</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromDXAddressPlusImmediate8WithBorrow">
		<xsl:element name="hex">5A</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBXAddressPlusImmediate8WithBorrow">
		<xsl:element name="hex">5B</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromIndexAddressPlusImmediate8WithBorrow">
		<xsl:element name="hex">5C</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBPAddressPlusImmediate8WithBorrow">
		<xsl:element name="hex">5D</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromSIAddressPlusImmediate8WithBorrow">
		<xsl:element name="hex">5E</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromDIAddressPlusImmediate8WithBorrow">
		<xsl:element name="hex">5F</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithAXAddressPlusImmediate8">
		<xsl:element name="hex">60</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithCXAddressPlusImmediate8">
		<xsl:element name="hex">61</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithDXAddressPlusImmediate8">
		<xsl:element name="hex">62</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithBXAddressPlusImmediate8">
		<xsl:element name="hex">63</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithIndexAddressPlusImmediate8">
		<xsl:element name="hex">64</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithBPAddressPlusImmediate8">
		<xsl:element name="hex">65</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithSIAddressPlusImmediate8">
		<xsl:element name="hex">66</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithDIAddressPlusImmediate8">
		<xsl:element name="hex">67</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromAXAddressPlusImmediate8">
		<xsl:element name="hex">68</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromCXAddressPlusImmediate8">
		<xsl:element name="hex">69</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromDXAddressPlusImmediate8">
		<xsl:element name="hex">6A</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBXAddressPlusImmediate8">
		<xsl:element name="hex">6B</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromIndexAddressPlusImmediate8">
		<xsl:element name="hex">6C</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBPAddressPlusImmediate8">
		<xsl:element name="hex">6D</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromSIAddressPlusImmediate8">
		<xsl:element name="hex">6E</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromDIAddressPlusImmediate8">
		<xsl:element name="hex">6F</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithAXAddressPlusImmediate8">
		<xsl:element name="hex">70</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithCXAddressPlusImmediate8">
		<xsl:element name="hex">71</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithDXAddressPlusImmediate8">
		<xsl:element name="hex">72</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithBXAddressPlusImmediate8">
		<xsl:element name="hex">73</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithIndexAddressPlusImmediate8">
		<xsl:element name="hex">74</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithBPAddressPlusImmediate8">
		<xsl:element name="hex">75</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithSIAddressPlusImmediate8">
		<xsl:element name="hex">76</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithDIAddressPlusImmediate8">
		<xsl:element name="hex">77</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithAXAddressPlusImmediate8">
		<xsl:element name="hex">78</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithCXAddressPlusImmediate8">
		<xsl:element name="hex">79</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithDXAddressPlusImmediate8">
		<xsl:element name="hex">7A</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithBXAddressPlusImmediate8">
		<xsl:element name="hex">7B</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithIndexAddressPlusImmediate8">
		<xsl:element name="hex">7C</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithBPAddressPlusImmediate8">
		<xsl:element name="hex">7D</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithSIAddressPlusImmediate8">
		<xsl:element name="hex">7E</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithDIAddressPlusImmediate8">
		<xsl:element name="hex">7F</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToAXAddressPlusImmediate">
		<xsl:element name="hex">80</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToCXAddressPlusImmediate">
		<xsl:element name="hex">81</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToDXAddressPlusImmediate">
		<xsl:element name="hex">82</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBXAddressPlusImmediate">
		<xsl:element name="hex">83</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToIndexAddressPlusImmediate">
		<xsl:element name="hex">84</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBPAddressPlusImmediate">
		<xsl:element name="hex">85</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToSIAddressPlusImmediate">
		<xsl:element name="hex">86</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToDIAddressPlusImmediate">
		<xsl:element name="hex">87</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithAXAddressPlusImmediate">
		<xsl:element name="hex">88</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithCXAddressPlusImmediate">
		<xsl:element name="hex">89</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithDXAddressPlusImmediate">
		<xsl:element name="hex">8A</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithBXAddressPlusImmediate">
		<xsl:element name="hex">8B</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithIndexAddressPlusImmediate">
		<xsl:element name="hex">8C</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithBPAddressPlusImmediate">
		<xsl:element name="hex">8D</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithSIAddressPlusImmediate">
		<xsl:element name="hex">8E</xsl:element>
	</xsl:template>
	<xsl:template match="math:OrWithDIAddressPlusImmediate">
		<xsl:element name="hex">8F</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToAXAddressPlusImmediateWithCarry">
		<xsl:element name="hex">90</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToCXAddressPlusImmediateWithCarry">
		<xsl:element name="hex">91</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToDXAddressPlusImmediateWithCarry">
		<xsl:element name="hex">92</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBXAddressPlusImmediateWithCarry">
		<xsl:element name="hex">93</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToIndexAddressPlusImmediateWithCarry">
		<xsl:element name="hex">94</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToBPAddressPlusImmediateWithCarry">
		<xsl:element name="hex">95</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToSIAddressPlusImmediateWithCarry">
		<xsl:element name="hex">96</xsl:element>
	</xsl:template>
	<xsl:template match="math:AddToDIAddressPlusImmediateWithCarry">
		<xsl:element name="hex">97</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromAXAddressPlusImmediateWithBorrow">
		<xsl:element name="hex">98</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromCXAddressPlusImmediateWithBorrow">
		<xsl:element name="hex">99</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromDXAddressPlusImmediateWithBorrow">
		<xsl:element name="hex">9A</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBXAddressPlusImmediateWithBorrow">
		<xsl:element name="hex">9B</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromIndexAddressPlusImmediateWithBorrow">
		<xsl:element name="hex">9C</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBPAddressPlusImmediateWithBorrow">
		<xsl:element name="hex">9D</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromSIAddressPlusImmediateWithBorrow">
		<xsl:element name="hex">9E</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromDIAddressPlusImmediateWithBorrow">
		<xsl:element name="hex">9F</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithAXAddressPlusImmediate">
		<xsl:element name="hex">A0</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithCXAddressPlusImmediate">
		<xsl:element name="hex">A1</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithDXAddressPlusImmediate">
		<xsl:element name="hex">A2</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithBXAddressPlusImmediate">
		<xsl:element name="hex">A3</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithIndexAddressPlusImmediate">
		<xsl:element name="hex">A4</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithBPAddressPlusImmediate">
		<xsl:element name="hex">A5</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithSIAddressPlusImmediate">
		<xsl:element name="hex">A6</xsl:element>
	</xsl:template>
	<xsl:template match="math:AndWithDIAddressPlusImmediate">
		<xsl:element name="hex">A7</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromAXAddressPlusImmediate">
		<xsl:element name="hex">A8</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromCXAddressPlusImmediate">
		<xsl:element name="hex">A9</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromDXAddressPlusImmediate">
		<xsl:element name="hex">AA</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBXAddressPlusImmediate">
		<xsl:element name="hex">AB</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromIndexAddressPlusImmediate">
		<xsl:element name="hex">AC</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromBPAddressPlusImmediate">
		<xsl:element name="hex">AD</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromSIAddressPlusImmediate">
		<xsl:element name="hex">AE</xsl:element>
	</xsl:template>
	<xsl:template match="math:SubtractFromDIAddressPlusImmediate">
		<xsl:element name="hex">AF</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithAXAddressPlusImmediate">
		<xsl:element name="hex">B0</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithCXAddressPlusImmediate">
		<xsl:element name="hex">B1</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithDXAddressPlusImmediate">
		<xsl:element name="hex">B2</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithBXAddressPlusImmediate">
		<xsl:element name="hex">B3</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithIndexAddressPlusImmediate">
		<xsl:element name="hex">B4</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithBPAddressPlusImmediate">
		<xsl:element name="hex">B5</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithSIAddressPlusImmediate">
		<xsl:element name="hex">B6</xsl:element>
	</xsl:template>
	<xsl:template match="math:ExclusiveOrWithDIAddressPlusImmediate">
		<xsl:element name="hex">B7</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithAXAddressPlusImmediate">
		<xsl:element name="hex">B8</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithCXAddressPlusImmediate">
		<xsl:element name="hex">B9</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithDXAddressPlusImmediate">
		<xsl:element name="hex">BA</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithBXAddressPlusImmediate">
		<xsl:element name="hex">BB</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithIndexAddressPlusImmediate">
		<xsl:element name="hex">BC</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithBPAddressPlusImmediate">
		<xsl:element name="hex">BD</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithSIAddressPlusImmediate">
		<xsl:element name="hex">BE</xsl:element>
	</xsl:template>
	<xsl:template match="math:CompareWithDIAddressPlusImmediate">
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