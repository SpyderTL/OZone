namespace OZone.Programs
{
	public class MemoryAddress
	{
		public uint Segment;
		public uint Offset;

		//public override bool Equals(object obj)
		//{
		//	if(obj is MemoryAddress)
		//		return Equals((MemoryAddress)obj);

		//	return false;
		//}

		//public bool Equals(MemoryAddress address)
		//{
		//	return Segment.Equals(address.Segment) &&
		//		Offset.Equals(address.Offset);
		//}

		//public static bool operator ==(MemoryAddress address1, MemoryAddress address2)
		//{
		//	return address1.Equals(address2);
		//}

		//public static bool operator !=(MemoryAddress address1, MemoryAddress address2)
		//{
		//	return !address1.Equals(address2);
		//}

		//public override int GetHashCode()
		//{
		//	return Segment.GetHashCode() + Offset.GetHashCode();
		//}
	}
}
