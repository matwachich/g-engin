#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.6.1
 Author:         Matwachich

 Script Function:


#ce ----------------------------------------------------------------------------

Func _GEng_SpriteAnimRewind(ByRef $hSprite, $Frame = 1)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$hSprite[21] = $Frame ; current frame (start)
	$hSprite[41] = -1 ; timer
	; ---
	Return 1
EndFunc

; Quand StopFrame est atteinte, la fonction retourne -1
; Si l'animation commence par la frame 1 et que vous mettez comme StopFrame 1,
; 	la fonction ne s'arrétera qu'après avoir fait un tour, et pas des le début
Func _GEng_SpriteAnimate(ByRef $hSprite, ByRef $hAnim, $iStopFrame = Default)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	If Not __GEng_Anim_IsAnim($hAnim) Then Return SetError(1, 0, 0)
	; ---
	Local $img
	If $hSprite[41] = -1 Then
		$img = __GEng_Anim_BuildImageFromFrame($hAnim, $hSprite[21])
		_GEng_Sprite_ImageSet($hSprite, $img, $hAnim[$hSprite[21]][1], $hAnim[$hSprite[21]][2], $hAnim[$hSprite[21]][3], $hAnim[$hSprite[21]][4])
		$hSprite[21] += 1
		$hSprite[41] = Timerinit()
	Else
		If TimerDiff($hSprite[41]) >= $hAnim[$hSprite[21]][5] Then
			$hSprite[21] += 1
			If $hSprite[21] > $hAnim[0][0] Then $hSprite[21] = 1
			; ---
			$img = __GEng_Anim_BuildImageFromFrame($hAnim, $hSprite[21])
			_GEng_Sprite_ImageSet($hSprite, $img, $hAnim[$hSprite[21]][1], $hAnim[$hSprite[21]][2], $hAnim[$hSprite[21]][3], $hAnim[$hSprite[21]][4])
			$hSprite[41] = Timerinit()
		EndIf
		; ---
		; StopFrame test
		If $iStopFrame <> Default Then
			If $hSprite[21] = $iStopFrame Then Return -1
		EndIf
	EndIf
	; ---
	Return 1
EndFunc

; ==============================================================
; ### Internals
; ==============================================================
Func __GEng_Anim_BuildImageFromFrame(ByRef $hAnim, $iFrame)
	If Not __GEng_Anim_IsAnim($hAnim) Then Return SetError(1, 0, 0)
	If $iFrame > $hAnim[0][0] Then Return SetError(1, 0, 0)
	; ---
	Local $ret[3]
	$ret[0] = $hAnim[$iFrame][0]
	$ret[1] = $hAnim[$iFrame][3]
	$ret[2] = $hAnim[$iFrame][4]
	Return $ret
EndFunc