<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns="http://metalx.org/Program" xmlns:ari="http://metalx.org/Intel/80286/Arithmetic" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" indent="yes" />
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="ari:TestWithBXSIAddress">
    <xsl:element name="hex">00</xsl:element>
  </xsl:template>
  <xsl:template match="ari:TestWithBXDIAddress">
    <xsl:element name="hex">01</xsl:element>
  </xsl:template>
  <xsl:template match="ari:TestWithBPSIAddress">
    <xsl:element name="hex">02</xsl:element>
  </xsl:template>
  <xsl:template match="ari:TestWithBPDIAddress">
    <xsl:element name="hex">03</xsl:element>
  </xsl:template>
  <xsl:template match="ari:TestWithSIAddress">
    <xsl:element name="hex">04</xsl:element>
  </xsl:template>
  <xsl:template match="ari:TestWithDIAddress">
    <xsl:element name="hex">05</xsl:element>
  </xsl:template>
  <xsl:template match="ari:TestWithImmediate16Address">
    <xsl:element name="hex">06</xsl:element>
  </xsl:template>
  <xsl:template match="ari:TestWithBXAddress">
    <xsl:element name="hex">07</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NotWithBXSIAddress">
    <xsl:element name="hex">10</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NotWithBXDIAddress">
    <xsl:element name="hex">11</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NotWithBPSIAddress">
    <xsl:element name="hex">12</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NotWithBPDIAddress">
    <xsl:element name="hex">13</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NotWithSIAddress">
    <xsl:element name="hex">14</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NotWithDIAddress">
    <xsl:element name="hex">15</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NotWithImmediate16Address">
    <xsl:element name="hex">16</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NotWithBXAddress">
    <xsl:element name="hex">17</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NegateWithBXSIAddress">
    <xsl:element name="hex">18</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NegateWithBXDIAddress">
    <xsl:element name="hex">19</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NegateWithBPSIAddress">
    <xsl:element name="hex">1A</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NegateWithBPDIAddress">
    <xsl:element name="hex">1B</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NegateWithSIAddress">
    <xsl:element name="hex">1C</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NegateWithDIAddress">
    <xsl:element name="hex">1D</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NegateWithImmediate16Address">
    <xsl:element name="hex">1E</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NegateWithBXAddress">
    <xsl:element name="hex">1F</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByBXSIAddress">
    <xsl:element name="hex">20</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByBXDIAddress">
    <xsl:element name="hex">21</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByBPSIAddress">
    <xsl:element name="hex">22</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByBPDIAddress">
    <xsl:element name="hex">23</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyBySIAddress">
    <xsl:element name="hex">24</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByDIAddress">
    <xsl:element name="hex">25</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByImmediate16Address">
    <xsl:element name="hex">26</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByBXAddress">
    <xsl:element name="hex">27</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByBXSIAddressWithSign">
    <xsl:element name="hex">28</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByBXDIAddressWithSign">
    <xsl:element name="hex">29</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByBPSIAddressWithSign">
    <xsl:element name="hex">2A</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByBPDIAddressWithSign">
    <xsl:element name="hex">2B</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyBySIAddressWithSign">
    <xsl:element name="hex">2C</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByDIAddressWithSign">
    <xsl:element name="hex">2D</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByImmediate16AddressWithSign">
    <xsl:element name="hex">2E</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByBXAddressWithSign">
    <xsl:element name="hex">2F</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByBXSIAddress">
    <xsl:element name="hex">30</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByBXDIAddress">
    <xsl:element name="hex">31</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByBPSIAddress">
    <xsl:element name="hex">32</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByBPDIAddress">
    <xsl:element name="hex">33</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideBySIAddress">
    <xsl:element name="hex">34</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByDIAddress">
    <xsl:element name="hex">35</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByImmediate16Address">
    <xsl:element name="hex">36</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByBXAddress">
    <xsl:element name="hex">37</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByBXSIAddressWithSign">
    <xsl:element name="hex">38</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByBXDIAddressWithSign">
    <xsl:element name="hex">39</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByBPSIAddressWithSign">
    <xsl:element name="hex">3A</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByBPDIAddressWithSign">
    <xsl:element name="hex">3B</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideBySIAddressWithSign">
    <xsl:element name="hex">3C</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByDIAddressWithSign">
    <xsl:element name="hex">3D</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByImmediate16AddressWithSign">
    <xsl:element name="hex">3E</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByBXAddressWithSign">
    <xsl:element name="hex">3F</xsl:element>
  </xsl:template>
  <xsl:template match="ari:TestWithBXSIAddressPlusImmediate8">
    <xsl:element name="hex">40</xsl:element>
  </xsl:template>
  <xsl:template match="ari:TestWithBXDIAddressPlusImmediate8">
    <xsl:element name="hex">41</xsl:element>
  </xsl:template>
  <xsl:template match="ari:TestWithBPSIAddressPlusImmediate8">
    <xsl:element name="hex">42</xsl:element>
  </xsl:template>
  <xsl:template match="ari:TestWithBPDIAddressPlusImmediate8">
    <xsl:element name="hex">43</xsl:element>
  </xsl:template>
  <xsl:template match="ari:TestWithSIAddressPlusImmediate8">
    <xsl:element name="hex">44</xsl:element>
  </xsl:template>
  <xsl:template match="ari:TestWithDIAddressPlusImmediate8">
    <xsl:element name="hex">45</xsl:element>
  </xsl:template>
  <xsl:template match="ari:TestWithBPAddressPlusImmediate8">
    <xsl:element name="hex">46</xsl:element>
  </xsl:template>
  <xsl:template match="ari:TestWithBXAddressPlusImmediate8">
    <xsl:element name="hex">47</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NotWithBXSIAddressPlusImmediate8">
    <xsl:element name="hex">50</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NotWithBXDIAddressPlusImmediate8">
    <xsl:element name="hex">51</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NotWithBPSIAddressPlusImmediate8">
    <xsl:element name="hex">52</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NotWithBPDIAddressPlusImmediate8">
    <xsl:element name="hex">53</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NotWithSIAddressPlusImmediate8">
    <xsl:element name="hex">54</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NotWithDIAddressPlusImmediate8">
    <xsl:element name="hex">55</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NotWithBPAddressPlusImmediate8">
    <xsl:element name="hex">56</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NotWithBXAddressPlusImmediate8">
    <xsl:element name="hex">57</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NegateWithBXSIAddressPlusImmediate8">
    <xsl:element name="hex">58</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NegateWithBXDIAddressPlusImmediate8">
    <xsl:element name="hex">59</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NegateWithBPSIAddressPlusImmediate8">
    <xsl:element name="hex">5A</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NegateWithBPDIAddressPlusImmediate8">
    <xsl:element name="hex">5B</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NegateWithSIAddressPlusImmediate8">
    <xsl:element name="hex">5C</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NegateWithDIAddressPlusImmediate8">
    <xsl:element name="hex">5D</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NegateWithBPAddressPlusImmediate8">
    <xsl:element name="hex">5E</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NegateWithBXAddressPlusImmediate8">
    <xsl:element name="hex">5F</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByBXSIAddressPlusImmediate8">
    <xsl:element name="hex">60</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByBXDIAddressPlusImmediate8">
    <xsl:element name="hex">61</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByBPSIAddressPlusImmediate8">
    <xsl:element name="hex">62</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByBPDIAddressPlusImmediate8">
    <xsl:element name="hex">63</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyBySIAddressPlusImmediate8">
    <xsl:element name="hex">64</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByDIAddressPlusImmediate8">
    <xsl:element name="hex">65</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByBPAddressPlusImmediate8">
    <xsl:element name="hex">66</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByBXAddressPlusImmediate8">
    <xsl:element name="hex">67</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByBXSIAddressPlusImmediate8WithSign">
    <xsl:element name="hex">68</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByBXDIAddressPlusImmediate8WithSign">
    <xsl:element name="hex">69</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByBPSIAddressPlusImmediate8WithSign">
    <xsl:element name="hex">6A</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByBPDIAddressPlusImmediate8WithSign">
    <xsl:element name="hex">6B</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyBySIAddressPlusImmediate8WithSign">
    <xsl:element name="hex">6C</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByDIAddressPlusImmediate8WithSign">
    <xsl:element name="hex">6D</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByBPAddressPlusImmediate8WithSign">
    <xsl:element name="hex">6E</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByBXAddressPlusImmediate8WithSign">
    <xsl:element name="hex">6F</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByBXSIAddressPlusImmediate8">
    <xsl:element name="hex">70</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByBXDIAddressPlusImmediate8">
    <xsl:element name="hex">71</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByBPSIAddressPlusImmediate8">
    <xsl:element name="hex">72</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByBPDIAddressPlusImmediate8">
    <xsl:element name="hex">73</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideBySIAddressPlusImmediate8">
    <xsl:element name="hex">74</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByDIAddressPlusImmediate8">
    <xsl:element name="hex">75</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByBPAddressPlusImmediate8">
    <xsl:element name="hex">76</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByBXAddressPlusImmediate8">
    <xsl:element name="hex">77</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByBXSIAddressPlusImmediate8WithSign">
    <xsl:element name="hex">78</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByBXDIAddressPlusImmediate8WithSign">
    <xsl:element name="hex">79</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByBPSIAddressPlusImmediate8WithSign">
    <xsl:element name="hex">7A</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByBPDIAddressPlusImmediate8WithSign">
    <xsl:element name="hex">7B</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideBySIAddressPlusImmediate8WithSign">
    <xsl:element name="hex">7C</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByDIAddressPlusImmediate8WithSign">
    <xsl:element name="hex">7D</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByBPAddressPlusImmediate8WithSign">
    <xsl:element name="hex">7E</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByBXAddressPlusImmediate8WithSign">
    <xsl:element name="hex">7F</xsl:element>
  </xsl:template>
  <xsl:template match="ari:TestWithBXSIAddressPlusImmediate16">
    <xsl:element name="hex">80</xsl:element>
  </xsl:template>
  <xsl:template match="ari:TestWithBXDIAddressPlusImmediate16">
    <xsl:element name="hex">81</xsl:element>
  </xsl:template>
  <xsl:template match="ari:TestWithBPSIAddressPlusImmediate16">
    <xsl:element name="hex">82</xsl:element>
  </xsl:template>
  <xsl:template match="ari:TestWithBPDIAddressPlusImmediate16">
    <xsl:element name="hex">83</xsl:element>
  </xsl:template>
  <xsl:template match="ari:TestWithSIAddressPlusImmediate16">
    <xsl:element name="hex">84</xsl:element>
  </xsl:template>
  <xsl:template match="ari:TestWithDIAddressPlusImmediate16">
    <xsl:element name="hex">85</xsl:element>
  </xsl:template>
  <xsl:template match="ari:TestWithBPAddressPlusImmediate16">
    <xsl:element name="hex">86</xsl:element>
  </xsl:template>
  <xsl:template match="ari:TestWithBXAddressPlusImmediate16">
    <xsl:element name="hex">87</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NotWithBXSIAddressPlusImmediate16">
    <xsl:element name="hex">90</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NotWithBXDIAddressPlusImmediate16">
    <xsl:element name="hex">91</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NotWithBPSIAddressPlusImmediate16">
    <xsl:element name="hex">92</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NotWithBPDIAddressPlusImmediate16">
    <xsl:element name="hex">93</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NotWithSIAddressPlusImmediate16">
    <xsl:element name="hex">94</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NotWithDIAddressPlusImmediate16">
    <xsl:element name="hex">95</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NotWithBPAddressPlusImmediate16">
    <xsl:element name="hex">96</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NotWithBXAddressPlusImmediate16">
    <xsl:element name="hex">97</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NegateWithBXSIAddressPlusImmediate16">
    <xsl:element name="hex">98</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NegateWithBXDIAddressPlusImmediate16">
    <xsl:element name="hex">99</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NegateWithBPSIAddressPlusImmediate16">
    <xsl:element name="hex">9A</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NegateWithBPDIAddressPlusImmediate16">
    <xsl:element name="hex">9B</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NegateWithSIAddressPlusImmediate16">
    <xsl:element name="hex">9C</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NegateWithDIAddressPlusImmediate16">
    <xsl:element name="hex">9D</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NegateWithBPAddressPlusImmediate16">
    <xsl:element name="hex">9E</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NegateWithBXAddressPlusImmediate16">
    <xsl:element name="hex">9F</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByBXSIAddressPlusImmediate16">
    <xsl:element name="hex">A0</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByBXDIAddressPlusImmediate16">
    <xsl:element name="hex">A1</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByBPSIAddressPlusImmediate16">
    <xsl:element name="hex">A2</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByBPDIAddressPlusImmediate16">
    <xsl:element name="hex">A3</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyBySIAddressPlusImmediate16">
    <xsl:element name="hex">A4</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByDIAddressPlusImmediate16">
    <xsl:element name="hex">A5</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByBPAddressPlusImmediate16">
    <xsl:element name="hex">A6</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByBXAddressPlusImmediate16">
    <xsl:element name="hex">A7</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByBXSIAddressPlusImmediate16WithSign">
    <xsl:element name="hex">A8</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByBXDIAddressPlusImmediate16WithSign">
    <xsl:element name="hex">A9</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByBPSIAddressPlusImmediate16WithSign">
    <xsl:element name="hex">AA</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByBPDIAddressPlusImmediate16WithSign">
    <xsl:element name="hex">AB</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyBySIAddressPlusImmediate16WithSign">
    <xsl:element name="hex">AC</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByDIAddressPlusImmediate16WithSign">
    <xsl:element name="hex">AD</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByBPAddressPlusImmediate16WithSign">
    <xsl:element name="hex">AE</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByBXAddressPlusImmediate16WithSign">
    <xsl:element name="hex">AF</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByBXSIAddressPlusImmediate16">
    <xsl:element name="hex">B0</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByBXDIAddressPlusImmediate16">
    <xsl:element name="hex">B1</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByBPSIAddressPlusImmediate16">
    <xsl:element name="hex">B2</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByBPDIAddressPlusImmediate16">
    <xsl:element name="hex">B3</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideBySIAddressPlusImmediate16">
    <xsl:element name="hex">B4</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByDIAddressPlusImmediate16">
    <xsl:element name="hex">B5</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByBPAddressPlusImmediate16">
    <xsl:element name="hex">B6</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByBXAddressPlusImmediate16">
    <xsl:element name="hex">B7</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByBXSIAddressPlusImmediate16WithSign">
    <xsl:element name="hex">B8</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByBXDIAddressPlusImmediate16WithSign">
    <xsl:element name="hex">B9</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByBPSIAddressPlusImmediate16WithSign">
    <xsl:element name="hex">BA</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByBPDIAddressPlusImmediate16WithSign">
    <xsl:element name="hex">BB</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideBySIAddressPlusImmediate16WithSign">
    <xsl:element name="hex">BC</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByDIAddressPlusImmediate16WithSign">
    <xsl:element name="hex">BD</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByBPAddressPlusImmediate16WithSign">
    <xsl:element name="hex">BE</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByBXAddressPlusImmediate16WithSign">
    <xsl:element name="hex">BF</xsl:element>
  </xsl:template>
  <xsl:template match="ari:TestWithALRegister">
    <xsl:element name="hex">C0</xsl:element>
  </xsl:template>
  <xsl:template match="ari:TestWithCLRegister">
    <xsl:element name="hex">C1</xsl:element>
  </xsl:template>
  <xsl:template match="ari:TestWithDLRegister">
    <xsl:element name="hex">C2</xsl:element>
  </xsl:template>
  <xsl:template match="ari:TestWithBLRegister">
    <xsl:element name="hex">C3</xsl:element>
  </xsl:template>
  <xsl:template match="ari:TestWithAHRegister">
    <xsl:element name="hex">C4</xsl:element>
  </xsl:template>
  <xsl:template match="ari:TestWithCHRegister">
    <xsl:element name="hex">C5</xsl:element>
  </xsl:template>
  <xsl:template match="ari:TestWithDHRegister">
    <xsl:element name="hex">C6</xsl:element>
  </xsl:template>
  <xsl:template match="ari:TestWithBHRegister">
    <xsl:element name="hex">C7</xsl:element>
  </xsl:template>
  <xsl:template match="ari:TestWithAXRegister">
    <xsl:element name="hex">C0</xsl:element>
  </xsl:template>
  <xsl:template match="ari:TestWithCXRegister">
    <xsl:element name="hex">C1</xsl:element>
  </xsl:template>
  <xsl:template match="ari:TestWithDXRegister">
    <xsl:element name="hex">C2</xsl:element>
  </xsl:template>
  <xsl:template match="ari:TestWithBXRegister">
    <xsl:element name="hex">C3</xsl:element>
  </xsl:template>
  <xsl:template match="ari:TestWithSPRegister">
    <xsl:element name="hex">C4</xsl:element>
  </xsl:template>
  <xsl:template match="ari:TestWithBPRegister">
    <xsl:element name="hex">C5</xsl:element>
  </xsl:template>
  <xsl:template match="ari:TestWithSIRegister">
    <xsl:element name="hex">C6</xsl:element>
  </xsl:template>
  <xsl:template match="ari:TestWithDIRegister">
    <xsl:element name="hex">C7</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NotWithALRegister">
    <xsl:element name="hex">D0</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NotWithCLRegister">
    <xsl:element name="hex">D1</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NotWithDLRegister">
    <xsl:element name="hex">D2</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NotWithBLRegister">
    <xsl:element name="hex">D3</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NotWithAHRegister">
    <xsl:element name="hex">D4</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NotWithCHRegister">
    <xsl:element name="hex">D5</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NotWithDHRegister">
    <xsl:element name="hex">D6</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NotWithBHRegister">
    <xsl:element name="hex">D7</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NotWithAXRegister">
    <xsl:element name="hex">D0</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NotWithCXRegister">
    <xsl:element name="hex">D1</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NotWithDXRegister">
    <xsl:element name="hex">D2</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NotWithBXRegister">
    <xsl:element name="hex">D3</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NotWithSPRegister">
    <xsl:element name="hex">D4</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NotWithBPRegister">
    <xsl:element name="hex">D5</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NotWithSIRegister">
    <xsl:element name="hex">D6</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NotWithDIRegister">
    <xsl:element name="hex">D7</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NegateWithALRegister">
    <xsl:element name="hex">D8</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NegateWithCLRegister">
    <xsl:element name="hex">D9</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NegateWithDLRegister">
    <xsl:element name="hex">DA</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NegateWithBLRegister">
    <xsl:element name="hex">DB</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NegateWithAHRegister">
    <xsl:element name="hex">DC</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NegateWithCHRegister">
    <xsl:element name="hex">DD</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NegateWithDHRegister">
    <xsl:element name="hex">DE</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NegateWithBHRegister">
    <xsl:element name="hex">DF</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NegateWithAXRegister">
    <xsl:element name="hex">D8</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NegateWithCXRegister">
    <xsl:element name="hex">D9</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NegateWithDXRegister">
    <xsl:element name="hex">DA</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NegateWithBXRegister">
    <xsl:element name="hex">DB</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NegateWithSPRegister">
    <xsl:element name="hex">DC</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NegateWithBPRegister">
    <xsl:element name="hex">DD</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NegateWithSIRegister">
    <xsl:element name="hex">DE</xsl:element>
  </xsl:template>
  <xsl:template match="ari:NegateWithDIRegister">
    <xsl:element name="hex">DF</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByALRegister">
    <xsl:element name="hex">E0</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByCLRegister">
    <xsl:element name="hex">E1</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByDLRegister">
    <xsl:element name="hex">E2</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByBLRegister">
    <xsl:element name="hex">E3</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByAHRegister">
    <xsl:element name="hex">E4</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByCHRegister">
    <xsl:element name="hex">E5</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByDHRegister">
    <xsl:element name="hex">E6</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByBHRegister">
    <xsl:element name="hex">E7</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByAXRegister">
    <xsl:element name="hex">E0</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByCXRegister">
    <xsl:element name="hex">E1</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByDXRegister">
    <xsl:element name="hex">E2</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByBXRegister">
    <xsl:element name="hex">E3</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyBySPRegister">
    <xsl:element name="hex">E4</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByBPRegister">
    <xsl:element name="hex">E5</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyBySIRegister">
    <xsl:element name="hex">E6</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByDIRegister">
    <xsl:element name="hex">E7</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByALRegisterWithSign">
    <xsl:element name="hex">E8</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByCLRegisterWithSign">
    <xsl:element name="hex">E9</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByDLRegisterWithSign">
    <xsl:element name="hex">EA</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByBLRegisterWithSign">
    <xsl:element name="hex">EB</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByAHRegisterWithSign">
    <xsl:element name="hex">EC</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByCHRegisterWithSign">
    <xsl:element name="hex">ED</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByDHRegisterWithSign">
    <xsl:element name="hex">EE</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByBHRegisterWithSign">
    <xsl:element name="hex">EF</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByAXRegisterWithSign">
    <xsl:element name="hex">E8</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByCXRegisterWithSign">
    <xsl:element name="hex">E9</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByDXRegisterWithSign">
    <xsl:element name="hex">EA</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByBXRegisterWithSign">
    <xsl:element name="hex">EB</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyBySPRegisterWithSign">
    <xsl:element name="hex">EC</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByBPRegisterWithSign">
    <xsl:element name="hex">ED</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyBySIRegisterWithSign">
    <xsl:element name="hex">EE</xsl:element>
  </xsl:template>
  <xsl:template match="ari:MultiplyByDIRegisterWithSign">
    <xsl:element name="hex">EF</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByALRegister">
    <xsl:element name="hex">F0</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByCLRegister">
    <xsl:element name="hex">F1</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByDLRegister">
    <xsl:element name="hex">F2</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByBLRegister">
    <xsl:element name="hex">F3</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByAHRegister">
    <xsl:element name="hex">F4</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByCHRegister">
    <xsl:element name="hex">F5</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByDHRegister">
    <xsl:element name="hex">F6</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByBHRegister">
    <xsl:element name="hex">F7</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByAXRegister">
    <xsl:element name="hex">F0</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByCXRegister">
    <xsl:element name="hex">F1</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByDXRegister">
    <xsl:element name="hex">F2</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByBXRegister">
    <xsl:element name="hex">F3</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideBySPRegister">
    <xsl:element name="hex">F4</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByBPRegister">
    <xsl:element name="hex">F5</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideBySIRegister">
    <xsl:element name="hex">F6</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByDIRegister">
    <xsl:element name="hex">F7</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByALRegisterWithSign">
    <xsl:element name="hex">F8</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByCLRegisterWithSign">
    <xsl:element name="hex">F9</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByDLRegisterWithSign">
    <xsl:element name="hex">FA</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByBLRegisterWithSign">
    <xsl:element name="hex">FB</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByAHRegisterWithSign">
    <xsl:element name="hex">FC</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByCHRegisterWithSign">
    <xsl:element name="hex">FD</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByDHRegisterWithSign">
    <xsl:element name="hex">FE</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByBHRegisterWithSign">
    <xsl:element name="hex">FF</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByAXRegisterWithSign">
    <xsl:element name="hex">F8</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByCXRegisterWithSign">
    <xsl:element name="hex">F9</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByDXRegisterWithSign">
    <xsl:element name="hex">FA</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByBXRegisterWithSign">
    <xsl:element name="hex">FB</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideBySPRegisterWithSign">
    <xsl:element name="hex">FC</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByBPRegisterWithSign">
    <xsl:element name="hex">FD</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideBySIRegisterWithSign">
    <xsl:element name="hex">FE</xsl:element>
  </xsl:template>
  <xsl:template match="ari:DivideByDIRegisterWithSign">
    <xsl:element name="hex">FF</xsl:element>
  </xsl:template>
</xsl:stylesheet>