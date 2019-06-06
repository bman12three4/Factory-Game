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
.export ItemLoc

World:	; This is the array which stores all of the world data.
	; Right now this is just 10x10, so no other methods are needed.
.byte 16, 00, 00, 00, 00, 00, 00, 00, 00, 00
.byte 00, 00, 00, 00, 00, 00, 00, 00, 00, 00
.byte 00, 00, 00, 00, 00, 00, 00, 00, 00, 00
.byte 00, 00, 00, 00, 00, 00, 00, 00, 00, 00
.byte 00, 00, 00, 00, 00, 00, 00, 00, 00, 00
.byte 00, 00, 00, 00, 00, 00, 00, 00, 00, 00
.byte 00, 00, 00, 00, 00, 00, 00, 00, 00, 00
.byte 00, 00, 00, 00, 00, 00, 00, 00, 00, 00
.byte 00, 00, 00, 00, 00, 00, 00, 00, 00, 00
.byte 00, 00, 00, 00, 00, 00, 00, 00, 00, 00



;	Item's rotation and position.
;	00000000
;	|   | |
;	|   | | First two bits are rotation (0-3)
;       |   | Third and fourth bits are position in cell (0-2)
;	| Last 4 bits are the item type.
;
;	For reference,  00001100 is $C
;		       	00000011 is $3 
;			00001111 is $F

ItemLoc:
.byte $20, 00, 00, 00, 00, 00, 00, 00, 00, 00
.byte 00, 00, 00, 00, 00, 00, 00, 00, 00, 00
.byte 00, 00, 00, 00, 00, 00, 00, 00, 00, 00
.byte 00, 00, 00, 00, 00, 00, 00, 00, 00, 00
.byte 00, 00, 00, 00, 00, 00, 00, 00, 00, 00
.byte 00, 00, 00, 00, 00, 00, 00, 00, 00, 00
.byte 00, 00, 00, 00, 00, 00, 00, 00, 00, 00
.byte 00, 00, 00, 00, 00, 00, 00, 00, 00, 00
.byte 00, 00, 00, 00, 00, 00, 00, 00, 00, 00
.byte 00, 00, 00, 00, 00, 00, 00, 00, 00, 00