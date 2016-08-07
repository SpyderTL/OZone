<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ns="http://metalx.org/Pc/Keyboard/ScanCodes" xmlns:prg="http://metalx.org/Program">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="ns:Error">
		<xsl:element name="prg:hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Escape">
		<xsl:element name="prg:hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="ns:One">
		<xsl:element name="prg:hex">02</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Two">
		<xsl:element name="prg:hex">03</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Three">
		<xsl:element name="prg:hex">04</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Four">
		<xsl:element name="prg:hex">05</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Five">
		<xsl:element name="prg:hex">06</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Six">
		<xsl:element name="prg:hex">07</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Seven">
		<xsl:element name="prg:hex">08</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Eight">
		<xsl:element name="prg:hex">09</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Nine">
		<xsl:element name="prg:hex">0A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Zero">
		<xsl:element name="prg:hex">0B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Minus">
		<xsl:element name="prg:hex">0C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Equals">
		<xsl:element name="prg:hex">0D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Backspace">
		<xsl:element name="prg:hex">0E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Tab">
		<xsl:element name="prg:hex">0F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Q">
		<xsl:element name="prg:hex">10</xsl:element>
	</xsl:template>
	<xsl:template match="ns:W">
		<xsl:element name="prg:hex">11</xsl:element>
	</xsl:template>
	<xsl:template match="ns:E">
		<xsl:element name="prg:hex">12</xsl:element>
	</xsl:template>
	<xsl:template match="ns:R">
		<xsl:element name="prg:hex">13</xsl:element>
	</xsl:template>
	<xsl:template match="ns:T">
		<xsl:element name="prg:hex">14</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Y">
		<xsl:element name="prg:hex">15</xsl:element>
	</xsl:template>
	<xsl:template match="ns:U">
		<xsl:element name="prg:hex">16</xsl:element>
	</xsl:template>
	<xsl:template match="ns:I">
		<xsl:element name="prg:hex">17</xsl:element>
	</xsl:template>
	<xsl:template match="ns:O">
		<xsl:element name="prg:hex">18</xsl:element>
	</xsl:template>
	<xsl:template match="ns:P">
		<xsl:element name="prg:hex">19</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OpenBracket">
		<xsl:element name="prg:hex">1A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CloseBracket">
		<xsl:element name="prg:hex">1B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Enter">
		<xsl:element name="prg:hex">1C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LeftControl">
		<xsl:element name="prg:hex">1D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:A">
		<xsl:element name="prg:hex">1E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:S">
		<xsl:element name="prg:hex">1F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:D">
		<xsl:element name="prg:hex">20</xsl:element>
	</xsl:template>
	<xsl:template match="ns:F">
		<xsl:element name="prg:hex">21</xsl:element>
	</xsl:template>
	<xsl:template match="ns:G">
		<xsl:element name="prg:hex">22</xsl:element>
	</xsl:template>
	<xsl:template match="ns:H">
		<xsl:element name="prg:hex">23</xsl:element>
	</xsl:template>
	<xsl:template match="ns:J">
		<xsl:element name="prg:hex">24</xsl:element>
	</xsl:template>
	<xsl:template match="ns:K">
		<xsl:element name="prg:hex">25</xsl:element>
	</xsl:template>
	<xsl:template match="ns:L">
		<xsl:element name="prg:hex">26</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Semicolon">
		<xsl:element name="prg:hex">27</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SingleQuote">
		<xsl:element name="prg:hex">28</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BackQuote">
		<xsl:element name="prg:hex">29</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LeftShift">
		<xsl:element name="prg:hex">2A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Backslash">
		<xsl:element name="prg:hex">2B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Z">
		<xsl:element name="prg:hex">2C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:X">
		<xsl:element name="prg:hex">2D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:C">
		<xsl:element name="prg:hex">2E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:V">
		<xsl:element name="prg:hex">2F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:B">
		<xsl:element name="prg:hex">30</xsl:element>
	</xsl:template>
	<xsl:template match="ns:N">
		<xsl:element name="prg:hex">31</xsl:element>
	</xsl:template>
	<xsl:template match="ns:M">
		<xsl:element name="prg:hex">32</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Comma">
		<xsl:element name="prg:hex">33</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Period">
		<xsl:element name="prg:hex">34</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Slash">
		<xsl:element name="prg:hex">35</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RightShift">
		<xsl:element name="prg:hex">36</xsl:element>
	</xsl:template>
	<xsl:template match="ns:KeypadAsterisk">
		<xsl:element name="prg:hex">37</xsl:element>
	</xsl:template>
	<xsl:template match="ns:LeftAlternate">
		<xsl:element name="prg:hex">38</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Space">
		<xsl:element name="prg:hex">20</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftLock">
		<xsl:element name="prg:hex">3A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:F1">
		<xsl:element name="prg:hex">3B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:F2">
		<xsl:element name="prg:hex">3C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:F3">
		<xsl:element name="prg:hex">3D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:F4">
		<xsl:element name="prg:hex">3E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:F5">
		<xsl:element name="prg:hex">3F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:F6">
		<xsl:element name="prg:hex">40</xsl:element>
	</xsl:template>
	<xsl:template match="ns:F7">
		<xsl:element name="prg:hex">41</xsl:element>
	</xsl:template>
	<xsl:template match="ns:F8">
		<xsl:element name="prg:hex">42</xsl:element>
	</xsl:template>
	<xsl:template match="ns:F9">
		<xsl:element name="prg:hex">43</xsl:element>
	</xsl:template>
	<xsl:template match="ns:F10">
		<xsl:element name="prg:hex">44</xsl:element>
	</xsl:template>
	<xsl:template match="ns:NumberLock">
		<xsl:element name="prg:hex">45</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ScrollLock">
		<xsl:element name="prg:hex">46</xsl:element>
	</xsl:template>
	<xsl:template match="ns:KeypadSeven">
		<xsl:element name="prg:hex">47</xsl:element>
	</xsl:template>
	<xsl:template match="ns:KeypadEight">
		<xsl:element name="prg:hex">48</xsl:element>
	</xsl:template>
	<xsl:template match="ns:KeypadNine">
		<xsl:element name="prg:hex">49</xsl:element>
	</xsl:template>
	<xsl:template match="ns:KeypadMinus">
		<xsl:element name="prg:hex">4A</xsl:element>
	</xsl:template>
	<xsl:template match="ns:KeypadFour">
		<xsl:element name="prg:hex">4B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:KeypadFive">
		<xsl:element name="prg:hex">4C</xsl:element>
	</xsl:template>
	<xsl:template match="ns:KeypadSix">
		<xsl:element name="prg:hex">4D</xsl:element>
	</xsl:template>
	<xsl:template match="ns:KeypadPlus">
		<xsl:element name="prg:hex">4E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:KeypadOne">
		<xsl:element name="prg:hex">4F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:KeypadTwo">
		<xsl:element name="prg:hex">50</xsl:element>
	</xsl:template>
	<xsl:template match="ns:KeypadThree">
		<xsl:element name="prg:hex">51</xsl:element>
	</xsl:template>
	<xsl:template match="ns:KeypadZero">
		<xsl:element name="prg:hex">52</xsl:element>
	</xsl:template>
	<xsl:template match="ns:KeypadPeriod">
		<xsl:element name="prg:hex">53</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SystemRequest">
		<xsl:element name="prg:hex">54</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Function">
		<xsl:element name="prg:hex">55</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Unlabeled">
		<xsl:element name="prg:hex">56</xsl:element>
	</xsl:template>
	<xsl:template match="ns:F11">
		<xsl:element name="prg:hex">57</xsl:element>
	</xsl:template>
	<xsl:template match="ns:F12">
		<xsl:element name="prg:hex">58</xsl:element>
	</xsl:template>
</xsl:stylesheet>