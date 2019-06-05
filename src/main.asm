.include "monitor.inc"
.include "display.inc"
.include "world.inc"

.import	draw
.import World

.CODE

_main:
	jsr HGR		; Hires setup stuff
	jsr BKGND
loop:	jsr update	; update runs the "game logic" (more to come)
	jmp loop	; to every tile, which animates belts and assemblers
	
update:	ldx #00		; This loop just updates any animated tiles, like conveyors.
update1:lda World,x	; Load every world coordinate
ckconv:	cmp #00
	beq view
	cmp #02		; Check if it is one of the three conveyor positions
	beq upconv	; Jump if it is
	cmp #04
	beq upconv
	cmp #06
	beq upconv2	; Jump if it needs to be reset
ckasmb:	cmp #14
	beq upassm
	cmp #16
	beq upassm
	cmp #18
	beq upassm2
view:	lda World,x
	sta TILENUM
	txa 
	asl
	sta TILECD
	jsr draw
	lda TILECD
	lsr
	tax
footer:	inx
	cpx #100
	bne update1
	rts
	
upconv:	clc		; Add 2 to the tile type, moving it forward 1.
	adc #02
	sta World,x
	jmp view
	
upconv2:lda #02		; Set the tile type back to 2, reseting it.
	sta World,x
	jmp view
	
upassm:	clc
	adc #02
	sta World,x
	jmp view

upassm2:lda #14
	sta World,x
	jmp view
	
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