<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:ns="http://metalx.org/Intel/80386/ExtendedOperators" xmlns:prg="http://metalx.org/Program" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes" />
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()" />
		</xsl:copy>
	</xsl:template>
	<xsl:template match="ns:DescriptorTableFunction">
		<xsl:element name="prg:hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyControlRegisterToRegister">
		<xsl:element name="prg:hex">20</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyRegisterToControlRegister">
		<xsl:element name="prg:hex">22</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyAXDXToCXModelSpecificRegister">
		<xsl:element name="prg:hex">30</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyCXModelSpecificRegisterToAXDX">
		<xsl:element name="prg:hex">32</xsl:element>
	</xsl:template>
	<xsl:template match="ns:GetCpuInformation">
		<xsl:element name="prg:hex">A2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RandomFunction">
		<xsl:element name="prg:hex">C7</xsl:element>
	</xsl:template>
	<xsl:template match="ns:EmptyMmxState">
		<xsl:element name="prg:hex">77</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyOperandToMmxRegister32">
		<xsl:element name="prg:hex">6E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyMmxRegisterToOperand32">
		<xsl:element name="prg:hex">7E</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyOperandToMmxRegister64">
		<xsl:element name="prg:hex">6F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CopyMmxRegisterToOperand64">
		<xsl:element name="prg:hex">7F</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddOperandToMmxRegister8">
		<xsl:element name="prg:hex">FC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddOperandToMmxRegister16">
		<xsl:element name="prg:hex">FD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddOperandToMmxRegister32">
		<xsl:element name="prg:hex">FE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddOperandToMmxRegister64">
		<xsl:element name="prg:hex">FF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddOperandToMmxRegister8WithSaturate">
		<xsl:element name="prg:hex">DC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddOperandToMmxRegister16WithSaturate">
		<xsl:element name="prg:hex">DD</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddOperandToMmxRegister32WithSaturate">
		<xsl:element name="prg:hex">DE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddOperandToMmxRegister64WithSaturate">
		<xsl:element name="prg:hex">DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddOperandToMmxRegister8WithSignedSaturate">
		<xsl:element name="prg:hex">EC</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddOperandToMmxRegister16WithSignedSaturate">
		<xsl:element name="prg:hex">ED</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddOperandToMmxRegister32WithSignedSaturate">
		<xsl:element name="prg:hex">EE</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddOperandToMmxRegister64WithSignedSaturate">
		<xsl:element name="prg:hex">EF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractOperandFromMmxRegister8">
		<xsl:element name="prg:hex">F8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractOperandFromMmxRegister16">
		<xsl:element name="prg:hex">F9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractOperandFromMmxRegister32">
		<xsl:element name="prg:hex">FA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractOperandFromMmxRegister64">
		<xsl:element name="prg:hex">FB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractOperandFromMmxRegister8WithSaturate">
		<xsl:element name="prg:hex">D8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractOperandFromMmxRegister16WithSaturate">
		<xsl:element name="prg:hex">D9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractOperandFromMmxRegister32WithSaturate">
		<xsl:element name="prg:hex">DA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractOperandFromMmxRegister64WithSaturate">
		<xsl:element name="prg:hex">DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractOperandFromMmxRegister8WithSignedSaturate">
		<xsl:element name="prg:hex">E8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractOperandFromMmxRegister16WithSignedSaturate">
		<xsl:element name="prg:hex">E9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractOperandFromMmxRegister32WithSignedSaturate">
		<xsl:element name="prg:hex">EA</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractOperandFromMmxRegister64WithSignedSaturate">
		<xsl:element name="prg:hex">EB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyMmxRegisterByOperandLow">
		<xsl:element name="prg:hex">D5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyMmxRegisterByOperandHigh">
		<xsl:element name="prg:hex">E4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyMmxRegisterByOperandHighSigned">
		<xsl:element name="prg:hex">E5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyMmxRegisterByOperandWithAdd">
		<xsl:element name="prg:hex">F5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AndMmxRegisterWithOperand">
		<xsl:element name="prg:hex">DB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AndNotMmxRegisterWithOperand">
		<xsl:element name="prg:hex">DF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OrMmxRegisterWithOperand">
		<xsl:element name="prg:hex">EB</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExclusiveOrMmxRegisterWithOperand">
		<xsl:element name="prg:hex">EF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftMmxRegisterLeftByOperand8">
		<xsl:element name="prg:hex">F0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftMmxRegisterLeftByOperand16">
		<xsl:element name="prg:hex">F1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftMmxRegisterLeftByOperand32">
		<xsl:element name="prg:hex">F2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftMmxRegisterLeftByOperand64">
		<xsl:element name="prg:hex">F3</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftMmxRegisterRightByOperand8">
		<xsl:element name="prg:hex">D0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftMmxRegisterRightByOperand16">
		<xsl:element name="prg:hex">D1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftMmxRegisterRightByOperand32">
		<xsl:element name="prg:hex">D2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftMmxRegisterRightByOperand64">
		<xsl:element name="prg:hex">D3</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftMmxRegisterRightByOperandWithSign8">
		<xsl:element name="prg:hex">E0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftMmxRegisterRightByOperandWithSign16">
		<xsl:element name="prg:hex">E1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftMmxRegisterRightByOperandWithSign32">
		<xsl:element name="prg:hex">E2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftMmxRegisterRightByOperandWithSign64">
		<xsl:element name="prg:hex">E3</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftMmxRegisterByImmediateFunction">
		<xsl:element name="prg:hex">EF</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PackOperandIntoMmxRegisterWithSignedSaturate32">
		<xsl:element name="prg:hex">6B</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PackOperandIntoMmxRegisterWithSaturate16">
		<xsl:element name="prg:hex">67</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PackOperandIntoMmxRegisterWithSignedSaturate16">
		<xsl:element name="prg:hex">63</xsl:element>
	</xsl:template>
	<xsl:template match="ns:UnpackOperandToMmxRegisterLow8">
		<xsl:element name="prg:hex">60</xsl:element>
	</xsl:template>
	<xsl:template match="ns:UnpackOperandToMmxRegisterLow16">
		<xsl:element name="prg:hex">61</xsl:element>
	</xsl:template>
	<xsl:template match="ns:UnpackOperandToMmxRegisterLow32">
		<xsl:element name="prg:hex">62</xsl:element>
	</xsl:template>
	<xsl:template match="ns:UnpackOperandToMmxRegisterHigh8">
		<xsl:element name="prg:hex">68</xsl:element>
	</xsl:template>
	<xsl:template match="ns:UnpackOperandToMmxRegisterHigh16">
		<xsl:element name="prg:hex">69</xsl:element>
	</xsl:template>
	<xsl:template match="ns:UnpackOperandToMmxRegisterHigh32">
		<xsl:element name="prg:hex">6a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareEqualMmxRegisterWithOperand8">
		<xsl:element name="prg:hex">74</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareEqualMmxRegisterWithOperand16">
		<xsl:element name="prg:hex">75</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareEqualMmxRegisterWithOperand32">
		<xsl:element name="prg:hex">76</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareGreaterMmxRegisterWithOperandWithSign8">
		<xsl:element name="prg:hex">64</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareGreaterMmxRegisterWithOperandWithSign16">
		<xsl:element name="prg:hex">65</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CompareGreaterMmxRegisterWithOperandWithSign32">
		<xsl:element name="prg:hex">66</xsl:element>
	</xsl:template>
</xsl:stylesheet>