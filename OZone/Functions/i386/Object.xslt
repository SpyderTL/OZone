<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:cpu="http://metalx.org/Intel/80386/Operators"
	xmlns:op="http://metalx.org/Intel/80386/Operands"
	xmlns:imm="http://metalx.org/Intel/80386/Immediate"
	xmlns:math="http://metalx.org/Intel/80386/Math"
	xmlns:logic="http://metalx.org/Intel/80386/Logic"
	xmlns:index="http://metalx.org/Intel/80386/Index"
	xmlns:obj="http://metalx.org/i386/Functions/Object"
	xmlns:clsf="http://metalx.org/i386/Functions/Class"
	xmlns:sys="http://metalx.org/i386/Functions/System"
	xmlns:cat="http://metalx.org/i386/Functions/Catalog"
	xmlns:var="http://metalx.org/Variable"
	xmlns:mm="http://metalx.org/i386/Functions/MemoryManager">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="obj:Create">
		<xsl:choose>
			<xsl:when test="@type">
				<scope>
					<cpu:PushDIToStack/>

					<mm:CheckOut length="12"/>

					<cpu:PushDIToStack/>

					<sys:GetCatalog/>

					<cpu:CopyImmediateToDI/>
					<addressOf ref="type" type="Absolute32"/>

					<cat:FindType/>

					<cpu:PullDIFromStack/>

					<cpu:CopyRegisterToOperand/>
					<op:SI-DIAddress/>

					<cpu:PullSIFromStack/>

					<cpu:CopyRegisterToOperand/>
					<op:SI-DIAddressPlusImmediate8/>
					<byte>4</byte>

					<xsl:choose>
						<xsl:when test="@length">
							<cpu:CopyImmediateToOperandFunction/>
							<imm:CopyImmediateToDIAddressPlusImmediate8/>
							<byte>8</byte>
							<int>
								<xsl:value-of select="@length"/>
							</int>
						</xsl:when>
						<xsl:otherwise>
							<cpu:CopyRegisterToOperand/>
							<op:AX-DIAddressPlusImmediate8/>
							<byte>8</byte>
						</xsl:otherwise>
					</xsl:choose>

					<cpu:JumpToRelative8/>
					<addressOf ref="end" type="Relative8"/>

					<var:string id="type">
						<xsl:value-of select="@type"/>
					</var:string>

					<label id="end"/>
				</scope>
			</xsl:when>
			<xsl:otherwise>
				<cpu:CopyRegisterToOperand/>
				<op:DI-DXRegister/>

				<mm:CheckOut length="12"/>

				<cpu:CopyRegisterToOperand/>
				<op:BX-DIAddress/>

				<cpu:CopyRegisterToOperand/>
				<op:DX-DIAddressPlusImmediate8/>
				<byte>4</byte>

				<xsl:choose>
					<xsl:when test="@length">
						<cpu:CopyImmediateToOperandFunction/>
						<imm:CopyImmediateToDIAddressPlusImmediate8/>
						<byte>8</byte>
						<int>
							<xsl:value-of select="@length"/>
						</int>
					</xsl:when>
					<xsl:otherwise>
						<cpu:CopyRegisterToOperand/>
						<op:AX-DIAddressPlusImmediate8/>
						<byte>8</byte>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="obj:Copy">
		<mm:CheckOut length="12"/>

		<cpu:PushDIToStack/>
		<cpu:PushSIToStack/>

		<cpu:CopySIAddressToDIAddressAndIncrementSIAndDI/>
		<cpu:CopySIAddressToDIAddressAndIncrementSIAndDI/>
		<cpu:CopySIAddressToDIAddressAndIncrementSIAndDI/>

		<cpu:CopyOperandToRegister/>
		<op:SI-IndexAddressPlusImmediate8/>
		<index:SP/>
		<byte>4</byte>

		<xsl:call-template name="GetDataLength"/>

		<cpu:CopyRegisterToOperand/>
		<op:AX-CXRegister/>

		<mm:CheckOut/>

		<cpu:CopyOperandToRegister/>
		<op:SI-IndexAddress/>
		<index:SP/>

		<cpu:CopyRegisterToOperand/>
		<op:DI-SIAddressPlusImmediate8/>
		<byte>4</byte>
		
		<cpu:PullSIFromStack/>

		<xsl:call-template name="GetData"/>

		<cpu:Repeat/>
		<cpu:CopySIAddressToDIAddressAndIncrementSIAndDI8/>

		<cpu:PullDIFromStack/>
	</xsl:template>

	<xsl:template match="obj:GetType" name="GetType">
		<cpu:CopyOperandToRegister/>
		<op:SI-SIAddress/>
	</xsl:template>

	<xsl:template match="obj:GetData" name="GetData">
		<cpu:CopyOperandToRegister/>
		<op:SI-SIAddressPlusImmediate8/>
		<byte>4</byte>
	</xsl:template>

	<xsl:template match="obj:GetDataLength" name="GetDataLength">
		<cpu:CopyOperandToRegister/>
		<op:AX-SIAddressPlusImmediate8/>
		<byte>8</byte>
	</xsl:template>

	<xsl:template match="obj:ExecuteMethod">
		<xsl:choose>
			<xsl:when test="@name">
				<scope>
					<cpu:PushSIToStack/>

					<xsl:call-template name="GetType"/>

					<cpu:PushSIToStack/>

					<cpu:CopyImmediateToDI/>
					<addressOf ref="methodName" type="Absolute32"/>

					<clsf:FindMethod/>

					<cpu:PullBXFromStack/>

					<cpu:PullDIFromStack/>

					<clsf:ExecuteMethod/>

					<cpu:JumpToRelative8/>
					<addressOf ref="end" type="Relative8"/>

					<var:string id="methodName">
						<xsl:value-of select="@name"/>
					</var:string>

					<label id="end"/>
				</scope>
			</xsl:when>
			<xsl:otherwise>
				<cpu:LogicFunction/>
				<logic:CallSIAddressPlusImmediate8/>
				<byte>12</byte>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="obj:GetFieldValue">
		<scope>
			<cpu:PushSIToStack/>

			<xsl:call-template name="GetType"/>

			<cpu:CopyImmediateToDI/>
			<addressOf ref="fieldName" type="Absolute32"/>

			<clsf:FindField/>

			<cpu:PullDIFromStack/>

			<clsf:GetFieldValue/>

			<cpu:JumpToRelative8/>
			<addressOf ref="end" type="Relative8"/>

			<var:string id="fieldName">
				<xsl:value-of select="@name"/>
			</var:string>

			<label id="end"/>
		</scope>
	</xsl:template>
</xsl:stylesheet>
