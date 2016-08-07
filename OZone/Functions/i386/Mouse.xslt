<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:var="http://metalx.org/Variable"
	xmlns:mouse="http://metalx.org/i386/Functions/Mouse"
	xmlns:kbd="http://metalx.org/i386/Functions/Keyboard"
	xmlns:inc="http://metalx.org/Intel/80386/Increment"
	xmlns:imm="http://metalx.org/Intel/80386/Immediate"
	xmlns:math="http://metalx.org/Intel/80386/Math"
	xmlns:obj="http://metalx.org/i386/Functions/Object"
	xmlns:lst="http://metalx.org/i386/Functions/List"
	xmlns:cat="http://metalx.org/i386/Functions/Catalog"
	xmlns:sys="http://metalx.org/i386/Functions/System"
	xmlns:mm="http://metalx.org/i386/Functions/MemoryManager"
	xmlns:cpu="http://metalx.org/Intel/80386/Operators"
	xmlns:op="http://metalx.org/Intel/80386/Operands">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="mouse:Enable">
		<!--Send Enable Aux Port Command To Keyboard Controller-->
		<!--<kbd:WaitWrite/>

		<cpu:CopyImmediateToAL/>
		<hex>a8</hex>

		<cpu:WriteALToImmediate8Port/>
		<hex>64</hex>-->

		<!--<kbd:WaitRead/>-->

		<!--<cpu:ReadFromImmediate8PortToAL/>
		<hex>60</hex>-->

		<!--Enable Auxilary Port And Interrupts-->
		<kbd:WaitWrite/>

		<cpu:CopyImmediateToAL/>
		<hex>20</hex>

		<cpu:WriteALToImmediate8Port/>
		<hex>64</hex>

		<kbd:WaitRead/>

		<cpu:ReadFromImmediate8PortToAL/>
		<hex>60</hex>

		<cpu:OrALWithImmediate/>
		<binary>00000010</binary>

		<cpu:AndALWithImmediate/>
		<binary>11011111</binary>

		<cpu:PushAXToStack/>

		<kbd:WaitWrite/>

		<cpu:CopyImmediateToAL/>
		<hex>60</hex>

		<cpu:WriteALToImmediate8Port/>
		<hex>64</hex>

		<kbd:WaitWrite/>

		<cpu:PullAXFromStack/>

		<cpu:WriteALToImmediate8Port/>
		<hex>60</hex>

		<!--Enable 2:1 Scaling (Enhance Precision)-->
		<kbd:WaitWrite/>

		<cpu:CopyImmediateToAL/>
		<hex>d4</hex>

		<cpu:WriteALToImmediate8Port/>
		<hex>64</hex>

		<kbd:WaitWrite/>

		<cpu:CopyImmediateToAL/>
		<hex>e7</hex>

		<cpu:WriteALToImmediate8Port/>
		<hex>60</hex>

		<kbd:WaitRead/>

		<cpu:ReadFromImmediate8PortToAL/>
		<hex>60</hex>

		<!--Set Sample Rate (200 per second)-->
		<kbd:WaitWrite/>

		<cpu:CopyImmediateToAL/>
		<hex>d4</hex>

		<cpu:WriteALToImmediate8Port/>
		<hex>64</hex>

		<kbd:WaitWrite/>

		<cpu:CopyImmediateToAL/>
		<hex>f3</hex>

		<cpu:WriteALToImmediate8Port/>
		<hex>60</hex>

		<kbd:WaitRead/>

		<cpu:ReadFromImmediate8PortToAL/>
		<hex>60</hex>

		<kbd:WaitWrite/>

		<cpu:CopyImmediateToAL/>
		<hex>d4</hex>

		<cpu:WriteALToImmediate8Port/>
		<hex>64</hex>

		<kbd:WaitWrite/>

		<cpu:CopyImmediateToAL/>
		<byte>200</byte>

		<cpu:WriteALToImmediate8Port/>
		<hex>60</hex>

		<kbd:WaitRead/>

		<cpu:ReadFromImmediate8PortToAL/>
		<hex>60</hex>

		<!--Set Resolution (1/8mm)-->
		<kbd:WaitWrite/>

		<cpu:CopyImmediateToAL/>
		<hex>d4</hex>

		<cpu:WriteALToImmediate8Port/>
		<hex>64</hex>

		<kbd:WaitWrite/>

		<cpu:CopyImmediateToAL/>
		<hex>e8</hex>

		<cpu:WriteALToImmediate8Port/>
		<hex>60</hex>

		<kbd:WaitRead/>

		<cpu:ReadFromImmediate8PortToAL/>
		<hex>60</hex>

		<kbd:WaitWrite/>

		<cpu:CopyImmediateToAL/>
		<hex>d4</hex>

		<cpu:WriteALToImmediate8Port/>
		<hex>64</hex>

		<kbd:WaitWrite/>

		<cpu:CopyImmediateToAL/>
		<byte>3</byte>

		<cpu:WriteALToImmediate8Port/>
		<hex>60</hex>

		<kbd:WaitRead/>

		<cpu:ReadFromImmediate8PortToAL/>
		<hex>60</hex>

		<!--Enable PS/2 Aux Port (Mouse)-->
		<kbd:WaitWrite/>

		<cpu:CopyImmediateToAL/>
		<hex>d4</hex>

		<cpu:WriteALToImmediate8Port/>
		<hex>64</hex>

		<kbd:WaitWrite/>

		<cpu:CopyImmediateToAL/>
		<hex>f4</hex>

		<cpu:WriteALToImmediate8Port/>
		<hex>60</hex>

		<kbd:WaitRead/>

		<cpu:ReadFromImmediate8PortToAL/>
		<hex>60</hex>
	</xsl:template>

	<xsl:template match="mouse:Disable">
		<!--Disable PS/2 Aux Port (Mouse)-->
		<kbd:WaitWrite/>

		<cpu:CopyImmediateToAL/>
		<hex>d4</hex>

		<cpu:WriteALToImmediate8Port/>
		<hex>64</hex>

		<kbd:WaitWrite/>

		<cpu:CopyImmediateToAL/>
		<hex>f5</hex>

		<cpu:WriteALToImmediate8Port/>
		<hex>60</hex>

		<kbd:WaitRead/>

		<cpu:ReadFromImmediate8PortToAL/>
		<hex>60</hex>
	</xsl:template>

</xsl:stylesheet>
