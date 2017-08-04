<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:ns="http://metalx.org/Commodore64/Petscii" xmlns:prg="http://metalx.org/Program" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="ns:Stop">
		<xsl:element name="prg:hex">03</xsl:element>
	</xsl:template>
	<xsl:template match="ns:White">
		<xsl:element name="prg:hex">05</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Disable">
		<xsl:element name="prg:hex">08</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Enable">
		<xsl:element name="prg:hex">09</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Return">
		<xsl:element name="prg:hex">13</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CharacterSet2">
		<xsl:element name="prg:hex">0e</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CursorDown">
		<xsl:element name="prg:hex">11</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ReverseOn">
		<xsl:element name="prg:hex">12</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Home">
		<xsl:element name="prg:hex">13</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Delete">
		<xsl:element name="prg:hex">14</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Red">
		<xsl:element name="prg:hex">1c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CursorRight">
		<xsl:element name="prg:hex">1d</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Green">
		<xsl:element name="prg:hex">1e</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Blue">
		<xsl:element name="prg:hex">1f</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Space">
		<xsl:element name="prg:hex">20</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Exclamation">
		<xsl:element name="prg:hex">21</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DoubleQuote">
		<xsl:element name="prg:hex">22</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Hash">
		<xsl:element name="prg:hex">23</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Dollar">
		<xsl:element name="prg:hex">24</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Percent">
		<xsl:element name="prg:hex">25</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Ampersand">
		<xsl:element name="prg:hex">26</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Apostrophe">
		<xsl:element name="prg:hex">27</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LeftParenthesis">
		<xsl:element name="prg:hex">28</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RightParenthesis">
		<xsl:element name="prg:hex">29</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Asterisk">
		<xsl:element name="prg:hex">2a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Plus">
		<xsl:element name="prg:hex">2b</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Comma">
		<xsl:element name="prg:hex">2c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Minus">
		<xsl:element name="prg:hex">2d</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Period">
		<xsl:element name="prg:hex">2e</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Slash">
		<xsl:element name="prg:hex">2f</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Zero">
		<xsl:element name="prg:hex">30</xsl:element>
	</xsl:template>
	<xsl:template match="ns:One">
		<xsl:element name="prg:hex">31</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Two">
		<xsl:element name="prg:hex">32</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Three">
		<xsl:element name="prg:hex">33</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Four">
		<xsl:element name="prg:hex">34</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Five">
		<xsl:element name="prg:hex">35</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Six">
		<xsl:element name="prg:hex">36</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Seven">
		<xsl:element name="prg:hex">37</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Eight">
		<xsl:element name="prg:hex">38</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Nine">
		<xsl:element name="prg:hex">39</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Colon">
		<xsl:element name="prg:hex">3a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Semicolon">
		<xsl:element name="prg:hex">3b</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LessThan">
		<xsl:element name="prg:hex">3c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Equals">
		<xsl:element name="prg:hex">3d</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GreaterThan">
		<xsl:element name="prg:hex">3e</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Question">
		<xsl:element name="prg:hex">3f</xsl:element>
	</xsl:template>
	<xsl:template match="ns:At">
		<xsl:element name="prg:hex">40</xsl:element>
	</xsl:template>
	<xsl:template match="ns:a">
		<xsl:element name="prg:hex">41</xsl:element>
	</xsl:template>
	<xsl:template match="ns:b">
		<xsl:element name="prg:hex">42</xsl:element>
	</xsl:template>
	<xsl:template match="ns:c">
		<xsl:element name="prg:hex">43</xsl:element>
	</xsl:template>
	<xsl:template match="ns:d">
		<xsl:element name="prg:hex">44</xsl:element>
	</xsl:template>
	<xsl:template match="ns:e">
		<xsl:element name="prg:hex">45</xsl:element>
	</xsl:template>
	<xsl:template match="ns:f">
		<xsl:element name="prg:hex">46</xsl:element>
	</xsl:template>
	<xsl:template match="ns:g">
		<xsl:element name="prg:hex">47</xsl:element>
	</xsl:template>
	<xsl:template match="ns:h">
		<xsl:element name="prg:hex">48</xsl:element>
	</xsl:template>
	<xsl:template match="ns:i">
		<xsl:element name="prg:hex">49</xsl:element>
	</xsl:template>
	<xsl:template match="ns:j">
		<xsl:element name="prg:hex">4a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:k">
		<xsl:element name="prg:hex">4b</xsl:element>
	</xsl:template>
	<xsl:template match="ns:l">
		<xsl:element name="prg:hex">4c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:m">
		<xsl:element name="prg:hex">4d</xsl:element>
	</xsl:template>
	<xsl:template match="ns:n">
		<xsl:element name="prg:hex">4e</xsl:element>
	</xsl:template>
	<xsl:template match="ns:o">
		<xsl:element name="prg:hex">4f</xsl:element>
	</xsl:template>
	<xsl:template match="ns:p">
		<xsl:element name="prg:hex">50</xsl:element>
	</xsl:template>
	<xsl:template match="ns:q">
		<xsl:element name="prg:hex">51</xsl:element>
	</xsl:template>
	<xsl:template match="ns:r">
		<xsl:element name="prg:hex">52</xsl:element>
	</xsl:template>
	<xsl:template match="ns:s">
		<xsl:element name="prg:hex">53</xsl:element>
	</xsl:template>
	<xsl:template match="ns:t">
		<xsl:element name="prg:hex">54</xsl:element>
	</xsl:template>
	<xsl:template match="ns:u">
		<xsl:element name="prg:hex">55</xsl:element>
	</xsl:template>
	<xsl:template match="ns:v">
		<xsl:element name="prg:hex">56</xsl:element>
	</xsl:template>
	<xsl:template match="ns:w">
		<xsl:element name="prg:hex">57</xsl:element>
	</xsl:template>
	<xsl:template match="ns:x">
		<xsl:element name="prg:hex">58</xsl:element>
	</xsl:template>
	<xsl:template match="ns:y">
		<xsl:element name="prg:hex">59</xsl:element>
	</xsl:template>
	<xsl:template match="ns:z">
		<xsl:element name="prg:hex">5a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LeftBracket">
		<xsl:element name="prg:hex">5b</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Pound">
		<xsl:element name="prg:hex">5c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RightBracket">
		<xsl:element name="prg:hex">5d</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ArrowUp">
		<xsl:element name="prg:hex">5e</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ArrowLeft">
		<xsl:element name="prg:hex">5f</xsl:element>
	</xsl:template>
	<xsl:template match="ns:A">
		<xsl:element name="prg:hex">61</xsl:element>
	</xsl:template>
	<xsl:template match="ns:B">
		<xsl:element name="prg:hex">62</xsl:element>
	</xsl:template>
	<xsl:template match="ns:C">
		<xsl:element name="prg:hex">63</xsl:element>
	</xsl:template>
	<xsl:template match="ns:D">
		<xsl:element name="prg:hex">64</xsl:element>
	</xsl:template>
	<xsl:template match="ns:E">
		<xsl:element name="prg:hex">65</xsl:element>
	</xsl:template>
	<xsl:template match="ns:F">
		<xsl:element name="prg:hex">66</xsl:element>
	</xsl:template>
	<xsl:template match="ns:G">
		<xsl:element name="prg:hex">67</xsl:element>
	</xsl:template>
	<xsl:template match="ns:H">
		<xsl:element name="prg:hex">68</xsl:element>
	</xsl:template>
	<xsl:template match="ns:I">
		<xsl:element name="prg:hex">69</xsl:element>
	</xsl:template>
	<xsl:template match="ns:J">
		<xsl:element name="prg:hex">6a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:K">
		<xsl:element name="prg:hex">6b</xsl:element>
	</xsl:template>
	<xsl:template match="ns:L">
		<xsl:element name="prg:hex">6c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:M">
		<xsl:element name="prg:hex">6d</xsl:element>
	</xsl:template>
	<xsl:template match="ns:N">
		<xsl:element name="prg:hex">6e</xsl:element>
	</xsl:template>
	<xsl:template match="ns:O">
		<xsl:element name="prg:hex">6f</xsl:element>
	</xsl:template>
	<xsl:template match="ns:P">
		<xsl:element name="prg:hex">70</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Q">
		<xsl:element name="prg:hex">71</xsl:element>
	</xsl:template>
	<xsl:template match="ns:R">
		<xsl:element name="prg:hex">72</xsl:element>
	</xsl:template>
	<xsl:template match="ns:S">
		<xsl:element name="prg:hex">73</xsl:element>
	</xsl:template>
	<xsl:template match="ns:T">
		<xsl:element name="prg:hex">74</xsl:element>
	</xsl:template>
	<xsl:template match="ns:U">
		<xsl:element name="prg:hex">75</xsl:element>
	</xsl:template>
	<xsl:template match="ns:V">
		<xsl:element name="prg:hex">76</xsl:element>
	</xsl:template>
	<xsl:template match="ns:W">
		<xsl:element name="prg:hex">77</xsl:element>
	</xsl:template>
	<xsl:template match="ns:X">
		<xsl:element name="prg:hex">78</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Y">
		<xsl:element name="prg:hex">79</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Z">
		<xsl:element name="prg:hex">7a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Orange">
		<xsl:element name="prg:hex">81</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Run">
		<xsl:element name="prg:hex">83</xsl:element>
	</xsl:template>
	<xsl:template match="ns:F1">
		<xsl:element name="prg:hex">85</xsl:element>
	</xsl:template>
	<xsl:template match="ns:F3">
		<xsl:element name="prg:hex">86</xsl:element>
	</xsl:template>
	<xsl:template match="ns:F5">
		<xsl:element name="prg:hex">87</xsl:element>
	</xsl:template>
	<xsl:template match="ns:F7">
		<xsl:element name="prg:hex">88</xsl:element>
	</xsl:template>
	<xsl:template match="ns:F2">
		<xsl:element name="prg:hex">89</xsl:element>
	</xsl:template>
	<xsl:template match="ns:F4">
		<xsl:element name="prg:hex">8a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:F6">
		<xsl:element name="prg:hex">8b</xsl:element>
	</xsl:template>
	<xsl:template match="ns:F8">
		<xsl:element name="prg:hex">8c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftReturn">
		<xsl:element name="prg:hex">8d</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CharacterSet1">
		<xsl:element name="prg:hex">8e</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Black">
		<xsl:element name="prg:hex">90</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CursorUp">
		<xsl:element name="prg:hex">91</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ReverseOff">
		<xsl:element name="prg:hex">92</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Clear">
		<xsl:element name="prg:hex">93</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Insert">
		<xsl:element name="prg:hex">94</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Brown">
		<xsl:element name="prg:hex">95</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Pink">
		<xsl:element name="prg:hex">96</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DarkGray">
		<xsl:element name="prg:hex">97</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Gray">
		<xsl:element name="prg:hex">98</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LightGreen">
		<xsl:element name="prg:hex">99</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LightBlue">
		<xsl:element name="prg:hex">9a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LightGray">
		<xsl:element name="prg:hex">9b</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Purple">
		<xsl:element name="prg:hex">9c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CursorLeft">
		<xsl:element name="prg:hex">9d</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Yellow">
		<xsl:element name="prg:hex">9e</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Cyan">
		<xsl:element name="prg:hex">9f</xsl:element>
	</xsl:template>
</xsl:stylesheet>