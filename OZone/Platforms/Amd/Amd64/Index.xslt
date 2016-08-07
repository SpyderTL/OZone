<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:ns="http://metalx.org/Amd/Amd64/Index" xmlns:prg="http://metalx.org/Program" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="ns:AXPlusAX">
		<xsl:element name="prg:hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AXPlusCX">
		<xsl:element name="prg:hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AXPlusDX">
		<xsl:element name="prg:hex">02</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AXPlusBX">
		<xsl:element name="prg:hex">03</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AXPlusSP">
		<xsl:element name="prg:hex">04</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AXPlusBP">
		<xsl:element name="prg:hex">05</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AXPlusImmediate32">
		<xsl:element name="prg:hex">05</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AXPlusSI">
		<xsl:element name="prg:hex">06</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AXPlusDI">
		<xsl:element name="prg:hex">07</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CXPlusAX">
		<xsl:element name="prg:hex">08</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CXPlusCX">
		<xsl:element name="prg:hex">09</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CXPlusDX">
		<xsl:element name="prg:hex">0A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CXPlusBX">
		<xsl:element name="prg:hex">0B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CXPlusSP">
		<xsl:element name="prg:hex">0C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CXPlusBP">
		<xsl:element name="prg:hex">0D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CXPlusImmediate32">
		<xsl:element name="prg:hex">0D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CXPlusSI">
		<xsl:element name="prg:hex">0E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CXPlusDI">
		<xsl:element name="prg:hex">0F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DXPlusAX">
		<xsl:element name="prg:hex">10</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DXPlusCX">
		<xsl:element name="prg:hex">11</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DXPlusDX">
		<xsl:element name="prg:hex">12</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DXPlusBX">
		<xsl:element name="prg:hex">13</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DXPlusSP">
		<xsl:element name="prg:hex">14</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DXPlusBP">
		<xsl:element name="prg:hex">15</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DXPlusImmediate32">
		<xsl:element name="prg:hex">15</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DXPlusSI">
		<xsl:element name="prg:hex">16</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DXPlusDI">
		<xsl:element name="prg:hex">17</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BXPlusAX">
		<xsl:element name="prg:hex">18</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BXPlusCX">
		<xsl:element name="prg:hex">19</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BXPlusDX">
		<xsl:element name="prg:hex">1A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BXPlusBX">
		<xsl:element name="prg:hex">1B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BXPlusSP">
		<xsl:element name="prg:hex">1C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BXPlusBP">
		<xsl:element name="prg:hex">1D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BXPlusImmediate32">
		<xsl:element name="prg:hex">1D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BXPlusSI">
		<xsl:element name="prg:hex">1E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BXPlusDI">
		<xsl:element name="prg:hex">1F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AX">
		<xsl:element name="prg:hex">20</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CX">
		<xsl:element name="prg:hex">21</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DX">
		<xsl:element name="prg:hex">22</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BX">
		<xsl:element name="prg:hex">23</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SP">
		<xsl:element name="prg:hex">24</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BP">
		<xsl:element name="prg:hex">25</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Immediate32">
		<xsl:element name="prg:hex">25</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SI">
		<xsl:element name="prg:hex">26</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DI">
		<xsl:element name="prg:hex">27</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BPPlusAX">
		<xsl:element name="prg:hex">28</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BPPlusCX">
		<xsl:element name="prg:hex">29</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BPPlusDX">
		<xsl:element name="prg:hex">2A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BPPlusBX">
		<xsl:element name="prg:hex">2B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BPPlusSP">
		<xsl:element name="prg:hex">2C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BPPlusBP">
		<xsl:element name="prg:hex">2D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BPPlusImmediate32">
		<xsl:element name="prg:hex">2D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BPPlusSI">
		<xsl:element name="prg:hex">2E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BPPlusDI">
		<xsl:element name="prg:hex">2F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SIPlusAX">
		<xsl:element name="prg:hex">30</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SIPlusCX">
		<xsl:element name="prg:hex">31</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SIPlusDX">
		<xsl:element name="prg:hex">32</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SIPlusBX">
		<xsl:element name="prg:hex">33</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SIPlusSP">
		<xsl:element name="prg:hex">34</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SIPlusBP">
		<xsl:element name="prg:hex">35</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SIPlusImmediate32">
		<xsl:element name="prg:hex">35</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SIPlusSI">
		<xsl:element name="prg:hex">36</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SIPlusDI">
		<xsl:element name="prg:hex">37</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DIPlusAX">
		<xsl:element name="prg:hex">38</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DIPlusCX">
		<xsl:element name="prg:hex">39</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DIPlusDX">
		<xsl:element name="prg:hex">3A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DIPlusBX">
		<xsl:element name="prg:hex">3B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DIPlusSP">
		<xsl:element name="prg:hex">3C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DIPlusBP">
		<xsl:element name="prg:hex">3D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DIPlusImmediate32">
		<xsl:element name="prg:hex">3D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DIPlusSI">
		<xsl:element name="prg:hex">3E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DIPlusDI">
		<xsl:element name="prg:hex">3F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AXTimesTwoPlusAX">
		<xsl:element name="prg:hex">40</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AXTimesTwoPlusCX">
		<xsl:element name="prg:hex">41</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AXTimesTwoPlusDX">
		<xsl:element name="prg:hex">42</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AXTimesTwoPlusBX">
		<xsl:element name="prg:hex">43</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AXTimesTwoPlusSP">
		<xsl:element name="prg:hex">44</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AXTimesTwoPlusBP">
		<xsl:element name="prg:hex">45</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AXTimesTwoPlusImmediate32">
		<xsl:element name="prg:hex">45</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AXTimesTwoPlusSI">
		<xsl:element name="prg:hex">46</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AXTimesTwoPlusDI">
		<xsl:element name="prg:hex">47</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CXTimesTwoPlusAX">
		<xsl:element name="prg:hex">48</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CXTimesTwoPlusCX">
		<xsl:element name="prg:hex">49</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CXTimesTwoPlusDX">
		<xsl:element name="prg:hex">4A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CXTimesTwoPlusBX">
		<xsl:element name="prg:hex">4B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CXTimesTwoPlusSP">
		<xsl:element name="prg:hex">4C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CXTimesTwoPlusBP">
		<xsl:element name="prg:hex">4D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CXTimesTwoPlusImmediate32">
		<xsl:element name="prg:hex">4D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CXTimesTwoPlusSI">
		<xsl:element name="prg:hex">4E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CXTimesTwoPlusDI">
		<xsl:element name="prg:hex">4F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DXTimesTwoPlusAX">
		<xsl:element name="prg:hex">50</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DXTimesTwoPlusCX">
		<xsl:element name="prg:hex">51</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DXTimesTwoPlusDX">
		<xsl:element name="prg:hex">52</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DXTimesTwoPlusBX">
		<xsl:element name="prg:hex">53</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DXTimesTwoPlusSP">
		<xsl:element name="prg:hex">54</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DXTimesTwoPlusBP">
		<xsl:element name="prg:hex">55</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DXTimesTwoPlusImmediate32">
		<xsl:element name="prg:hex">55</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DXTimesTwoPlusSI">
		<xsl:element name="prg:hex">56</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DXTimesTwoPlusDI">
		<xsl:element name="prg:hex">57</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BXTimesTwoPlusAX">
		<xsl:element name="prg:hex">58</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BXTimesTwoPlusCX">
		<xsl:element name="prg:hex">59</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BXTimesTwoPlusDX">
		<xsl:element name="prg:hex">5A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BXTimesTwoPlusBX">
		<xsl:element name="prg:hex">5B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BXTimesTwoPlusSP">
		<xsl:element name="prg:hex">5C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BXTimesTwoPlusBP">
		<xsl:element name="prg:hex">5D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BXTimesTwoPlusImmediate32">
		<xsl:element name="prg:hex">5D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BXTimesTwoPlusSI">
		<xsl:element name="prg:hex">5E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BXTimesTwoPlusDI">
		<xsl:element name="prg:hex">5F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BPTimesTwoPlusAX">
		<xsl:element name="prg:hex">68</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BPTimesTwoPlusCX">
		<xsl:element name="prg:hex">69</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BPTimesTwoPlusDX">
		<xsl:element name="prg:hex">6A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BPTimesTwoPlusBX">
		<xsl:element name="prg:hex">6B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BPTimesTwoPlusSP">
		<xsl:element name="prg:hex">6C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BPTimesTwoPlusBP">
		<xsl:element name="prg:hex">6D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BPTimesTwoPlusImmediate32">
		<xsl:element name="prg:hex">6D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BPTimesTwoPlusSI">
		<xsl:element name="prg:hex">6E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BPTimesTwoPlusDI">
		<xsl:element name="prg:hex">6F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SITimesTwoPlusAX">
		<xsl:element name="prg:hex">70</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SITimesTwoPlusCX">
		<xsl:element name="prg:hex">71</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SITimesTwoPlusDX">
		<xsl:element name="prg:hex">72</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SITimesTwoPlusBX">
		<xsl:element name="prg:hex">73</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SITimesTwoPlusSP">
		<xsl:element name="prg:hex">74</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SITimesTwoPlusBP">
		<xsl:element name="prg:hex">75</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SITimesTwoPlusImmediate32">
		<xsl:element name="prg:hex">75</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SITimesTwoPlusSI">
		<xsl:element name="prg:hex">76</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SITimesTwoPlusDI">
		<xsl:element name="prg:hex">77</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DITimesTwoPlusAX">
		<xsl:element name="prg:hex">78</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DITimesTwoPlusCX">
		<xsl:element name="prg:hex">79</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DITimesTwoPlusDX">
		<xsl:element name="prg:hex">7A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DITimesTwoPlusBX">
		<xsl:element name="prg:hex">7B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DITimesTwoPlusSP">
		<xsl:element name="prg:hex">7C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DITimesTwoPlusBP">
		<xsl:element name="prg:hex">7D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DITimesTwoPlusImmediate32">
		<xsl:element name="prg:hex">7D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DITimesTwoPlusSI">
		<xsl:element name="prg:hex">7E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DITimesTwoPlusDI">
		<xsl:element name="prg:hex">7F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AXTimesFourPlusAX">
		<xsl:element name="prg:hex">80</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AXTimesFourPlusCX">
		<xsl:element name="prg:hex">81</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AXTimesFourPlusDX">
		<xsl:element name="prg:hex">82</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AXTimesFourPlusBX">
		<xsl:element name="prg:hex">83</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AXTimesFourPlusSP">
		<xsl:element name="prg:hex">84</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AXTimesFourPlusBP">
		<xsl:element name="prg:hex">85</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AXTimesFourPlusImmediate32">
		<xsl:element name="prg:hex">85</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AXTimesFourPlusSI">
		<xsl:element name="prg:hex">86</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AXTimesFourPlusDI">
		<xsl:element name="prg:hex">87</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CXTimesFourPlusAX">
		<xsl:element name="prg:hex">88</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CXTimesFourPlusCX">
		<xsl:element name="prg:hex">89</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CXTimesFourPlusDX">
		<xsl:element name="prg:hex">8A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CXTimesFourPlusBX">
		<xsl:element name="prg:hex">8B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CXTimesFourPlusSP">
		<xsl:element name="prg:hex">8C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CXTimesFourPlusBP">
		<xsl:element name="prg:hex">8D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CXTimesFourPlusImmediate32">
		<xsl:element name="prg:hex">8D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CXTimesFourPlusSI">
		<xsl:element name="prg:hex">8E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CXTimesFourPlusDI">
		<xsl:element name="prg:hex">8F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DXTimesFourPlusAX">
		<xsl:element name="prg:hex">90</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DXTimesFourPlusCX">
		<xsl:element name="prg:hex">91</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DXTimesFourPlusDX">
		<xsl:element name="prg:hex">92</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DXTimesFourPlusBX">
		<xsl:element name="prg:hex">93</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DXTimesFourPlusSP">
		<xsl:element name="prg:hex">94</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DXTimesFourPlusBP">
		<xsl:element name="prg:hex">95</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DXTimesFourPlusImmediate32">
		<xsl:element name="prg:hex">95</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DXTimesFourPlusSI">
		<xsl:element name="prg:hex">96</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DXTimesFourPlusDI">
		<xsl:element name="prg:hex">97</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BXTimesFourPlusAX">
		<xsl:element name="prg:hex">98</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BXTimesFourPlusCX">
		<xsl:element name="prg:hex">99</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BXTimesFourPlusDX">
		<xsl:element name="prg:hex">9A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BXTimesFourPlusBX">
		<xsl:element name="prg:hex">9B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BXTimesFourPlusSP">
		<xsl:element name="prg:hex">9C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BXTimesFourPlusBP">
		<xsl:element name="prg:hex">9D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BXTimesFourPlusImmediate32">
		<xsl:element name="prg:hex">9D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BXTimesFourPlusSI">
		<xsl:element name="prg:hex">9E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BXTimesFourPlusDI">
		<xsl:element name="prg:hex">9F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BPTimesFourPlusAX">
		<xsl:element name="prg:hex">A8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BPTimesFourPlusCX">
		<xsl:element name="prg:hex">A9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BPTimesFourPlusDX">
		<xsl:element name="prg:hex">AA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BPTimesFourPlusBX">
		<xsl:element name="prg:hex">AB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BPTimesFourPlusSP">
		<xsl:element name="prg:hex">AC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BPTimesFourPlusBP">
		<xsl:element name="prg:hex">AD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BPTimesFourPlusImmediate32">
		<xsl:element name="prg:hex">AD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BPTimesFourPlusSI">
		<xsl:element name="prg:hex">AE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BPTimesFourPlusDI">
		<xsl:element name="prg:hex">AF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SITimesFourPlusAX">
		<xsl:element name="prg:hex">B0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SITimesFourPlusCX">
		<xsl:element name="prg:hex">B1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SITimesFourPlusDX">
		<xsl:element name="prg:hex">B2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SITimesFourPlusBX">
		<xsl:element name="prg:hex">B3</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SITimesFourPlusSP">
		<xsl:element name="prg:hex">B4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SITimesFourPlusBP">
		<xsl:element name="prg:hex">B5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SITimesFourPlusImmediate32">
		<xsl:element name="prg:hex">B5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SITimesFourPlusSI">
		<xsl:element name="prg:hex">B6</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SITimesFourPlusDI">
		<xsl:element name="prg:hex">B7</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DITimesFourPlusAX">
		<xsl:element name="prg:hex">B8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DITimesFourPlusCX">
		<xsl:element name="prg:hex">B9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DITimesFourPlusDX">
		<xsl:element name="prg:hex">BA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DITimesFourPlusBX">
		<xsl:element name="prg:hex">BB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DITimesFourPlusSP">
		<xsl:element name="prg:hex">BC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DITimesFourPlusBP">
		<xsl:element name="prg:hex">BD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DITimesFourPlusImmediate32">
		<xsl:element name="prg:hex">BD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DITimesFourPlusSI">
		<xsl:element name="prg:hex">BE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DITimesFourPlusDI">
		<xsl:element name="prg:hex">BF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AXTimesEightPlusAX">
		<xsl:element name="prg:hex">C0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AXTimesEightPlusCX">
		<xsl:element name="prg:hex">C1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AXTimesEightPlusDX">
		<xsl:element name="prg:hex">C2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AXTimesEightPlusBX">
		<xsl:element name="prg:hex">C3</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AXTimesEightPlusSP">
		<xsl:element name="prg:hex">C4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AXTimesEightPlusBP">
		<xsl:element name="prg:hex">C5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AXTimesEightPlusImmediate32">
		<xsl:element name="prg:hex">C5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AXTimesEightPlusSI">
		<xsl:element name="prg:hex">C6</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AXTimesEightPlusDI">
		<xsl:element name="prg:hex">C7</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CXTimesEightPlusAX">
		<xsl:element name="prg:hex">C8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CXTimesEightPlusCX">
		<xsl:element name="prg:hex">C9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CXTimesEightPlusDX">
		<xsl:element name="prg:hex">CA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CXTimesEightPlusBX">
		<xsl:element name="prg:hex">CB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CXTimesEightPlusSP">
		<xsl:element name="prg:hex">CC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CXTimesEightPlusBP">
		<xsl:element name="prg:hex">CD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CXTimesEightPlusImmediate32">
		<xsl:element name="prg:hex">CD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CXTimesEightPlusSI">
		<xsl:element name="prg:hex">CE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CXTimesEightPlusDI">
		<xsl:element name="prg:hex">CF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DXTimesEightPlusAX">
		<xsl:element name="prg:hex">D0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DXTimesEightPlusCX">
		<xsl:element name="prg:hex">D1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DXTimesEightPlusDX">
		<xsl:element name="prg:hex">D2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DXTimesEightPlusBX">
		<xsl:element name="prg:hex">D3</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DXTimesEightPlusSP">
		<xsl:element name="prg:hex">D4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DXTimesEightPlusBP">
		<xsl:element name="prg:hex">D5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DXTimesEightPlusImmediate32">
		<xsl:element name="prg:hex">D5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DXTimesEightPlusSI">
		<xsl:element name="prg:hex">D6</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DXTimesEightPlusDI">
		<xsl:element name="prg:hex">D7</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BXTimesEightPlusAX">
		<xsl:element name="prg:hex">D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BXTimesEightPlusCX">
		<xsl:element name="prg:hex">D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BXTimesEightPlusDX">
		<xsl:element name="prg:hex">DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BXTimesEightPlusBX">
		<xsl:element name="prg:hex">DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BXTimesEightPlusSP">
		<xsl:element name="prg:hex">DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BXTimesEightPlusBP">
		<xsl:element name="prg:hex">DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BXTimesEightPlusImmediate32">
		<xsl:element name="prg:hex">DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BXTimesEightPlusSI">
		<xsl:element name="prg:hex">DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BXTimesEightPlusDI">
		<xsl:element name="prg:hex">DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BPTimesEightPlusAX">
		<xsl:element name="prg:hex">E8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BPTimesEightPlusCX">
		<xsl:element name="prg:hex">E9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BPTimesEightPlusDX">
		<xsl:element name="prg:hex">EA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BPTimesEightPlusBX">
		<xsl:element name="prg:hex">EB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BPTimesEightPlusSP">
		<xsl:element name="prg:hex">EC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BPTimesEightPlusBP">
		<xsl:element name="prg:hex">ED</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BPTimesEightPlusImmediate32">
		<xsl:element name="prg:hex">ED</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BPTimesEightPlusSI">
		<xsl:element name="prg:hex">EE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BPTimesEightPlusDI">
		<xsl:element name="prg:hex">EF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SITimesEightPlusAX">
		<xsl:element name="prg:hex">F0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SITimesEightPlusCX">
		<xsl:element name="prg:hex">F1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SITimesEightPlusDX">
		<xsl:element name="prg:hex">F2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SITimesEightPlusBX">
		<xsl:element name="prg:hex">F3</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SITimesEightPlusSP">
		<xsl:element name="prg:hex">F4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SITimesEightPlusBP">
		<xsl:element name="prg:hex">F5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SITimesEightPlusImmediate32">
		<xsl:element name="prg:hex">F5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SITimesEightPlusSI">
		<xsl:element name="prg:hex">F6</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SITimesEightPlusDI">
		<xsl:element name="prg:hex">F7</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DITimesEightPlusAX">
		<xsl:element name="prg:hex">F8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DITimesEightPlusCX">
		<xsl:element name="prg:hex">F9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DITimesEightPlusDX">
		<xsl:element name="prg:hex">FA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DITimesEightPlusBX">
		<xsl:element name="prg:hex">FB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DITimesEightPlusSP">
		<xsl:element name="prg:hex">FC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DITimesEightPlusBP">
		<xsl:element name="prg:hex">FD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DITimesEightPlusImmediate32">
		<xsl:element name="prg:hex">FD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DITimesEightPlusSI">
		<xsl:element name="prg:hex">FE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DITimesEightPlusDI">
		<xsl:element name="prg:hex">FF</xsl:element>
	</xsl:template>
</xsl:stylesheet>