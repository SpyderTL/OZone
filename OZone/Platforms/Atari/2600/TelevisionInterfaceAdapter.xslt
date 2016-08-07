<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:tia="http://metalx.org/Atari/2600/TelevisionInterfaceAdapter"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="xml" indent="yes" />

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="tia:VerticalSync">
		<xsl:element name="hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="tia:VerticalBlank">
		<xsl:element name="hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="tia:WaitForHorizontalSync">
		<xsl:element name="hex">02</xsl:element>
	</xsl:template>
	<xsl:template match="tia:ResetHorizontalSync">
		<xsl:element name="hex">03</xsl:element>
	</xsl:template>
	<xsl:template match="tia:PlayerAndMissileSize0">
		<xsl:element name="hex">04</xsl:element>
	</xsl:template>
	<xsl:template match="tia:PlayerAndMissileSize1">
		<xsl:element name="hex">05</xsl:element>
	</xsl:template>
	<xsl:template match="tia:Player0Color">
		<xsl:element name="hex">06</xsl:element>
	</xsl:template>
	<xsl:template match="tia:Player1Color">
		<xsl:element name="hex">07</xsl:element>
	</xsl:template>
	<xsl:template match="tia:PlayfieldAndBallColor">
		<xsl:element name="hex">08</xsl:element>
	</xsl:template>
	<xsl:template match="tia:BackgroundColor">
		<xsl:element name="hex">09</xsl:element>
	</xsl:template>
	<xsl:template match="tia:PlayfieldAndBallControl">
		<xsl:element name="hex">0a</xsl:element>
	</xsl:template>
	<xsl:template match="tia:PlayerReflect0">
		<xsl:element name="hex">0b</xsl:element>
	</xsl:template>
	<xsl:template match="tia:PlayerReflect1">
		<xsl:element name="hex">0c</xsl:element>
	</xsl:template>
	<xsl:template match="tia:PlayfieldGraphics0">
		<xsl:element name="hex">0d</xsl:element>
	</xsl:template>
	<xsl:template match="tia:PlayfieldGraphics1">
		<xsl:element name="hex">0e</xsl:element>
	</xsl:template>
	<xsl:template match="tia:PlayfieldGraphics2">
		<xsl:element name="hex">0f</xsl:element>
	</xsl:template>
	<xsl:template match="tia:ResetPlayer0Position">
		<xsl:element name="hex">10</xsl:element>
	</xsl:template>
	<xsl:template match="tia:ResetPlayer1Position">
		<xsl:element name="hex">11</xsl:element>
	</xsl:template>
	<xsl:template match="tia:ResetMissile0Position">
		<xsl:element name="hex">12</xsl:element>
	</xsl:template>
	<xsl:template match="tia:ResetMissile1Position">
		<xsl:element name="hex">13</xsl:element>
	</xsl:template>
	<xsl:template match="tia:ResetBallPosition">
		<xsl:element name="hex">14</xsl:element>
	</xsl:template>
	<xsl:template match="tia:AudioControl0">
		<xsl:element name="hex">15</xsl:element>
	</xsl:template>
	<xsl:template match="tia:AudioControl1">
		<xsl:element name="hex">16</xsl:element>
	</xsl:template>
	<xsl:template match="tia:AudioFrequency0">
		<xsl:element name="hex">17</xsl:element>
	</xsl:template>
	<xsl:template match="tia:AudioFrequency1">
		<xsl:element name="hex">18</xsl:element>
	</xsl:template>
	<xsl:template match="tia:AudioVolume0">
		<xsl:element name="hex">19</xsl:element>
	</xsl:template>
	<xsl:template match="tia:AudioVolume1">
		<xsl:element name="hex">1a</xsl:element>
	</xsl:template>
	<xsl:template match="tia:Player0Graphics">
		<xsl:element name="hex">1b</xsl:element>
	</xsl:template>
	<xsl:template match="tia:Player1Graphics">
		<xsl:element name="hex">1c</xsl:element>
	</xsl:template>
	<xsl:template match="tia:Missile0Enable">
		<xsl:element name="hex">1d</xsl:element>
	</xsl:template>
	<xsl:template match="tia:Missile1Enable">
		<xsl:element name="hex">1e</xsl:element>
	</xsl:template>
	<xsl:template match="tia:BallEnable">
		<xsl:element name="hex">1f</xsl:element>
	</xsl:template>
	<xsl:template match="tia:Player0HorizontalMotion">
		<xsl:element name="hex">20</xsl:element>
	</xsl:template>
	<xsl:template match="tia:Player1HorizontalMotion">
		<xsl:element name="hex">21</xsl:element>
	</xsl:template>
	<xsl:template match="tia:Missile0HorizontalMotion">
		<xsl:element name="hex">22</xsl:element>
	</xsl:template>
	<xsl:template match="tia:Missile1HorizontalMotion">
		<xsl:element name="hex">23</xsl:element>
	</xsl:template>
	<xsl:template match="tia:BallHorizontalMotion">
		<xsl:element name="hex">24</xsl:element>
	</xsl:template>
	<xsl:template match="tia:Player0VerticalDelay">
		<xsl:element name="hex">25</xsl:element>
	</xsl:template>
	<xsl:template match="tia:Player1VerticalDelay">
		<xsl:element name="hex">26</xsl:element>
	</xsl:template>
	<xsl:template match="tia:BallVerticalDelay">
		<xsl:element name="hex">27</xsl:element>
	</xsl:template>
	<xsl:template match="tia:ResetMissileToPlayer0">
		<xsl:element name="hex">28</xsl:element>
	</xsl:template>
	<xsl:template match="tia:ResetMissileToPlayer1">
		<xsl:element name="hex">29</xsl:element>
	</xsl:template>
	<xsl:template match="tia:MoveAllObjects">
		<xsl:element name="hex">2a</xsl:element>
	</xsl:template>
	<xsl:template match="tia:StopAllObjects">
		<xsl:element name="hex">2b</xsl:element>
	</xsl:template>
	<xsl:template match="tia:ClearCollisions">
		<xsl:element name="hex">2c</xsl:element>
	</xsl:template>
	<xsl:template match="tia:Missile0CollidedWithPlayer">
		<xsl:element name="hex">30</xsl:element>
	</xsl:template>
	<xsl:template match="tia:Missile1CollidedWithPlayer">
		<xsl:element name="hex">31</xsl:element>
	</xsl:template>
	<xsl:template match="tia:Player0CollidedWithFieldOrBall">
		<xsl:element name="hex">32</xsl:element>
	</xsl:template>
	<xsl:template match="tia:Player1CollidedWithFieldOrBall">
		<xsl:element name="hex">33</xsl:element>
	</xsl:template>
	<xsl:template match="tia:Missile0CollidedWithFieldOrBall">
		<xsl:element name="hex">34</xsl:element>
	</xsl:template>
	<xsl:template match="tia:Missile1CollidedWithFieldOrBall">
		<xsl:element name="hex">35</xsl:element>
	</xsl:template>
	<xsl:template match="tia:BallCollidedWithField">
		<xsl:element name="hex">36</xsl:element>
	</xsl:template>
	<xsl:template match="tia:PlayerOrMissileCollision">
		<xsl:element name="hex">37</xsl:element>
	</xsl:template>
	<xsl:template match="tia:Input0">
		<xsl:element name="hex">38</xsl:element>
	</xsl:template>
	<xsl:template match="tia:Input1">
		<xsl:element name="hex">39</xsl:element>
	</xsl:template>
	<xsl:template match="tia:Input2">
		<xsl:element name="hex">3a</xsl:element>
	</xsl:template>
	<xsl:template match="tia:Input3">
		<xsl:element name="hex">3b</xsl:element>
	</xsl:template>
	<xsl:template match="tia:PaddleInput0">
		<xsl:element name="hex">38</xsl:element>
	</xsl:template>
	<xsl:template match="tia:PaddleInput1">
		<xsl:element name="hex">39</xsl:element>
	</xsl:template>
	<xsl:template match="tia:PaddleInput2">
		<xsl:element name="hex">3a</xsl:element>
	</xsl:template>
	<xsl:template match="tia:PaddleInput3">
		<xsl:element name="hex">3b</xsl:element>
	</xsl:template>
	<xsl:template match="tia:Input4">
		<xsl:element name="hex">3c</xsl:element>
	</xsl:template>
	<xsl:template match="tia:Input5">
		<xsl:element name="hex">3d</xsl:element>
	</xsl:template>
</xsl:stylesheet>