#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.6.1
 Author:         Matwachich

 Script Function:


#ce ----------------------------------------------------------------------------

#Region ### Functions ###
#cs
- Main Functions
	_GEng_Sprite_AnimRewind(ByRef $hSprite, $Frame = 1)
	_GEng_Sprite_Animate(ByRef $hSprite, ByRef $hAnim, $iStopFrame = Default)
	_GEng_Sprite_AnimDelayMultiplierGet(ByRef $hSprite)
	_GEng_Sprite_AnimDelayMultiplierSet(ByRef $hSprite, $iVal)
	__GEng_Anim_BuildImageFromFrame(ByRef $hAnim, $iFrame)
#ce
#EndRegion ###


; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Sprite_AnimRewind
; Description....:	
; Parameters.....:	$hSprite = Objet sprite
;					$iFrame = Frame à laquelle initialiser le sprite (voir remarque)
;						Par défaut: 1
; Return values..:	Succes - 1
;					Echec - 0 et @error = 1
; Author.........:	Matwachich
; Remarks........:	Doit être appeler à la fin de l'animation d'un sprite, pour que la prochaine fois
;						que ce sprite est animé par _GEng_Sprite_Animate, l'animation commence à la frame
;						spécifié dans cette fonction (par défaut 1)
; ===========================================================================================================
Func _GEng_Sprite_AnimRewind(ByRef $hSprite, $iFrame = 1)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$hSprite[$_gSpr_AnimFrame] = $iFrame ; current frame (start)
	$hSprite[$_gSpr_AnimTimer] = -1 ; timer
	; ---
	Return 1
EndFunc

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Sprite_Animate
; Description....:	Anime un Sprite avec l'objet animation spécifié
; Parameters.....:	$hSprite = Objet sprite
;					$hAnim = Objet Animation
;					$iStopFrame = Lorsque l'animation arrive à cette frame, la fonction retourne -1
;						Idéal pour faire en sorte qu'une animation ne s'exécute qu'un nombre défini de tours
;						(Voir remarques)
; Return values..:	Succes - 1
;					Echec - 0 et @error = 1
;					Spécial: Frame $iStopFrame atteinte -> -1
; Author.........:	Matwachich
; Remarks........:	Quand StopFrame est atteinte, la fonction retourne -1
; 						Si l'animation commence par la frame 1 et que vous mettez comme StopFrame 1,
; 						la fonction ne s'arrétera qu'après avoir fait un tour, et pas des le début
; ===========================================================================================================
Func _GEng_Sprite_Animate(ByRef $hSprite, ByRef $hAnim, $iStopFrame = Default)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	If Not __GEng_Anim_IsAnim($hAnim) Then Return SetError(1, 0, 0)
	If _GEng_Anim_FrameCount($hAnim) = 0 Then Return SetError(1, 0, 0)
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

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Sprite_AnimDelayMultiplierGet
; Description....:	Récupère la valeur actuelle du coeficient de multiplication de la duré des frame d'animation
; Parameters.....:	$hSprite = Objet sprite
; Return values..:	Succes - 1
;					Echec - 0 et @error = 1
; Author.........:	Matwachich
; Remarks........:	
; ===========================================================================================================
Func _GEng_Sprite_AnimDelayMultiplierGet(ByRef $hSprite)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	Return $hSprite[$_gSpr_AnimDelayMulti]
EndFunc

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Sprite_AnimDelayMultiplierSet
; Description....:	Assigne une valeur au coeficient de multiplication de la duré des frame d'animation
; Parameters.....:	$hSprite = Objet sprite
;					$iVal = Valeur à assigner
; Return values..:	Succes - 1
;					Echec - 0 et @error = 1
; Author.........:	Matwachich
; Remarks........:	
; ===========================================================================================================
Func _GEng_Sprite_AnimDelayMultiplierSet(ByRef $hSprite, $iVal)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	If $iVal > 0 Then
		$hSprite[$_gSpr_AnimDelayMulti] = $iVal
		Return 1
	Else
		Return SetError(1, 0, 0)
	EndIf
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