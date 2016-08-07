// All rights reserved ADENEO EMBEDDED 2010
//
// Copyright (c) Microsoft Corporation.  All rights reserved.
//
//
// Use of this sample source code is subject to the terms of the Microsoft
// license agreement under which you licensed this sample source code. If
// you did not accept the terms of the license agreement, you are not
// authorized to use this sample source code. For the terms of the license,
// please see the license agreement between you and Microsoft or, if applicable,
// see the LICENSE.RTF on your install media or the root of your tools installation.
// THE SAMPLE SOURCE CODE IS PROVIDED "AS IS", WITH NO WARRANTIES.
//
// -----------------------------------------------------------------------------
//
//      THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF
//      ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO
//      THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
//      PARTICULAR PURPOSE.
//
// -----------------------------------------------------------------------------

//
// hw_ac97.cpp
//
// functions for controlling hardware features of the AC97 Codec
//

#include "es1371.h"
#include <wavedbg.h>

void
CES1371::InitCodec()
{
  USHORT usCodecRead;
  UCHAR i;

  // write the Codec reset
  WriteCodecRegister( AC97_RESET, 0xffff );

  // read all the registers so we sync the states
  for ( i = AC97_RESET; i <= AC97_POWER_CONTROL; i += 2)
    usCodecRead = ReadCodecRegister( i );

  // get the Vendor ID and revision
  m_ulCodecVendorID = ULONG(ReadCodecRegister( AC97_VENDOR_ID1 )) << 16;
  usCodecRead = ReadCodecRegister( AC97_VENDOR_ID2 );
  m_ulCodecVendorID |= ULONG(usCodecRead) & 0x0000ff00;
  m_ulCodecRevision = ULONG(usCodecRead) & 0x000000ff;

  DEBUGMSG(ZONE_ERROR, (TEXT("ES1371 Codec Vendor ID: %08x '%c%c%c'\n"),
       m_ulCodecVendorID,
      (m_ulCodecVendorID >> 24) & 0xFF,
      (m_ulCodecVendorID >> 16) & 0xFF,
      (m_ulCodecVendorID >>  8) & 0xFF
      ));
  DEBUGMSG(ZONE_ERROR, (TEXT("ES1371 Codec Revision:  %02x\n"), m_ulCodecRevision));

  if ( !( m_ulCodecVendorID == AC97_VENDOR_CRYSTAL && m_ulCodecRevision == 0x13))
  {
      // now power down the Analog section of the AC97
      // and power it back up.  This forces the Crystal
      // AC97 to recalibrate its analog levels.
      Codec_SetPowerState( AC97_PWR_ANLOFF );

    //<mod:ce>  KeStallExecutionProcessor (100);
	  StallExecution(1000); // some older codecs require longer stall times
      Codec_SetPowerState( AC97_PWR_D0 );
  }


  // write master volume
  WriteCodecRegister( AC97_MASTER_VOL_STEREO, ES1371_INITIALVOLUME );

  // write the wave out volume
  WriteCodecRegister( AC97_PCMOUT_VOL, 0x0606 );

  // write the stereo analog lines volume
  WriteCodecRegister( AC97_LINEIN_VOL, 0x0808 );
  WriteCodecRegister( AC97_CD_VOL,     0x0808 );
  WriteCodecRegister( AC97_VIDEO_VOL,  0x0808 );
  WriteCodecRegister( AC97_AUX_VOL,    0x0808 );
  WriteCodecRegister( AC97_LINEIN_VOL, 0x0808 );

  // write the TAD volume
  WriteCodecRegister( AC97_PHONE_VOL, 0x0008 );

  // write the pc beep volume
  WriteCodecRegister( AC97_PCBEEP_VOL, 0x8000 );

  // turn on the mic boost but leave it muted
  WriteCodecRegister( AC97_MIC_VOL, 0x8048 );

  // set up the record mux for mic input
  WriteCodecRegister( AC97_RECORD_SELECT, AC97_RECMUX_MIC );

  // set up a default record gain
  WriteCodecRegister( AC97_RECORD_GAIN, ES1371_INITIALVOLUME );

  // set the mono output to mic instead of the default mix
  WriteCodecRegister( AC97_GENERAL_PURPOSE, AC97_GP_MIX );

  // and unmute it
  WriteCodecRegister( AC97_MASTER_VOL_MONO, 0x0000 );
}

void
CES1371::WriteCodecRegister(UCHAR Reg, USHORT Val)
{
    ULONG i;
//  ULONG dtemp, dinit;

    // Don't write if the value is the same as
    // what is in the register but always let writes
    // to the reset register go through.
    if ( (m_usCRegs[Reg/2] == Val) &&
         (AC97_RESET != Reg)  )
      return;

#ifdef DBG
    _DbgPrintF( DEBUGLVL_VERBOSE, ("[CodecWrite] Reg %x Val %x", Reg, Val));
#endif

    /* wait for WIP to go away */
    for( i = 0; i < 0x1000UL; ++i )
        if( !(READ_PORT_ULONG((PULONG)(m_pPciAddr + ES1371_dCODECCTL_OFF)) & (1UL << 30)) )
            break;

//    /* save the current state for later */
//    dinit = READ_PORT_ULONG((PULONG)(m_pPciAddr + ES1371_dSRCIO_OFF));
//
//    /* enable SRC state data in SRC mux */
//    for( i = 0; i < 0x1000UL; ++i )
//        if( !((dtemp = READ_PORT_ULONG((PULONG)(m_pPciAddr + ES1371_dSRCIO_OFF))) & SRC_BUSY) )
//            break;
//    WRITE_PORT_ULONG((PULONG)(m_pPciAddr + ES1371_dSRCIO_OFF), (dtemp & SRC_CTLMASK) | 0x00010000UL);
//
//    /* wait for a SAFE time to write addr/data and then do it */
////    _disable();
//    for( i = 0; i < 0x1000UL; ++i )
//        if( (READ_PORT_ULONG((PULONG)(m_pPciAddr + ES1371_dSRCIO_OFF)) & 0x00870000UL) ==
//                0x00010000UL )
//        break;

    WRITE_PORT_ULONG((PULONG)(m_pPciAddr + ES1371_dCODECCTL_OFF),
                        ((ULONG) Reg << 16) | Val);
////    _enable();
//
//    /* restore SRC reg */
//    for( i = 0; i < 0x1000UL; ++i )
//        if( !(READ_PORT_ULONG((PULONG)(m_pPciAddr + ES1371_dSRCIO_OFF)) & SRC_BUSY) )
//            break;
//     WRITE_PORT_ULONG((PULONG)(m_pPciAddr + ES1371_dSRCIO_OFF), dinit & SRC_CTLMASK );

    /* store the written value in our local storage */
    m_usCRegs[Reg/2] = Val;

    return;
}


USHORT
CES1371::ReadCodecRegister( UCHAR Reg )
{
    ULONG i, dtemp;
//  ULONG dinit;


    /* wait for WIP to go away saving the current state for later */
    for( i = 0; i < 0x1000UL; ++i )
        if( !(READ_PORT_ULONG((PULONG)(m_pPciAddr + ES1371_dCODECCTL_OFF)) & (1UL << 30)) )
            break;

    /* write addr w/data=0 and assert read request ... */

//    /* save the current state for later */
//    dinit = READ_PORT_ULONG((PULONG)(m_pPciAddr + ES1371_dSRCIO_OFF));
//
//    /* enable SRC state data in SRC mux */
//    for( i = 0; i < 0x1000UL; ++i )
//        if( !((dtemp = READ_PORT_ULONG((PULONG)(m_pPciAddr + ES1371_dSRCIO_OFF))) & SRC_BUSY) )
//            break;
//    WRITE_PORT_ULONG((PULONG)(m_pPciAddr + ES1371_dSRCIO_OFF), (dtemp & SRC_CTLMASK) | 0x00010000UL);
//
//    /* wait for a SAFE time to write a read request and then do it */
////    _disable();
//    for( i = 0; i < 0x1000UL; ++i )
//        if( (READ_PORT_ULONG((PULONG)(m_pPciAddr + ES1371_dSRCIO_OFF)) & 0x00870000UL) ==
//                0x00010000UL )
//        break;
//
    WRITE_PORT_ULONG((PULONG)(m_pPciAddr + ES1371_dCODECCTL_OFF),
                        ((ULONG) Reg << 16) | (1UL << 23));
//    _enable();

//    /* restore SRC reg */
//    for( i = 0; i < 0x1000UL; ++i )
//        if( !(READ_PORT_ULONG((PULONG)(m_pPciAddr + ES1371_dSRCIO_OFF)) & SRC_BUSY) )
//            break;
//    WRITE_PORT_ULONG((PULONG)(m_pPciAddr + ES1371_dSRCIO_OFF), dinit & SRC_CTLMASK );
//
    /* now wait for the data (RDY) */
    for( i = 0; i < 0x1000UL; ++i )
        if( READ_PORT_ULONG((PULONG)(m_pPciAddr + ES1371_dCODECCTL_OFF)) & (1UL << 31) )
            break;
    dtemp = READ_PORT_ULONG((PULONG)(m_pPciAddr + ES1371_dCODECCTL_OFF));

    /* store the read value in our local storage */
    m_usCRegs[Reg/2] = (USHORT) dtemp;

    return (USHORT) dtemp;
}


USHORT
CES1371::GetCodecRegisterValue( UCHAR Reg )
{
  return m_usCRegs[Reg/2];
}

//--------------------------------------------------------------------------
//
//  Codec_SetPowerState
//  Description:
//      The AC97 Codec has 4 power states (that are meaningful to us):
//        0x0000 - normal operation
//        0x1700 - fully powered down
//           AC97_PWR_PR0|AC97_PWR_PR1|AC97_PWR_PR2|AC97_PWR_PR4
//        0x1300 - powered down with analog mixer active
//           AC97_PWR_PR0|AC97_PWR_PR1|AC97_PWR_PR4
//        0x0800 - turn off analog mixer section
//           AC97_PWR_PR3
//
//      This procedure will transition the Codec from its current
//      state to the specified one.
//
//  Input:
//      ulNewState - the new AC97 power state
//
//--------------------------------------------------------------------------
ULONG
CES1371::Codec_SetPowerState( ULONG ulNewState )
{
  USHORT usAC97_PowerReg;
  ULONG delay_count;

  // if the AC97 is asleep wake it up.  since we only leave it asleep
  // or fully awake if it isn't awake it must be asleep
  if ( m_ulCodecPowerState )
  {
     UCHAR ucMiscCtl;

     // wake up the AC97 using the warm reset method
     // from 5.2.1.2 AC97 spec a warm reset is signaled by
     // driving SYNC high for a minimum of one microsecond
     // in the absence of bit clock.  Do this using the
     // SYNC_RES bit in byte 1 of the es1371 chip.
     if ( AC97_PWR_PR4 & m_ulCodecPowerState )
     {
         ucMiscCtl = READ_PORT_UCHAR((PUCHAR)(m_pPciAddr + ES1371_bMISCCTL_OFF));
         WRITE_PORT_UCHAR((PUCHAR)(m_pPciAddr + ES1371_bMISCCTL_OFF),
                           ucMiscCtl | ES1371_MISCCTL_SYNC_RES );

         // now wait around long enough to be sure 1.3 microseconds have gone by
//<mod:ce>         KeStallExecutionProcessor( 2 );
         StallExecution(1000); // some older codecs require longer stall times

         WRITE_PORT_UCHAR((PUCHAR)(m_pPciAddr + ES1371_bMISCCTL_OFF),
                           ucMiscCtl & ~ES1371_MISCCTL_SYNC_RES );

         // now wait around long enough to be sure a microsecond has gone by
//<mod:ce>         KeStallExecutionProcessor( 1 );
         StallExecution(1000); // some older codecs require longer stall times
     }
     // now the ACLink should be active.  take the Codec through the steps
     // to bring it back up to fully awake.

     // read the power register to see what the current state is
     usAC97_PowerReg = ReadCodecRegister( AC97_POWER_CONTROL );

#ifdef DBG
     _DbgPrintF( DEBUGLVL_VERBOSE, ("AC97 power state 1: %x", usAC97_PowerReg));
#endif
     // is the analog section awake
     if ( !(AC97_PWR_ANL & usAC97_PowerReg ) )
       WriteCodecRegister( AC97_POWER_CONTROL, usAC97_PowerReg & ~(AC97_PWR_PR2|AC97_PWR_PR3) );

     Codec_WaitForPowerState( AC97_PWR_ANL );

     // read the power register to see what the current state is
     usAC97_PowerReg = ReadCodecRegister( AC97_POWER_CONTROL );

#ifdef DBG
     _DbgPrintF( DEBUGLVL_VERBOSE, ("AC97 power state 2: %x", usAC97_PowerReg));
#endif
     // is the DAC section awake
     if ( !(AC97_PWR_DAC & usAC97_PowerReg ) )
       WriteCodecRegister( AC97_POWER_CONTROL, usAC97_PowerReg & ~AC97_PWR_PR1 );

     Codec_WaitForPowerState( AC97_PWR_DAC );

     // read the power register to see what the current state is
     usAC97_PowerReg = ReadCodecRegister( AC97_POWER_CONTROL );

#ifdef DBG
     _DbgPrintF( DEBUGLVL_VERBOSE, ("AC97 power state 3: %x", usAC97_PowerReg));
#endif
     // is the ADC section awake
     if ( !(AC97_PWR_ADC & usAC97_PowerReg ) )
       WriteCodecRegister( AC97_POWER_CONTROL, usAC97_PowerReg & ~AC97_PWR_PR0 );

     Codec_WaitForPowerState( AC97_PWR_ADC );

     // read the power register to see what the current state is
     usAC97_PowerReg = ReadCodecRegister( AC97_POWER_CONTROL );

#ifdef DBG
     _DbgPrintF( DEBUGLVL_VERBOSE, ("AC97 power state 3: %x", usAC97_PowerReg));
#endif
  }

  // now the AC97 Codec if fully awake.  if it should be in a power down
  // mode do that now.
  if ( ulNewState )
  {
    // start the process of shutting down the Codec
    usAC97_PowerReg = 0;

    // shut down the ADC section
    if ( AC97_PWR_PR0 & ulNewState )
    {
      usAC97_PowerReg |= AC97_PWR_PR0;
      WriteCodecRegister( AC97_POWER_CONTROL, usAC97_PowerReg );
    }

    // shut down the DAC section
    if ( AC97_PWR_PR1 & ulNewState )
    {
      usAC97_PowerReg |= AC97_PWR_PR1;
      WriteCodecRegister( AC97_POWER_CONTROL, usAC97_PowerReg );
    }

    // if it is called for shut off the analog section
    if ( AC97_PWR_PR2 & ulNewState )
    {
      usAC97_PowerReg |= AC97_PWR_PR2;
      WriteCodecRegister( AC97_POWER_CONTROL, usAC97_PowerReg );
    }

    // if it is called for shut off the analog section
    if ( AC97_PWR_PR3 & ulNewState )
    {
      usAC97_PowerReg |= AC97_PWR_PR3;
      WriteCodecRegister( AC97_POWER_CONTROL, usAC97_PowerReg );
    }

    if ( AC97_PWR_PR4 & ulNewState )
    {
      // shut down the digital interface section
      usAC97_PowerReg |= AC97_PWR_PR4;
      WriteCodecRegister( AC97_POWER_CONTROL, usAC97_PowerReg );
    }

    // poll the WIP bit of the Codec control register to make sure
    // it is clear before we power anything else down.
    for( delay_count = 0; delay_count < 0x1000UL; ++delay_count )
        if( !(READ_PORT_ULONG((PULONG)(m_pPciAddr + ES1371_dCODECCTL_OFF)) & (1UL << 30)) )
            break;

    // the AC97 Codec is now powered down
  }

  // save the new AC97 Codec power state
  m_ulCodecPowerState = ulNewState;

  return ulNewState;
}

void
CES1371::Codec_WaitForPowerState( USHORT usState )
{
    // Wait for power up to 1 second
    ULONG i;
    for (i=0; i<1000; ++i)
    {
        if ( ReadCodecRegister ( AC97_POWER_CONTROL ) & usState ) {
            // RETAILMSG(1, (TEXT("Codec_WaitForPowerState took %d msec\r\n"),i));
            return;
        }
        Sleep(1); // 1 msec
    }
    RETAILMSG(1, (TEXT("Codec_WaitForPowerState timed out\r\n")));
    return;
}
