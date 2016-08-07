<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:ns="http://metalx.org/Intel/80386/MmxOperands" xmlns:prg="http://metalx.org/Program" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="ns:MM0-AXAddress">
		<xsl:element name="prg:hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM0-CXAddress">
		<xsl:element name="prg:hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM0-DXAddress">
		<xsl:element name="prg:hex">02</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM0-BXAddress">
		<xsl:element name="prg:hex">03</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM0-IndexAddress">
		<xsl:element name="prg:hex">04</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM0-ImmediateAddress">
		<xsl:element name="prg:hex">05</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM0-SIAddress">
		<xsl:element name="prg:hex">06</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM0-DIAddress">
		<xsl:element name="prg:hex">07</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM1-AXAddress">
		<xsl:element name="prg:hex">08</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM1-CXAddress">
		<xsl:element name="prg:hex">09</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM1-DXAddress">
		<xsl:element name="prg:hex">0A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM1-BXAddress">
		<xsl:element name="prg:hex">0B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM1-IndexAddress">
		<xsl:element name="prg:hex">0C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM1-ImmediateAddress">
		<xsl:element name="prg:hex">0D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM1-SIAddress">
		<xsl:element name="prg:hex">0E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM1-DIAddress">
		<xsl:element name="prg:hex">0F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM2-AXAddress">
		<xsl:element name="prg:hex">10</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM2-CXAddress">
		<xsl:element name="prg:hex">11</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM2-DXAddress">
		<xsl:element name="prg:hex">12</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM2-BXAddress">
		<xsl:element name="prg:hex">13</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM2-IndexAddress">
		<xsl:element name="prg:hex">14</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM2-ImmediateAddress">
		<xsl:element name="prg:hex">15</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM2-SIAddress">
		<xsl:element name="prg:hex">16</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM2-DIAddress">
		<xsl:element name="prg:hex">17</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM3-AXAddress">
		<xsl:element name="prg:hex">18</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM3-CXAddress">
		<xsl:element name="prg:hex">19</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM3-DXAddress">
		<xsl:element name="prg:hex">1A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM3-BXAddress">
		<xsl:element name="prg:hex">1B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM3-IndexAddress">
		<xsl:element name="prg:hex">1C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM3-ImmediateAddress">
		<xsl:element name="prg:hex">1D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM3-SIAddress">
		<xsl:element name="prg:hex">1E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM3-DIAddress">
		<xsl:element name="prg:hex">1F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM4-AXAddress">
		<xsl:element name="prg:hex">20</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM4-CXAddress">
		<xsl:element name="prg:hex">21</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM4-DXAddress">
		<xsl:element name="prg:hex">22</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM4-BXAddress">
		<xsl:element name="prg:hex">23</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM4-IndexAddress">
		<xsl:element name="prg:hex">24</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM4-ImmediateAddress">
		<xsl:element name="prg:hex">25</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM4-SIAddress">
		<xsl:element name="prg:hex">26</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM4-DIAddress">
		<xsl:element name="prg:hex">27</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM5-AXAddress">
		<xsl:element name="prg:hex">28</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM5-CXAddress">
		<xsl:element name="prg:hex">29</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM5-DXAddress">
		<xsl:element name="prg:hex">2A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM5-BXAddress">
		<xsl:element name="prg:hex">2B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM5-IndexAddress">
		<xsl:element name="prg:hex">2C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM5-ImmediateAddress">
		<xsl:element name="prg:hex">2D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM5-SIAddress">
		<xsl:element name="prg:hex">2E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM5-DIAddress">
		<xsl:element name="prg:hex">2F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM6-AXAddress">
		<xsl:element name="prg:hex">30</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM6-CXAddress">
		<xsl:element name="prg:hex">31</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM6-DXAddress">
		<xsl:element name="prg:hex">32</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM6-BXAddress">
		<xsl:element name="prg:hex">33</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM6-IndexAddress">
		<xsl:element name="prg:hex">34</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM6-ImmediateAddress">
		<xsl:element name="prg:hex">35</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM6-SIAddress">
		<xsl:element name="prg:hex">36</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM6-DIAddress">
		<xsl:element name="prg:hex">37</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM7-AXAddress">
		<xsl:element name="prg:hex">38</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM7-CXAddress">
		<xsl:element name="prg:hex">39</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM7-DXAddress">
		<xsl:element name="prg:hex">3A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM7-BXAddress">
		<xsl:element name="prg:hex">3B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM7-IndexAddress">
		<xsl:element name="prg:hex">3C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM7-ImmediateAddress">
		<xsl:element name="prg:hex">3D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM7-SIAddress">
		<xsl:element name="prg:hex">3E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM7-DIAddress">
		<xsl:element name="prg:hex">3F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM0-AXAddressPlusImmediate8">
		<xsl:element name="prg:hex">40</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM0-CXAddressPlusImmediate8">
		<xsl:element name="prg:hex">41</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM0-DXAddressPlusImmediate8">
		<xsl:element name="prg:hex">42</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM0-BXAddressPlusImmediate8">
		<xsl:element name="prg:hex">43</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM0-IndexAddressPlusImmediate8">
		<xsl:element name="prg:hex">44</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM0-BPAddressPlusImmediate8">
		<xsl:element name="prg:hex">45</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM0-SIAddressPlusImmediate8">
		<xsl:element name="prg:hex">46</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM0-DIAddressPlusImmediate8">
		<xsl:element name="prg:hex">47</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM1-AXAddressPlusImmediate8">
		<xsl:element name="prg:hex">48</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM1-CXAddressPlusImmediate8">
		<xsl:element name="prg:hex">49</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM1-DXAddressPlusImmediate8">
		<xsl:element name="prg:hex">4A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM1-BXAddressPlusImmediate8">
		<xsl:element name="prg:hex">4B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM1-IndexAddressPlusImmediate8">
		<xsl:element name="prg:hex">4C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM1-BPAddressPlusImmediate8">
		<xsl:element name="prg:hex">4D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM1-SIAddressPlusImmediate8">
		<xsl:element name="prg:hex">4E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM1-DIAddressPlusImmediate8">
		<xsl:element name="prg:hex">4F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM2-AXAddressPlusImmediate8">
		<xsl:element name="prg:hex">50</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM2-CXAddressPlusImmediate8">
		<xsl:element name="prg:hex">51</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM2-DXAddressPlusImmediate8">
		<xsl:element name="prg:hex">52</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM2-BXAddressPlusImmediate8">
		<xsl:element name="prg:hex">53</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM2-IndexAddressPlusImmediate8">
		<xsl:element name="prg:hex">54</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM2-BPAddressPlusImmediate8">
		<xsl:element name="prg:hex">55</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM2-SIAddressPlusImmediate8">
		<xsl:element name="prg:hex">56</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM2-DIAddressPlusImmediate8">
		<xsl:element name="prg:hex">57</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM3-AXAddressPlusImmediate8">
		<xsl:element name="prg:hex">58</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM3-CXAddressPlusImmediate8">
		<xsl:element name="prg:hex">59</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM3-DXAddressPlusImmediate8">
		<xsl:element name="prg:hex">5A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM3-BXAddressPlusImmediate8">
		<xsl:element name="prg:hex">5B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM3-IndexAddressPlusImmediate8">
		<xsl:element name="prg:hex">5C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM3-BPAddressPlusImmediate8">
		<xsl:element name="prg:hex">5D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM3-SIAddressPlusImmediate8">
		<xsl:element name="prg:hex">5E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM3-DIAddressPlusImmediate8">
		<xsl:element name="prg:hex">5F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM4-AXAddressPlusImmediate8">
		<xsl:element name="prg:hex">60</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM4-CXAddressPlusImmediate8">
		<xsl:element name="prg:hex">61</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM4-DXAddressPlusImmediate8">
		<xsl:element name="prg:hex">62</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM4-BXAddressPlusImmediate8">
		<xsl:element name="prg:hex">63</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM4-IndexAddressPlusImmediate8">
		<xsl:element name="prg:hex">64</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM4-BPAddressPlusImmediate8">
		<xsl:element name="prg:hex">65</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM4-SIAddressPlusImmediate8">
		<xsl:element name="prg:hex">66</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM4-DIAddressPlusImmediate8">
		<xsl:element name="prg:hex">67</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM5-AXAddressPlusImmediate8">
		<xsl:element name="prg:hex">68</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM5-CXAddressPlusImmediate8">
		<xsl:element name="prg:hex">69</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM5-DXAddressPlusImmediate8">
		<xsl:element name="prg:hex">6A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM5-BXAddressPlusImmediate8">
		<xsl:element name="prg:hex">6B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM5-IndexAddressPlusImmediate8">
		<xsl:element name="prg:hex">6C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM5-BPAddressPlusImmediate8">
		<xsl:element name="prg:hex">6D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM5-SIAddressPlusImmediate8">
		<xsl:element name="prg:hex">6E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM5-DIAddressPlusImmediate8">
		<xsl:element name="prg:hex">6F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM6-AXAddressPlusImmediate8">
		<xsl:element name="prg:hex">70</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM6-CXAddressPlusImmediate8">
		<xsl:element name="prg:hex">71</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM6-DXAddressPlusImmediate8">
		<xsl:element name="prg:hex">72</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM6-BXAddressPlusImmediate8">
		<xsl:element name="prg:hex">73</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM6-IndexAddressPlusImmediate8">
		<xsl:element name="prg:hex">74</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM6-BPAddressPlusImmediate8">
		<xsl:element name="prg:hex">75</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM6-SIAddressPlusImmediate8">
		<xsl:element name="prg:hex">76</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM6-DIAddressPlusImmediate8">
		<xsl:element name="prg:hex">77</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM7-AXAddressPlusImmediate8">
		<xsl:element name="prg:hex">78</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM7-CXAddressPlusImmediate8">
		<xsl:element name="prg:hex">79</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM7-DXAddressPlusImmediate8">
		<xsl:element name="prg:hex">7A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM7-BXAddressPlusImmediate8">
		<xsl:element name="prg:hex">7B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM7-IndexAddressPlusImmediate8">
		<xsl:element name="prg:hex">7C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM7-BPAddressPlusImmediate8">
		<xsl:element name="prg:hex">7D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM7-SIAddressPlusImmediate8">
		<xsl:element name="prg:hex">7E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM7-DIAddressPlusImmediate8">
		<xsl:element name="prg:hex">7F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM0-AXAddressPlusImmediate">
		<xsl:element name="prg:hex">80</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM0-CXAddressPlusImmediate">
		<xsl:element name="prg:hex">81</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM0-DXAddressPlusImmediate">
		<xsl:element name="prg:hex">82</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM0-BXAddressPlusImmediate">
		<xsl:element name="prg:hex">83</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM0-IndexAddressPlusImmediate">
		<xsl:element name="prg:hex">84</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM0-BPAddressPlusImmediate">
		<xsl:element name="prg:hex">85</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM0-SIAddressPlusImmediate">
		<xsl:element name="prg:hex">86</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM0-DIAddressPlusImmediate">
		<xsl:element name="prg:hex">87</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM1-AXAddressPlusImmediate">
		<xsl:element name="prg:hex">88</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM1-CXAddressPlusImmediate">
		<xsl:element name="prg:hex">89</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM1-DXAddressPlusImmediate">
		<xsl:element name="prg:hex">8A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM1-BXAddressPlusImmediate">
		<xsl:element name="prg:hex">8B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM1-IndexAddressPlusImmediate">
		<xsl:element name="prg:hex">8C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM1-BPAddressPlusImmediate">
		<xsl:element name="prg:hex">8D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM1-SIAddressPlusImmediate">
		<xsl:element name="prg:hex">8E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM1-DIAddressPlusImmediate">
		<xsl:element name="prg:hex">8F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM2-AXAddressPlusImmediate">
		<xsl:element name="prg:hex">90</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM2-CXAddressPlusImmediate">
		<xsl:element name="prg:hex">91</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM2-DXAddressPlusImmediate">
		<xsl:element name="prg:hex">92</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM2-BXAddressPlusImmediate">
		<xsl:element name="prg:hex">93</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM2-IndexAddressPlusImmediate">
		<xsl:element name="prg:hex">94</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM2-BPAddressPlusImmediate">
		<xsl:element name="prg:hex">95</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM2-SIAddressPlusImmediate">
		<xsl:element name="prg:hex">96</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM2-DIAddressPlusImmediate">
		<xsl:element name="prg:hex">97</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM3-AXAddressPlusImmediate">
		<xsl:element name="prg:hex">98</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM3-CXAddressPlusImmediate">
		<xsl:element name="prg:hex">99</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM3-DXAddressPlusImmediate">
		<xsl:element name="prg:hex">9A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM3-BXAddressPlusImmediate">
		<xsl:element name="prg:hex">9B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM3-IndexAddressPlusImmediate">
		<xsl:element name="prg:hex">9C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM3-BPAddressPlusImmediate">
		<xsl:element name="prg:hex">9D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM3-SIAddressPlusImmediate">
		<xsl:element name="prg:hex">9E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM3-DIAddressPlusImmediate">
		<xsl:element name="prg:hex">9F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM4-AXAddressPlusImmediate">
		<xsl:element name="prg:hex">A0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM4-CXAddressPlusImmediate">
		<xsl:element name="prg:hex">A1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM4-DXAddressPlusImmediate">
		<xsl:element name="prg:hex">A2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM4-BXAddressPlusImmediate">
		<xsl:element name="prg:hex">A3</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM4-IndexAddressPlusImmediate">
		<xsl:element name="prg:hex">A4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM4-BPAddressPlusImmediate">
		<xsl:element name="prg:hex">A5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM4-SIAddressPlusImmediate">
		<xsl:element name="prg:hex">A6</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM4-DIAddressPlusImmediate">
		<xsl:element name="prg:hex">A7</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM5-AXAddressPlusImmediate">
		<xsl:element name="prg:hex">A8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM5-CXAddressPlusImmediate">
		<xsl:element name="prg:hex">A9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM5-DXAddressPlusImmediate">
		<xsl:element name="prg:hex">AA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM5-BXAddressPlusImmediate">
		<xsl:element name="prg:hex">AB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM5-IndexAddressPlusImmediate">
		<xsl:element name="prg:hex">AC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM5-BPAddressPlusImmediate">
		<xsl:element name="prg:hex">AD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM5-SIAddressPlusImmediate">
		<xsl:element name="prg:hex">AE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM5-DIAddressPlusImmediate">
		<xsl:element name="prg:hex">AF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM6-AXAddressPlusImmediate">
		<xsl:element name="prg:hex">B0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM6-CXAddressPlusImmediate">
		<xsl:element name="prg:hex">B1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM6-DXAddressPlusImmediate">
		<xsl:element name="prg:hex">B2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM6-BXAddressPlusImmediate">
		<xsl:element name="prg:hex">B3</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM6-IndexAddressPlusImmediate">
		<xsl:element name="prg:hex">B4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM6-BPAddressPlusImmediate">
		<xsl:element name="prg:hex">B5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM6-SIAddressPlusImmediate">
		<xsl:element name="prg:hex">B6</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM6-DIAddressPlusImmediate">
		<xsl:element name="prg:hex">B7</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM7-AXAddressPlusImmediate">
		<xsl:element name="prg:hex">B8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM7-CXAddressPlusImmediate">
		<xsl:element name="prg:hex">B9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM7-DXAddressPlusImmediate">
		<xsl:element name="prg:hex">BA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM7-BXAddressPlusImmediate">
		<xsl:element name="prg:hex">BB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM7-IndexAddressPlusImmediate">
		<xsl:element name="prg:hex">BC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM7-BPAddressPlusImmediate">
		<xsl:element name="prg:hex">BD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM7-SIAddressPlusImmediate">
		<xsl:element name="prg:hex">BE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM7-DIAddressPlusImmediate">
		<xsl:element name="prg:hex">BF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM0-AXRegister">
		<xsl:element name="prg:hex">C0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM0-CXRegister">
		<xsl:element name="prg:hex">C1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM0-DXRegister">
		<xsl:element name="prg:hex">C2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM0-BXRegister">
		<xsl:element name="prg:hex">C3</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM0-SPRegister">
		<xsl:element name="prg:hex">C4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM0-BPRegister">
		<xsl:element name="prg:hex">C5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM0-SIRegister">
		<xsl:element name="prg:hex">C6</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM0-DIRegister">
		<xsl:element name="prg:hex">C7</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM1-AXRegister">
		<xsl:element name="prg:hex">C8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM1-CXRegister">
		<xsl:element name="prg:hex">C9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM1-DXRegister">
		<xsl:element name="prg:hex">CA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM1-BXRegister">
		<xsl:element name="prg:hex">CB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM1-SPRegister">
		<xsl:element name="prg:hex">CC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM1-BPRegister">
		<xsl:element name="prg:hex">CD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM1-SIRegister">
		<xsl:element name="prg:hex">CE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM1-DIRegister">
		<xsl:element name="prg:hex">CF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM2-AXRegister">
		<xsl:element name="prg:hex">D0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM2-CXRegister">
		<xsl:element name="prg:hex">D1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM2-DXRegister">
		<xsl:element name="prg:hex">D2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM2-BXRegister">
		<xsl:element name="prg:hex">D3</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM2-SPRegister">
		<xsl:element name="prg:hex">D4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM2-BPRegister">
		<xsl:element name="prg:hex">D5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM2-SIRegister">
		<xsl:element name="prg:hex">D6</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM2-DIRegister">
		<xsl:element name="prg:hex">D7</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM3-AXRegister">
		<xsl:element name="prg:hex">D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM3-CXRegister">
		<xsl:element name="prg:hex">D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM3-DXRegister">
		<xsl:element name="prg:hex">DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM3-BXRegister">
		<xsl:element name="prg:hex">DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM3-SPRegister">
		<xsl:element name="prg:hex">DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM3-BPRegister">
		<xsl:element name="prg:hex">DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM3-SIRegister">
		<xsl:element name="prg:hex">DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM3-DIRegister">
		<xsl:element name="prg:hex">DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM4-AXRegister">
		<xsl:element name="prg:hex">E0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM4-CXRegister">
		<xsl:element name="prg:hex">E1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM4-DXRegister">
		<xsl:element name="prg:hex">E2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM4-BXRegister">
		<xsl:element name="prg:hex">E3</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM4-SPRegister">
		<xsl:element name="prg:hex">E4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM4-BPRegister">
		<xsl:element name="prg:hex">E5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM4-SIRegister">
		<xsl:element name="prg:hex">E6</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM4-DIRegister">
		<xsl:element name="prg:hex">E7</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM5-AXRegister">
		<xsl:element name="prg:hex">E8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM5-CXRegister">
		<xsl:element name="prg:hex">E9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM5-DXRegister">
		<xsl:element name="prg:hex">EA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM5-BXRegister">
		<xsl:element name="prg:hex">EB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM5-SPRegister">
		<xsl:element name="prg:hex">EC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM5-BPRegister">
		<xsl:element name="prg:hex">ED</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM5-SIRegister">
		<xsl:element name="prg:hex">EE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM5-DIRegister">
		<xsl:element name="prg:hex">EF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM6-AXRegister">
		<xsl:element name="prg:hex">F0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM6-CXRegister">
		<xsl:element name="prg:hex">F1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM6-DXRegister">
		<xsl:element name="prg:hex">F2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM6-BXRegister">
		<xsl:element name="prg:hex">F3</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM6-SPRegister">
		<xsl:element name="prg:hex">F4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM6-BPRegister">
		<xsl:element name="prg:hex">F5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM6-SIRegister">
		<xsl:element name="prg:hex">F6</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM6-DIRegister">
		<xsl:element name="prg:hex">F7</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM7-AXRegister">
		<xsl:element name="prg:hex">F8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM7-CXRegister">
		<xsl:element name="prg:hex">F9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM7-DXRegister">
		<xsl:element name="prg:hex">FA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM7-BXRegister">
		<xsl:element name="prg:hex">FB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM7-SPRegister">
		<xsl:element name="prg:hex">FC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM7-BPRegister">
		<xsl:element name="prg:hex">FD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM7-SIRegister">
		<xsl:element name="prg:hex">FE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MM7-DIRegister">
		<xsl:element name="prg:hex">FF</xsl:element>
	</xsl:template>
</xsl:stylesheet>