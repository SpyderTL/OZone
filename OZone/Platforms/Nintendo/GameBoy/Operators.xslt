<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:ns="http://metalx.org/Nintendo/GameBoy/Operators" xmlns:prg="http://metalx.org/Program" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="ns:NoOperation">
		<xsl:element name="prg:hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediateToBC">
		<xsl:element name="prg:hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAToBCAddress">
		<xsl:element name="prg:hex">02</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IncrementBC">
		<xsl:element name="prg:hex">03</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IncrementB">
		<xsl:element name="prg:hex">04</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DecrementB">
		<xsl:element name="prg:hex">05</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediateToB">
		<xsl:element name="prg:hex">06</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RotateALeftToCarryFlag">
		<xsl:element name="prg:hex">07</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopySPToImmediateAddress">
		<xsl:element name="prg:hex">08</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddBCToHL">
		<xsl:element name="prg:hex">09</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyBCAddressToA">
		<xsl:element name="prg:hex">0A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DecrementBC">
		<xsl:element name="prg:hex">0B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IncrementC">
		<xsl:element name="prg:hex">0C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DecrementC">
		<xsl:element name="prg:hex">0D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediateToC">
		<xsl:element name="prg:hex">0E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RotateARightToCarryFlag">
		<xsl:element name="prg:hex">0F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:WaitForButtonPress">
		<xsl:element name="prg:hex">10</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediateToDE">
		<xsl:element name="prg:hex">11</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAToDEAddress">
		<xsl:element name="prg:hex">12</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IncrementDE">
		<xsl:element name="prg:hex">13</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IncrementD">
		<xsl:element name="prg:hex">14</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DecrementD">
		<xsl:element name="prg:hex">15</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediateToD">
		<xsl:element name="prg:hex">16</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RotateAAndCarryFlagLeft">
		<xsl:element name="prg:hex">17</xsl:element>
	</xsl:template>
	<xsl:template match="ns:JumpToRelativeAddress">
		<xsl:element name="prg:hex">18</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddDEToHL">
		<xsl:element name="prg:hex">19</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyDEAddressToA">
		<xsl:element name="prg:hex">1A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DecrementDE">
		<xsl:element name="prg:hex">1B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IncrementE">
		<xsl:element name="prg:hex">1C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DecrementE">
		<xsl:element name="prg:hex">1D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediateToE">
		<xsl:element name="prg:hex">1E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RotateAAndCarryFlagRight">
		<xsl:element name="prg:hex">1F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelativeAddressIfNotZero">
		<xsl:element name="prg:hex">20</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediateToHL">
		<xsl:element name="prg:hex">21</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAToHLAddressAndIncrementHL">
		<xsl:element name="prg:hex">22</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IncrementHL">
		<xsl:element name="prg:hex">23</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IncrementH">
		<xsl:element name="prg:hex">24</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DecrementH">
		<xsl:element name="prg:hex">25</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediateToH">
		<xsl:element name="prg:hex">26</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ConvertAToDecimal">
		<xsl:element name="prg:hex">27</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelativeAddressIfZero">
		<xsl:element name="prg:hex">28</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddHLToHL">
		<xsl:element name="prg:hex">29</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyHLAddressToAAndIncrementHL">
		<xsl:element name="prg:hex">2A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DecrementHL">
		<xsl:element name="prg:hex">2B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IncrementL">
		<xsl:element name="prg:hex">2C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DecrementL">
		<xsl:element name="prg:hex">2D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediateToL">
		<xsl:element name="prg:hex">2E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ComplementA">
		<xsl:element name="prg:hex">2F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelativeAddressIfNotCarry">
		<xsl:element name="prg:hex">30</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediateToSP">
		<xsl:element name="prg:hex">31</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAToHLAddressAndDecrementHL">
		<xsl:element name="prg:hex">32</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IncrementSP">
		<xsl:element name="prg:hex">33</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IncrementHLAddress">
		<xsl:element name="prg:hex">34</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DecrementHLAddress">
		<xsl:element name="prg:hex">35</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediateToHLAddress">
		<xsl:element name="prg:hex">36</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SetCarryFlag">
		<xsl:element name="prg:hex">37</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToRelativeAddressIfCarry">
		<xsl:element name="prg:hex">38</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddSPToHL">
		<xsl:element name="prg:hex">39</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyHLAddressToAAndDecrementHL">
		<xsl:element name="prg:hex">3A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DecrementSP">
		<xsl:element name="prg:hex">3B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IncrementA">
		<xsl:element name="prg:hex">3C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DecrementA">
		<xsl:element name="prg:hex">3D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediateToA">
		<xsl:element name="prg:hex">3E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ComplementCarryFlag">
		<xsl:element name="prg:hex">3F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyBToB">
		<xsl:element name="prg:hex">40</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyCToB">
		<xsl:element name="prg:hex">41</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyDToB">
		<xsl:element name="prg:hex">42</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyEToB">
		<xsl:element name="prg:hex">43</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyHToB">
		<xsl:element name="prg:hex">44</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyLToB">
		<xsl:element name="prg:hex">45</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyHLAddressToB">
		<xsl:element name="prg:hex">46</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAToB">
		<xsl:element name="prg:hex">47</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyBToC">
		<xsl:element name="prg:hex">48</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyCToC">
		<xsl:element name="prg:hex">49</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyDToC">
		<xsl:element name="prg:hex">4A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyEToC">
		<xsl:element name="prg:hex">4B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyHToC">
		<xsl:element name="prg:hex">4C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyLToC">
		<xsl:element name="prg:hex">4D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyHLAddressToC">
		<xsl:element name="prg:hex">4E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAToC">
		<xsl:element name="prg:hex">4F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyBToD">
		<xsl:element name="prg:hex">50</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyCToD">
		<xsl:element name="prg:hex">51</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyDToD">
		<xsl:element name="prg:hex">52</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyEToD">
		<xsl:element name="prg:hex">53</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyHToD">
		<xsl:element name="prg:hex">54</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyLToD">
		<xsl:element name="prg:hex">55</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyHLAddressToD">
		<xsl:element name="prg:hex">56</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAToD">
		<xsl:element name="prg:hex">57</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyBToE">
		<xsl:element name="prg:hex">58</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyCToE">
		<xsl:element name="prg:hex">59</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyDToE">
		<xsl:element name="prg:hex">5A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyEToE">
		<xsl:element name="prg:hex">5B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyHToE">
		<xsl:element name="prg:hex">5C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyLToE">
		<xsl:element name="prg:hex">5D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyHLAddressToE">
		<xsl:element name="prg:hex">5E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAToE">
		<xsl:element name="prg:hex">5F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyBToH">
		<xsl:element name="prg:hex">60</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyCToH">
		<xsl:element name="prg:hex">61</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyDToH">
		<xsl:element name="prg:hex">62</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyEToH">
		<xsl:element name="prg:hex">63</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyHToH">
		<xsl:element name="prg:hex">64</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyLToH">
		<xsl:element name="prg:hex">65</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyHLAddressToH">
		<xsl:element name="prg:hex">66</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAToH">
		<xsl:element name="prg:hex">67</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyBToL">
		<xsl:element name="prg:hex">68</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyCToL">
		<xsl:element name="prg:hex">69</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyDToL">
		<xsl:element name="prg:hex">6A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyEToL">
		<xsl:element name="prg:hex">6B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyHToL">
		<xsl:element name="prg:hex">6C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyLToL">
		<xsl:element name="prg:hex">6D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyHLAddressToL">
		<xsl:element name="prg:hex">6E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAToL">
		<xsl:element name="prg:hex">6F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyBToHLAddress">
		<xsl:element name="prg:hex">70</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyCToHLAddress">
		<xsl:element name="prg:hex">71</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyDToHLAddress">
		<xsl:element name="prg:hex">72</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyEToHLAddress">
		<xsl:element name="prg:hex">73</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyHToHLAddress">
		<xsl:element name="prg:hex">74</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyLToHLAddress">
		<xsl:element name="prg:hex">75</xsl:element>
	</xsl:template>
	<xsl:template match="ns:WaitForInterrupt">
		<xsl:element name="prg:hex">76</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAToHLAddress">
		<xsl:element name="prg:hex">77</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyBToA">
		<xsl:element name="prg:hex">78</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyCToA">
		<xsl:element name="prg:hex">79</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyDToA">
		<xsl:element name="prg:hex">7A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyEToA">
		<xsl:element name="prg:hex">7B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyHToA">
		<xsl:element name="prg:hex">7C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyLToA">
		<xsl:element name="prg:hex">7D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyHLAddressToA">
		<xsl:element name="prg:hex">7E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAToA">
		<xsl:element name="prg:hex">7F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddBToA">
		<xsl:element name="prg:hex">80</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddCToA">
		<xsl:element name="prg:hex">81</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddDToA">
		<xsl:element name="prg:hex">82</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddEToA">
		<xsl:element name="prg:hex">83</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddHToA">
		<xsl:element name="prg:hex">84</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddLToA">
		<xsl:element name="prg:hex">85</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddHLAddressToA">
		<xsl:element name="prg:hex">86</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddAToA">
		<xsl:element name="prg:hex">87</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddBPlusCarryFlagToA">
		<xsl:element name="prg:hex">88</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddCPlusCarryFlagToA">
		<xsl:element name="prg:hex">89</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddDPlusCarryFlagToA">
		<xsl:element name="prg:hex">8A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddEPlusCarryFlagToA">
		<xsl:element name="prg:hex">8B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddHPlusCarryFlagToA">
		<xsl:element name="prg:hex">8C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddLPlusCarryFlagToA">
		<xsl:element name="prg:hex">8D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddHLAddressPlusCarryFlagToA">
		<xsl:element name="prg:hex">8E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddAPlusCarryFlagToA">
		<xsl:element name="prg:hex">8F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractBFromA">
		<xsl:element name="prg:hex">90</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractCFromA">
		<xsl:element name="prg:hex">91</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractDFromA">
		<xsl:element name="prg:hex">92</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractEFromA">
		<xsl:element name="prg:hex">93</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractHFromA">
		<xsl:element name="prg:hex">94</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractLFromA">
		<xsl:element name="prg:hex">95</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractHLAddressFromA">
		<xsl:element name="prg:hex">96</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractAFromA">
		<xsl:element name="prg:hex">97</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractBPlusCarryFlagFromA">
		<xsl:element name="prg:hex">98</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractCPlusCarryFlagFromA">
		<xsl:element name="prg:hex">99</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractDPlusCarryFlagFromA">
		<xsl:element name="prg:hex">9A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractEPlusCarryFlagFromA">
		<xsl:element name="prg:hex">9B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractHPlusCarryFlagFromA">
		<xsl:element name="prg:hex">9C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractLPlusCarryFlagFromA">
		<xsl:element name="prg:hex">9D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractHLAddressPlusCarryFlagFromA">
		<xsl:element name="prg:hex">9E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractAPlusCarryFlagFromA">
		<xsl:element name="prg:hex">9F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AndAWithB">
		<xsl:element name="prg:hex">A0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AndAWithC">
		<xsl:element name="prg:hex">A1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AndAWithD">
		<xsl:element name="prg:hex">A2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AndAWithE">
		<xsl:element name="prg:hex">A3</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AndAWithH">
		<xsl:element name="prg:hex">A4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AndAWithL">
		<xsl:element name="prg:hex">A5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AndAWithHLAddress">
		<xsl:element name="prg:hex">A6</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AndAWithA">
		<xsl:element name="prg:hex">A7</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExclusiveOrAWithB">
		<xsl:element name="prg:hex">A8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExclusiveOrAWithC">
		<xsl:element name="prg:hex">A9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExclusiveOrAWithD">
		<xsl:element name="prg:hex">AA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExclusiveOrAWithE">
		<xsl:element name="prg:hex">AB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExclusiveOrAWithH">
		<xsl:element name="prg:hex">AC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExclusiveOrAWithL">
		<xsl:element name="prg:hex">AD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExclusiveOrAWithHLAddress">
		<xsl:element name="prg:hex">AE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExclusiveOrAWithA">
		<xsl:element name="prg:hex">AF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OrAWithB">
		<xsl:element name="prg:hex">B0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OrAWithC">
		<xsl:element name="prg:hex">B1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OrAWithD">
		<xsl:element name="prg:hex">B2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OrAWithE">
		<xsl:element name="prg:hex">B3</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OrAWithH">
		<xsl:element name="prg:hex">B4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OrAWithL">
		<xsl:element name="prg:hex">B5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OrAWithHLAddress">
		<xsl:element name="prg:hex">B6</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OrAWithA">
		<xsl:element name="prg:hex">B7</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareAToB">
		<xsl:element name="prg:hex">B8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareAToC">
		<xsl:element name="prg:hex">B9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareAToD">
		<xsl:element name="prg:hex">BA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareAToE">
		<xsl:element name="prg:hex">BB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareAToH">
		<xsl:element name="prg:hex">BC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareAToL">
		<xsl:element name="prg:hex">BD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareAToHLAddress">
		<xsl:element name="prg:hex">BE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareAToA">
		<xsl:element name="prg:hex">BF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ReturnToCallerIfNotZero">
		<xsl:element name="prg:hex">C0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullBCFromStack">
		<xsl:element name="prg:hex">C1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToAbsoluteAddressIfNotZero">
		<xsl:element name="prg:hex">C2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:JumpToAbsoluteAddress">
		<xsl:element name="prg:hex">C3</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CallAbsoluteAddressIfNotZero">
		<xsl:element name="prg:hex">C4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushBCToStack">
		<xsl:element name="prg:hex">C5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddImmediateToA">
		<xsl:element name="prg:hex">C6</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CallSystemFunction0">
		<xsl:element name="prg:hex">C7</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ReturnToCallerIfZero">
		<xsl:element name="prg:hex">C8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ReturnToCaller">
		<xsl:element name="prg:hex">C9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToAbsoluteAddressIfZero">
		<xsl:element name="prg:hex">CA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BitwiseFunctions">
		<xsl:element name="prg:hex">CB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CallAbsoluteAddressIfZero">
		<xsl:element name="prg:hex">CC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CallAbsoluteAddress">
		<xsl:element name="prg:hex">CD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddImmediatePlusCarryFlagToA">
		<xsl:element name="prg:hex">CE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CallSystemFunction1">
		<xsl:element name="prg:hex">CF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ReturnToCallerIfNotCarry">
		<xsl:element name="prg:hex">D0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullDEFromStack">
		<xsl:element name="prg:hex">D1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToAbsoluteAddressIfNotCarry">
		<xsl:element name="prg:hex">D2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CallAbsoluteAddressIfNotCarry">
		<xsl:element name="prg:hex">D4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushDEToStack">
		<xsl:element name="prg:hex">D5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractImmediateFromA">
		<xsl:element name="prg:hex">D6</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CallSystemFunction2">
		<xsl:element name="prg:hex">D7</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ReturnToCallerIfCarry">
		<xsl:element name="prg:hex">D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ReturnToCallerAndEnableInterrupts">
		<xsl:element name="prg:hex">D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchToAbsoluteAddressIfCarry">
		<xsl:element name="prg:hex">DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CallAbsoluteAddressIfCarry">
		<xsl:element name="prg:hex">DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CallSystemFunction3">
		<xsl:element name="prg:hex">DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAToLastPagePlusImmediateAddress">
		<xsl:element name="prg:hex">E0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullHLFromStack">
		<xsl:element name="prg:hex">E1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAToLastPagePlusCAddress">
		<xsl:element name="prg:hex">E2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushHLToStack">
		<xsl:element name="prg:hex">E5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AndAWithImmediate">
		<xsl:element name="prg:hex">E6</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CallSystemFunction4">
		<xsl:element name="prg:hex">E7</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddImmediateToSP">
		<xsl:element name="prg:hex">E8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:JumpToHLAddress">
		<xsl:element name="prg:hex">E9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAToImmediateAddress">
		<xsl:element name="prg:hex">EA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExclusiveOrAWithImmediate">
		<xsl:element name="prg:hex">EE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CallSystemFunction5">
		<xsl:element name="prg:hex">EF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyLastPagePlusImmediateAddressToA">
		<xsl:element name="prg:hex">F0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullAFFromStack">
		<xsl:element name="prg:hex">F1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyLastPagePlusCAddressToA">
		<xsl:element name="prg:hex">F2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DisableInterrupts">
		<xsl:element name="prg:hex">F3</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushAFToStack">
		<xsl:element name="prg:hex">F5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OrAWithImmediate">
		<xsl:element name="prg:hex">F6</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CallSystemFunction6">
		<xsl:element name="prg:hex">F7</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopySPPlusImmediateToHL">
		<xsl:element name="prg:hex">F8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyHLToSP">
		<xsl:element name="prg:hex">F9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyImmediateAddressToA">
		<xsl:element name="prg:hex">FA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:EnableInterrupts">
		<xsl:element name="prg:hex">FB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareAToImmediate">
		<xsl:element name="prg:hex">FE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CallSystemFunction7">
		<xsl:element name="prg:hex">FF</xsl:element>
	</xsl:template>
</xsl:stylesheet>