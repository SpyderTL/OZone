int fdc_read(fdc_drive_t *fd, unsigned char *data, unsigned int sector, unsigned int offset, unsigned int length)
{
   unsigned char st0, st1, st2, rcy, rhe, rse, bps, cyl;

   if(!fdc_motor_on(fd))
      return 0;

   //check if a disk is in the drive
   unsigned char disk_not_changed = inportb(fd->ports.digital_input) & 0x80;
   if(disk_not_changed)
   {
      //write_string("DNC");
      //this is gaurenteed to change the disk if it exists
      if(!fdc_seek(fd, 79))
      {
         write_string(" failed seek! ");
         return 0;
      }
      if(!fdc_seek(fd, 0))
      {
         write_string(" failed seek! ");
         return 0;
      }
   }
   disk_not_changed = inportb(fd->ports.digital_input) & 0x80;
   if(disk_not_changed)
   {   
      write_string(" No disk in drive. ");
      //there is no disk in the drive
      return 0;
   }

   if(!fdc_seek(fd, sector))
   {
      write_string(" failed seek! ");
      return 0;
   }

   //send the read command
   fdc_send_command(fd, FDC_READ_DATA);
   fdc_send_data(fd, fd->index | (fd->current_head << 2));   //head and drive 
   fdc_send_data(fd, fd->current_cylinder);
   fdc_send_data(fd, fd->current_head);
   fdc_send_data(fd, fd->current_sector);
   fdc_send_data(fd, 2);                  // bytes per sector (2 = 512)
   fdc_send_data(fd, 1);   // "end of track" the final sector of this track (I have no idea what it does)
   fdc_send_data(fd, 0x1B);               //GAP3 length
   fdc_send_data(fd, 0xFF);               //data length (0xFF because bytes per sector != 0)

   //get the data
   fdc_wait_interrupt(fd);//wait for it...
   //GO!
   int i = 0; unsigned char *tmp = data;
   for(i = 0; i < 512; i++)
   {   
      fdc_get_data(fd, tmp);
      write_hex(*tmp);
      tmp++;
   }

   // read status information
   fdc_get_data(fd, &st0);
   write_hex(st0);
   fdc_get_data(fd, &st1);
   fdc_get_data(fd, &st2);
   /*
    * These are cylinder/head/sector values, updated with some
    * rather bizarre logic, that I would like to understand.
    */
   fdc_get_data(fd, &rcy);
   fdc_get_data(fd, &rhe);
   fdc_get_data(fd, &rse);
   // bytes per sector, should be what we programmed in
   fdc_get_data(fd, &bps);

   if(!fdc_motor_off(fd))
      return 0;

   return 1;
}