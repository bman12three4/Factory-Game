.include "monitor.inc"
.include "display.inc"
.include "world.inc"

.import	draw
.import itemdraw
.import World
.import ItemLoc

.define UPDATEPT $6
.define UPDATERT $8

.CODE

_main:
	jsr HGR		; Hires setup stuff
	jsr BKGND
loop:	jmp update	; update runs the "game logic" (more to come)
			; to every tile, which animates belts and assemblers
	
update:	ldx #00		; This loop just updates any animated tiles, like conveyors.
update1:lda #>updates
	sta UPDATEPT+1
	lda World,x	; Load every world coordinate
	clc
	adc #<updates
	sta UPDATEPT
	ldy #00
	lda (UPDATEPT),y
	sta UPDATERT
	iny
	lda (UPDATEPT),y
	sta UPDATERT+1
	lda World,X
	jmp (UPDATERT)
ckitem: lda World,x
	clc
	cmp #16
	bcc view
	lda ItemLoc,X
	and #$3		; Isolate *+	
	cmp #00		; Right now just right and left
	beq itemright
	cmp #02
	beq itemleft
view:	lda World,x
	sta TILENUM
	txa 
	asl
	sta TILECD
	jsr draw
	lda TILECD
	lsr
	tax
	lda World,x
	cmp #16
	bcs iview
	jmp footer
iview:	lda ItemLoc,x
	and #$f0	; Isolate the last 4 bits
	lsr		; Move those to the first 4 bits
	lsr
	lsr
	lsr
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
	jmp loop
	
itemright:
itemleft:
	jmp view
	
	
updates:
.word	view, view		; 00, 02
.word	insert, insert, insert2	; 04, 06, 08
.word	upassm, upassm, upassm2 ; 10, 12, 14
.word	rtconv, rtconv, rtconv2 ; 16, 18, 20
.word	lfconv, lfconv, lfconv2 ; 22, 24, 26

	
rtconv:	clc		; Add 2 to the tile type, moving it forward 1.
	adc #02
	sta World,x
	jmp ckitem
	
rtconv2:lda #16		; Set the tile type back to 2, reseting it.
	sta World,x
	jmp ckitem
	
lfconv:	clc		; Add 2 to the tile type, moving it forward 1.
	adc #02
	sta World,x
	jmp ckitem
	
lfconv2:lda #10		; Set the tile type back to 2, reseting it.
	sta World,x
	jmp ckitem
	
insert:	jmp ckitem

insert2:jmp ckitem

upassm:	clc
	adc #02
	sta World,x
	jmp ckitem

upassm2:lda #12
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