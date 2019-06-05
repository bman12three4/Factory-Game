.include "monitor.inc"
.include "display.inc"
.include "world.inc"

.import	draw
.import World
.import ItemLoc
.import itemRot

.define UPDATEPT $6
.define UPDATERT $8

.CODE

_main:
	jsr HGR		; Hires setup stuff
	jsr BKGND
loop:	jsr update	; update runs the "game logic" (more to come)
	jmp loop	; to every tile, which animates belts and assemblers
	
update:	ldx #00		; This loop just updates any animated tiles, like conveyors.
update1:lda World,x
cktile:	cmp #00
	beq view
	cmp #02		; Check if it is one of the three conveyor positions
	beq rtconvJ	; Jump if it is
	cmp #04
	beq rtconvJ
	cmp #06
	beq rtconv2J	; Jump if it needs to be reset
	cmp #08
	beq lfconvJ
	cmp #10
	beq lfconvJ
	cmp #12
	beq lfconv2J
	cmp #14
	beq upassmJ
	cmp #16
	beq upassmJ
	cmp #18
	beq upassm2J
	jmp ckitem
rtconvJ: jmp rtconv
rtconv2J:jmp rtconv2
lfconvJ: jmp lfconv
lfconv2J:jmp lfconv2
upassmJ: jmp upassm
upassm2J:jmp upassm2
ckitem:	lda World,x
	cmp #14
	bcs upitem
	jmp view
upitem:	lda ItemLoc,x
	cmp #02
	beq orecalc1
	cmp #04
	beq orecalc2
	cmp #06
	beq orecalc3
view:	lda World,x
	sta TILENUM
	txa 
	asl
	sta TILECD
	jsr draw
	lda TILECD
	lsr
	tax
	lda ItemLoc,x
	sta TILENUM
	txa 
	asl
	sta TILECD
	jsr itemdraw
	lda TILECD
	lsr
	tax
footer:	inx
	cpx #100
	bne update1
	rts
	
orecalc1:
	lda ItemRot,x
	cmp #00
	beq orecalc10
	cmp #02
	beq orecalc12
	jmp view

orecalc10:
	lda #04
	sta ItemLoc,x
	jmp view

orecalc12:
	lda #00
	sta ItemLoc,x
	lda #06
	dex
	sta ItemLoc,x
	jmp view
	
orecalc2:
	lda ItemRot,x
	cmp #00
	beq orecalc20
	cmp #02
	beq orecalc22
	jmp view

orecalc20:
	lda #06
	sta ItemLoc,x
	jmp view
	
orecalc22:
	lda #02
	sta ItemLoc,x
	jmp view
	
orecalc3:
	lda ItemRot,x
	cmp #00
	beq orecalc30
	cmp #02
	beq orecalc32
	jmp view
	
orecalc30:
	lda #00
	sta ItemLoc,x
	lda #02
	inx
	sta ItemLoc,x
	jmp view
	
orecalc32:
	lda #04
	sta ItemLoc,x
	jmp view
	
	
rtconv:	clc		; Add 2 to the tile type, moving it forward 1.
	adc #02
	sta World,x
	jmp ckitem
	
rtconv2:lda #02		; Set the tile type back to 2, reseting it.
	sta World,x
	jmp ckitem
	
lfconv:	clc		; Add 2 to the tile type, moving it forward 1.
	adc #02
	sta World,x
	jmp ckitem
	
lfconv2:lda #08		; Set the tile type back to 2, reseting it.
	sta World,x
	jmp ckitem
	
insert:	jmp ckitem

insert2:jmp ckitem

upassm:	clc
	adc #02
	sta World,x
	jmp ckitem

upassm2:lda #14
	sta World,x
	jmp ckitem
	
_delay:			; Delay loop just adds a bunch of numbers 
	lda #00		; together to waste time.
	ldx #00
_delay1:adc #01
	cmp #$ff
	bne _delay1
	inx
	cpx #$ff
	bne _delay1
	rts
	
	
; This routine is a routine which calculates the corrent place to jump based
; off of the data loaded from the world. This has the advantage of taking the 
; same time no matter which of the 128 possible tiles are loaded, but takes much 
; longer. More common tiles like grass, conveyors, or assemblers would be earlier
; in the list so it wouldn't matter as much. There might be a way to speed this up
; more, but I think the chain of cmp/beq will actually be faster and easier to use.
; If there are a ton of subroutines, it might be too much for the break instructions,
; whereass the jump instructions would not have this problem.
; 
; This loop is 39 cycles always, the chan loop is 4 cycles for each false, and 5 for true.

slow:	ldx #00		; This loop just updates any animated tiles, like conveyors.
slow1:	lda #>updates
	sta UPDATEPT+1
	lda World,x	; Load every world coordinate
	tay
	adc #<updates
	sta UPDATEPT
	lda (UPDATEPT),Y
	sta UPDATERT
	iny
	lda (UPDATEPT),Y
	sta UPDATERT+1
	lda World,x
	jmp (UPDATERT)

	
updates:
.word	view			; If the tile is grass (0), do nothing
.word	rtconv, rtconv, rtconv2	; 02, 04, 06
.word	lfconv, lfconv, lfconv2 ; 08, 10, 12
.word	insert, insert, insert2 ; 14, 16, 18
.word	upassm, upassm, upassm2 ; 20, 22, 24