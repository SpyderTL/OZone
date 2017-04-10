<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns="http://metalx.org/Program" xmlns:sq="http://metalx.org/Subleq" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" indent="yes" />
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" />
    </xsl:copy>
  </xsl:template>
	<xsl:template match="sq:Jump" name="Jump">
		<scope>
			<addressOf ref="zero" type="Absolute64"/>
			<addressOf ref="zero" type="Absolute64"/>
			<addressOf ref="{@destination}" type="Absolute64"/>

			<label id="zero"/>
			<long>0</long>
		</scope>
	</xsl:template>
	<xsl:template match="sq:Next" name="Next">
		<scope>
			<addressOf ref="next" type="Absolute64"/>

			<label id="next"/>
		</scope>
	</xsl:template>
	<xsl:template match="sq:Copy">
		<scope>
			<addressOf ref="{@destination}" type="Absolute64"/>
			<addressOf ref="{@destination}" type="Absolute64"/>
			<xsl:call-template name="Next"/>

			<xsl:call-template name="Add"/>
		</scope>
	</xsl:template>
	<xsl:template match="sq:CopyIndirect">
		<scope>
			<addressOf ref="{@destination}" type="Absolute64"/>
			<addressOf ref="{@destination}" type="Absolute64"/>
			<xsl:call-template name="Next"/>

			<addressOf ref="pointer" type="Absolute64"/>
			<addressOf ref="pointer" type="Absolute64"/>
			<xsl:call-template name="Next"/>

			<addressOf ref="{@pointer}" type="Absolute64"/>
			<addressOf ref="zero" type="Absolute64"/>
			<xsl:call-template name="Next"/>

			<addressOf ref="zero" type="Absolute64"/>
			<addressOf ref="pointer" type="Absolute64"/>
			<xsl:call-template name="Next"/>

			<addressOf ref="zero" type="Absolute64"/>
			<addressOf ref="zero" type="Absolute64"/>
			<xsl:call-template name="Next"/>

			<label id="pointer"/>
			<long>0</long>
			<addressOf ref="zero" type="Absolute64"/>
			<xsl:call-template name="Next"/>

			<addressOf ref="zero" type="Absolute64"/>
			<addressOf ref="{@destination}" type="Absolute64"/>
			<xsl:call-template name="Next"/>

			<addressOf ref="zero" type="Absolute64"/>
			<addressOf ref="zero" type="Absolute64"/>
			<addressOf ref="end" type="Absolute64"/>

			<label id="zero"/>
			<long>0</long>
			
			<label id="end"/>
		</scope>
	</xsl:template>
	<xsl:template match="sq:Equals" name="Equals">
		<scope>
			<addressOf ref="{@value1}" type="Absolute64"/>
			<addressOf ref="Equals_zero" type="Absolute64"/>
			<xsl:call-template name="Next"/>

			<addressOf ref="{@value2}" type="Absolute64"/>
			<addressOf ref="Equals_value" type="Absolute64"/>
			<xsl:call-template name="Next"/>

			<addressOf ref="Equals_value" type="Absolute64"/>
			<addressOf ref="Equals_zero" type="Absolute64"/>
			<addressOf ref="Equals_next" type="Absolute64"/>

			<addressOf ref="Equals_zero" type="Absolute64"/>
			<addressOf ref="Equals_zero" type="Absolute64"/>
			<addressOf ref="Equals_end" type="Absolute64"/>

			<label id="Equals_next"/>
			
			<addressOf ref="Equals_zero" type="Absolute64"/>
			<addressOf ref="Equals_zero" type="Absolute64"/>
			<xsl:call-template name="Next"/>

			<addressOf ref="Equals_value" type="Absolute64"/>
			<addressOf ref="Equals_value" type="Absolute64"/>
			<xsl:call-template name="Next"/>

			<addressOf ref="{@value2}" type="Absolute64"/>
			<addressOf ref="Equals_zero" type="Absolute64"/>
			<xsl:call-template name="Next"/>

			<addressOf ref="{@value1}" type="Absolute64"/>
			<addressOf ref="Equals_value" type="Absolute64"/>
			<xsl:call-template name="Next"/>

			<addressOf ref="Equals_value" type="Absolute64"/>
			<addressOf ref="Equals_zero" type="Absolute64"/>
			<addressOf ref="Equals_equal" type="Absolute64"/>

			<addressOf ref="Equals_zero" type="Absolute64"/>
			<addressOf ref="Equals_zero" type="Absolute64"/>
			<addressOf ref="Equals_end" type="Absolute64"/>

			<label id="Equals_equal"/>

			<addressOf ref="Equals_value" type="Absolute64"/>
			<addressOf ref="Equals_value" type="Absolute64"/>
			<addressOf ref="{@branch}" type="Absolute64"/>

			<label id="Equals_zero"/>
			<long>0</long>

			<label id="Equals_value"/>
			<long>0</long>

			<label id="Equals_end"/>
			
			<addressOf ref="Equals_value" type="Absolute64"/>
			<addressOf ref="Equals_value" type="Absolute64"/>
			<xsl:call-template name="Next"/>
		</scope>
	</xsl:template>
	<xsl:template match="sq:Zero" name="Zero">
		<scope>
			<addressOf ref="{@value}" type="Absolute64"/>
			<addressOf ref="{@value}" type="Absolute64"/>
			<sq:Next/>
		</scope>
	</xsl:template>
	<xsl:template match="sq:Increment" name="Increment">
		<scope>
			<addressOf ref="negativeOne" type="Absolute64"/>
			<addressOf ref="{@value}" type="Absolute64"/>
			<sq:Next/>

			<addressOf ref="zero" type="Absolute64"/>
			<addressOf ref="zero" type="Absolute64"/>
			<addressOf ref="end" type="Absolute64"/>

			<label id="zero"/>
			<long>0</long>

			<label id="negativeOne"/>
			<long>-1</long>

			<label id="end"/>
		</scope>
	</xsl:template>
	<xsl:template match="sq:Decrement" name="Decrement">
		<scope>
			<addressOf ref="one" type="Absolute64"/>
			<addressOf ref="{@value}" type="Absolute64"/>
			<xsl:choose>
				<xsl:when test="@branch">
					<addressOf ref="{@branch}" type="Absolute64"/>
				</xsl:when>
				<xsl:otherwise>
					<addressOf ref="end" type="Absolute64"/>
				</xsl:otherwise>
			</xsl:choose>

			<addressOf ref="zero" type="Absolute64"/>
			<addressOf ref="zero" type="Absolute64"/>
			<addressOf ref="end" type="Absolute64"/>

			<label id="zero"/>
			<long>0</long>

			<label id="one"/>
			<long>1</long>

			<label id="end"/>
		</scope>
	</xsl:template>
	<xsl:template match="sq:Add" name="Add">
		<scope>
			<addressOf ref="{@source}" type="Absolute64"/>
			<addressOf ref="zero" type="Absolute64"/>
			<xsl:call-template name="Next"/>

			<addressOf ref="zero" type="Absolute64"/>
			<addressOf ref="{@destination}" type="Absolute64"/>
			<xsl:call-template name="Next"/>

			<addressOf ref="zero" type="Absolute64"/>
			<addressOf ref="zero" type="Absolute64"/>
			<addressOf ref="end" type="Absolute64"/>

			<label id="zero"/>
			<long>0</long>

			<label id="end"/>
		</scope>
	</xsl:template>
	<xsl:template match="sq:Subtract" name="Subtract">
		<addressOf ref="{@source}" type="Absolute64"/>
		<addressOf ref="{@destination}" type="Absolute64"/>
		<xsl:choose>
			<xsl:when test="@branch">
				<addressOf ref="{@branch}" type="Absolute64"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="Next"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="sq:Multiply" name="Multiply">
		<scope>
			<addressOf ref="{@source}" type="Absolute64"/>
			<addressOf ref="zero" type="Absolute64"/>
			<xsl:call-template name="Next"/>

			<addressOf ref="zero" type="Absolute64"/>
			<addressOf ref="{@destination}" type="Absolute64"/>
			<xsl:call-template name="Next"/>

			<addressOf ref="zero" type="Absolute64"/>
			<addressOf ref="zero" type="Absolute64"/>
			<addressOf ref="end" type="Absolute64"/>

			<label id="zero"/>
			<long>0</long>

			<label id="end"/>
		</scope>
	</xsl:template>
	<xsl:template match="sq:Divide" name="Divide">
		<scope>
			<addressOf ref="{@source}" type="Absolute64"/>
			<addressOf ref="zero" type="Absolute64"/>
			<xsl:call-template name="Next"/>

			<addressOf ref="zero" type="Absolute64"/>
			<addressOf ref="{@destination}" type="Absolute64"/>
			<xsl:call-template name="Next"/>

			<addressOf ref="zero" type="Absolute64"/>
			<addressOf ref="zero" type="Absolute64"/>
			<addressOf ref="end" type="Absolute64"/>

			<label id="zero"/>
			<long>0</long>

			<label id="end"/>
		</scope>
	</xsl:template>
	<xsl:template match="sq:Loop" name="Loop">
		<scope>
			<label id="start"/>

			<scope>
				<xsl:copy-of select="@* | node()"/>
			</scope>

			<addressOf ref="one" type="Absolute64"/>
			<addressOf ref="count" type="Absolute64"/>
			<addressOf ref="end" type="Absolute64"/>

			<addressOf ref="zero" type="Absolute64"/>
			<addressOf ref="zero" type="Absolute64"/>
			<addressOf ref="start" type="Absolute64"/>

			<label id="zero"/>
			<long>0</long>

			<label id="one"/>
			<long>1</long>

			<label id="count"/>
			<long>0</long>

			<label id="end"/>
		</scope>
	</xsl:template>
</xsl:stylesheet>