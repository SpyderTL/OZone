<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns="http://metalx.org/Program" xmlns:sq="http://metalx.org/Subleq" xmlns:math="http://metalx.org/Subleq/Math" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" indent="yes" />
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" />
    </xsl:copy>
  </xsl:template>
	<xsl:template match="math:Add" name="Add">
		<scope>
			<addressOf ref="{@source}" type="Absolute64"/>
			<addressOf ref="zero" type="Absolute64"/>
			<sq:Next/>

			<addressOf ref="zero" type="Absolute64"/>
			<addressOf ref="{@destination}" type="Absolute64"/>
			<sq:Next/>

			<addressOf ref="zero" type="Absolute64"/>
			<addressOf ref="zero" type="Absolute64"/>
			<addressOf ref="end" type="Absolute64"/>

			<label id="zero"/>
			<long>0</long>

			<label id="end"/>
		</scope>
	</xsl:template>
	<xsl:template match="math:Subtract" name="Subtract">
		<addressOf ref="{@source}" type="Absolute64"/>
		<addressOf ref="{@destination}" type="Absolute64"/>
		<xsl:choose>
			<xsl:when test="@branch">
				<addressOf ref="{@branch}" type="Absolute64"/>
			</xsl:when>
			<xsl:otherwise>
				<sq:Next/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="math:Multiply" name="Multiply">
		<scope>
			<addressOf ref="{@source}" type="Absolute64"/>
			<addressOf ref="zero" type="Absolute64"/>
			<sq:Next/>

			<addressOf ref="zero" type="Absolute64"/>
			<addressOf ref="{@destination}" type="Absolute64"/>
			<sq:Next/>

			<addressOf ref="zero" type="Absolute64"/>
			<addressOf ref="zero" type="Absolute64"/>
			<addressOf ref="end" type="Absolute64"/>

			<label id="zero"/>
			<long>0</long>

			<label id="end"/>
		</scope>
	</xsl:template>
	<xsl:template match="math:Divide" name="Divide">
		<scope>
			<addressOf ref="{@source}" type="Absolute64"/>
			<addressOf ref="zero" type="Absolute64"/>
			<sq:Next/>

			<addressOf ref="zero" type="Absolute64"/>
			<addressOf ref="{@destination}" type="Absolute64"/>
			<sq:Next/>

			<addressOf ref="zero" type="Absolute64"/>
			<addressOf ref="zero" type="Absolute64"/>
			<addressOf ref="end" type="Absolute64"/>

			<label id="zero"/>
			<long>0</long>

			<label id="end"/>
		</scope>
	</xsl:template>
</xsl:stylesheet>