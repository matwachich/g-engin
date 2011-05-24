#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.6.1
 Author:         Matwachich

 Script Function:


#ce ----------------------------------------------------------------------------

Func _GEng_SpriteAnimRewind(ByRef $hSprite, $Frame = 1)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$hSprite[$_gSpr_AnimFrame] = $Frame ; current frame (start)
	$hSprite[$_gSpr_AnimTimer] = -1 ; timer
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
	If $hSprite[$_gSpr_AnimTimer] = -1 Then
		$img = __GEng_Anim_BuildImageFromFrame($hAnim, $hSprite[$_gSpr_AnimFrame])
		_GEng_Sprite_ImageSet($hSprite, $img, _
								$hAnim[$hSprite[$_gSpr_AnimFrame]][1], _
								$hAnim[$hSprite[$_gSpr_AnimFrame]][2], _
								$hAnim[$hSprite[$_gSpr_AnimFrame]][3], _
								$hAnim[$hSprite[$_gSpr_AnimFrame]][4])
		$hSprite[$_gSpr_AnimFrame] += 1
		$hSprite[$_gSpr_AnimTimer] = Timerinit()
	Else
		If TimerDiff($hSprite[$_gSpr_AnimTimer]) >= $hAnim[$hSprite[$_gSpr_AnimFrame]][5] Then
			$hSprite[$_gSpr_AnimFrame] += 1
			If $hSprite[$_gSpr_AnimFrame] > $hAnim[0][0] Then $hSprite[$_gSpr_AnimFrame] = 1
			; ---
			$img = __GEng_Anim_BuildImageFromFrame($hAnim, $hSprite[$_gSpr_AnimFrame])
			_GEng_Sprite_ImageSet($hSprite, $img, _
									$hAnim[$hSprite[$_gSpr_AnimFrame]][1], _
									$hAnim[$hSprite[$_gSpr_AnimFrame]][2], _
									$hAnim[$hSprite[$_gSpr_AnimFrame]][3], _
									$hAnim[$hSprite[$_gSpr_AnimFrame]][4])
			$hSprite[$_gSpr_AnimTimer] = Timerinit()
		EndIf
		; ---
		; StopFrame test
		If $iStopFrame <> Default Then
			If $hSprite[$_gSpr_AnimFrame] = $iStopFrame Then Return -1
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