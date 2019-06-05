;	world.asm
;
; The world file contains the following:
;	* The current world, stored as an array of bytes refering
;	  to the tile type they represent
;	* The item map, which stores all of the items to be drawn
;	  on top of any of the applicable items, namely conveyor belts
;	* Routines for getting the current 10x10 window from the larger
;	  world.

.export World

World:	; This is the array which stores all of the world data.
	; Right now this is just 10x10, so no other methods are needed.
.byte 02, 00, 00, 00, 00, 00, 00, 00, 00, 00
.byte 00, 00, 00, 00, 00, 00, 00, 00, 00, 00
.byte 00, 02, 02, 02, 14, 02, 02, 02, 00, 00
.byte 00, 00, 00, 00, 00, 00, 00, 00, 00, 00
.byte 00, 00, 00, 00, 00, 00, 00, 00, 00, 00
.byte 00, 00, 00, 00, 00, 00, 00, 00, 00, 00
.byte 00, 00, 00, 00, 00, 00, 00, 00, 00, 00
.byte 00, 00, 00, 00, 00, 00, 00, 00, 00, 00
.byte 00, 00, 00, 00, 00, 00, 00, 00, 00, 00
.byte 00, 00, 00, 00, 00, 00, 00, 00, 00, 00