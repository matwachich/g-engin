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
	_GEng_Anim_FrameAdd(ByRef $hAnim, ByRef $hImage, $iFramDuration, $x = 0, $y = 0, $w = Default, $h = Default)
	_GEng_Anim_FrameMod(ByRef $hAnim, $iFrameNumber, ByRef $hImage, $iFramDuration = Default, $x = 0, $y = 0, $w = Default, $h = Default)
	__GEng_Anim_IsAnim(ByRef $hAnim)
#ce
#EndRegion ###


Func _GEng_Anim_Create()
	Local $a[1][6] ; Index Img, x, y, w, h, fram duration
	$a[0][0] = 0
	Return $a
EndFunc

Func _GEng_Anim_FrameCount(ByRef $hAnim)
	If Not __GEng_Anim_IsAnim($hAnim) Then Return SetError(1, 0, 0)
	; ---
	Return $hAnim[0][0]
EndFunc

Func _GEng_Anim_FrameAdd(ByRef $hAnim, ByRef $hImage, $iFramDuration, $x = 0, $y = 0, $w = Default, $h = Default)
	If Not __GEng_Anim_IsAnim($hAnim) Then Return SetError(1, 0, 0)
	If Not __GEng_Image_IsImage($hImage) Then Return SetError(1, 0, 0)
	; ---
	Local $uB = $hAnim[0][0]
	ReDim $hAnim[$uB + 2][6]
	$hAnim[$uB + 1][0] = $hImage[0]
	$hAnim[$uB + 1][1] = $x
	$hAnim[$uB + 1][2] = $y
	If $w = Default Then
		$hAnim[$uB + 1][3] = $hImage[1]
	Else
		$hAnim[$uB + 1][3] = $w
	EndIf
	If $h = Default Then
		$hAnim[$uB + 1][4] = $hImage[2]
	Else
		$hAnim[$uB + 1][4] = $h
	EndIf
	$hAnim[$uB + 1][5] = $iFramDuration
	$hAnim[0][0] += 1
	; ---
	Return 1
EndFunc

Func _GEng_Anim_FrameMod(ByRef $hAnim, $iFrameNumber, ByRef $hImage, $iFramDuration = Default, $x = 0, $y = 0, $w = Default, $h = Default)
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
	$hAnim[$i][1] = 0
	$hAnim[$i][2] = $y
	; ---
	If $w = Default Then
		$hAnim[$i][3] = $hImage[1]
	Else
		$hAnim[$i][3] = $w
	EndIf
	If $h = Default Then
		$hAnim[$i][4] = $hImage[2]
	Else
		$hAnim[$i][4] = $h
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
