CC      = arm-linux-gcc
LD      = arm-linux-ld
AR      = arm-linux-ar
OBJCOPY = arm-linux-objcopy
OBJDUMP = arm-linux-objdump

CFLAGS 		:= -Wall -Os -fno-builtin
CPPFLAGS   	:= -nostdinc

export 	CC AR LD OBJCOPY OBJDUMP INCLUDEDIR CFLAGS CPPFLAGS 

objs := start.o clock.o sdram.o main.o nand.o

timer.bin: $(objs)
	${LD} -Ttimer.lds -o timer.elf $^
	${OBJCOPY} -O binary -S timer.elf $@
	${OBJDUMP} -D timer.elf > timer.dis
	
%.o:%.c
	${CC} $(CPPFLAGS) $(CFLAGS) -c -o $@ $<

%.o:%.S
	${CC} $(CPPFLAGS) $(CFLAGS) -c -o $@ $<

clean:
	rm -f *.bin *.elf *.dis *.o
	