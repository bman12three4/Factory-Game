;	tiles.asm
;
; The tiles file stores all of the different tile and item types.
; The TILES location stores the locations of all of the tile types.
; The ITEMS location stores the location of all of the item types.
;
; Currently items are not implemented yet so it is only tiles right now.

.export TILES

; This is the tile section. Each tile is 14x16, which translates to 4 bytes x 16 lines.
; Most of these were generated with a processing program I wrote which allows you to 
; draw on the screen and then export that as hexadecimal data.
; Each time a new tile is created, it's label is added to the TILES section to be
; referenced to in the world array and drawn in the drawing loop.

TILES:	; A list of all of them is in the .inc file.
.word GRASS, CONVEYOR1_1, CONVEYOR1_2, CONVEYOR1_3
.word INSERTER1_1, INSERTER1_2, INSERTER1_3,ASSEMBLER1_1
.word ASSEMBLER1_2, ASSEMBLER1_3


GRASS:
.byte $6a, $55, $2a, $57
.byte $6b, $55, $2a, $57
.byte $2e, $55, $3a, $55
.byte $2e, $55, $2e, $55
.byte $2e, $55, $2e, $55
.byte $2a, $55, $2e, $55
.byte $2a, $55, $2a, $55
.byte $2b, $57, $2a, $55
.byte $2a, $57, $2a, $75
.byte $3a, $5f, $2a, $75
.byte $2e, $5d, $3a, $75
.byte $2e, $5d, $6a, $55
.byte $2e, $55, $6a, $55
.byte $2a, $55, $6a, $55
.byte $2a, $57, $2a, $55
.byte $6a, $55, $2a, $5d

CONVEYOR1_1:
.byte $0, $0, $0, $0
.byte $0, $0, $0, $0
.byte $0, $0, $0, $0
.byte $0, $0, $0, $0
.byte $0, $0, $0, $0
.byte $0, $0, $0, $0
.byte $0, $0, $0, $0
.byte $0, $0, $0, $0
.byte $0, $0, $0, $0
.byte $aa, $d5, $aa, $d5
.byte $a0, $d5, $a0, $d5
.byte $82, $d5, $82, $d5
.byte $8a, $d4, $8a, $d4
.byte $82, $d5, $82, $d5
.byte $a0, $d5, $a0, $d5
.byte $aa, $d5, $aa, $d5

CONVEYOR1_2:
.byte $0, $0, $0, $0
.byte $0, $0, $0, $0
.byte $0, $0, $0, $0
.byte $0, $0, $0, $0
.byte $0, $0, $0, $0
.byte $0, $0, $0, $0
.byte $0, $0, $0, $0
.byte $0, $0, $0, $0
.byte $0, $0, $0, $0
.byte $aa, $d5, $aa, $d5
.byte $8a, $d4, $8a, $d4
.byte $aa, $d0, $aa, $d0
.byte $aa, $c1, $aa, $c1
.byte $aa, $d0, $aa, $d0
.byte $8a, $d4, $8a, $d4
.byte $aa, $d5, $aa, $d5

CONVEYOR1_3:
.byte $0, $0, $0, $0
.byte $0, $0, $0, $0
.byte $0, $0, $0, $0
.byte $0, $0, $0, $0
.byte $0, $0, $0, $0
.byte $0, $0, $0, $0
.byte $0, $0, $0, $0
.byte $0, $0, $0, $0
.byte $0, $0, $0, $0
.byte $aa, $d5, $aa, $d5
.byte $aa, $c1, $aa, $c1
.byte $aa, $85, $aa, $85
.byte $a8, $95, $a8, $95
.byte $aa, $85, $aa, $85
.byte $aa, $c1, $aa, $c1
.byte $aa, $d5, $aa, $d5

INSERTER1_1:
.byte $80, $84, $a0, $80
.byte $80, $84, $a0, $80
.byte $80, $84, $a0, $80
.byte $80, $84, $a0, $80
.byte $80, $94, $a8, $80
.byte $80, $d0, $8a, $80
.byte $80, $c0, $82, $80
.byte $80, $c0, $82, $80
.byte $80, $c0, $82, $80
.byte $80, $c0, $82, $80
.byte $80, $c0, $82, $80
.byte $80, $c0, $82, $80
.byte $80, $d0, $8a, $80
.byte $80, $d0, $8a, $80
.byte $80, $d0, $8a, $80
.byte $aa, $d5, $aa, $d5

INSERTER1_2:
.byte $80, $80, $80, $80
.byte $80, $80, $80, $80
.byte $80, $80, $80, $80
.byte $80, $80, $80, $80
.byte $80, $80, $80, $80
.byte $aa, $80, $80, $80
.byte $a0, $81, $80, $80
.byte $80, $d5, $82, $80
.byte $80, $d5, $82, $80
.byte $a0, $c1, $82, $80
.byte $aa, $c0, $82, $80
.byte $80, $c0, $82, $80
.byte $80, $d0, $8a, $80
.byte $80, $d0, $8a, $80
.byte $80, $d0, $8a, $80
.byte $aa, $d5, $aa, $d5

INSERTER1_3:
.byte $80, $80, $80, $80
.byte $80, $80, $80, $80
.byte $80, $80, $80, $80
.byte $80, $80, $80, $80
.byte $80, $80, $80, $80
.byte $80, $80, $80, $d4
.byte $80, $80, $80, $85
.byte $80, $c0, $aa, $81
.byte $80, $c0, $aa, $81
.byte $80, $c0, $82, $85
.byte $80, $c0, $82, $d4
.byte $80, $c0, $82, $80
.byte $80, $d0, $8a, $80
.byte $80, $d0, $8a, $80
.byte $80, $d0, $8a, $80
.byte $aa, $d5, $aa, $d5

ASSEMBLER1_1:
.byte $d5, $aa, $d5, $aa
.byte $d5, $aa, $d5, $aa
.byte $f5, $ff, $ff, $af
.byte $f5, $ff, $ff, $af
.byte $f5, $ff, $ff, $af
.byte $f5, $ff, $ab, $ad
.byte $f5, $fd, $fb, $ad
.byte $f5, $fd, $fb, $ad
.byte $a5, $d5, $fb, $ad
.byte $f5, $fd, $fb, $ad
.byte $f5, $fd, $ab, $ad
.byte $f5, $ff, $ff, $af
.byte $f5, $ff, $ff, $af
.byte $f5, $ff, $ff, $af
.byte $d5, $aa, $d5, $aa
.byte $d5, $aa, $d5, $aa

ASSEMBLER1_2:
.byte $d5, $aa, $d5, $aa
.byte $d5, $aa, $d5, $aa
.byte $f5, $ff, $ff, $af
.byte $f5, $ff, $ff, $af
.byte $f5, $ff, $ff, $af
.byte $f5, $ff, $ab, $ad
.byte $f5, $f7, $eb, $ad
.byte $a5, $f7, $eb, $ad
.byte $f5, $fd, $eb, $ad
.byte $b5, $d7, $eb, $ad
.byte $b5, $ff, $ab, $ad
.byte $f5, $ff, $ff, $af
.byte $f5, $ff, $ff, $af
.byte $f5, $ff, $ff, $af
.byte $d5, $aa, $d5, $aa
.byte $d5, $aa, $d5, $aa

ASSEMBLER1_3:
.byte $d5, $aa, $d5, $aa
.byte $d5, $aa, $d5, $aa
.byte $f5, $ff, $ff, $af
.byte $f5, $ff, $ff, $af
.byte $f5, $ff, $ff, $af
.byte $f5, $ff, $ab, $ad
.byte $b5, $ff, $bb, $ad
.byte $b5, $d7, $bb, $ad
.byte $f5, $fd, $bb, $ad
.byte $a5, $f7, $bb, $ad
.byte $f5, $f7, $ab, $ad
.byte $f5, $ff, $ff, $af
.byte $f5, $ff, $ff, $af
.byte $f5, $ff, $ff, $af
.byte $d5, $aa, $d5, $aa
.byte $d5, $aa, $d5, $aa