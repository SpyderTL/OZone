<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:ns="http://metalx.org/Subleq/Console"
	xmlns:sq="http://metalx.org/Subleq"
	xmlns:var="http://metalx.org/Variable"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
  <xsl:output method="xml" indent="yes" />
	
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" />
    </xsl:copy>
  </xsl:template>
	<xsl:template match="ns:Write">
		<scope>
			<sq:CopyIndirect pointer="{@pointer}" destination="characterCount"/>

			<sq:Copy source="{@pointer}" destination="characterPointer"/>

			<sq:Increment value="characterPointer"/>

			<label id="forEachCharacter"/>

			<label id="characterPointer"/>
			<long>0</long>
			<long>-1</long>
			<sq:Next/>

			<sq:Increment value="characterPointer"/>

			<sq:Decrement value="characterCount" branch="done"/>

			<sq:Jump destination="forEachCharacter"/>

			<label id="characterCount"/>
			<long>0</long>

			<label id="done"/>
		</scope>
	</xsl:template>
	<xsl:template match="ns:Read">
		<scope>
			<sq:Copy source="{@pointer}" destination="stringLength"/>
			
			<sq:Copy source="{@pointer}" destination="characterPointer"/>

			<addressOf ref="negativeOne" type="Absolute64"/>
			<addressOf ref="characterPointer" type="Absolute64"/>
			<sq:Next/>

			<label id="loop"/>

			<long>-1</long>
			<label id="characterPointer"/>
			<long>0</long>
			<addressOf ref="done" type="Absolute64"/>

			<addressOf ref="negativeOne" type="Absolute64"/>
			<addressOf ref="characterPointer" type="Absolute64"/>
			<sq:Next/>

			<addressOf ref="negativeOne" type="Absolute64"/>
			<label id="stringLength"/>
			<long>0</long>
			<sq:Next/>

			<sq:Jump destination="loop"/>

			<var:long id="negativeOne">-1</var:long>
			
			<label id="done"/>
		</scope>
	</xsl:template>
</xsl:stylesheet>