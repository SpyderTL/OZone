<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:keys="http://metalx.org/Pc/Keys">
  <xsl:output method="xml" indent="yes" />
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="keys:KeyEscape">
    <xsl:element name="hex">01</xsl:element>
  </xsl:template>
  <xsl:template match="keys:Key1">
    <xsl:element name="hex">02</xsl:element>
  </xsl:template>
  <xsl:template match="keys:Key2">
    <xsl:element name="hex">03</xsl:element>
  </xsl:template>
  <xsl:template match="keys:Key3">
    <xsl:element name="hex">04</xsl:element>
  </xsl:template>
  <xsl:template match="keys:Key4">
    <xsl:element name="hex">05</xsl:element>
  </xsl:template>
  <xsl:template match="keys:Key5">
    <xsl:element name="hex">06</xsl:element>
  </xsl:template>
  <xsl:template match="keys:Key6">
    <xsl:element name="hex">07</xsl:element>
  </xsl:template>
  <xsl:template match="keys:Key7">
    <xsl:element name="hex">08</xsl:element>
  </xsl:template>
  <xsl:template match="keys:Key8">
    <xsl:element name="hex">09</xsl:element>
  </xsl:template>
  <xsl:template match="keys:Key9">
    <xsl:element name="hex">0A</xsl:element>
  </xsl:template>
  <xsl:template match="keys:Key0">
    <xsl:element name="hex">0B</xsl:element>
  </xsl:template>
  <xsl:template match="keys:KeyMinus">
    <xsl:element name="hex">0C</xsl:element>
  </xsl:template>
  <xsl:template match="keys:KeyUnderscore">
    <xsl:element name="hex">0C</xsl:element>
  </xsl:template>
  <xsl:template match="keys:KeyEquals">
    <xsl:element name="hex">0D</xsl:element>
  </xsl:template>
  <xsl:template match="keys:KeyPlus">
    <xsl:element name="hex">0D</xsl:element>
  </xsl:template>
  <xsl:template match="keys:KeyBackspace">
    <xsl:element name="hex">0E</xsl:element>
  </xsl:template>
  <xsl:template match="keys:KeyTab">
    <xsl:element name="hex">0F</xsl:element>
  </xsl:template>
  <xsl:template match="keys:KeyQ">
    <xsl:element name="hex">10</xsl:element>
  </xsl:template>
  <xsl:template match="keys:KeyW">
    <xsl:element name="hex">11</xsl:element>
  </xsl:template>
  <xsl:template match="keys:KeyE">
    <xsl:element name="hex">12</xsl:element>
  </xsl:template>
  <xsl:template match="keys:KeyR">
    <xsl:element name="hex">13</xsl:element>
  </xsl:template>
  <xsl:template match="keys:KeyT">
    <xsl:element name="hex">14</xsl:element>
  </xsl:template>
  <xsl:template match="keys:KeyY">
    <xsl:element name="hex">15</xsl:element>
  </xsl:template>
  <xsl:template match="keys:KeyU">
    <xsl:element name="hex">16</xsl:element>
  </xsl:template>
  <xsl:template match="keys:KeyI">
    <xsl:element name="hex">17</xsl:element>
  </xsl:template>
  <xsl:template match="keys:KeyO">
    <xsl:element name="hex">18</xsl:element>
  </xsl:template>
  <xsl:template match="keys:KeyP">
    <xsl:element name="hex">19</xsl:element>
  </xsl:template>
  <xsl:template match="keys:KeyLeftBracket">
    <xsl:element name="hex">1A</xsl:element>
  </xsl:template>
  <xsl:template match="keys:KeyLeftCurlyBrace">
    <xsl:element name="hex">1A</xsl:element>
  </xsl:template>
  <xsl:template match="keys:KeyRightBracket">
    <xsl:element name="hex">1B</xsl:element>
  </xsl:template>
  <xsl:template match="keys:KeyRightCurlyBrace">
    <xsl:element name="hex">1B</xsl:element>
  </xsl:template>
  <xsl:template match="keys:KeyEnter">
    <xsl:element name="hex">1C</xsl:element>
  </xsl:template>
  <xsl:template match="keys:KeyLeftControl">
    <xsl:element name="hex">1D</xsl:element>
  </xsl:template>
  <xsl:template match="keys:KeyA">
    <xsl:element name="hex">1E</xsl:element>
  </xsl:template>
  <xsl:template match="keys:KeyS">
    <xsl:element name="hex">1F</xsl:element>
  </xsl:template>
  <xsl:template match="keys:KeyD">
    <xsl:element name="hex">20</xsl:element>
  </xsl:template>
  <xsl:template match="keys:KeyF">
    <xsl:element name="hex">21</xsl:element>
  </xsl:template>
  <xsl:template match="keys:KeyG">
    <xsl:element name="hex">22</xsl:element>
  </xsl:template>
  <xsl:template match="keys:KeyH">
    <xsl:element name="hex">23</xsl:element>
  </xsl:template>
  <xsl:template match="keys:KeyJ">
    <xsl:element name="hex">24</xsl:element>
  </xsl:template>
  <xsl:template match="keys:KeyK">
    <xsl:element name="hex">25</xsl:element>
  </xsl:template>
  <xsl:template match="keys:KeyL">
    <xsl:element name="hex">26</xsl:element>
  </xsl:template>
  <xsl:template match="keys:KeySemicolon">
    <xsl:element name="hex">27</xsl:element>
  </xsl:template>
  <xsl:template match="keys:KeyColon">
    <xsl:element name="hex">27</xsl:element>
  </xsl:template>
  <xsl:template match="keys:KeySingleQuote">
    <xsl:element name="hex">28</xsl:element>
  </xsl:template>
  <xsl:template match="keys:KeyDoubleQuote">
    <xsl:element name="hex">28</xsl:element>
  </xsl:template>
</xsl:stylesheet>