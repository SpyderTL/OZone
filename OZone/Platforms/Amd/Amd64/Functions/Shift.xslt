<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns="http://metalx.org/Program" xmlns:shift="http://metalx.org/Amd/Amd64/Shift" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" indent="yes" />
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="shift:RotateLeftAXAddress">
    <xsl:element name="hex">00</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftCXAddress">
    <xsl:element name="hex">01</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftDXAddress">
    <xsl:element name="hex">02</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftBXAddress">
    <xsl:element name="hex">03</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftIndexAddress">
    <xsl:element name="hex">04</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftImmediateAddress">
    <xsl:element name="hex">05</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftSIAddress">
    <xsl:element name="hex">06</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftDIAddress">
    <xsl:element name="hex">07</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightAXAddress">
    <xsl:element name="hex">08</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightCXAddress">
    <xsl:element name="hex">09</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightDXAddress">
    <xsl:element name="hex">0A</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightBXAddress">
    <xsl:element name="hex">0B</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightIndexAddress">
    <xsl:element name="hex">0C</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightImmediateAddress">
    <xsl:element name="hex">0D</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightSIAddress">
    <xsl:element name="hex">0E</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightDIAddress">
    <xsl:element name="hex">0F</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftAXAddressWithCarry">
    <xsl:element name="hex">10</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftCXAddressWithCarry">
    <xsl:element name="hex">11</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftDXAddressWithCarry">
    <xsl:element name="hex">12</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftBXAddressWithCarry">
    <xsl:element name="hex">13</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftIndexAddressWithCarry">
    <xsl:element name="hex">14</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftImmediateAddressWithCarry">
    <xsl:element name="hex">15</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftSIAddressWithCarry">
    <xsl:element name="hex">16</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftDIAddressWithCarry">
    <xsl:element name="hex">17</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightAXAddressWithCarry">
    <xsl:element name="hex">18</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightCXAddressWithCarry">
    <xsl:element name="hex">19</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightDXAddressWithCarry">
    <xsl:element name="hex">1A</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightBXAddressWithCarry">
    <xsl:element name="hex">1B</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightIndexAddressWithCarry">
    <xsl:element name="hex">1C</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightImmediateAddressWithCarry">
    <xsl:element name="hex">1D</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightSIAddressWithCarry">
    <xsl:element name="hex">1E</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightDIAddressWithCarry">
    <xsl:element name="hex">1F</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftLeftAXAddress">
    <xsl:element name="hex">20</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftLeftCXAddress">
    <xsl:element name="hex">21</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftLeftDXAddress">
    <xsl:element name="hex">22</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftLeftBXAddress">
    <xsl:element name="hex">23</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftLeftIndexAddress">
    <xsl:element name="hex">24</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftLeftImmediateAddress">
    <xsl:element name="hex">25</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftLeftSIAddress">
    <xsl:element name="hex">26</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftLeftDIAddress">
    <xsl:element name="hex">27</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightAXAddress">
    <xsl:element name="hex">28</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightCXAddress">
    <xsl:element name="hex">29</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightDXAddress">
    <xsl:element name="hex">2A</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightBXAddress">
    <xsl:element name="hex">2B</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightIndexAddress">
    <xsl:element name="hex">2C</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightImmediateAddress">
    <xsl:element name="hex">2D</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightSIAddress">
    <xsl:element name="hex">2E</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightDIAddress">
    <xsl:element name="hex">2F</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightAXAddressSigned">
    <xsl:element name="hex">38</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightCXAddressSigned">
    <xsl:element name="hex">39</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightDXAddressSigned">
    <xsl:element name="hex">3A</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightBXAddressSigned">
    <xsl:element name="hex">3B</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightIndexAddressSigned">
    <xsl:element name="hex">3C</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightImmediateAddressSigned">
    <xsl:element name="hex">3D</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightSIAddressSigned">
    <xsl:element name="hex">3E</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightDIAddressSigned">
    <xsl:element name="hex">3F</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftAXAddressPlusImmediate8">
    <xsl:element name="hex">40</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftCXAddressPlusImmediate8">
    <xsl:element name="hex">41</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftDXAddressPlusImmediate8">
    <xsl:element name="hex">42</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftBXAddressPlusImmediate8">
    <xsl:element name="hex">43</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftIndexAddressPlusImmediate8">
    <xsl:element name="hex">44</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftBPAddressPlusImmediate8">
    <xsl:element name="hex">45</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftSIAddressPlusImmediate8">
    <xsl:element name="hex">46</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftDIAddressPlusImmediate8">
    <xsl:element name="hex">47</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightAXAddressPlusImmediate8">
    <xsl:element name="hex">48</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightCXAddressPlusImmediate8">
    <xsl:element name="hex">49</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightDXAddressPlusImmediate8">
    <xsl:element name="hex">4A</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightBXAddressPlusImmediate8">
    <xsl:element name="hex">4B</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightIndexAddressPlusImmediate8">
    <xsl:element name="hex">4C</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightBPAddressPlusImmediate8">
    <xsl:element name="hex">4D</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightSIAddressPlusImmediate8">
    <xsl:element name="hex">4E</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightDIAddressPlusImmediate8">
    <xsl:element name="hex">4F</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftAXAddressPlusImmediate8WithCarry">
    <xsl:element name="hex">50</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftCXAddressPlusImmediate8WithCarry">
    <xsl:element name="hex">51</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftDXAddressPlusImmediate8WithCarry">
    <xsl:element name="hex">52</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftBXAddressPlusImmediate8WithCarry">
    <xsl:element name="hex">53</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftIndexAddressPlusImmediate8WithCarry">
    <xsl:element name="hex">54</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftBPAddressPlusImmediate8WithCarry">
    <xsl:element name="hex">55</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftSIAddressPlusImmediate8WithCarry">
    <xsl:element name="hex">56</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftDIAddressPlusImmediate8WithCarry">
    <xsl:element name="hex">57</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightAXAddressPlusImmediate8WithCarry">
    <xsl:element name="hex">58</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightCXAddressPlusImmediate8WithCarry">
    <xsl:element name="hex">59</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightDXAddressPlusImmediate8WithCarry">
    <xsl:element name="hex">5A</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightBXAddressPlusImmediate8WithCarry">
    <xsl:element name="hex">5B</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightIndexAddressPlusImmediate8WithCarry">
    <xsl:element name="hex">5C</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightBPAddressPlusImmediate8WithCarry">
    <xsl:element name="hex">5D</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightSIAddressPlusImmediate8WithCarry">
    <xsl:element name="hex">5E</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightDIAddressPlusImmediate8WithCarry">
    <xsl:element name="hex">5F</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftLeftAXAddressPlusImmediate8">
    <xsl:element name="hex">60</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftLeftCXAddressPlusImmediate8">
    <xsl:element name="hex">61</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftLeftDXAddressPlusImmediate8">
    <xsl:element name="hex">62</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftLeftBXAddressPlusImmediate8">
    <xsl:element name="hex">63</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftLeftIndexAddressPlusImmediate8">
    <xsl:element name="hex">64</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftLeftBPAddressPlusImmediate8">
    <xsl:element name="hex">65</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftLeftSIAddressPlusImmediate8">
    <xsl:element name="hex">66</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftLeftDIAddressPlusImmediate8">
    <xsl:element name="hex">67</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightAXAddressPlusImmediate8">
    <xsl:element name="hex">68</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightCXAddressPlusImmediate8">
    <xsl:element name="hex">69</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightDXAddressPlusImmediate8">
    <xsl:element name="hex">6A</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightBXAddressPlusImmediate8">
    <xsl:element name="hex">6B</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightIndexAddressPlusImmediate8">
    <xsl:element name="hex">6C</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightBPAddressPlusImmediate8">
    <xsl:element name="hex">6D</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightSIAddressPlusImmediate8">
    <xsl:element name="hex">6E</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightDIAddressPlusImmediate8">
    <xsl:element name="hex">6F</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightAXAddressPlusImmediate8Signed">
    <xsl:element name="hex">78</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightCXAddressPlusImmediate8Signed">
    <xsl:element name="hex">79</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightDXAddressPlusImmediate8Signed">
    <xsl:element name="hex">7A</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightBXAddressPlusImmediate8Signed">
    <xsl:element name="hex">7B</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightIndexAddressPlusImmediate8Signed">
    <xsl:element name="hex">7C</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightBPAddressPlusImmediate8Signed">
    <xsl:element name="hex">7D</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightSIAddressPlusImmediate8Signed">
    <xsl:element name="hex">7E</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightDIAddressPlusImmediate8Signed">
    <xsl:element name="hex">7F</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftAXAddressPlusImmediate">
    <xsl:element name="hex">80</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftCXAddressPlusImmediate">
    <xsl:element name="hex">81</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftDXAddressPlusImmediate">
    <xsl:element name="hex">82</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftBXAddressPlusImmediate">
    <xsl:element name="hex">83</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftIndexAddressPlusImmediate">
    <xsl:element name="hex">84</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftBPAddressPlusImmediate">
    <xsl:element name="hex">85</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftSIAddressPlusImmediate">
    <xsl:element name="hex">86</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftDIAddressPlusImmediate">
    <xsl:element name="hex">87</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightAXAddressPlusImmediate">
    <xsl:element name="hex">88</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightCXAddressPlusImmediate">
    <xsl:element name="hex">89</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightDXAddressPlusImmediate">
    <xsl:element name="hex">8A</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightBXAddressPlusImmediate">
    <xsl:element name="hex">8B</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightIndexAddressPlusImmediate">
    <xsl:element name="hex">8C</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightBPAddressPlusImmediate">
    <xsl:element name="hex">8D</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightSIAddressPlusImmediate">
    <xsl:element name="hex">8E</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightDIAddressPlusImmediate">
    <xsl:element name="hex">8F</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftAXAddressPlusImmediateWithCarry">
    <xsl:element name="hex">90</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftCXAddressPlusImmediateWithCarry">
    <xsl:element name="hex">91</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftDXAddressPlusImmediateWithCarry">
    <xsl:element name="hex">92</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftBXAddressPlusImmediateWithCarry">
    <xsl:element name="hex">93</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftIndexAddressPlusImmediateWithCarry">
    <xsl:element name="hex">94</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftBPAddressPlusImmediateWithCarry">
    <xsl:element name="hex">95</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftSIAddressPlusImmediateWithCarry">
    <xsl:element name="hex">96</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateLeftDIAddressPlusImmediateWithCarry">
    <xsl:element name="hex">97</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightAXAddressPlusImmediateWithCarry">
    <xsl:element name="hex">98</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightCXAddressPlusImmediateWithCarry">
    <xsl:element name="hex">99</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightDXAddressPlusImmediateWithCarry">
    <xsl:element name="hex">9A</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightBXAddressPlusImmediateWithCarry">
    <xsl:element name="hex">9B</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightIndexAddressPlusImmediateWithCarry">
    <xsl:element name="hex">9C</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightBPAddressPlusImmediateWithCarry">
    <xsl:element name="hex">9D</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightSIAddressPlusImmediateWithCarry">
    <xsl:element name="hex">9E</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RotateRightDIAddressPlusImmediateWithCarry">
    <xsl:element name="hex">9F</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftLeftAXAddressPlusImmediate">
    <xsl:element name="hex">A0</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftLeftCXAddressPlusImmediate">
    <xsl:element name="hex">A1</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftLeftDXAddressPlusImmediate">
    <xsl:element name="hex">A2</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftLeftBXAddressPlusImmediate">
    <xsl:element name="hex">A3</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftLeftIndexAddressPlusImmediate">
    <xsl:element name="hex">A4</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftLeftBPAddressPlusImmediate">
    <xsl:element name="hex">A5</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftLeftSIAddressPlusImmediate">
    <xsl:element name="hex">A6</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftLeftDIAddressPlusImmediate">
    <xsl:element name="hex">A7</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightAXAddressPlusImmediate">
    <xsl:element name="hex">A8</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightCXAddressPlusImmediate">
    <xsl:element name="hex">A9</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightDXAddressPlusImmediate">
    <xsl:element name="hex">AA</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightBXAddressPlusImmediate">
    <xsl:element name="hex">AB</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightIndexAddressPlusImmediate">
    <xsl:element name="hex">AC</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightBPAddressPlusImmediate">
    <xsl:element name="hex">AD</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightSIAddressPlusImmediate">
    <xsl:element name="hex">AE</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightDIAddressPlusImmediate">
    <xsl:element name="hex">AF</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightAXAddressPlusImmediateSigned">
    <xsl:element name="hex">B8</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightCXAddressPlusImmediateSigned">
    <xsl:element name="hex">B9</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightDXAddressPlusImmediateSigned">
    <xsl:element name="hex">BA</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightBXAddressPlusImmediateSigned">
    <xsl:element name="hex">BB</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightIndexAddressPlusImmediateSigned">
    <xsl:element name="hex">BC</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightBPAddressPlusImmediateSigned">
    <xsl:element name="hex">BD</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightSIAddressPlusImmediateSigned">
    <xsl:element name="hex">BE</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftRightDIAddressPlusImmediateSigned">
    <xsl:element name="hex">BF</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollALRegisterLeft">
    <xsl:element name="hex">C0</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollCLRegisterLeft">
    <xsl:element name="hex">C1</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollDLRegisterLeft">
    <xsl:element name="hex">C2</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollBLRegisterLeft">
    <xsl:element name="hex">C3</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollAHRegisterLeft">
    <xsl:element name="hex">C4</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollCHRegisterLeft">
    <xsl:element name="hex">C5</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollDHRegisterLeft">
    <xsl:element name="hex">C6</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollBHRegisterLeft">
    <xsl:element name="hex">C7</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollAXRegisterLeft">
    <xsl:element name="hex">C0</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollCXRegisterLeft">
    <xsl:element name="hex">C1</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollDXRegisterLeft">
    <xsl:element name="hex">C2</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollBXRegisterLeft">
    <xsl:element name="hex">C3</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollSPRegisterLeft">
    <xsl:element name="hex">C4</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollBPRegisterLeft">
    <xsl:element name="hex">C5</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollSIRegisterLeft">
    <xsl:element name="hex">C6</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollDIRegisterLeft">
    <xsl:element name="hex">C7</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollALRegisterRight">
    <xsl:element name="hex">C8</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollCLRegisterRight">
    <xsl:element name="hex">C9</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollDLRegisterRight">
    <xsl:element name="hex">CA</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollBLRegisterRight">
    <xsl:element name="hex">CB</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollAHRegisterRight">
    <xsl:element name="hex">CC</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollCHRegisterRight">
    <xsl:element name="hex">CD</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollDHRegisterRight">
    <xsl:element name="hex">CE</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollBHRegisterRight">
    <xsl:element name="hex">CF</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollAXRegisterRight">
    <xsl:element name="hex">C8</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollCXRegisterRight">
    <xsl:element name="hex">C9</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollDXRegisterRight">
    <xsl:element name="hex">CA</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollBXRegisterRight">
    <xsl:element name="hex">CB</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollSPRegisterRight">
    <xsl:element name="hex">CC</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollBPRegisterRight">
    <xsl:element name="hex">CD</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollSIRegisterRight">
    <xsl:element name="hex">CE</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollDIRegisterRight">
    <xsl:element name="hex">CF</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollALRegisterLeftWithCarry">
    <xsl:element name="hex">D0</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollCLRegisterLeftWithCarry">
    <xsl:element name="hex">D1</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollDLRegisterLeftWithCarry">
    <xsl:element name="hex">D2</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollBLRegisterLeftWithCarry">
    <xsl:element name="hex">D3</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollAHRegisterLeftWithCarry">
    <xsl:element name="hex">D4</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollCHRegisterLeftWithCarry">
    <xsl:element name="hex">D5</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollDHRegisterLeftWithCarry">
    <xsl:element name="hex">D6</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollBHRegisterLeftWithCarry">
    <xsl:element name="hex">D7</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollAXRegisterLeftWithCarry">
    <xsl:element name="hex">D0</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollCXRegisterLeftWithCarry">
    <xsl:element name="hex">D1</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollDXRegisterLeftWithCarry">
    <xsl:element name="hex">D2</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollBXRegisterLeftWithCarry">
    <xsl:element name="hex">D3</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollSPRegisterLeftWithCarry">
    <xsl:element name="hex">D4</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollBPRegisterLeftWithCarry">
    <xsl:element name="hex">D5</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollSIRegisterLeftWithCarry">
    <xsl:element name="hex">D6</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollDIRegisterLeftWithCarry">
    <xsl:element name="hex">D7</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollALRegisterRightWithCarry">
    <xsl:element name="hex">D8</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollCLRegisterRightWithCarry">
    <xsl:element name="hex">D9</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollDLRegisterRightWithCarry">
    <xsl:element name="hex">DA</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollBLRegisterRightWithCarry">
    <xsl:element name="hex">DB</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollAHRegisterRightWithCarry">
    <xsl:element name="hex">DC</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollCHRegisterRightWithCarry">
    <xsl:element name="hex">DD</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollDHRegisterRightWithCarry">
    <xsl:element name="hex">DE</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollBHRegisterRightWithCarry">
    <xsl:element name="hex">DF</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollAXRegisterRightWithCarry">
    <xsl:element name="hex">D8</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollCXRegisterRightWithCarry">
    <xsl:element name="hex">D9</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollDXRegisterRightWithCarry">
    <xsl:element name="hex">DA</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollBXRegisterRightWithCarry">
    <xsl:element name="hex">DB</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollSPRegisterRightWithCarry">
    <xsl:element name="hex">DC</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollBPRegisterRightWithCarry">
    <xsl:element name="hex">DD</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollSIRegisterRightWithCarry">
    <xsl:element name="hex">DE</xsl:element>
  </xsl:template>
  <xsl:template match="shift:RollDIRegisterRightWithCarry">
    <xsl:element name="hex">DF</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftALRegisterLeft">
    <xsl:element name="hex">E0</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftCLRegisterLeft">
    <xsl:element name="hex">E1</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftDLRegisterLeft">
    <xsl:element name="hex">E2</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftBLRegisterLeft">
    <xsl:element name="hex">E3</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftAHRegisterLeft">
    <xsl:element name="hex">E4</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftCHRegisterLeft">
    <xsl:element name="hex">E5</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftDHRegisterLeft">
    <xsl:element name="hex">E6</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftBHRegisterLeft">
    <xsl:element name="hex">E7</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftAXRegisterLeft">
    <xsl:element name="hex">E0</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftCXRegisterLeft">
    <xsl:element name="hex">E1</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftDXRegisterLeft">
    <xsl:element name="hex">E2</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftBXRegisterLeft">
    <xsl:element name="hex">E3</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftSPRegisterLeft">
    <xsl:element name="hex">E4</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftBPRegisterLeft">
    <xsl:element name="hex">E5</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftSIRegisterLeft">
    <xsl:element name="hex">E6</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftDIRegisterLeft">
    <xsl:element name="hex">E7</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftALRegisterRight">
    <xsl:element name="hex">E8</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftCLRegisterRight">
    <xsl:element name="hex">E9</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftDLRegisterRight">
    <xsl:element name="hex">EA</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftBLRegisterRight">
    <xsl:element name="hex">EB</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftAHRegisterRight">
    <xsl:element name="hex">EC</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftCHRegisterRight">
    <xsl:element name="hex">ED</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftDHRegisterRight">
    <xsl:element name="hex">EE</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftBHRegisterRight">
    <xsl:element name="hex">EF</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftAXRegisterRight">
    <xsl:element name="hex">E8</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftCXRegisterRight">
    <xsl:element name="hex">E9</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftDXRegisterRight">
    <xsl:element name="hex">EA</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftBXRegisterRight">
    <xsl:element name="hex">EB</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftSPRegisterRight">
    <xsl:element name="hex">EC</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftBPRegisterRight">
    <xsl:element name="hex">ED</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftSIRegisterRight">
    <xsl:element name="hex">EE</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftDIRegisterRight">
    <xsl:element name="hex">EF</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftALRegisterRightWithSign">
    <xsl:element name="hex">F8</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftCLRegisterRightWithSign">
    <xsl:element name="hex">F9</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftDLRegisterRightWithSign">
    <xsl:element name="hex">FA</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftBLRegisterRightWithSign">
    <xsl:element name="hex">FB</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftAHRegisterRightWithSign">
    <xsl:element name="hex">FC</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftCHRegisterRightWithSign">
    <xsl:element name="hex">FD</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftDHRegisterRightWithSign">
    <xsl:element name="hex">FE</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftBHRegisterRightWithSign">
    <xsl:element name="hex">FF</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftAXRegisterRightWithSign">
    <xsl:element name="hex">F8</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftCXRegisterRightWithSign">
    <xsl:element name="hex">F9</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftDXRegisterRightWithSign">
    <xsl:element name="hex">FA</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftBXRegisterRightWithSign">
    <xsl:element name="hex">FB</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftSPRegisterRightWithSign">
    <xsl:element name="hex">FC</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftBPRegisterRightWithSign">
    <xsl:element name="hex">FD</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftSIRegisterRightWithSign">
    <xsl:element name="hex">FE</xsl:element>
  </xsl:template>
  <xsl:template match="shift:ShiftDIRegisterRightWithSign">
    <xsl:element name="hex">FF</xsl:element>
  </xsl:template>
</xsl:stylesheet>