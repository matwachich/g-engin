#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.6.1
 Author:         Matwachich

 Script Function:


#ce ----------------------------------------------------------------------------

#Region ### Functions ###
#cs
- Main Functions
	_GEng_Anim_Create()
	_GEng_Anim_FrameCount(ByRef $hAnim)
	_GEng_Anim_FrameAdd(ByRef $hAnim, ByRef $hImage, $iFramDuration, $x = Default, $y = Default, $w = Default, $h = Default)
	_GEng_Anim_FrameMod(ByRef $hAnim, $iFrameNumber, ByRef $hImage, $iFramDuration = Default, $x = Default, $y = Default, $w = Default, $h = Default)
	__GEng_Anim_IsAnim(ByRef $hAnim)
#ce
#EndRegion ###

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Anim_Create
; Description....:	Créer un objet Animation
; Parameters.....:	Aucun
; Return values..:	Objet Animation ($oAnim)
; Author.........:	Matwachich
; Remarks........:	
; ===========================================================================================================
Func _GEng_Anim_Create()
	Local $a[1][6] ; Index Img, x, y, w, h, fram duration
	$a[0][0] = 0
	Return $a
EndFunc

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Anim_FrameCount
; Description....:	Retourne le nombre de frames contenues dans un objet Animation
; Parameters.....:	ByRef $hAnim = Objet Animation
; Return values..:	Succes - Nombre de frames
;					Echec - 0 et @error = 1
; Author.........:	Matwachich
; Remarks........:	
; ===========================================================================================================
Func _GEng_Anim_FrameCount(ByRef $hAnim)
	If Not __GEng_Anim_IsAnim($hAnim) Then Return SetError(1, 0, 0)
	; ---
	Return $hAnim[0][0]
EndFunc

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Anim_FrameAdd
; Description....:	Ajoute une frame dans l'objet animation
; Parameters.....:	ByRef $hAnim = Objet Animation
;					ByRef $hImage = Objet Image
;					$iFramDuration = Durée de la frame (ms)
;					- Optionels: prendre une partie de l'objet Image (idéal pour les SpriteSheets)
;						Doivent TOUS être spécifiés pour être pris en concidération
;					$x, $y = coordonnées du point supérieur gauche du rectangle à prendre
;					$w, $h = largeur et hauteur du rectangle à prendre
; Return values..:	Succes - 1
;					Echec - 0 et @error = 1
; Author.........:	Matwachich
; Remarks........:	
; ===========================================================================================================
Func _GEng_Anim_FrameAdd(ByRef $hAnim, ByRef $hImage, $iFramDuration, $x = Default, $y = Default, $w = Default, $h = Default)
	If Not __GEng_Anim_IsAnim($hAnim) Then Return SetError(1, 0, 0)
	If Not __GEng_Image_IsImage($hImage) Then Return SetError(1, 0, 0)
	; ---
	Local $uB = $hAnim[0][0]
	ReDim $hAnim[$uB + 2][6]
	$hAnim[$uB + 1][0] = $hImage[0]
	; ---
	If $x <> Default And $y <> Default And $w <> Default And $h <> Default Then
		$hAnim[$uB + 1][1] = $x
		$hAnim[$uB + 1][2] = $y
		$hAnim[$uB + 1][3] = $w
		$hAnim[$uB + 1][4] = $h
	Else
		$hAnim[$uB + 1][1] = 0
		$hAnim[$uB + 1][2] = 0
		$hAnim[$uB + 1][3] = $hImage[1]
		$hAnim[$uB + 1][4] = $hImage[2]
	EndIf
	; ---
	$hAnim[$uB + 1][5] = $iFramDuration
	; ---
	$hAnim[0][0] += 1
	; ---
	Return 1
EndFunc

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Anim_FrameMod
; Description....:	Modifier une frame d'un Objet Animation
; Parameters.....:	ByRef $hAnim = Objet Animation
;					$iFrameNumber = Numéro de la frame à modifier (base 1)
;					ByRef $hImage = Objet Image
;					$iFramDuration = Durée de la frame (ms)
;					- Optionels: prendre une partie de l'objet Image (idéal pour les SpriteSheets)
;						Doivent TOUS être spécifiés pour être pris en concidération
;					$x, $y = coordonnées du point supérieur gauche du rectangle à prendre
;					$w, $h = largeur et hauteur du rectangle à prendre
; Return values..:	Succes - 1
;					Echec - 0 et @error = 1
; Author.........:	Matwachich
; Remarks........:	
; ===========================================================================================================
Func _GEng_Anim_FrameMod(ByRef $hAnim, $iFrameNumber, ByRef $hImage, $iFramDuration = Default, _
									$x = Default, $y = Default, $w = Default, $h = Default)
	If Not __GEng_Anim_IsAnim($hAnim) Then Return SetError(1, 0, 0)
	If $hImage <> Default Then
		If Not __GEng_Image_IsImage($hImage) Then Return SetError(1, 0, 0)
	EndIf
	; ---
	If $iFrameNumber > $hAnim[0][0] Then Return SetError(1, 0, 0)
	Local $i = $iFrameNumber
	; ---
	$hAnim[$i][0] = $hImage[0]
	; ---
	If $x <> Default And $y <> Default And $w <> Default And $h <> Default Then
		$hAnim[$i][1] = $x
		$hAnim[$i][2] = $y
		$hAnim[$i][3] = $w
		$hAnim[$i][4] = $h
	Else
		$hAnim[$i][1] = 0
		$hAnim[$i][2] = 0
		$hAnim[$i][3] = $hImage[1]
		$hAnim[$i][4] = $hImage[2]
	EndIf
	; ---
	If $iFramDuration <> Default Then $hAnim[$i][5] = $iFramDuration
	; ---
	Return 1
EndFunc

; ==============================================================
; ### Internals
; ==============================================================
Func __GEng_Anim_IsAnim(ByRef $hAnim)
	If UBound($hAnim, 2) <> 6 Then Return SetError(1, 0, 0)
	; ---
	Return 1
EndFunc
