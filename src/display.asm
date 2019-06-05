.include "monitor.inc"
.include "display.inc"
.include "tiles.inc"
.include "world.inc"

.export	draw

.import World

.CODE

.define GRID_WIDTH	$0A
.define GRID_HEIGHT	$0A
.define PLAYER_X	GRID_WIDTH/2
.define PLAYER_Y	GRID_HEIGHT/2


.define	ADDR_1	$19
.define ADDR_2	$1B
.define TILE2D	$abc
	
draw:	ldx	TILENUM	;num
	lda 	TILES, X
	sta 	patch_1+1
	sta 	patch_2+1
	sta 	patch_3+1
	sta 	patch_4+1
	sta 	patch_5+1
	sta 	patch_6+1
	sta 	patch_7+1
	sta 	patch_8+1

	lda 	TILES+1, X
	sta 	patch_1+2
	sta 	patch_2+2
	sta 	patch_3+2
	sta 	patch_4+2
	sta 	patch_5+2
	sta 	patch_6+2
	sta 	patch_7+2
	sta 	patch_8+2

	ldx	#00
	ldy	TILECD
	lda	HGR_GRID,Y
	sta	ADDR_1
	clc
	adc	#$80
	sta	ADDR_2
	lda	HGR_GRID+1,Y
	sta	ADDR_1+1
	sta	ADDR_2+1
	.define ITER1 #$20
lin1t8:	ldy	#00
patch_1:
	lda	TILE2D,X
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
	bne	lin1t8
	clc
	.define ITER2 #$40
lin916:	ldy	#00
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
	bne	lin916
	rts
	
.DATA

HGR_GRID:
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