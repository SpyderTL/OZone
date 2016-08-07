<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet
	version="1.0"
	xmlns="http://metalx.org/Program"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:kbd="http://metalx.org/i386/Functions/Keyboard"
	xmlns:key="http://metalx.org/Pc/Keyboard"
	xmlns:cpu="http://metalx.org/Intel/80386/Operators"
	xmlns:op="http://metalx.org/Intel/80386/Operands"
	xmlns:imm="http://metalx.org/Intel/80386/Immediate"
	xmlns:math="http://metalx.org/Intel/80386/Math"
	xmlns:ari="http://metalx.org/Intel/80386/Arithmetic">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="kbd:WaitRead">
		<scope>
			<label id="waitForRead"/>

			<cpu:ReadFromImmediate8PortToAL/>
			<key:StatusPort/>

			<cpu:AndALWithImmediate/>
			<binary>00000001</binary>

			<cpu:CompareALToImmediate/>
			<binary>00000001</binary>

			<cpu:BranchToRelative8IfNotEqual/>
			<addressOf ref="waitForRead" type="Relative8"/>
		</scope>
	</xsl:template>

	<xsl:template match="kbd:WaitWrite">
		<scope>
			<label id="waitForWrite"/>

			<cpu:ReadFromImmediate8PortToAL/>
			<key:StatusPort/>

			<cpu:AndALWithImmediate/>
			<binary>00000010</binary>

			<cpu:CompareALToImmediate/>
			<binary>00000010</binary>

			<cpu:BranchToRelative8IfEqual/>
			<addressOf ref="waitForWrite" type="Relative8"/>
		</scope>
	</xsl:template>

	<xsl:template match="kbd:GetAsciiCharacter">
		<scope>
			<cpu:AndAXWithImmediate/>
			<hex>000000ff</hex>

			<cpu:CopyImmediateToBX/>
			<addressOf ref="table" type="Absolute32"/>

			<cpu:CopyBXAddressPlusALToAL/>

			<cpu:JumpToRelative/>
			<addressOf ref="end" type="Relative32"/>
			
			<label id="table"/>
			<hex>00</hex>
			<hex>00</hex>
			<hex>31</hex>
			<hex>32</hex>
			<hex>33</hex>
			<hex>34</hex>
			<hex>35</hex>
			<hex>36</hex>
			<hex>37</hex>
			<hex>38</hex>
			<hex>39</hex>
			<hex>30</hex>
			<hex>2D</hex>
			<hex>3D</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>71</hex>
			<hex>77</hex>
			<hex>65</hex>
			<hex>72</hex>
			<hex>74</hex>
			<hex>79</hex>
			<hex>75</hex>
			<hex>69</hex>
			<hex>6F</hex>
			<hex>70</hex>
			<hex>5B</hex>
			<hex>5D</hex>
			<hex>0D</hex>
			<hex>00</hex>
			<hex>61</hex>
			<hex>73</hex>
			<hex>64</hex>
			<hex>66</hex>
			<hex>67</hex>
			<hex>68</hex>
			<hex>6A</hex>
			<hex>6B</hex>
			<hex>6C</hex>
			<hex>3B</hex>
			<hex>27</hex>
			<hex>60</hex>
			<hex>00</hex>
			<hex>5C</hex>
			<hex>7A</hex>
			<hex>78</hex>
			<hex>63</hex>
			<hex>76</hex>
			<hex>62</hex>
			<hex>6E</hex>
			<hex>6D</hex>
			<hex>2C</hex>
			<hex>2E</hex>
			<hex>2F</hex>
			<hex>00</hex>
			<hex>2A</hex>
			<hex>00</hex>
			<hex>20</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>2D</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>2B</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>

			<label id="end"/>
		</scope>
	</xsl:template>

	<xsl:template match="kbd:GetAsciiCharacterShift">
		<scope>
			<cpu:AndAXWithImmediate/>
			<hex>000000ff</hex>

			<cpu:AddImmediateToAX/>
			<addressOf ref="table" type="Absolute32"/>

			<cpu:CopyOperandToRegister8/>
			<op:AL-AXAddress/>

			<cpu:JumpToRelative/>
			<addressOf ref="end" type="Relative32"/>

			<label id="table"/>
			<hex>00</hex>
			<hex>00</hex>
			<hex>21</hex>
			<hex>40</hex>
			<hex>23</hex>
			<hex>24</hex>
			<hex>25</hex>
			<hex>5E</hex>
			<hex>26</hex>
			<hex>2A</hex>
			<hex>28</hex>
			<hex>29</hex>
			<hex>5F</hex>
			<hex>2B</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>51</hex>
			<hex>57</hex>
			<hex>45</hex>
			<hex>52</hex>
			<hex>54</hex>
			<hex>59</hex>
			<hex>55</hex>
			<hex>49</hex>
			<hex>4F</hex>
			<hex>50</hex>
			<hex>7B</hex>
			<hex>7D</hex>
			<hex>0A</hex>
			<hex>00</hex>
			<hex>41</hex>
			<hex>53</hex>
			<hex>44</hex>
			<hex>46</hex>
			<hex>47</hex>
			<hex>48</hex>
			<hex>4A</hex>
			<hex>4B</hex>
			<hex>4C</hex>
			<hex>3A</hex>
			<hex>22</hex>
			<hex>7E</hex>
			<hex>00</hex>
			<hex>7C</hex>
			<hex>5A</hex>
			<hex>58</hex>
			<hex>43</hex>
			<hex>56</hex>
			<hex>42</hex>
			<hex>4E</hex>
			<hex>4D</hex>
			<hex>3C</hex>
			<hex>3E</hex>
			<hex>3F</hex>
			<hex>00</hex>
			<hex>2A</hex>
			<hex>00</hex>
			<hex>20</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>2D</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>2B</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			
			<label id="end"/>
		</scope>
	</xsl:template>

	<xsl:template match="kbd:GetAsciiCharacterNumber">
		<scope>
			<cpu:AndAXWithImmediate/>
			<hex>000000ff</hex>

			<cpu:AddImmediateToAX/>
			<addressOf ref="table" type="Absolute32"/>

			<cpu:CopyOperandToRegister8/>
			<op:AL-AXAddress/>

			<cpu:JumpToRelative/>
			<addressOf ref="end" type="Relative32"/>

			<label id="table"/>
			<hex>00</hex>
			<hex>00</hex>
			<hex>31</hex>
			<hex>32</hex>
			<hex>33</hex>
			<hex>34</hex>
			<hex>35</hex>
			<hex>36</hex>
			<hex>37</hex>
			<hex>38</hex>
			<hex>39</hex>
			<hex>30</hex>
			<hex>2D</hex>
			<hex>3D</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>71</hex>
			<hex>77</hex>
			<hex>65</hex>
			<hex>72</hex>
			<hex>74</hex>
			<hex>79</hex>
			<hex>75</hex>
			<hex>69</hex>
			<hex>6F</hex>
			<hex>70</hex>
			<hex>5B</hex>
			<hex>5D</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>61</hex>
			<hex>73</hex>
			<hex>64</hex>
			<hex>66</hex>
			<hex>67</hex>
			<hex>68</hex>
			<hex>6A</hex>
			<hex>6B</hex>
			<hex>6C</hex>
			<hex>3B</hex>
			<hex>27</hex>
			<hex>60</hex>
			<hex>00</hex>
			<hex>5C</hex>
			<hex>7A</hex>
			<hex>78</hex>
			<hex>63</hex>
			<hex>76</hex>
			<hex>62</hex>
			<hex>6E</hex>
			<hex>6D</hex>
			<hex>2C</hex>
			<hex>2E</hex>
			<hex>2F</hex>
			<hex>00</hex>
			<hex>2A</hex>
			<hex>00</hex>
			<hex>20</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>37</hex>
			<hex>38</hex>
			<hex>39</hex>
			<hex>2D</hex>
			<hex>34</hex>
			<hex>35</hex>
			<hex>36</hex>
			<hex>2B</hex>
			<hex>31</hex>
			<hex>32</hex>
			<hex>33</hex>
			<hex>30</hex>
			<hex>2E</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			<hex>00</hex>
			
			<label id="end"/>
		</scope>
	</xsl:template>
</xsl:stylesheet>
