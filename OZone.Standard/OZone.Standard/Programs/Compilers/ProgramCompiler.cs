using System.IO;
using System.Linq;
using System.Diagnostics;
using System.Collections.Generic;
using System;

namespace OZone.Programs.Compilers
{
	public abstract class ProgramCompiler
	{
		public abstract uint Compile(Program program, MemoryAddress baseAddress);
		public abstract void Write(Program program, BinaryWriter writer);
		public abstract uint GetLength(ProgramSegment segment);

		public void Link(Program program, Dictionary<string, Label> exports)
		{
			Link(program.Segments, exports);
		}

		private void Link(IEnumerable<ProgramSegment> segments, Dictionary<string, Label> exports)
		{
			var labels = exports.ToDictionary(x => x.Key, x => x.Value);

			foreach (var label in segments.OfType<Label>())
				labels[label.Id] = label;

			foreach (var addressOf in segments.OfType<AddressOf>())
			{
				if (labels.TryGetValue(addressOf.Reference, out Label label))
					addressOf.Segment = label;
				else
					throw new Exception("Label not found: " + addressOf.Reference);
			}

			foreach (var length in segments.OfType<Length>())
			{
				if (labels.TryGetValue(length.From, out Label label))
					length.FromSegment = label;
				else
					throw new Exception("Label not found: " + length.From);

				if (labels.TryGetValue(length.To, out Label label2))
					length.ToSegment = label2;
				else
					throw new Exception("Label not found: " + length.To);
			}

			foreach (var scope in segments.OfType<Scope>())
			{
				Link(scope.Segments, labels);
			}
		}
	}
}