HandleBallLossRedField: ; 0xdd76
	ld a, [wBallSaverTimerFrames]
	ld hl, wBallSaverTimerSeconds
	or [hl]
	jr z, .youLose
	ld a, [wNumTimesBallSavedTextWillDisplay]
	bit 7, a
	jr nz, .skip_save_text
	dec a
	ld [wNumTimesBallSavedTextWillDisplay], a
	push af
	ld de, BallSavedText
	call Func_dc6d
	pop af
	jr nz, .skip_save_text
	ld a, $1
	ld [wBallSaverTimerFrames], a
	ld [wBallSaverTimerSeconds], a
.skip_save_text
	lb de, $15, $02
	call PlaySoundEffect
	ret

.youLose
	ld de, $0000
	call PlaySong
	ld bc, $001e
	call AdvanceFrames
	lb de, $25, $24
	call PlaySoundEffect
	call Start20SecondSaverTimer
	ld a, $1
	ld [wd4c9], a
	xor a
	ld [wd4de], a
	ld [wd4df], a
	call Func_ddfd
	ld a, [wd49b]
	and a
	jr z, .asm_dddd
	dec a
	ld [wd49b], a
	ld a, $1
	ld [wd49c], a
	ld de, EndOfBallBonusText
	call Func_dc6d
	ret

.asm_dddd
	ld a, [wd49d]
	ld hl, wd49e
	cp [hl]
	jr z, .asm_ddf1
	inc a
	ld [wd49d], a
	ld de, EndOfBallBonusText
	call Func_dc6d
	ret

.asm_ddf1
	ld de, EndOfBallBonusText
	call Func_dc6d
	ld a, $1
	ld [wGameOver], a
	ret

Func_ddfd: ; 0xddfd
	ld a, [wInSpecialMode]
	and a
	ret z
	ld a, [wSpecialMode]
	and a
	jr nz, .asm_de14
	callba Func_10157
	jr .asm_de40

.asm_de14
	cp SPECIAL_MODE_CATCHEM
	jr nz, .asm_de2d
	xor a
	ld [wd604], a
	ld a, $1e
	ld [wd607], a
	callba Func_10ac8
	jr .asm_de40

.asm_de2d
	xor a
	ld [wd604], a
	ld a, $1e
	ld [wd607], a
	callba Func_3022b
.asm_de40
	ld a, [wd7ad]
	ld c, a
	ld a, [wStageCollisionState]
	and $1
	or c
	ld [wStageCollisionState], a
	ret

Func_de4e: ; 0xde4e
; unused
	ret