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
		Absolute8,
		Absolute16,
		Absolute24,
		Absolute32,
		Absolute64,
		Absolute16High8,
		Absolute24High8,
		Absolute32High8,
		Absolute40High8,
		Absolute48High8,
		Absolute56High8,
		Absolute64High8,
		Relative8,
		Relative16,
		Relative24,
		Relative32,
		Relative64
	}
}
