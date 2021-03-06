# _____     ___ ____     ___ ____
#  ____|   |    ____|   |        | |____|
# |     ___|   |____ ___|    ____| |    \    PS2DEV Open Source Project.
#-----------------------------------------------------------------------
# Copyright 2001-2004, ps2dev - http://www.ps2dev.org
# Copyright 2014 doctorxyz
# Licenced under Academic Free License version 2.0
# Review ps2sdk README & LICENSE files for further details.
#

.SILENT:

EE_BIN = 3dcb.elf
EE_BIN_PKD = 3D-CUBE.ELF
EE_OBJS = main.o
EE_LIBS = -ldraw -lgraph -lmath3d -lmf -lpacket -ldma

all:
	echo "Building..."
		$(MAKE) texture.c $(EE_BIN)
	
	echo "Stripping..."
	ee-strip $(EE_BIN)

	echo "Compressing..."
	ps2-packer $(EE_BIN) $(EE_BIN_PKD) > /dev/null

# You can replace the mickey.raw texture below by yours.
# Just pick up a 512x512 24-Bit RGB BMP image, then convert it to PS2 BGR RAW, using bmp2raw tool
# (https://bitbucket.org/doctorxyz/bmp2raw)
texture.c:
	bin2c mickey.raw texture.c texture

clean:
	echo "Cleaning..."
	rm -f *.ELF *.elf *.o texture.c

rebuild: clean all

include $(PS2SDK)/samples/Makefile.pref
include $(PS2SDK)/samples/Makefile.eeglobal
