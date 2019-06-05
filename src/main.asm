.include "monitor.inc"
.include "display.inc"
.include "world.inc"

.import	draw
.import World

.CODE

_main:
	jsr HGR		; Hires setup stuff
	jsr BKGND
loop:	jsr view	; view draws all tiles to the screen
	jsr update	; update runs the "game logic" (more to come)
	jsr _delay;	; to every tile, which animates belts and assemblers
	jmp loop;	; for now. Delay will probably go away later once
			; everything slows down.
view: 	ldx #00		; View loop, x starts at 0.
view1:	lda World,x	; Get the tile type at the coordinate
	sta TILENUM	; Store that as the tile nuber
	txa		; Multiply x by 2
	asl
	sta TILECD	; Store that as the tile coordinate
	jsr draw	; Draw that tile
	lda TILECD	; Grab the tile coordinate and divide by 2, since
	lsr		; draw uses up the x value. This gets it back.
	tax
	inx		; Incrase x until 100, all tiles have been drawn.
	cpx #100
	bne view1
	rts
	
update:	ldx #00		; This loop just updates any animated tiles, like conveyors.
update1:lda World,x	; Load every world coordinate
ckconv:	cmp #02		; Check if it is one of the three conveyor positions
	beq upconv	; Jump if it is
	cmp #04
	beq upconv
	cmp #06
	beq upconv2	; Jump if it needs to be reset
ckasmb:	
	inx
	cpx #100
	bne update1
	rts
	
upconv:	clc		; Add 2 to the tile type, moving it forward 1.
	adc #02
	sta World,x
	jmp ckasmb
	
upconv2:lda #02		; Set the tile type back to 2, reseting it.
	sta World,x
	jmp ckasmb
	
	
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