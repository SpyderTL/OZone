<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0"
                xmlns:ns="http://metalx.org/W3c/Wasm/Operators"
                xmlns:prg="http://metalx.org/Program">
	<xsl:output method="xml" indent="yes"/>
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="ns:UnreachableCodeTrap">
		<xsl:element name="prg:hex">00</xsl:element>
	</xsl:template>
	<xsl:template match="ns:NoOperation">
		<xsl:element name="prg:hex">01</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Block">
		<xsl:element name="prg:hex">02</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Loop">
		<xsl:element name="prg:hex">03</xsl:element>
	</xsl:template>
	<xsl:template match="ns:If">
		<xsl:element name="prg:hex">04</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Else">
		<xsl:element name="prg:hex">05</xsl:element>
	</xsl:template>
	<xsl:template match="ns:End">
		<xsl:element name="prg:hex">0b</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BreakImmediate">
		<xsl:element name="prg:hex">0c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BreakImmediateIf">
		<xsl:element name="prg:hex">0d</xsl:element>
	</xsl:template>
	<xsl:template match="ns:BranchTable">
		<xsl:element name="prg:hex">0e</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Return">
		<xsl:element name="prg:hex">0f</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Call">
		<xsl:element name="prg:hex">10</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CallIndirect">
		<xsl:element name="prg:hex">11</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Drop">
		<xsl:element name="prg:hex">1a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Select">
		<xsl:element name="prg:hex">1b</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushImmediateLocal">
		<xsl:element name="prg:hex">20</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullImmediateLocal">
		<xsl:element name="prg:hex">21</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PeekImmedateLocal">
		<xsl:element name="prg:hex">22</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushImmediateGlobal">
		<xsl:element name="prg:hex">23</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullImmediateGlobal">
		<xsl:element name="prg:hex">24</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushIntegerAtImmediateAddress">
		<xsl:element name="prg:hex">28</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushLongAtImmediateAddress">
		<xsl:element name="prg:hex">29</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushFloatAtImmediateAddress">
		<xsl:element name="prg:hex">2a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushDoubleAtImmediateAddress">
		<xsl:element name="prg:hex">2b</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushSignedByteAtImmediateAddress32">
		<xsl:element name="prg:hex">2c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushByteAtImmediateAddress32">
		<xsl:element name="prg:hex">2d</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushShortAtImmediateAddress32">
		<xsl:element name="prg:hex">2e</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushUnsignedShortAtImmediateAddress32">
		<xsl:element name="prg:hex">2f</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushSignedByteAtImmediateAddress64">
		<xsl:element name="prg:hex">30</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushByteAtImmediateAddress64">
		<xsl:element name="prg:hex">31</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushShortAtImmediateAddress64">
		<xsl:element name="prg:hex">32</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushUnsignedShortAtImmediateAddress64">
		<xsl:element name="prg:hex">33</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushIntegerAtImmediateAddress64">
		<xsl:element name="prg:hex">34</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushUnsignedIntegerAtImmediateAddress64">
		<xsl:element name="prg:hex">35</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullIntegerAtImmediateAddress">
		<xsl:element name="prg:hex">36</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullLongAtImmediateAddress">
		<xsl:element name="prg:hex">37</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullFloatAtImmediateAddress">
		<xsl:element name="prg:hex">38</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullDoubleAtImmediateAddress">
		<xsl:element name="prg:hex">39</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullByteAtImmediateAddress32">
		<xsl:element name="prg:hex">3a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullShortAtImmediateAddress32">
		<xsl:element name="prg:hex">3b</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullByteAtImmediateAddress64">
		<xsl:element name="prg:hex">3c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullShortAtImmediateAddress64">
		<xsl:element name="prg:hex">3d</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PullIntegerAtImmediateAddress64">
		<xsl:element name="prg:hex">3e</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushImmediateMemorySize">
		<xsl:element name="prg:hex">3f</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IncreaseImmediateMemorySize">
		<xsl:element name="prg:hex">40</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushImmediateInteger">
		<xsl:element name="prg:hex">41</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushImmediateLong">
		<xsl:element name="prg:hex">42</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushImmediateFloat">
		<xsl:element name="prg:hex">43</xsl:element>
	</xsl:template>
	<xsl:template match="ns:PushImmediateDouble">
		<xsl:element name="prg:hex">44</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IsIntegerZero">
		<xsl:element name="prg:hex">45</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IsIntegerEqual">
		<xsl:element name="prg:hex">46</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IsIntegerNotEqual">
		<xsl:element name="prg:hex">47</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IsIntegerLess">
		<xsl:element name="prg:hex">48</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IsUnsignedIntegerLess">
		<xsl:element name="prg:hex">49</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IsIntegerGreater">
		<xsl:element name="prg:hex">4a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IsUnsignedIntegerGreater">
		<xsl:element name="prg:hex">4b</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IsIntegerLessOrEqual">
		<xsl:element name="prg:hex">4c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IsUnsignedIntegerLessOrEqual">
		<xsl:element name="prg:hex">4d</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IsIntegerGreaterOrEqual">
		<xsl:element name="prg:hex">4e</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IsUnsignedIntegerGreaterOrEqual">
		<xsl:element name="prg:hex">4f</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IsLongZero">
		<xsl:element name="prg:hex">50</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IsLongEqual">
		<xsl:element name="prg:hex">51</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IsLongNotEqual">
		<xsl:element name="prg:hex">52</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IsLongLess">
		<xsl:element name="prg:hex">53</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IsUnsignedLongLess">
		<xsl:element name="prg:hex">54</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IsLongGreater">
		<xsl:element name="prg:hex">55</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IsUnsignedLongGreater">
		<xsl:element name="prg:hex">56</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IsLongLessOrEqual">
		<xsl:element name="prg:hex">57</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IsUnsignedLongLessOrEqual">
		<xsl:element name="prg:hex">58</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IsLongGreaterOrEqual">
		<xsl:element name="prg:hex">59</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IsUnsignedLongGreaterOrEqual">
		<xsl:element name="prg:hex">5a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IsFloatEqual">
		<xsl:element name="prg:hex">5b</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IsFloatNotEqual">
		<xsl:element name="prg:hex">5c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IsFloatLess">
		<xsl:element name="prg:hex">5d</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IsFloatGreater">
		<xsl:element name="prg:hex">5e</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IsFloatLessOrEqual">
		<xsl:element name="prg:hex">5f</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IsFloatGreaterOrEqual">
		<xsl:element name="prg:hex">60</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IsDoubleEqual">
		<xsl:element name="prg:hex">61</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IsDoubleNotEqual">
		<xsl:element name="prg:hex">62</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IsDoubleLess">
		<xsl:element name="prg:hex">63</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IsDoubleGreater">
		<xsl:element name="prg:hex">64</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IsDoubleLessOrEqual">
		<xsl:element name="prg:hex">65</xsl:element>
	</xsl:template>
	<xsl:template match="ns:IsDoubleGreaterOrEqual">
		<xsl:element name="prg:hex">66</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CountLeadingClearBits32">
		<xsl:element name="prg:hex">67</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CountTrailingClearBits32">
		<xsl:element name="prg:hex">68</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CountSetBits32">
		<xsl:element name="prg:hex">69</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddInteger">
		<xsl:element name="prg:hex">6a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractInteger">
		<xsl:element name="prg:hex">6b</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyInteger">
		<xsl:element name="prg:hex">6c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DivideInteger">
		<xsl:element name="prg:hex">6d</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DivideUnsignedInteger">
		<xsl:element name="prg:hex">6e</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DivideIntegerRemainder">
		<xsl:element name="prg:hex">6f</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DivideUnsignedIntegerRemainder">
		<xsl:element name="prg:hex">70</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AndInteger">
		<xsl:element name="prg:hex">71</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OrInteger">
		<xsl:element name="prg:hex">72</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExclusiveOrInteger">
		<xsl:element name="prg:hex">73</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftIntegerLeft">
		<xsl:element name="prg:hex">74</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftIntegerRight">
		<xsl:element name="prg:hex">75</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftUnsignedIntegerRight">
		<xsl:element name="prg:hex">76</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RotateIntegerLeft">
		<xsl:element name="prg:hex">77</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RotateIntegerRight">
		<xsl:element name="prg:hex">78</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CountLeadingClearBits32">
		<xsl:element name="prg:hex">79</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CountTrailingClearBits32">
		<xsl:element name="prg:hex">7a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CountSetBits32">
		<xsl:element name="prg:hex">7b</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddLong">
		<xsl:element name="prg:hex">7c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractLong">
		<xsl:element name="prg:hex">7d</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyLong">
		<xsl:element name="prg:hex">7e</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DivideLong">
		<xsl:element name="prg:hex">7f</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DivideUnsignedLong">
		<xsl:element name="prg:hex">80</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DivideLongRemainder">
		<xsl:element name="prg:hex">81</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DivideUnsignedLongRemainder">
		<xsl:element name="prg:hex">82</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AndLong">
		<xsl:element name="prg:hex">83</xsl:element>
	</xsl:template>
	<xsl:template match="ns:OrLong">
		<xsl:element name="prg:hex">84</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ExclusiveOrLong">
		<xsl:element name="prg:hex">85</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftLongLeft">
		<xsl:element name="prg:hex">86</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftLongRight">
		<xsl:element name="prg:hex">87</xsl:element>
	</xsl:template>
	<xsl:template match="ns:ShiftUnsignedLongRight">
		<xsl:element name="prg:hex">88</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RotateLongLeft">
		<xsl:element name="prg:hex">89</xsl:element>
	</xsl:template>
	<xsl:template match="ns:RotateLongRight">
		<xsl:element name="prg:hex">8a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AbsoluteFloat">
		<xsl:element name="prg:hex">8b</xsl:element>
	</xsl:template>
	<xsl:template match="ns:NegateFloat">
		<xsl:element name="prg:hex">8c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CeilingFloat">
		<xsl:element name="prg:hex">8d</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FloorFloat">
		<xsl:element name="prg:hex">8e</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TruncateFloat">
		<xsl:element name="prg:hex">8f</xsl:element>
	</xsl:template>
	<xsl:template match="ns:NearesetFloat">
		<xsl:element name="prg:hex">90</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SquareRootFloat">
		<xsl:element name="prg:hex">91</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddFloat">
		<xsl:element name="prg:hex">92</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractFloat">
		<xsl:element name="prg:hex">93</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyFloat">
		<xsl:element name="prg:hex">94</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DivideFloat">
		<xsl:element name="prg:hex">95</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MinimumFloat">
		<xsl:element name="prg:hex">96</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MaximumFloat">
		<xsl:element name="prg:hex">97</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SignFloat">
		<xsl:element name="prg:hex">98</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AbsoluteDouble">
		<xsl:element name="prg:hex">99</xsl:element>
	</xsl:template>
	<xsl:template match="ns:NegateDouble">
		<xsl:element name="prg:hex">9a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:CeilingDouble">
		<xsl:element name="prg:hex">9b</xsl:element>
	</xsl:template>
	<xsl:template match="ns:FloorDouble">
		<xsl:element name="prg:hex">9c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:TruncateDouble">
		<xsl:element name="prg:hex">9d</xsl:element>
	</xsl:template>
	<xsl:template match="ns:NearesetDouble">
		<xsl:element name="prg:hex">9e</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SquareRootDouble">
		<xsl:element name="prg:hex">9f</xsl:element>
	</xsl:template>
	<xsl:template match="ns:AddDouble">
		<xsl:element name="prg:hex">a0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SubtractDouble">
		<xsl:element name="prg:hex">a1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MultiplyDouble">
		<xsl:element name="prg:hex">a2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:DivideDouble">
		<xsl:element name="prg:hex">a3</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MinimumDouble">
		<xsl:element name="prg:hex">a4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:MaximumDouble">
		<xsl:element name="prg:hex">a5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:SignDouble">
		<xsl:element name="prg:hex">a6</xsl:element>
	</xsl:template>
</xsl:stylesheet>

