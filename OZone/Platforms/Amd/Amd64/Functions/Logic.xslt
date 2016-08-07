<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:logic='http://metalx.org/Amd/Amd64/Logic'>
	
  <xsl:output method="xml" indent="yes" />
	
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" />
    </xsl:copy>
  </xsl:template>
	
  <xsl:template match="logic:CallAXAddress">
    <xsl:element name="hex">10</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallCXAddress">
    <xsl:element name="hex">11</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallDXAddress">
    <xsl:element name="hex">12</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallBXAddress">
    <xsl:element name="hex">13</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallIndexAddress">
    <xsl:element name="hex">14</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallImmediateAddress">
    <xsl:element name="hex">15</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallSIAddress">
    <xsl:element name="hex">16</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallDIAddress">
    <xsl:element name="hex">17</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallPointerAtAXAddress">
    <xsl:element name="hex">18</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallPointerAtCXAddress">
    <xsl:element name="hex">19</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallPointerAtDXAddress">
    <xsl:element name="hex">1A</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallPointerAtBXAddress">
    <xsl:element name="hex">1B</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallPointerAtIndexAddress">
    <xsl:element name="hex">1C</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallPointerAtImmediateAddress">
    <xsl:element name="hex">1D</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallPointerAtSIAddress">
    <xsl:element name="hex">1E</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallPointerAtDIAddress">
    <xsl:element name="hex">1F</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToAXAddress">
    <xsl:element name="hex">20</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToCXAddress">
    <xsl:element name="hex">21</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToDXAddress">
    <xsl:element name="hex">22</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToBXAddress">
    <xsl:element name="hex">23</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToIndexAddress">
    <xsl:element name="hex">24</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToImmediateAddress">
    <xsl:element name="hex">25</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToSIAddress">
    <xsl:element name="hex">26</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToDIAddress">
    <xsl:element name="hex">27</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToPointerAtAXAddress">
    <xsl:element name="hex">28</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToPointerAtCXAddress">
    <xsl:element name="hex">29</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToPointerAtDXAddress">
    <xsl:element name="hex">2A</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToPointerAtBXAddress">
    <xsl:element name="hex">2B</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToPointerAtIndexAddress">
    <xsl:element name="hex">2C</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToPointerAtImmediateAddress">
    <xsl:element name="hex">2D</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToPointerAtSIAddress">
    <xsl:element name="hex">2E</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToPointerAtDIAddress">
    <xsl:element name="hex">2F</xsl:element>
  </xsl:template>
  <xsl:template match="logic:PushAXAddress">
    <xsl:element name="hex">30</xsl:element>
  </xsl:template>
  <xsl:template match="logic:PushCXAddress">
    <xsl:element name="hex">31</xsl:element>
  </xsl:template>
  <xsl:template match="logic:PushDXAddress">
    <xsl:element name="hex">32</xsl:element>
  </xsl:template>
  <xsl:template match="logic:PushBXAddress">
    <xsl:element name="hex">33</xsl:element>
  </xsl:template>
  <xsl:template match="logic:PushIndexAddress">
    <xsl:element name="hex">34</xsl:element>
  </xsl:template>
  <xsl:template match="logic:PushImmediateAddress">
    <xsl:element name="hex">35</xsl:element>
  </xsl:template>
  <xsl:template match="logic:PushSIAddress">
    <xsl:element name="hex">36</xsl:element>
  </xsl:template>
  <xsl:template match="logic:PushDIAddress">
    <xsl:element name="hex">37</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallAXAddressPlusImmediate8">
    <xsl:element name="hex">50</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallCXAddressPlusImmediate8">
    <xsl:element name="hex">51</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallDXAddressPlusImmediate8">
    <xsl:element name="hex">52</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallBXAddressPlusImmediate8">
    <xsl:element name="hex">53</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallIndexAddressPlusImmediate8">
    <xsl:element name="hex">54</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallBPAddressPlusImmediate8">
    <xsl:element name="hex">55</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallSIAddressPlusImmediate8">
    <xsl:element name="hex">56</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallDIAddressPlusImmediate8">
    <xsl:element name="hex">57</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallPointerAtAXAddressPlusImmediate8">
    <xsl:element name="hex">58</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallPointerAtCXAddressPlusImmediate8">
    <xsl:element name="hex">59</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallPointerAtDXAddressPlusImmediate8">
    <xsl:element name="hex">5A</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallPointerAtBXAddressPlusImmediate8">
    <xsl:element name="hex">5B</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallPointerAtIndexAddressPlusImmediate8">
    <xsl:element name="hex">5C</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallPointerAtBPAddressPlusImmediate8">
    <xsl:element name="hex">5D</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallPointerAtSIAddressPlusImmediate8">
    <xsl:element name="hex">5E</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallPointerAtDIAddressPlusImmediate8">
    <xsl:element name="hex">5F</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToAXAddressPlusImmediate8">
    <xsl:element name="hex">60</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToCXAddressPlusImmediate8">
    <xsl:element name="hex">61</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToDXAddressPlusImmediate8">
    <xsl:element name="hex">62</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToBXAddressPlusImmediate8">
    <xsl:element name="hex">63</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToIndexAddressPlusImmediate8">
    <xsl:element name="hex">64</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToBPAddressPlusImmediate8">
    <xsl:element name="hex">65</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToSIAddressPlusImmediate8">
    <xsl:element name="hex">66</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToDIAddressPlusImmediate8">
    <xsl:element name="hex">67</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToPointerAtAXAddressPlusImmediate8">
    <xsl:element name="hex">68</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToPointerAtCXAddressPlusImmediate8">
    <xsl:element name="hex">69</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToPointerAtDXAddressPlusImmediate8">
    <xsl:element name="hex">6A</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToPointerAtBXAddressPlusImmediate8">
    <xsl:element name="hex">6B</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToPointerAtIndexAddressPlusImmediate8">
    <xsl:element name="hex">6C</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToPointerAtBPAddressPlusImmediate8">
    <xsl:element name="hex">6D</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToPointerAtSIAddressPlusImmediate8">
    <xsl:element name="hex">6E</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToPointerAtDIAddressPlusImmediate8">
    <xsl:element name="hex">6F</xsl:element>
  </xsl:template>
  <xsl:template match="logic:PushAXAddressPlusImmediate8">
    <xsl:element name="hex">70</xsl:element>
  </xsl:template>
  <xsl:template match="logic:PushCXAddressPlusImmediate8">
    <xsl:element name="hex">71</xsl:element>
  </xsl:template>
  <xsl:template match="logic:PushDXAddressPlusImmediate8">
    <xsl:element name="hex">72</xsl:element>
  </xsl:template>
  <xsl:template match="logic:PushBXAddressPlusImmediate8">
    <xsl:element name="hex">73</xsl:element>
  </xsl:template>
  <xsl:template match="logic:PushIndexAddressPlusImmediate8">
    <xsl:element name="hex">74</xsl:element>
  </xsl:template>
  <xsl:template match="logic:PushBPAddressPlusImmediate8">
    <xsl:element name="hex">75</xsl:element>
  </xsl:template>
  <xsl:template match="logic:PushSIAddressPlusImmediate8">
    <xsl:element name="hex">76</xsl:element>
  </xsl:template>
  <xsl:template match="logic:PushDIAddressPlusImmediate8">
    <xsl:element name="hex">77</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallAXAddressPlusImmediate">
    <xsl:element name="hex">90</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallCXAddressPlusImmediate">
    <xsl:element name="hex">91</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallDXAddressPlusImmediate">
    <xsl:element name="hex">92</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallBXAddressPlusImmediate">
    <xsl:element name="hex">93</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallIndexAddressPlusImmediate">
    <xsl:element name="hex">94</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallBPAddressPlusImmediate">
    <xsl:element name="hex">95</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallSIAddressPlusImmediate">
    <xsl:element name="hex">96</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallDIAddressPlusImmediate">
    <xsl:element name="hex">97</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallPointerAtAXAddressPlusImmediate">
    <xsl:element name="hex">98</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallPointerAtCXAddressPlusImmediate">
    <xsl:element name="hex">99</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallPointerAtDXAddressPlusImmediate">
    <xsl:element name="hex">9A</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallPointerAtBXAddressPlusImmediate">
    <xsl:element name="hex">9B</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallPointerAtIndexAddressPlusImmediate">
    <xsl:element name="hex">9C</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallPointerAtBPAddressPlusImmediate">
    <xsl:element name="hex">9D</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallPointerAtSIAddressPlusImmediate">
    <xsl:element name="hex">9E</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallPointerAtDIAddressPlusImmediate">
    <xsl:element name="hex">9F</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToAXAddressPlusImmediate">
    <xsl:element name="hex">A0</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToCXAddressPlusImmediate">
    <xsl:element name="hex">A1</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToDXAddressPlusImmediate">
    <xsl:element name="hex">A2</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToBXAddressPlusImmediate">
    <xsl:element name="hex">A3</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToIndexAddressPlusImmediate">
    <xsl:element name="hex">A4</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToBPAddressPlusImmediate">
    <xsl:element name="hex">A5</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToSIAddressPlusImmediate">
    <xsl:element name="hex">A6</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToDIAddressPlusImmediate">
    <xsl:element name="hex">A7</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToPointerAtAXAddressPlusImmediate">
    <xsl:element name="hex">A8</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToPointerAtCXAddressPlusImmediate">
    <xsl:element name="hex">A9</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToPointerAtDXAddressPlusImmediate">
    <xsl:element name="hex">AA</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToPointerAtBXAddressPlusImmediate">
    <xsl:element name="hex">AB</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToPointerAtIndexAddressPlusImmediate">
    <xsl:element name="hex">AC</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToPointerAtBPAddressPlusImmediate">
    <xsl:element name="hex">AD</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToPointerAtSIAddressPlusImmediate">
    <xsl:element name="hex">AE</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToPointerAtDIAddressPlusImmediate">
    <xsl:element name="hex">AF</xsl:element>
  </xsl:template>
  <xsl:template match="logic:PushAXAddressPlusImmediate">
    <xsl:element name="hex">B0</xsl:element>
  </xsl:template>
  <xsl:template match="logic:PushCXAddressPlusImmediate">
    <xsl:element name="hex">B1</xsl:element>
  </xsl:template>
  <xsl:template match="logic:PushDXAddressPlusImmediate">
    <xsl:element name="hex">B2</xsl:element>
  </xsl:template>
  <xsl:template match="logic:PushBXAddressPlusImmediate">
    <xsl:element name="hex">B3</xsl:element>
  </xsl:template>
  <xsl:template match="logic:PushIndexAddressPlusImmediate">
    <xsl:element name="hex">B4</xsl:element>
  </xsl:template>
  <xsl:template match="logic:PushBPAddressPlusImmediate">
    <xsl:element name="hex">B5</xsl:element>
  </xsl:template>
  <xsl:template match="logic:PushSIAddressPlusImmediate">
    <xsl:element name="hex">B6</xsl:element>
  </xsl:template>
  <xsl:template match="logic:PushDIAddressPlusImmediate">
    <xsl:element name="hex">B7</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallAXRegister">
    <xsl:element name="hex">D0</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallCXRegister">
    <xsl:element name="hex">D1</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallDXRegister">
    <xsl:element name="hex">D2</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallBXRegister">
    <xsl:element name="hex">D3</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallSPRegister">
    <xsl:element name="hex">D4</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallBPRegister">
    <xsl:element name="hex">D5</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallSIRegister">
    <xsl:element name="hex">D6</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallDIRegister">
    <xsl:element name="hex">D7</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallPointerAtAXRegister">
    <xsl:element name="hex">D8</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallPointerAtCXRegister">
    <xsl:element name="hex">D9</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallPointerAtDXRegister">
    <xsl:element name="hex">DA</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallPointerAtBXRegister">
    <xsl:element name="hex">DB</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallPointerAtSPRegister">
    <xsl:element name="hex">DC</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallPointerAtBPRegister">
    <xsl:element name="hex">DD</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallPointerAtSIRegister">
    <xsl:element name="hex">DE</xsl:element>
  </xsl:template>
  <xsl:template match="logic:CallPointerAtDIRegister">
    <xsl:element name="hex">DF</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToAXRegister">
    <xsl:element name="hex">E0</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToCXRegister">
    <xsl:element name="hex">E1</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToDXRegister">
    <xsl:element name="hex">E2</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToBXRegister">
    <xsl:element name="hex">E3</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToSPRegister">
    <xsl:element name="hex">E4</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToBPRegister">
    <xsl:element name="hex">E5</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToSIRegister">
    <xsl:element name="hex">E6</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToDIRegister">
    <xsl:element name="hex">E7</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToPointerAtAXRegister">
    <xsl:element name="hex">E8</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToPointerAtCXRegister">
    <xsl:element name="hex">E9</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToPointerAtDXRegister">
    <xsl:element name="hex">EA</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToPointerAtBXRegister">
    <xsl:element name="hex">EB</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToPointerAtSPRegister">
    <xsl:element name="hex">EC</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToPointerAtBPRegister">
    <xsl:element name="hex">ED</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToPointerAtSIRegister">
    <xsl:element name="hex">EE</xsl:element>
  </xsl:template>
  <xsl:template match="logic:JumpToPointerAtDIRegister">
    <xsl:element name="hex">EF</xsl:element>
  </xsl:template>
  <xsl:template match="logic:PushAXRegister">
    <xsl:element name="hex">F0</xsl:element>
  </xsl:template>
  <xsl:template match="logic:PushCXRegister">
    <xsl:element name="hex">F1</xsl:element>
  </xsl:template>
  <xsl:template match="logic:PushDXRegister">
    <xsl:element name="hex">F2</xsl:element>
  </xsl:template>
  <xsl:template match="logic:PushBXRegister">
    <xsl:element name="hex">F3</xsl:element>
  </xsl:template>
  <xsl:template match="logic:PushSPRegister">
    <xsl:element name="hex">F4</xsl:element>
  </xsl:template>
  <xsl:template match="logic:PushBPRegister">
    <xsl:element name="hex">F5</xsl:element>
  </xsl:template>
  <xsl:template match="logic:PushSIRegister">
    <xsl:element name="hex">F6</xsl:element>
  </xsl:template>
  <xsl:template match="logic:PushDIRegister">
    <xsl:element name="hex">F7</xsl:element>
  </xsl:template>
</xsl:stylesheet>