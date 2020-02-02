using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace OZone.Programs
{
	public enum ReferenceType
	{
		Pointer16,
		Segment16,
		Absolute16,
		Absolute26,
		Absolute32,
		Absolute64,
		Absolute16High8,
		Absolute16Low8,
		Relative8,
		Relative16,
		Relative24,
		Relative32,
		Relative64
	}
}
