<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0"
                xmlns:ns="http://metalx.org/Yamaha/Opl2/Registers"
                xmlns:prg="http://metalx.org/Program">
	<xsl:output method="xml" indent="yes"/>
	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
	<xsl:template match="ns:Channel1Modulation1">
		<xsl:element name="prg:hex">20</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel2Modulation1">
		<xsl:element name="prg:hex">21</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel3Modulation1">
		<xsl:element name="prg:hex">22</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel1Modulation2">
		<xsl:element name="prg:hex">23</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel2Modulation2">
		<xsl:element name="prg:hex">24</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel3Modulation2">
		<xsl:element name="prg:hex">25</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel4Modulation1">
		<xsl:element name="prg:hex">28</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel5Modulation1">
		<xsl:element name="prg:hex">29</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel6Modulation1">
		<xsl:element name="prg:hex">2a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel4Modulation2">
		<xsl:element name="prg:hex">2b</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel5Modulation2">
		<xsl:element name="prg:hex">2c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel6Modulation2">
		<xsl:element name="prg:hex">2d</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel7Modulation1">
		<xsl:element name="prg:hex">30</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel8Modulation1">
		<xsl:element name="prg:hex">31</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel9Modulation1">
		<xsl:element name="prg:hex">32</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel7Modulation2">
		<xsl:element name="prg:hex">33</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel8Modulation2">
		<xsl:element name="prg:hex">34</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel9Modulation2">
		<xsl:element name="prg:hex">35</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel1Output1">
		<xsl:element name="prg:hex">40</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel2Output1">
		<xsl:element name="prg:hex">41</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel3Output1">
		<xsl:element name="prg:hex">42</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel1Output2">
		<xsl:element name="prg:hex">43</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel2Output2">
		<xsl:element name="prg:hex">44</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel3Output2">
		<xsl:element name="prg:hex">45</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel4Output1">
		<xsl:element name="prg:hex">48</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel5Output1">
		<xsl:element name="prg:hex">49</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel6Output1">
		<xsl:element name="prg:hex">4a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel4Output2">
		<xsl:element name="prg:hex">4b</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel5Output2">
		<xsl:element name="prg:hex">4c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel6Output2">
		<xsl:element name="prg:hex">4d</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel7Output1">
		<xsl:element name="prg:hex">50</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel8Output1">
		<xsl:element name="prg:hex">51</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel9Output1">
		<xsl:element name="prg:hex">52</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel7Output2">
		<xsl:element name="prg:hex">53</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel8Output2">
		<xsl:element name="prg:hex">54</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel9Output2">
		<xsl:element name="prg:hex">55</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel1AttackDecay1">
		<xsl:element name="prg:hex">60</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel2AttackDecay1">
		<xsl:element name="prg:hex">61</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel3AttackDecay1">
		<xsl:element name="prg:hex">62</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel1AttackDecay2">
		<xsl:element name="prg:hex">63</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel2AttackDecay2">
		<xsl:element name="prg:hex">64</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel3AttackDecay2">
		<xsl:element name="prg:hex">65</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel4AttackDecay1">
		<xsl:element name="prg:hex">68</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel5AttackDecay1">
		<xsl:element name="prg:hex">69</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel6AttackDecay1">
		<xsl:element name="prg:hex">6a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel4AttackDecay2">
		<xsl:element name="prg:hex">6b</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel5AttackDecay2">
		<xsl:element name="prg:hex">6c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel6AttackDecay2">
		<xsl:element name="prg:hex">6d</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel7AttackDecay1">
		<xsl:element name="prg:hex">70</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel8AttackDecay1">
		<xsl:element name="prg:hex">71</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel9AttackDecay1">
		<xsl:element name="prg:hex">72</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel7AttackDecay2">
		<xsl:element name="prg:hex">73</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel8AttackDecay2">
		<xsl:element name="prg:hex">74</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel9AttackDecay2">
		<xsl:element name="prg:hex">75</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel1SustainRelease1">
		<xsl:element name="prg:hex">80</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel2SustainRelease1">
		<xsl:element name="prg:hex">81</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel3SustainRelease1">
		<xsl:element name="prg:hex">82</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel1SustainRelease2">
		<xsl:element name="prg:hex">83</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel2SustainRelease2">
		<xsl:element name="prg:hex">84</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel3SustainRelease2">
		<xsl:element name="prg:hex">85</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel4SustainRelease1">
		<xsl:element name="prg:hex">88</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel5SustainRelease1">
		<xsl:element name="prg:hex">89</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel6SustainRelease1">
		<xsl:element name="prg:hex">8a</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel4SustainRelease2">
		<xsl:element name="prg:hex">8b</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel5SustainRelease2">
		<xsl:element name="prg:hex">8c</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel6SustainRelease2">
		<xsl:element name="prg:hex">8d</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel7SustainRelease1">
		<xsl:element name="prg:hex">90</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel8SustainRelease1">
		<xsl:element name="prg:hex">91</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel9SustainRelease1">
		<xsl:element name="prg:hex">92</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel7SustainRelease2">
		<xsl:element name="prg:hex">93</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel8SustainRelease2">
		<xsl:element name="prg:hex">94</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel9SustainRelease2">
		<xsl:element name="prg:hex">95</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel1Frequency">
		<xsl:element name="prg:hex">a0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel2Frequency">
		<xsl:element name="prg:hex">a1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel3Frequency">
		<xsl:element name="prg:hex">a2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel4Frequency">
		<xsl:element name="prg:hex">a3</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel5Frequency">
		<xsl:element name="prg:hex">a4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel6Frequency">
		<xsl:element name="prg:hex">a5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel7Frequency">
		<xsl:element name="prg:hex">a6</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel8Frequency">
		<xsl:element name="prg:hex">a7</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel9Frequency">
		<xsl:element name="prg:hex">a8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel1KeyOn">
		<xsl:element name="prg:hex">b0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel2KeyOn">
		<xsl:element name="prg:hex">b1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel3KeyOn">
		<xsl:element name="prg:hex">b2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel4KeyOn">
		<xsl:element name="prg:hex">b3</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel5KeyOn">
		<xsl:element name="prg:hex">b4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel6KeyOn">
		<xsl:element name="prg:hex">b5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel7KeyOn">
		<xsl:element name="prg:hex">b6</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel8KeyOn">
		<xsl:element name="prg:hex">b7</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel9KeyOn">
		<xsl:element name="prg:hex">b8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel1Feedback">
		<xsl:element name="prg:hex">c0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel2Feedback">
		<xsl:element name="prg:hex">c1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel3Feedback">
		<xsl:element name="prg:hex">c2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel4Feedback">
		<xsl:element name="prg:hex">c3</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel5Feedback">
		<xsl:element name="prg:hex">c4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel6Feedback">
		<xsl:element name="prg:hex">c5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel7Feedback">
		<xsl:element name="prg:hex">c6</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel8Feedback">
		<xsl:element name="prg:hex">c7</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel9Feedback">
		<xsl:element name="prg:hex">c8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel1Waveform1">
		<xsl:element name="prg:hex">e0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel2Waveform1">
		<xsl:element name="prg:hex">e1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel3Waveform1">
		<xsl:element name="prg:hex">e2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel1Waveform2">
		<xsl:element name="prg:hex">e3</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel2Waveform2">
		<xsl:element name="prg:hex">e4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel3Waveform2">
		<xsl:element name="prg:hex">e5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel4Waveform1">
		<xsl:element name="prg:hex">e8</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel5Waveform1">
		<xsl:element name="prg:hex">e9</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel6Waveform1">
		<xsl:element name="prg:hex">ea</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel4Waveform2">
		<xsl:element name="prg:hex">eb</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel5Waveform2">
		<xsl:element name="prg:hex">ec</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel6Waveform2">
		<xsl:element name="prg:hex">ed</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel7Waveform1">
		<xsl:element name="prg:hex">f0</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel8Waveform1">
		<xsl:element name="prg:hex">f1</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel9Waveform1">
		<xsl:element name="prg:hex">f2</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel7Waveform2">
		<xsl:element name="prg:hex">f3</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel8Waveform2">
		<xsl:element name="prg:hex">f4</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Channel9Waveform2">
		<xsl:element name="prg:hex">f5</xsl:element>
	</xsl:template>
	<xsl:template match="ns:Drums">
		<xsl:element name="prg:hex">bd</xsl:element>
	</xsl:template>
</xsl:stylesheet>
