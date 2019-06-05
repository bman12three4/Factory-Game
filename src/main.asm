.include "monitor.inc"
.include "display.inc"
.include "world.inc"

.import	draw
.import World

.CODE

_main:
	jsr HGR
	jsr BKGND
loop:	jsr view
	jsr update
	jsr _delay;
	jmp loop;
	
view: 	ldx #00
view1:	lda World,x
	sta TILENUM
	txa
	asl
	sta TILECD
	jsr draw
	lda TILECD
	lsr
	tax
	inx
	cpx #100
	bne view1
	rts
	
update:	ldx #00
update1:lda World,x
ckconv:	cmp #02
	beq upconv
	cmp #04
	beq upconv
	cmp #06
	beq upconv2
ckasmb:	
	inx
	cpx #100
	bne update1
	rts
	
upconv:	clc
	adc #02
	sta World,x
	jmp ckasmb
	
upconv2:lda #02
	sta World,x
	jmp ckasmb
_delay:
	lda #00
	ldx #00
_delay1:adc #01
	cmp #$ff
	bne _delay1
	inx
	cpx #$ff
	bne _delay1
	rts