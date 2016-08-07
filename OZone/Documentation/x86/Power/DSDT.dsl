/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20111123-32 [Nov 23 2011]
 * Copyright (c) 2000 - 2011 Intel Corporation
 * 
 * Disassembly of X:\Projects\OZone\OZone\Documentation\x86\Power\DSDT.aml, Mon Dec 26 23:53:55 2011
 *
 * Original Table Header:
 *     Signature        "DSDT"
 *     Length           0x00001B96 (7062)
 *     Revision         0x01 **** 32-bit table (V1), no 64-bit math support
 *     Checksum         0x8D
 *     OEM ID           "VBOX  "
 *     OEM Table ID     "VBOXBIOS"
 *     OEM Revision     0x00000002 (2)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20100528 (537920808)
 */

DefinitionBlock ("X:\Projects\OZone\OZone\Documentation\x86\Power\DSDT.aml", "DSDT", 1, "VBOX  ", "VBOXBIOS", 0x00000002)
{
    OperationRegion (DBG0, SystemIO, 0x3000, 0x04)
    Field (DBG0, ByteAcc, NoLock, Preserve)
    {
        DHE1,   8
    }

    Field (DBG0, WordAcc, NoLock, Preserve)
    {
        DHE2,   16
    }

    Field (DBG0, DWordAcc, NoLock, Preserve)
    {
        DHE4,   32
    }

    Field (DBG0, ByteAcc, NoLock, Preserve)
    {
        Offset (0x01), 
        DCHR,   8
    }

    Method (HEX, 1, NotSerialized)
    {
        Store (Arg0, DHE1)
    }

    Method (HEX2, 1, NotSerialized)
    {
        Store (Arg0, DHE2)
    }

    Method (HEX4, 1, NotSerialized)
    {
        Store (Arg0, DHE4)
    }

    Method (SLEN, 1, NotSerialized)
    {
        Store (Arg0, Local0)
        Return (SizeOf (Local0))
    }

    Method (S2BF, 1, NotSerialized)
    {
        Store (Arg0, Local0)
        Add (SLEN (Local0), One, Local0)
        Name (BUFF, Buffer (Local0) {})
        Store (Arg0, BUFF)
        Return (BUFF)
    }

    Method (DBG, 1, NotSerialized)
    {
        Store (Arg0, Local0)
        Store (S2BF (Local0), Local1)
        Store (SizeOf (Local1), Local0)
        Decrement (Local0)
        Store (Zero, Local2)
        While (Local0)
        {
            Decrement (Local0)
            Store (DerefOf (Index (Local1, Local2)), DCHR)
            Increment (Local2)
        }
    }

    Name (PICM, Zero)
    Method (_PIC, 1, NotSerialized)
    {
        DBG ("Pic mode: ")
        HEX4 (Arg0)
        Store (Arg0, PICM)
    }

    OperationRegion (SYSI, SystemIO, 0x4048, 0x08)
    Field (SYSI, DWordAcc, NoLock, Preserve)
    {
        IDX0,   32, 
        DAT0,   32
    }

    IndexField (IDX0, DAT0, DWordAcc, NoLock, Preserve)
    {
        MEML,   32, 
        UIOA,   32, 
        UHPT,   32, 
        USMC,   32, 
        UFDC,   32, 
        UCP0,   32, 
        UCP1,   32, 
        UCP2,   32, 
        UCP3,   32, 
        MEMH,   32, 
        URTC,   32, 
        CPUL,   32, 
        CPUC,   32, 
        CPET,   32, 
        CPEV,   32, 
        NICA,   32, 
        HDAA,   32, 
        PWRS,   32, 
        IOCA,   32, 
        HBCA,   32, 
        PCIB,   32, 
        PCIL,   32, 
        SL0B,   32, 
        SL0I,   32, 
        SL1B,   32, 
        SL1I,   32, 
        Offset (0x80), 
        ININ,   32, 
        Offset (0x200), 
        VAIN,   32
    }

    Scope (_SB)
    {
        Method (_INI, 0, NotSerialized)
        {
            Store (0x0BADC0DE, VAIN)
            DBG ("MEML: ")
            HEX4 (MEML)
            DBG ("UIOA: ")
            HEX4 (UIOA)
            DBG ("UHPT: ")
            HEX4 (UHPT)
            DBG ("USMC: ")
            HEX4 (USMC)
            DBG ("UFDC: ")
            HEX4 (UFDC)
            DBG ("MEMH: ")
            HEX4 (MEMH)
        }

        Name (PR00, Package (0x78)
        {
            Package (0x04)
            {
                0x0002FFFF, 
                Zero, 
                LNKB, 
                Zero
            }, 

            Package (0x04)
            {
                0x0002FFFF, 
                One, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x0002FFFF, 
                0x02, 
                LNKD, 
                Zero
            }, 

            Package (0x04)
            {
                0x0002FFFF, 
                0x03, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                Zero, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                One, 
                LNKD, 
                Zero
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                0x02, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                0x03, 
                LNKB, 
                Zero
            }, 

            Package (0x04)
            {
                0x0004FFFF, 
                Zero, 
                LNKD, 
                Zero
            }, 

            Package (0x04)
            {
                0x0004FFFF, 
                One, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0x0004FFFF, 
                0x02, 
                LNKB, 
                Zero
            }, 

            Package (0x04)
            {
                0x0004FFFF, 
                0x03, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x0005FFFF, 
                Zero, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0x0005FFFF, 
                One, 
                LNKB, 
                Zero
            }, 

            Package (0x04)
            {
                0x0005FFFF, 
                0x02, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x0005FFFF, 
                0x03, 
                LNKD, 
                Zero
            }, 

            Package (0x04)
            {
                0x0006FFFF, 
                Zero, 
                LNKB, 
                Zero
            }, 

            Package (0x04)
            {
                0x0006FFFF, 
                One, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x0006FFFF, 
                0x02, 
                LNKD, 
                Zero
            }, 

            Package (0x04)
            {
                0x0006FFFF, 
                0x03, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0x0007FFFF, 
                Zero, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x0007FFFF, 
                One, 
                LNKD, 
                Zero
            }, 

            Package (0x04)
            {
                0x0007FFFF, 
                0x02, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0x0007FFFF, 
                0x03, 
                LNKB, 
                Zero
            }, 

            Package (0x04)
            {
                0x0008FFFF, 
                Zero, 
                LNKD, 
                Zero
            }, 

            Package (0x04)
            {
                0x0008FFFF, 
                One, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0x0008FFFF, 
                0x02, 
                LNKB, 
                Zero
            }, 

            Package (0x04)
            {
                0x0008FFFF, 
                0x03, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x0009FFFF, 
                Zero, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0x0009FFFF, 
                One, 
                LNKB, 
                Zero
            }, 

            Package (0x04)
            {
                0x0009FFFF, 
                0x02, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x0009FFFF, 
                0x03, 
                LNKD, 
                Zero
            }, 

            Package (0x04)
            {
                0x000AFFFF, 
                Zero, 
                LNKB, 
                Zero
            }, 

            Package (0x04)
            {
                0x000AFFFF, 
                One, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x000AFFFF, 
                0x02, 
                LNKD, 
                Zero
            }, 

            Package (0x04)
            {
                0x000AFFFF, 
                0x03, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0x000BFFFF, 
                Zero, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x000BFFFF, 
                One, 
                LNKD, 
                Zero
            }, 

            Package (0x04)
            {
                0x000BFFFF, 
                0x02, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0x000BFFFF, 
                0x03, 
                LNKB, 
                Zero
            }, 

            Package (0x04)
            {
                0x000CFFFF, 
                Zero, 
                LNKD, 
                Zero
            }, 

            Package (0x04)
            {
                0x000CFFFF, 
                One, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0x000CFFFF, 
                0x02, 
                LNKB, 
                Zero
            }, 

            Package (0x04)
            {
                0x000CFFFF, 
                0x03, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x000DFFFF, 
                Zero, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0x000DFFFF, 
                One, 
                LNKB, 
                Zero
            }, 

            Package (0x04)
            {
                0x000DFFFF, 
                0x02, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x000DFFFF, 
                0x03, 
                LNKD, 
                Zero
            }, 

            Package (0x04)
            {
                0x000EFFFF, 
                Zero, 
                LNKB, 
                Zero
            }, 

            Package (0x04)
            {
                0x000EFFFF, 
                One, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x000EFFFF, 
                0x02, 
                LNKD, 
                Zero
            }, 

            Package (0x04)
            {
                0x000EFFFF, 
                0x03, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0x000FFFFF, 
                Zero, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x000FFFFF, 
                One, 
                LNKD, 
                Zero
            }, 

            Package (0x04)
            {
                0x000FFFFF, 
                0x02, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0x000FFFFF, 
                0x03, 
                LNKB, 
                Zero
            }, 

            Package (0x04)
            {
                0x0010FFFF, 
                Zero, 
                LNKD, 
                Zero
            }, 

            Package (0x04)
            {
                0x0010FFFF, 
                One, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0x0010FFFF, 
                0x02, 
                LNKB, 
                Zero
            }, 

            Package (0x04)
            {
                0x0010FFFF, 
                0x03, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x0011FFFF, 
                Zero, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0x0011FFFF, 
                One, 
                LNKB, 
                Zero
            }, 

            Package (0x04)
            {
                0x0011FFFF, 
                0x02, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x0011FFFF, 
                0x03, 
                LNKD, 
                Zero
            }, 

            Package (0x04)
            {
                0x0012FFFF, 
                Zero, 
                LNKB, 
                Zero
            }, 

            Package (0x04)
            {
                0x0012FFFF, 
                One, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x0012FFFF, 
                0x02, 
                LNKD, 
                Zero
            }, 

            Package (0x04)
            {
                0x0012FFFF, 
                0x03, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0x0013FFFF, 
                Zero, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x0013FFFF, 
                One, 
                LNKD, 
                Zero
            }, 

            Package (0x04)
            {
                0x0013FFFF, 
                0x02, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0x0013FFFF, 
                0x03, 
                LNKB, 
                Zero
            }, 

            Package (0x04)
            {
                0x0014FFFF, 
                Zero, 
                LNKD, 
                Zero
            }, 

            Package (0x04)
            {
                0x0014FFFF, 
                One, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0x0014FFFF, 
                0x02, 
                LNKB, 
                Zero
            }, 

            Package (0x04)
            {
                0x0014FFFF, 
                0x03, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x0015FFFF, 
                Zero, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0x0015FFFF, 
                One, 
                LNKB, 
                Zero
            }, 

            Package (0x04)
            {
                0x0015FFFF, 
                0x02, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x0015FFFF, 
                0x03, 
                LNKD, 
                Zero
            }, 

            Package (0x04)
            {
                0x0016FFFF, 
                Zero, 
                LNKB, 
                Zero
            }, 

            Package (0x04)
            {
                0x0016FFFF, 
                One, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x0016FFFF, 
                0x02, 
                LNKD, 
                Zero
            }, 

            Package (0x04)
            {
                0x0016FFFF, 
                0x03, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0x0017FFFF, 
                Zero, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x0017FFFF, 
                One, 
                LNKD, 
                Zero
            }, 

            Package (0x04)
            {
                0x0017FFFF, 
                0x02, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0x0017FFFF, 
                0x03, 
                LNKB, 
                Zero
            }, 

            Package (0x04)
            {
                0x0018FFFF, 
                Zero, 
                LNKD, 
                Zero
            }, 

            Package (0x04)
            {
                0x0018FFFF, 
                One, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0x0018FFFF, 
                0x02, 
                LNKB, 
                Zero
            }, 

            Package (0x04)
            {
                0x0018FFFF, 
                0x03, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x0019FFFF, 
                Zero, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0x0019FFFF, 
                One, 
                LNKB, 
                Zero
            }, 

            Package (0x04)
            {
                0x0019FFFF, 
                0x02, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x0019FFFF, 
                0x03, 
                LNKD, 
                Zero
            }, 

            Package (0x04)
            {
                0x001AFFFF, 
                Zero, 
                LNKB, 
                Zero
            }, 

            Package (0x04)
            {
                0x001AFFFF, 
                One, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x001AFFFF, 
                0x02, 
                LNKD, 
                Zero
            }, 

            Package (0x04)
            {
                0x001AFFFF, 
                0x03, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0x001BFFFF, 
                Zero, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x001BFFFF, 
                One, 
                LNKD, 
                Zero
            }, 

            Package (0x04)
            {
                0x001BFFFF, 
                0x02, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0x001BFFFF, 
                0x03, 
                LNKB, 
                Zero
            }, 

            Package (0x04)
            {
                0x001CFFFF, 
                Zero, 
                LNKD, 
                Zero
            }, 

            Package (0x04)
            {
                0x001CFFFF, 
                One, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0x001CFFFF, 
                0x02, 
                LNKB, 
                Zero
            }, 

            Package (0x04)
            {
                0x001CFFFF, 
                0x03, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x001DFFFF, 
                Zero, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0x001DFFFF, 
                One, 
                LNKB, 
                Zero
            }, 

            Package (0x04)
            {
                0x001DFFFF, 
                0x02, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x001DFFFF, 
                0x03, 
                LNKD, 
                Zero
            }, 

            Package (0x04)
            {
                0x001EFFFF, 
                Zero, 
                LNKB, 
                Zero
            }, 

            Package (0x04)
            {
                0x001EFFFF, 
                One, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x001EFFFF, 
                0x02, 
                LNKD, 
                Zero
            }, 

            Package (0x04)
            {
                0x001EFFFF, 
                0x03, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0x001FFFFF, 
                Zero, 
                LNKC, 
                Zero
            }, 

            Package (0x04)
            {
                0x001FFFFF, 
                One, 
                LNKD, 
                Zero
            }, 

            Package (0x04)
            {
                0x001FFFFF, 
                0x02, 
                LNKA, 
                Zero
            }, 

            Package (0x04)
            {
                0x001FFFFF, 
                0x03, 
                LNKB, 
                Zero
            }
        })
        Name (PR01, Package (0x78)
        {
            Package (0x04)
            {
                0x0002FFFF, 
                Zero, 
                Zero, 
                0x12
            }, 

            Package (0x04)
            {
                0x0002FFFF, 
                One, 
                Zero, 
                0x13
            }, 

            Package (0x04)
            {
                0x0002FFFF, 
                0x02, 
                Zero, 
                0x14
            }, 

            Package (0x04)
            {
                0x0002FFFF, 
                0x03, 
                Zero, 
                0x15
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                Zero, 
                Zero, 
                0x13
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                One, 
                Zero, 
                0x14
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                0x02, 
                Zero, 
                0x15
            }, 

            Package (0x04)
            {
                0x0003FFFF, 
                0x03, 
                Zero, 
                0x16
            }, 

            Package (0x04)
            {
                0x0004FFFF, 
                Zero, 
                Zero, 
                0x14
            }, 

            Package (0x04)
            {
                0x0004FFFF, 
                One, 
                Zero, 
                0x15
            }, 

            Package (0x04)
            {
                0x0004FFFF, 
                0x02, 
                Zero, 
                0x16
            }, 

            Package (0x04)
            {
                0x0004FFFF, 
                0x03, 
                Zero, 
                0x17
            }, 

            Package (0x04)
            {
                0x0005FFFF, 
                Zero, 
                Zero, 
                0x15
            }, 

            Package (0x04)
            {
                0x0005FFFF, 
                One, 
                Zero, 
                0x16
            }, 

            Package (0x04)
            {
                0x0005FFFF, 
                0x02, 
                Zero, 
                0x17
            }, 

            Package (0x04)
            {
                0x0005FFFF, 
                0x03, 
                Zero, 
                0x10
            }, 

            Package (0x04)
            {
                0x0006FFFF, 
                Zero, 
                Zero, 
                0x16
            }, 

            Package (0x04)
            {
                0x0006FFFF, 
                One, 
                Zero, 
                0x17
            }, 

            Package (0x04)
            {
                0x0006FFFF, 
                0x02, 
                Zero, 
                0x10
            }, 

            Package (0x04)
            {
                0x0006FFFF, 
                0x03, 
                Zero, 
                0x11
            }, 

            Package (0x04)
            {
                0x0007FFFF, 
                Zero, 
                Zero, 
                0x17
            }, 

            Package (0x04)
            {
                0x0007FFFF, 
                One, 
                Zero, 
                0x10
            }, 

            Package (0x04)
            {
                0x0007FFFF, 
                0x02, 
                Zero, 
                0x11
            }, 

            Package (0x04)
            {
                0x0007FFFF, 
                0x03, 
                Zero, 
                0x12
            }, 

            Package (0x04)
            {
                0x0008FFFF, 
                Zero, 
                Zero, 
                0x10
            }, 

            Package (0x04)
            {
                0x0008FFFF, 
                One, 
                Zero, 
                0x11
            }, 

            Package (0x04)
            {
                0x0008FFFF, 
                0x02, 
                Zero, 
                0x12
            }, 

            Package (0x04)
            {
                0x0008FFFF, 
                0x03, 
                Zero, 
                0x13
            }, 

            Package (0x04)
            {
                0x0009FFFF, 
                Zero, 
                Zero, 
                0x11
            }, 

            Package (0x04)
            {
                0x0009FFFF, 
                One, 
                Zero, 
                0x12
            }, 

            Package (0x04)
            {
                0x0009FFFF, 
                0x02, 
                Zero, 
                0x13
            }, 

            Package (0x04)
            {
                0x0009FFFF, 
                0x03, 
                Zero, 
                0x14
            }, 

            Package (0x04)
            {
                0x000AFFFF, 
                Zero, 
                Zero, 
                0x12
            }, 

            Package (0x04)
            {
                0x000AFFFF, 
                One, 
                Zero, 
                0x13
            }, 

            Package (0x04)
            {
                0x000AFFFF, 
                0x02, 
                Zero, 
                0x14
            }, 

            Package (0x04)
            {
                0x000AFFFF, 
                0x03, 
                Zero, 
                0x15
            }, 

            Package (0x04)
            {
                0x000BFFFF, 
                Zero, 
                Zero, 
                0x13
            }, 

            Package (0x04)
            {
                0x000BFFFF, 
                One, 
                Zero, 
                0x14
            }, 

            Package (0x04)
            {
                0x000BFFFF, 
                0x02, 
                Zero, 
                0x15
            }, 

            Package (0x04)
            {
                0x000BFFFF, 
                0x03, 
                Zero, 
                0x16
            }, 

            Package (0x04)
            {
                0x000CFFFF, 
                Zero, 
                Zero, 
                0x14
            }, 

            Package (0x04)
            {
                0x000CFFFF, 
                One, 
                Zero, 
                0x15
            }, 

            Package (0x04)
            {
                0x000CFFFF, 
                0x02, 
                Zero, 
                0x16
            }, 

            Package (0x04)
            {
                0x000CFFFF, 
                0x03, 
                Zero, 
                0x17
            }, 

            Package (0x04)
            {
                0x000DFFFF, 
                Zero, 
                Zero, 
                0x15
            }, 

            Package (0x04)
            {
                0x000DFFFF, 
                One, 
                Zero, 
                0x16
            }, 

            Package (0x04)
            {
                0x000DFFFF, 
                0x02, 
                Zero, 
                0x17
            }, 

            Package (0x04)
            {
                0x000DFFFF, 
                0x03, 
                Zero, 
                0x10
            }, 

            Package (0x04)
            {
                0x000EFFFF, 
                Zero, 
                Zero, 
                0x16
            }, 

            Package (0x04)
            {
                0x000EFFFF, 
                One, 
                Zero, 
                0x17
            }, 

            Package (0x04)
            {
                0x000EFFFF, 
                0x02, 
                Zero, 
                0x10
            }, 

            Package (0x04)
            {
                0x000EFFFF, 
                0x03, 
                Zero, 
                0x11
            }, 

            Package (0x04)
            {
                0x000FFFFF, 
                Zero, 
                Zero, 
                0x17
            }, 

            Package (0x04)
            {
                0x000FFFFF, 
                One, 
                Zero, 
                0x10
            }, 

            Package (0x04)
            {
                0x000FFFFF, 
                0x02, 
                Zero, 
                0x11
            }, 

            Package (0x04)
            {
                0x000FFFFF, 
                0x03, 
                Zero, 
                0x12
            }, 

            Package (0x04)
            {
                0x0010FFFF, 
                Zero, 
                Zero, 
                0x10
            }, 

            Package (0x04)
            {
                0x0010FFFF, 
                One, 
                Zero, 
                0x11
            }, 

            Package (0x04)
            {
                0x0010FFFF, 
                0x02, 
                Zero, 
                0x12
            }, 

            Package (0x04)
            {
                0x0010FFFF, 
                0x03, 
                Zero, 
                0x13
            }, 

            Package (0x04)
            {
                0x0011FFFF, 
                Zero, 
                Zero, 
                0x11
            }, 

            Package (0x04)
            {
                0x0011FFFF, 
                One, 
                Zero, 
                0x12
            }, 

            Package (0x04)
            {
                0x0011FFFF, 
                0x02, 
                Zero, 
                0x13
            }, 

            Package (0x04)
            {
                0x0011FFFF, 
                0x03, 
                Zero, 
                0x14
            }, 

            Package (0x04)
            {
                0x0012FFFF, 
                Zero, 
                Zero, 
                0x12
            }, 

            Package (0x04)
            {
                0x0012FFFF, 
                One, 
                Zero, 
                0x13
            }, 

            Package (0x04)
            {
                0x0012FFFF, 
                0x02, 
                Zero, 
                0x14
            }, 

            Package (0x04)
            {
                0x0012FFFF, 
                0x03, 
                Zero, 
                0x15
            }, 

            Package (0x04)
            {
                0x0013FFFF, 
                Zero, 
                Zero, 
                0x13
            }, 

            Package (0x04)
            {
                0x0013FFFF, 
                One, 
                Zero, 
                0x14
            }, 

            Package (0x04)
            {
                0x0013FFFF, 
                0x02, 
                Zero, 
                0x15
            }, 

            Package (0x04)
            {
                0x0013FFFF, 
                0x03, 
                Zero, 
                0x16
            }, 

            Package (0x04)
            {
                0x0014FFFF, 
                Zero, 
                Zero, 
                0x14
            }, 

            Package (0x04)
            {
                0x0014FFFF, 
                One, 
                Zero, 
                0x15
            }, 

            Package (0x04)
            {
                0x0014FFFF, 
                0x02, 
                Zero, 
                0x16
            }, 

            Package (0x04)
            {
                0x0014FFFF, 
                0x03, 
                Zero, 
                0x17
            }, 

            Package (0x04)
            {
                0x0015FFFF, 
                Zero, 
                Zero, 
                0x15
            }, 

            Package (0x04)
            {
                0x0015FFFF, 
                One, 
                Zero, 
                0x16
            }, 

            Package (0x04)
            {
                0x0015FFFF, 
                0x02, 
                Zero, 
                0x17
            }, 

            Package (0x04)
            {
                0x0015FFFF, 
                0x03, 
                Zero, 
                0x10
            }, 

            Package (0x04)
            {
                0x0016FFFF, 
                Zero, 
                Zero, 
                0x16
            }, 

            Package (0x04)
            {
                0x0016FFFF, 
                One, 
                Zero, 
                0x17
            }, 

            Package (0x04)
            {
                0x0016FFFF, 
                0x02, 
                Zero, 
                0x10
            }, 

            Package (0x04)
            {
                0x0016FFFF, 
                0x03, 
                Zero, 
                0x11
            }, 

            Package (0x04)
            {
                0x0017FFFF, 
                Zero, 
                Zero, 
                0x17
            }, 

            Package (0x04)
            {
                0x0017FFFF, 
                One, 
                Zero, 
                0x10
            }, 

            Package (0x04)
            {
                0x0017FFFF, 
                0x02, 
                Zero, 
                0x11
            }, 

            Package (0x04)
            {
                0x0017FFFF, 
                0x03, 
                Zero, 
                0x12
            }, 

            Package (0x04)
            {
                0x0018FFFF, 
                Zero, 
                Zero, 
                0x10
            }, 

            Package (0x04)
            {
                0x0018FFFF, 
                One, 
                Zero, 
                0x11
            }, 

            Package (0x04)
            {
                0x0018FFFF, 
                0x02, 
                Zero, 
                0x12
            }, 

            Package (0x04)
            {
                0x0018FFFF, 
                0x03, 
                Zero, 
                0x13
            }, 

            Package (0x04)
            {
                0x0019FFFF, 
                Zero, 
                Zero, 
                0x11
            }, 

            Package (0x04)
            {
                0x0019FFFF, 
                One, 
                Zero, 
                0x12
            }, 

            Package (0x04)
            {
                0x0019FFFF, 
                0x02, 
                Zero, 
                0x13
            }, 

            Package (0x04)
            {
                0x0019FFFF, 
                0x03, 
                Zero, 
                0x14
            }, 

            Package (0x04)
            {
                0x001AFFFF, 
                Zero, 
                Zero, 
                0x12
            }, 

            Package (0x04)
            {
                0x001AFFFF, 
                One, 
                Zero, 
                0x13
            }, 

            Package (0x04)
            {
                0x001AFFFF, 
                0x02, 
                Zero, 
                0x14
            }, 

            Package (0x04)
            {
                0x001AFFFF, 
                0x03, 
                Zero, 
                0x15
            }, 

            Package (0x04)
            {
                0x001BFFFF, 
                Zero, 
                Zero, 
                0x13
            }, 

            Package (0x04)
            {
                0x001BFFFF, 
                One, 
                Zero, 
                0x14
            }, 

            Package (0x04)
            {
                0x001BFFFF, 
                0x02, 
                Zero, 
                0x15
            }, 

            Package (0x04)
            {
                0x001BFFFF, 
                0x03, 
                Zero, 
                0x16
            }, 

            Package (0x04)
            {
                0x001CFFFF, 
                Zero, 
                Zero, 
                0x14
            }, 

            Package (0x04)
            {
                0x001CFFFF, 
                One, 
                Zero, 
                0x15
            }, 

            Package (0x04)
            {
                0x001CFFFF, 
                0x02, 
                Zero, 
                0x16
            }, 

            Package (0x04)
            {
                0x001CFFFF, 
                0x03, 
                Zero, 
                0x17
            }, 

            Package (0x04)
            {
                0x001DFFFF, 
                Zero, 
                Zero, 
                0x15
            }, 

            Package (0x04)
            {
                0x001DFFFF, 
                One, 
                Zero, 
                0x16
            }, 

            Package (0x04)
            {
                0x001DFFFF, 
                0x02, 
                Zero, 
                0x17
            }, 

            Package (0x04)
            {
                0x001DFFFF, 
                0x03, 
                Zero, 
                0x10
            }, 

            Package (0x04)
            {
                0x001EFFFF, 
                Zero, 
                Zero, 
                0x16
            }, 

            Package (0x04)
            {
                0x001EFFFF, 
                One, 
                Zero, 
                0x17
            }, 

            Package (0x04)
            {
                0x001EFFFF, 
                0x02, 
                Zero, 
                0x10
            }, 

            Package (0x04)
            {
                0x001EFFFF, 
                0x03, 
                Zero, 
                0x11
            }, 

            Package (0x04)
            {
                0x001FFFFF, 
                Zero, 
                Zero, 
                0x17
            }, 

            Package (0x04)
            {
                0x001FFFFF, 
                One, 
                Zero, 
                0x10
            }, 

            Package (0x04)
            {
                0x001FFFFF, 
                0x02, 
                Zero, 
                0x11
            }, 

            Package (0x04)
            {
                0x001FFFFF, 
                0x03, 
                Zero, 
                0x12
            }
        })
        Name (PRSA, ResourceTemplate ()
        {
            IRQ (Level, ActiveLow, Shared, )
                {5,9,10,11}
        })
        Name (PRSB, ResourceTemplate ()
        {
            IRQ (Level, ActiveLow, Shared, )
                {5,9,10,11}
        })
        Name (PRSC, ResourceTemplate ()
        {
            IRQ (Level, ActiveLow, Shared, )
                {5,9,10,11}
        })
        Name (PRSD, ResourceTemplate ()
        {
            IRQ (Level, ActiveLow, Shared, )
                {5,9,10,11}
        })
        Device (PCI0)
        {
            Name (_HID, EisaId ("PNP0A03"))
            Method (_ADR, 0, NotSerialized)
            {
                Return (HBCA)
            }

            Name (_BBN, Zero)
            Name (_UID, Zero)
            Method (_PRT, 0, NotSerialized)
            {
                If (LEqual (LAnd (PICM, UIOA), Zero))
                {
                    DBG ("RETURNING PIC\n")
                    Store (Zero, ^SBRG.APDE)
                    Store (Zero, ^SBRG.APAD)
                    Return (PR00)
                }
                Else
                {
                    DBG ("RETURNING APIC\n")
                    Store (0xBE, ^SBRG.APDE)
                    Store (0xEF, ^SBRG.APAD)
                    Return (PR01)
                }
            }

            Device (SBRG)
            {
                Method (_ADR, 0, NotSerialized)
                {
                    Return (IOCA)
                }

                OperationRegion (PCIC, PCI_Config, Zero, 0xFF)
                Field (PCIC, ByteAcc, NoLock, Preserve)
                {
                    Offset (0xAD), 
                    APAD,   8, 
                    Offset (0xDE), 
                    APDE,   8
                }

                Device (^PCIE)
                {
                    Name (_HID, EisaId ("PNP0C02"))
                    Name (_UID, 0x11)
                    Name (CRS, ResourceTemplate ()
                    {
                        Memory32Fixed (ReadOnly,
                            0xDC000000,         // Address Base
                            0x04000000,         // Address Length
                            _Y00)
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        CreateDWordField (CRS, \_SB.PCI0.PCIE._Y00._BAS, BAS1)
                        CreateDWordField (CRS, \_SB.PCI0.PCIE._Y00._LEN, LEN1)
                        Store (PCIB, BAS1)
                        Store (PCIL, LEN1)
                        Return (CRS)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (LEqual (PCIB, Zero))
                        {
                            Return (Zero)
                        }
                        Else
                        {
                            Return (0x0E)
                        }
                    }
                }

                Device (PS2K)
                {
                    Name (_HID, EisaId ("PNP0303"))
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }

                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0060,             // Range Minimum
                            0x0060,             // Range Maximum
                            0x00,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0064,             // Range Minimum
                            0x0064,             // Range Maximum
                            0x00,               // Alignment
                            0x01,               // Length
                            )
                        IRQNoFlags ()
                            {1}
                    })
                }

                Device (DMAC)
                {
                    Name (_HID, EisaId ("PNP0200"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0000,             // Range Minimum
                            0x0000,             // Range Maximum
                            0x01,               // Alignment
                            0x10,               // Length
                            )
                        IO (Decode16,
                            0x0080,             // Range Minimum
                            0x0080,             // Range Maximum
                            0x01,               // Alignment
                            0x10,               // Length
                            )
                        IO (Decode16,
                            0x00C0,             // Range Minimum
                            0x00C0,             // Range Maximum
                            0x01,               // Alignment
                            0x20,               // Length
                            )
                        DMA (Compatibility, BusMaster, Transfer8_16, )
                            {4}
                    })
                }

                Device (FDC0)
                {
                    Name (_HID, EisaId ("PNP0700"))
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (UFDC)
                    }

                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x03F0,             // Range Minimum
                            0x03F0,             // Range Maximum
                            0x01,               // Alignment
                            0x06,               // Length
                            )
                        IO (Decode16,
                            0x03F7,             // Range Minimum
                            0x03F7,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IRQNoFlags ()
                            {6}
                        DMA (Compatibility, NotBusMaster, Transfer8, )
                            {2}
                    })
                    Name (_PRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x03F0,             // Range Minimum
                            0x03F0,             // Range Maximum
                            0x01,               // Alignment
                            0x06,               // Length
                            )
                        IO (Decode16,
                            0x03F7,             // Range Minimum
                            0x03F7,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IRQNoFlags ()
                            {6}
                        DMA (Compatibility, NotBusMaster, Transfer8, )
                            {2}
                    })
                }

                Device (PS2M)
                {
                    Name (_HID, EisaId ("PNP0F03"))
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }

                    Name (_CRS, ResourceTemplate ()
                    {
                        IRQNoFlags ()
                            {12}
                    })
                }

                Device (LPT)
                {
                    Name (_HID, EisaId ("PNP0400"))
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }

                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0378,             // Range Minimum
                            0x0378,             // Range Maximum
                            0x08,               // Alignment
                            0x08,               // Length
                            )
                        IO (Decode16,
                            0x0778,             // Range Minimum
                            0x0778,             // Range Maximum
                            0x08,               // Alignment
                            0x08,               // Length
                            )
                        IRQNoFlags ()
                            {7}
                    })
                }

                Device (^SRL0)
                {
                    Name (_HID, EisaId ("PNP0501"))
                    Name (_UID, One)
                    Method (_STA, 0, NotSerialized)
                    {
                        If (LEqual (SL0B, Zero))
                        {
                            Return (Zero)
                        }
                        Else
                        {
                            Return (0x0F)
                        }
                    }

                    Name (CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x03F8,             // Range Minimum
                            0x03F8,             // Range Maximum
                            0x01,               // Alignment
                            0x08,               // Length
                            _Y01)
                        IRQNoFlags (_Y02)
                            {4}
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        CreateWordField (CRS, \_SB.PCI0.SRL0._Y01._MIN, MIN0)
                        CreateWordField (CRS, \_SB.PCI0.SRL0._Y01._MAX, MAX0)
                        CreateWordField (CRS, \_SB.PCI0.SRL0._Y02._INT, IRQ0)
                        Store (SL0B, MIN0)
                        Store (SL0B, MAX0)
                        ShiftLeft (One, SL0I, IRQ0)
                        Return (CRS)
                    }
                }

                Device (^SRL1)
                {
                    Name (_HID, EisaId ("PNP0501"))
                    Name (_UID, 0x02)
                    Method (_STA, 0, NotSerialized)
                    {
                        If (LEqual (SL1B, Zero))
                        {
                            Return (Zero)
                        }
                        Else
                        {
                            Return (0x0F)
                        }
                    }

                    Name (CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x02F8,             // Range Minimum
                            0x02F8,             // Range Maximum
                            0x01,               // Alignment
                            0x08,               // Length
                            _Y03)
                        IRQNoFlags (_Y04)
                            {3}
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        CreateWordField (CRS, \_SB.PCI0.SRL1._Y03._MIN, MIN1)
                        CreateWordField (CRS, \_SB.PCI0.SRL1._Y03._MAX, MAX1)
                        CreateWordField (CRS, \_SB.PCI0.SRL1._Y04._INT, IRQ1)
                        Store (SL1B, MIN1)
                        Store (SL1B, MAX1)
                        ShiftLeft (One, SL1I, IRQ1)
                        Return (CRS)
                    }
                }

                Device (TIMR)
                {
                    Name (_HID, EisaId ("PNP0100"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0040,             // Range Minimum
                            0x0040,             // Range Maximum
                            0x00,               // Alignment
                            0x04,               // Length
                            )
                        IO (Decode16,
                            0x0050,             // Range Minimum
                            0x0050,             // Range Maximum
                            0x10,               // Alignment
                            0x04,               // Length
                            )
                    })
                }

                Device (PIC)
                {
                    Name (_HID, EisaId ("PNP0000"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0020,             // Range Minimum
                            0x0020,             // Range Maximum
                            0x00,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00A0,             // Range Minimum
                            0x00A0,             // Range Maximum
                            0x00,               // Alignment
                            0x02,               // Length
                            )
                        IRQNoFlags ()
                            {2}
                    })
                }

                Device (RTC)
                {
                    Name (_HID, EisaId ("PNP0B00"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0070,             // Range Minimum
                            0x0070,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (URTC)
                    }
                }

                Device (HPET)
                {
                    Name (_HID, EisaId ("PNP0103"))
                    Name (_CID, EisaId ("PNP0C01"))
                    Name (_UID, Zero)
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (UHPT)
                    }

                    Name (CRS, ResourceTemplate ()
                    {
                        IRQNoFlags ()
                            {0}
                        IRQNoFlags ()
                            {8}
                        Memory32Fixed (ReadWrite,
                            0xFED00000,         // Address Base
                            0x00000400,         // Address Length
                            )
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        Return (CRS)
                    }
                }

                Device (SMC)
                {
                    Name (_HID, EisaId ("APP0001"))
                    Name (_CID, "smc-napa")
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (USMC)
                    }

                    Name (CRS, ResourceTemplate ()
                    {
                        IO (Decode16,
                            0x0300,             // Range Minimum
                            0x0300,             // Range Maximum
                            0x01,               // Alignment
                            0x20,               // Length
                            )
                        IRQNoFlags ()
                            {6}
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        Return (CRS)
                    }
                }
            }

            Device (GIGE)
            {
                Name (_HID, EisaId ("PNP8390"))
                Method (_ADR, 0, NotSerialized)
                {
                    Return (NICA)
                }

                Method (EWOL, 1, NotSerialized)
                {
                    Return (Zero)
                }

                Method (_STA, 0, NotSerialized)
                {
                    If (LEqual (NICA, Zero))
                    {
                        Return (Zero)
                    }
                    Else
                    {
                        Return (0x0F)
                    }
                }
            }

            Device (HDEF)
            {
                Method (_DSM, 4, NotSerialized)
                {
                    Store (Package (0x04)
                        {
                            "layout-id", 
                            Buffer (0x04)
                            {
                                 0x07, 0x00, 0x00, 0x00
                            }, 

                            "PinConfigurations", 
                            Buffer (Zero) {}
                        }, Local0)
                    If (LEqual (Arg0, Buffer (0x10)
                            {
                                /* 0000 */   0xC6, 0xB7, 0xB5, 0xA0, 0x18, 0x13, 0x1C, 0x44,
                                /* 0008 */   0xB0, 0xC9, 0xFE, 0x69, 0x5E, 0xAF, 0x94, 0x9B
                            }))
                    {
                        If (LEqual (Arg1, One))
                        {
                            If (LEqual (Arg2, Zero))
                            {
                                Store (Buffer (One)
                                    {
                                         0x03
                                    }, Local0)
                                Return (Local0)
                            }

                            If (LEqual (Arg2, One))
                            {
                                Return (Local0)
                            }
                        }
                    }

                    Store (Buffer (One)
                        {
                             0x00
                        }, Local0)
                    Return (Local0)
                }

                Method (_ADR, 0, NotSerialized)
                {
                    Return (HDAA)
                }

                Method (_STA, 0, NotSerialized)
                {
                    If (LEqual (HDAA, Zero))
                    {
                        Return (Zero)
                    }
                    Else
                    {
                        Return (0x0F)
                    }
                }
            }

            Device (BAT0)
            {
                Name (_HID, EisaId ("PNP0C0A"))
                Name (_UID, Zero)
                Scope (\_GPE)
                {
                    Method (_L00, 0, NotSerialized)
                    {
                        Notify (\_SB.PCI0.BAT0, 0x81)
                    }
                }

                OperationRegion (CBAT, SystemIO, 0x4040, 0x08)
                Field (CBAT, DWordAcc, NoLock, Preserve)
                {
                    IDX0,   32, 
                    DAT0,   32
                }

                IndexField (IDX0, DAT0, DWordAcc, NoLock, Preserve)
                {
                    STAT,   32, 
                    PRAT,   32, 
                    RCAP,   32, 
                    PVOL,   32, 
                    UNIT,   32, 
                    DCAP,   32, 
                    LFCP,   32, 
                    BTEC,   32, 
                    DVOL,   32, 
                    DWRN,   32, 
                    DLOW,   32, 
                    GRN1,   32, 
                    GRN2,   32, 
                    BSTA,   32, 
                    APSR,   32
                }

                Method (_STA, 0, NotSerialized)
                {
                    Return (BSTA)
                }

                Name (PBIF, Package (0x0D)
                {
                    One, 
                    0x7FFFFFFF, 
                    0x7FFFFFFF, 
                    Zero, 
                    Ones, 
                    Zero, 
                    Zero, 
                    0x04, 
                    0x04, 
                    "1", 
                    "0", 
                    "VBOX", 
                    "innotek"
                })
                Name (PBST, Package (0x04)
                {
                    Zero, 
                    0x7FFFFFFF, 
                    0x7FFFFFFF, 
                    0x7FFFFFFF
                })
                Method (_BIF, 0, NotSerialized)
                {
                    Store (UNIT, Index (PBIF, Zero))
                    Store (DCAP, Index (PBIF, One))
                    Store (LFCP, Index (PBIF, 0x02))
                    Store (BTEC, Index (PBIF, 0x03))
                    Store (DVOL, Index (PBIF, 0x04))
                    Store (DWRN, Index (PBIF, 0x05))
                    Store (DLOW, Index (PBIF, 0x06))
                    Store (GRN1, Index (PBIF, 0x07))
                    Store (GRN2, Index (PBIF, 0x08))
                    DBG ("_BIF:\n")
                    HEX4 (DerefOf (Index (PBIF, Zero)))
                    HEX4 (DerefOf (Index (PBIF, One)))
                    HEX4 (DerefOf (Index (PBIF, 0x02)))
                    HEX4 (DerefOf (Index (PBIF, 0x03)))
                    HEX4 (DerefOf (Index (PBIF, 0x04)))
                    HEX4 (DerefOf (Index (PBIF, 0x05)))
                    HEX4 (DerefOf (Index (PBIF, 0x06)))
                    HEX4 (DerefOf (Index (PBIF, 0x07)))
                    HEX4 (DerefOf (Index (PBIF, 0x08)))
                    Return (PBIF)
                }

                Method (_BST, 0, NotSerialized)
                {
                    Store (STAT, Index (PBST, Zero))
                    Store (PRAT, Index (PBST, One))
                    Store (RCAP, Index (PBST, 0x02))
                    Store (PVOL, Index (PBST, 0x03))
                    Return (PBST)
                }
            }

            Device (AC)
            {
                Name (_HID, "ACPI0003")
                Name (_UID, Zero)
                Name (_PCL, Package (0x01)
                {
                    _SB
                })
                Method (_PSR, 0, NotSerialized)
                {
                    Return (^^BAT0.APSR)
                }

                Method (_STA, 0, NotSerialized)
                {
                    Return (0x0F)
                }
            }
        }
    }

    Scope (_SB)
    {
        Scope (PCI0)
        {
            Name (CRS, ResourceTemplate ()
            {
                WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                    0x0000,             // Granularity
                    0x0000,             // Range Minimum
                    0x00FF,             // Range Maximum
                    0x0000,             // Translation Offset
                    0x0100,             // Length
                    ,, )
                IO (Decode16,
                    0x0CF8,             // Range Minimum
                    0x0CF8,             // Range Maximum
                    0x01,               // Alignment
                    0x08,               // Length
                    )
                WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x0000,             // Granularity
                    0x0000,             // Range Minimum
                    0x0CF7,             // Range Maximum
                    0x0000,             // Translation Offset
                    0x0CF8,             // Length
                    ,, , TypeStatic)
                WordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x0000,             // Granularity
                    0x0D00,             // Range Minimum
                    0xFFFF,             // Range Maximum
                    0x0000,             // Translation Offset
                    0xF300,             // Length
                    ,, , TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000A0000,         // Range Minimum
                    0x000BFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00020000,         // Length
                    ,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinNotFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x00000000,         // Range Minimum
                    0xFFDFFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00000000,         // Length
                    ,, _Y05, AddressRangeMemory, TypeStatic)
            })
            Method (_CRS, 0, NotSerialized)
            {
                CreateDWordField (CRS, \_SB.PCI0._Y05._MIN, RAMT)
                CreateDWordField (CRS, \_SB.PCI0._Y05._LEN, RAMR)
                Store (MEML, RAMT)
                Subtract (0xFFE00000, RAMT, RAMR)
                Return (CRS)
            }
        }
    }

    Scope (_SB)
    {
        Field (PCI0.SBRG.PCIC, ByteAcc, NoLock, Preserve)
        {
            Offset (0x60), 
            PIRA,   8, 
            PIRB,   8, 
            PIRC,   8, 
            PIRD,   8
        }

        Name (BUFA, ResourceTemplate ()
        {
            IRQ (Level, ActiveLow, Shared, )
                {15}
        })
        CreateWordField (BUFA, One, ICRS)
        Method (LSTA, 1, NotSerialized)
        {
            And (Arg0, 0x80, Local0)
            If (Local0)
            {
                Return (0x09)
            }
            Else
            {
                Return (0x0B)
            }
        }

        Method (LCRS, 1, NotSerialized)
        {
            And (Arg0, 0x0F, Local0)
            ShiftLeft (One, Local0, ICRS)
            Return (BUFA)
        }

        Method (LSRS, 1, NotSerialized)
        {
            CreateWordField (Arg0, One, ISRS)
            FindSetRightBit (ISRS, Local0)
            Return (Decrement (Local0))
        }

        Method (LDIS, 1, NotSerialized)
        {
            Return (Or (Arg0, 0x80))
        }

        Device (LNKA)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, One)
            Method (_STA, 0, NotSerialized)
            {
                DBG ("LNKA._STA\n")
                Return (LSTA (PIRA))
            }

            Method (_PRS, 0, NotSerialized)
            {
                DBG ("LNKA._PRS\n")
                Return (PRSA)
            }

            Method (_DIS, 0, NotSerialized)
            {
                DBG ("LNKA._DIS\n")
                Store (LDIS (PIRA), PIRA)
            }

            Method (_CRS, 0, NotSerialized)
            {
                DBG ("LNKA._CRS\n")
                Return (LCRS (PIRA))
            }

            Method (_SRS, 1, NotSerialized)
            {
                DBG ("LNKA._SRS: ")
                HEX (LSRS (Arg0))
                Store (LSRS (Arg0), PIRA)
            }
        }

        Device (LNKB)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x02)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (PIRB))
            }

            Method (_PRS, 0, NotSerialized)
            {
                Return (PRSB)
            }

            Method (_DIS, 0, NotSerialized)
            {
                Store (LDIS (PIRB), PIRB)
            }

            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (PIRB))
            }

            Method (_SRS, 1, NotSerialized)
            {
                DBG ("LNKB._SRS: ")
                HEX (LSRS (Arg0))
                Store (LSRS (Arg0), PIRB)
            }
        }

        Device (LNKC)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x03)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (PIRC))
            }

            Method (_PRS, 0, NotSerialized)
            {
                Return (PRSC)
            }

            Method (_DIS, 0, NotSerialized)
            {
                Store (LDIS (PIRC), PIRC)
            }

            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (PIRC))
            }

            Method (_SRS, 1, NotSerialized)
            {
                DBG ("LNKC._SRS: ")
                HEX (LSRS (Arg0))
                Store (LSRS (Arg0), PIRC)
            }
        }

        Device (LNKD)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, 0x04)
            Method (_STA, 0, NotSerialized)
            {
                Return (LSTA (PIRD))
            }

            Method (_PRS, 0, NotSerialized)
            {
                Return (PRSD)
            }

            Method (_DIS, 0, NotSerialized)
            {
                Store (LDIS (PIRA), PIRD)
            }

            Method (_CRS, 0, NotSerialized)
            {
                Return (LCRS (PIRD))
            }

            Method (_SRS, 1, NotSerialized)
            {
                DBG ("LNKD._SRS: ")
                HEX (LSRS (Arg0))
                Store (LSRS (Arg0), PIRD)
            }
        }
    }

    Name (_S0, Package (0x02)
    {
        Zero, 
        Zero
    })
    If (And (PWRS, 0x02))
    {
        Name (_S1, Package (0x02)
        {
            One, 
            One
        })
    }

    If (And (PWRS, 0x10))
    {
        Name (_S4, Package (0x02)
        {
            0x05, 
            0x05
        })
    }

    Name (_S5, Package (0x02)
    {
        0x05, 
        0x05
    })
    Method (_PTS, 1, NotSerialized)
    {
        DBG ("Prepare to sleep: ")
        HEX (Arg0)
    }
}

