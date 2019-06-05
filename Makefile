APPLE2_CL	:= C:\Users\bslat\Downloads\cc65-snapshot-win32\bin\cl65
APPLE2_SRC	:= 	src\main.asm src\display.asm src\tiles.asm src\world.asm
APPLE2_MAP	:= factory.map
APPLE2_LIST	:= factory.list
APPLE2_CFLAGS	:= -Oirs -v -t apple2 -vm --cpu 6502
APPLE2_OUT	:= bin\factory.a2

all:	directories apple2

directories:
	    mkdir bin

apple2: $(APPLE2_SRC)
		$(APPLE2_CL) -m $(APPLE2_MAP) -o $(APPLE2_OUT) -l $(APPLE2_LIST) $(APPLE2_CFLAGS) -C apple2-asm.cfg $? 

clean:	$(SRC)
	del /q/f $(APPLE2_MAP) src\*.o src\*.s gmon.out & rmdir /q/s bin\
