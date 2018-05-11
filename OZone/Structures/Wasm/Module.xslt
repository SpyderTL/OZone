<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:mod="http://metalx.org/Module"
	xmlns:wasm="http://metalx.org/W3c/Wasm/Operators">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="mod:return">
		<wasm:Return/>
	</xsl:template>

	<xsl:template match="mod:module">
		<scope>
			<!--Preamble-->
			<byte>0</byte>
			<string>asm</string>
			<hex>01</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>

			<!--Types-->
			<byte>1</byte>
			<length start="typesStart" end="typesEnd"/>

			<label id="typesStart"/>

			<byte>
				<xsl:value-of select="count(mod:function)"/>
			</byte>

			<xsl:for-each select="mod:function">
				<hex>60</hex>
				<byte>0</byte>
				<byte>1</byte>
				<xsl:choose>
					<xsl:when test="@type='http://metalx.org/Integer'">
						<hex>7f</hex>
					</xsl:when>
					<xsl:when test="@type='http://metalx.org/Long'">
						<hex>7e</hex>
					</xsl:when>
					<xsl:when test="@type='http://metalx.org/Float'">
						<hex>7d</hex>
					</xsl:when>
					<xsl:when test="@type='http://metalx.org/Double'">
						<hex>7c</hex>
					</xsl:when>
					<xsl:otherwise>
						<xsl:message terminate="yes">
							Unknown function type: <xsl:value-of select="@type"/>
						</xsl:message>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:for-each>

			<label id="typesEnd"/>

			<!--Imports-->

			<!--Functions-->
			<byte>3</byte>
			<length start="functionsStart" end="functionsEnd"/>

			<label id="functionsStart"/>

			<byte>
				<xsl:value-of select="count(mod:function)"/>
			</byte>

			<xsl:for-each select="mod:function">
				<byte>
					<xsl:value-of select="position() - 1"/>
				</byte>
			</xsl:for-each>

			<label id="functionsEnd"/>

			<!--Tables-->

			<!--Memory-->

			<!--Globals-->

			<!--Exports-->
			<byte>7</byte>

			<length start="exportsStart" end="exportsEnd"/>

			<label id="exportsStart"/>

			<byte>
				<xsl:value-of select="count(mod:function)"/>
			</byte>

			<xsl:for-each select="mod:function">
				<byte>
					<xsl:value-of select="string-length(@name)"/>
				</byte>
				<string>
					<xsl:value-of select="@name"/>
				</string>
				<byte>0</byte>
				<byte>
					<xsl:value-of select="position() - 1"/>
				</byte>
			</xsl:for-each>

			<label id="exportsEnd"/>

			<!--Code-->
			<byte>10</byte>
			<length start="codeStart" end="codeEnd"/>

			<label id="codeStart"/>

			<byte>
				<xsl:value-of select="count(mod:function)"/>
			</byte>

			<xsl:for-each select="mod:function">
				<scope>
					<length start="functionStart" end="functionEnd"/>

					<label id="functionStart"/>

					<byte>
						<xsl:value-of select="count(mod:local)"/>
					</byte>

					<xsl:for-each select="mod:local">
						<byte>1</byte>
						<xsl:choose>
							<xsl:when test="@type='http://metalx.org/Integer'">
								<hex>7f</hex>
							</xsl:when>
							<xsl:when test="@type='http://metalx.org/Long'">
								<hex>7e</hex>
							</xsl:when>
							<xsl:when test="@type='http://metalx.org/Float'">
								<hex>7d</hex>
							</xsl:when>
							<xsl:when test="@type='http://metalx.org/Double'">
								<hex>7c</hex>
							</xsl:when>
							<xsl:otherwise>
								<xsl:message terminate="yes">
									Unknown local type: <xsl:value-of select="@type"/>
								</xsl:message>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>

					<scope>
						<xsl:copy-of select="*[not(self::mod:parameter) and not(self::mod:local)]"/>
					</scope>

					<wasm:End/>

					<label id="functionEnd"/>
				</scope>
			</xsl:for-each>

			<label id="codeEnd"/>

			<!--Names-->

		</scope>
	</xsl:template>
</xsl:stylesheet>
