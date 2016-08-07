<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:asc="http://metalx.org/Ansi/Ascii">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="asc:Null">
		<xsl:element name="hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="asc:Beep">
		<xsl:element name="hex">07</xsl:element>
	</xsl:template>
	<xsl:template match="asc:Backspace">
		<xsl:element name="hex">08</xsl:element>
	</xsl:template>
	<xsl:template match="asc:Tab">
		<xsl:element name="hex">09</xsl:element>
	</xsl:template>
	<xsl:template match="asc:LineFeed">
		<xsl:element name="hex">0A</xsl:element>
	</xsl:template>
	<xsl:template match="asc:CarriageReturn">
		<xsl:element name="hex">0D</xsl:element>
	</xsl:template>
	<xsl:template match="asc:Escape">
		<xsl:element name="hex">1B</xsl:element>
	</xsl:template>
	<xsl:template match="asc:Delete">
		<xsl:element name="hex">7F</xsl:element>
	</xsl:template>
	<xsl:template match="asc:Space">
		<xsl:element name="hex">20</xsl:element>
	</xsl:template>
	<xsl:template match="asc:Exclamation">
		<xsl:element name="hex">21</xsl:element>
	</xsl:template>
	<xsl:template match="asc:Quote">
		<xsl:element name="hex">22</xsl:element>
	</xsl:template>
	<xsl:template match="asc:Pound">
		<xsl:element name="hex">23</xsl:element>
	</xsl:template>
	<xsl:template match="asc:Dollar">
		<xsl:element name="hex">24</xsl:element>
	</xsl:template>
	<xsl:template match="asc:Percent">
		<xsl:element name="hex">25</xsl:element>
	</xsl:template>
	<xsl:template match="asc:Ampersand">
		<xsl:element name="hex">26</xsl:element>
	</xsl:template>
	<xsl:template match="asc:Apostrophe">
		<xsl:element name="hex">27</xsl:element>
	</xsl:template>
	<xsl:template match="asc:LeftParenthesis">
		<xsl:element name="hex">28</xsl:element>
	</xsl:template>
	<xsl:template match="asc:RightParenthesis">
		<xsl:element name="hex">29</xsl:element>
	</xsl:template>
	<xsl:template match="asc:Asterisk">
		<xsl:element name="hex">2A</xsl:element>
	</xsl:template>
	<xsl:template match="asc:Plus">
		<xsl:element name="hex">2B</xsl:element>
	</xsl:template>
	<xsl:template match="asc:Comma">
		<xsl:element name="hex">2C</xsl:element>
	</xsl:template>
	<xsl:template match="asc:Minus">
		<xsl:element name="hex">2D</xsl:element>
	</xsl:template>
	<xsl:template match="asc:Period">
		<xsl:element name="hex">2E</xsl:element>
	</xsl:template>
	<xsl:template match="asc:Slash">
		<xsl:element name="hex">2F</xsl:element>
	</xsl:template>
	<xsl:template match="asc:Zero">
		<xsl:element name="hex">30</xsl:element>
	</xsl:template>
	<xsl:template match="asc:One">
		<xsl:element name="hex">31</xsl:element>
	</xsl:template>
	<xsl:template match="asc:Two">
		<xsl:element name="hex">32</xsl:element>
	</xsl:template>
	<xsl:template match="asc:Three">
		<xsl:element name="hex">33</xsl:element>
	</xsl:template>
	<xsl:template match="asc:Four">
		<xsl:element name="hex">34</xsl:element>
	</xsl:template>
	<xsl:template match="asc:Five">
		<xsl:element name="hex">35</xsl:element>
	</xsl:template>
	<xsl:template match="asc:Six">
		<xsl:element name="hex">36</xsl:element>
	</xsl:template>
	<xsl:template match="asc:Seven">
		<xsl:element name="hex">37</xsl:element>
	</xsl:template>
	<xsl:template match="asc:Eight">
		<xsl:element name="hex">38</xsl:element>
	</xsl:template>
	<xsl:template match="asc:Nine">
		<xsl:element name="hex">39</xsl:element>
	</xsl:template>
	<xsl:template match="asc:Colon">
		<xsl:element name="hex">3A</xsl:element>
	</xsl:template>
	<xsl:template match="asc:Simicolon">
		<xsl:element name="hex">3B</xsl:element>
	</xsl:template>
	<xsl:template match="asc:LessThan">
		<xsl:element name="hex">3C</xsl:element>
	</xsl:template>
	<xsl:template match="asc:Equal">
		<xsl:element name="hex">3D</xsl:element>
	</xsl:template>
	<xsl:template match="asc:GreaterThan">
		<xsl:element name="hex">3E</xsl:element>
	</xsl:template>
	<xsl:template match="asc:Question">
		<xsl:element name="hex">3F</xsl:element>
	</xsl:template>
	<xsl:template match="asc:At">
		<xsl:element name="hex">40</xsl:element>
	</xsl:template>
	<xsl:template match="asc:A">
		<xsl:element name="hex">41</xsl:element>
	</xsl:template>
	<xsl:template match="asc:B">
		<xsl:element name="hex">42</xsl:element>
	</xsl:template>
	<xsl:template match="asc:C">
		<xsl:element name="hex">43</xsl:element>
	</xsl:template>
	<xsl:template match="asc:D">
		<xsl:element name="hex">44</xsl:element>
	</xsl:template>
	<xsl:template match="asc:E">
		<xsl:element name="hex">45</xsl:element>
	</xsl:template>
	<xsl:template match="asc:F">
		<xsl:element name="hex">46</xsl:element>
	</xsl:template>
	<xsl:template match="asc:G">
		<xsl:element name="hex">47</xsl:element>
	</xsl:template>
	<xsl:template match="asc:H">
		<xsl:element name="hex">48</xsl:element>
	</xsl:template>
	<xsl:template match="asc:I">
		<xsl:element name="hex">49</xsl:element>
	</xsl:template>
	<xsl:template match="asc:J">
		<xsl:element name="hex">4A</xsl:element>
	</xsl:template>
	<xsl:template match="asc:K">
		<xsl:element name="hex">4B</xsl:element>
	</xsl:template>
	<xsl:template match="asc:L">
		<xsl:element name="hex">4C</xsl:element>
	</xsl:template>
	<xsl:template match="asc:M">
		<xsl:element name="hex">4D</xsl:element>
	</xsl:template>
	<xsl:template match="asc:N">
		<xsl:element name="hex">4E</xsl:element>
	</xsl:template>
	<xsl:template match="asc:O">
		<xsl:element name="hex">4F</xsl:element>
	</xsl:template>
	<xsl:template match="asc:P">
		<xsl:element name="hex">50</xsl:element>
	</xsl:template>
	<xsl:template match="asc:Q">
		<xsl:element name="hex">51</xsl:element>
	</xsl:template>
	<xsl:template match="asc:R">
		<xsl:element name="hex">52</xsl:element>
	</xsl:template>
	<xsl:template match="asc:S">
		<xsl:element name="hex">53</xsl:element>
	</xsl:template>
	<xsl:template match="asc:T">
		<xsl:element name="hex">54</xsl:element>
	</xsl:template>
	<xsl:template match="asc:U">
		<xsl:element name="hex">55</xsl:element>
	</xsl:template>
	<xsl:template match="asc:V">
		<xsl:element name="hex">56</xsl:element>
	</xsl:template>
	<xsl:template match="asc:W">
		<xsl:element name="hex">57</xsl:element>
	</xsl:template>
	<xsl:template match="asc:X">
		<xsl:element name="hex">58</xsl:element>
	</xsl:template>
	<xsl:template match="asc:Y">
		<xsl:element name="hex">59</xsl:element>
	</xsl:template>
	<xsl:template match="asc:Z">
		<xsl:element name="hex">5A</xsl:element>
	</xsl:template>
	<xsl:template match="asc:LeftBracket">
		<xsl:element name="hex">5B</xsl:element>
	</xsl:template>
	<xsl:template match="asc:Backslash">
		<xsl:element name="hex">5C</xsl:element>
	</xsl:template>
	<xsl:template match="asc:RightBracket">
		<xsl:element name="hex">5D</xsl:element>
	</xsl:template>
	<xsl:template match="asc:Caret">
		<xsl:element name="hex">5E</xsl:element>
	</xsl:template>
	<xsl:template match="asc:Underscore">
		<xsl:element name="hex">5F</xsl:element>
	</xsl:template>
	<xsl:template match="asc:Grave">
		<xsl:element name="hex">60</xsl:element>
	</xsl:template>
	<xsl:template match="asc:a">
		<xsl:element name="hex">61</xsl:element>
	</xsl:template>
	<xsl:template match="asc:b">
		<xsl:element name="hex">62</xsl:element>
	</xsl:template>
	<xsl:template match="asc:c">
		<xsl:element name="hex">63</xsl:element>
	</xsl:template>
	<xsl:template match="asc:d">
		<xsl:element name="hex">64</xsl:element>
	</xsl:template>
	<xsl:template match="asc:e">
		<xsl:element name="hex">65</xsl:element>
	</xsl:template>
	<xsl:template match="asc:f">
		<xsl:element name="hex">66</xsl:element>
	</xsl:template>
	<xsl:template match="asc:g">
		<xsl:element name="hex">67</xsl:element>
	</xsl:template>
	<xsl:template match="asc:h">
		<xsl:element name="hex">68</xsl:element>
	</xsl:template>
	<xsl:template match="asc:i">
		<xsl:element name="hex">69</xsl:element>
	</xsl:template>
	<xsl:template match="asc:j">
		<xsl:element name="hex">6A</xsl:element>
	</xsl:template>
	<xsl:template match="asc:k">
		<xsl:element name="hex">6B</xsl:element>
	</xsl:template>
	<xsl:template match="asc:l">
		<xsl:element name="hex">6C</xsl:element>
	</xsl:template>
	<xsl:template match="asc:m">
		<xsl:element name="hex">6D</xsl:element>
	</xsl:template>
	<xsl:template match="asc:n">
		<xsl:element name="hex">6E</xsl:element>
	</xsl:template>
	<xsl:template match="asc:o">
		<xsl:element name="hex">6F</xsl:element>
	</xsl:template>
	<xsl:template match="asc:p">
		<xsl:element name="hex">70</xsl:element>
	</xsl:template>
	<xsl:template match="asc:q">
		<xsl:element name="hex">71</xsl:element>
	</xsl:template>
	<xsl:template match="asc:r">
		<xsl:element name="hex">72</xsl:element>
	</xsl:template>
	<xsl:template match="asc:s">
		<xsl:element name="hex">73</xsl:element>
	</xsl:template>
	<xsl:template match="asc:t">
		<xsl:element name="hex">74</xsl:element>
	</xsl:template>
	<xsl:template match="asc:u">
		<xsl:element name="hex">75</xsl:element>
	</xsl:template>
	<xsl:template match="asc:v">
		<xsl:element name="hex">76</xsl:element>
	</xsl:template>
	<xsl:template match="asc:w">
		<xsl:element name="hex">77</xsl:element>
	</xsl:template>
	<xsl:template match="asc:x">
		<xsl:element name="hex">78</xsl:element>
	</xsl:template>
	<xsl:template match="asc:y">
		<xsl:element name="hex">79</xsl:element>
	</xsl:template>
	<xsl:template match="asc:z">
		<xsl:element name="hex">7A</xsl:element>
	</xsl:template>
	<xsl:template match="asc:LeftBrace">
		<xsl:element name="hex">7B</xsl:element>
	</xsl:template>
	<xsl:template match="asc:Pipe">
		<xsl:element name="hex">7C</xsl:element>
	</xsl:template>
	<xsl:template match="asc:RightBrace">
		<xsl:element name="hex">7D</xsl:element>
	</xsl:template>
	<xsl:template match="asc:Tilde">
		<xsl:element name="hex">7E</xsl:element>
	</xsl:template>
</xsl:stylesheet>