;	display.asm
;
; this file controls drawing to the screen. 
; The draw routine here draws one 14x16 tiles
; at a time, using the coordinate and type specified
; in the zeropage locations degined in display.inc


.include "monitor.inc"
.include "display.inc"
.include "tiles.inc"
.include "world.inc"

.export	draw
.export itemdraw

.import World
.import ItemLoc
.import ItemRot

.CODE

.define GRID_WIDTH	$0A
.define GRID_HEIGHT	$0A
.define PLAYER_X	GRID_WIDTH/2
.define PLAYER_Y	GRID_HEIGHT/2


.define	ADDR_1	$19	; First block line address
.define ADDR_2	$1B	; Second block line address
.define TILE2D	$abc	; This gets LDA into Absolute mode
	
draw:	ldx	TILENUM		; This section gets the type of tile to draw.
	lda 	TILES, X	; It then loads the address of the tile to draw
	sta 	patch_1+1	; and changes all references to the placeholder 
	sta 	patch_2+1	; address to the address of the tile to draw.
	sta 	patch_3+1
	sta 	patch_4+1	; this first part gets the low byte
	sta 	patch_5+1
	sta 	patch_6+1
	sta 	patch_7+1
	sta 	patch_8+1

	lda 	TILES+1, X	; and this second part gets the high byte.
	sta 	patch_1+2
	sta 	patch_2+2
	sta 	patch_3+2
	sta 	patch_4+2
	sta 	patch_5+2
	sta 	patch_6+2
	sta 	patch_7+2
	sta 	patch_8+2

	ldx	#00		; Start x, the counter, to 0.
	ldy	TILECD		; Set y to the coordinate to draw to.
	lda	HGR_GRID,Y	; Load the screen address for that coordinate
	sta	ADDR_1		; Store that to address 1
	clc
	adc	#$80		; Add $80 to get the block below that
	sta	ADDR_2		; Store that to address 2
	lda	HGR_GRID+1,Y	; Get the high bytes for those two, which will be the
	sta	ADDR_1+1	; same since the tiles never cross the interleaving pattern.
	sta	ADDR_2+1
	.define ITER1 #$20	; $20 means the first block is done.
lin1t8:	ldy	#00
patch_1:			; Loop through the first 8 lines, drawing the value from the tile
	lda	TILE2D,X	; data to the screen memory
	sta	(ADDR_1),Y
	inx
	iny
patch_2:
	lda	TILE2D,X
	sta	(ADDR_1),Y
	inx
	iny
patch_3:
	lda	TILE2D,X
	sta	(ADDR_1),Y
	inx
	iny
patch_4:
	lda	TILE2D,X
	sta	(ADDR_1),Y
	inx
	iny
	lda	ADDR_1+1
	adc	#$04
	sta 	ADDR_1+1
	cpx	ITER1
	bne	lin1t8		; Once that is over, go down to the next 8 lines.
	clc
	.define ITER2 #$40	; The x counter keeps going to access the rest of the tile data
lin916:	ldy	#00		; Y resets to go back to the beginning of screen memory offset
patch_5:
	lda	TILE2D,X
	sta	(ADDR_2),Y
	inx
	iny
patch_6:
	lda	TILE2D,X
	sta	(ADDR_2),Y
	inx
	iny
patch_7:
	lda	TILE2D,X
	sta	(ADDR_2),Y
	inx
	iny
patch_8:
	lda	TILE2D,X
	sta	(ADDR_2),Y
	inx
	iny
	lda	ADDR_2+1
	adc	#$04
	sta 	ADDR_2+1
	cpx	ITER2
	bne	lin916		; Do that till the end, then you're done.
	rts
	
	
	
	
	
itemdraw:
	ldx	TILENUM
	lda	ITEMS,X
	sta 	Ipatch_1+1	; and changes all references to the placeholder 
	sta 	Ipatch_2+1	; address to the address of the tile to draw.
	sta 	Ipatch_3+1
	sta 	Ipatch_4+1	; this first part gets the low byte
	sta 	Ipatch_5+1
	sta 	Ipatch_6+1
	sta 	Ipatch_7+1
	sta 	Ipatch_8+1

	lda 	ITEMS+1, X	; and this second part gets the high byte.
	sta 	Ipatch_1+2
	sta 	Ipatch_2+2
	sta 	Ipatch_3+2
	sta 	Ipatch_4+2
	sta 	Ipatch_5+2
	sta 	Ipatch_6+2
	sta 	Ipatch_7+2
	sta 	Ipatch_8+2

	ldx	#00		; Start x, the counter, to 0.
	ldy	TILECD		; Set y to the coordinate to draw to.
	lda	HGR_GRID,Y	; Load the screen address for that coordinate
	sta	ADDR_1		; Store that to address 1
	clc
	adc	#$80		; Add $80 to get the block below that
	sta	ADDR_2		; Store that to address 2
	lda	HGR_GRID+1,Y	; Get the high bytes for those two, which will be the
	sta	ADDR_1+1	; same since the tiles never cross the interleaving pattern.
	sta	ADDR_2+1
	.define ITER3 #$20	; $20 means the first block is done.
Ilin1t8:	ldy	#00
Ipatch_1:			; Loop through the first 8 lines, drawing the value from the tile
	lda	TILE2D,X	; data to the screen memory
	beq	Iskip1
	sta	(ADDR_1),Y
Iskip1:	inx
	iny
Ipatch_2:
	lda	TILE2D,X
	beq	Iskip2
	sta	(ADDR_1),Y
Iskip2:	inx
	iny
Ipatch_3:
	lda	TILE2D,X
	beq	Iskip3
	sta	(ADDR_1),Y
Iskip3:	inx
	iny
Ipatch_4:
	lda	TILE2D,X
	beq 	Iskip4
	sta	(ADDR_1),Y
Iskip4:	inx
	iny
	lda	ADDR_1+1
	adc	#$04
	sta 	ADDR_1+1
	cpx	ITER3
	bne	Ilin1t8		; Once that is over, go down to the next 8 lines.
	clc
	.define ITER4 #$40	; The x counter keeps going to access the rest of the tile data
Ilin916:	ldy	#00		; Y resets to go back to the beginning of screen memory offset
Ipatch_5:
	lda	TILE2D,X
	beq	Iskip5
	sta	(ADDR_2),Y
Iskip5:	inx
	iny
Ipatch_6:
	lda	TILE2D,X
	beq	Iskip6
	sta	(ADDR_2),Y
Iskip6:	inx
	iny
Ipatch_7:
	lda	TILE2D,X
	beq	Iskip7
	sta	(ADDR_2),Y
Iskip7:	inx
	iny
Ipatch_8:
	lda	TILE2D,X
	beq	Iskip8
	sta	(ADDR_2),Y
Iskip8:	inx
	iny
	lda	ADDR_2+1
	adc	#$04
	sta 	ADDR_2+1
	cpx	ITER4
	bne	Ilin916		; Do that till the end, then you're done.
	rts
	
.DATA
				; The HGR grid is every location that a tile can be drawn.
HGR_GRID:			; It is a 10x10 grid.
.word $2000, $2004, $2008, $200C, $2010, $2014, $2018, $201C, $2020, $2024
.word $2100, $2104, $2108, $210C, $2110, $2114, $2118, $211C, $2120, $2124
.word $2200, $2204, $2208, $220C, $2210, $2214, $2218, $221C, $2220, $2224
.word $2300, $2304, $2308, $230C, $2310, $2314, $2318, $231C, $2320, $2324
.word $2028, $202C, $2030, $2034, $2038, $203C, $2040, $2044, $2048, $204C
.word $2128, $212C, $2130, $2134, $2138, $213C, $2140, $2144, $2148, $214C
.word $2228, $222C, $2230, $2234, $2238, $223C, $2240, $2244, $2248, $224C
.word $2328, $232C, $2330, $2334, $2338, $233C, $2340, $2344, $2348, $234C
.word $2050, $2054, $2058, $205C, $2060, $2064, $2068, $206C, $2070, $2074
.word $2150, $2154, $2158, $215C, $2160, $2164, $2168, $216C, $2170, $2174