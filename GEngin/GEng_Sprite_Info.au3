#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.6.1
 Author:         Matwachich

 Script Function:


#ce ----------------------------------------------------------------------------

#Region ### Functions ###
#cs
- Main Functions
	_GEng_Sprite_PosGet(ByRef $hSprite, ByRef $x, ByRef $y)
	_GEng_Sprite_SizeGet(ByRef $hSprite, ByRef $x, ByRef $y)
	_GEng_Sprite_OriginGet(ByRef $hSprite, ByRef $x, ByRef $y)
	; ---
	_GEng_Sprite_SpeedGet(ByRef $hSprite, ByRef $x, ByRef $y)
	_GEng_Sprite_MaxSpeedGet(ByRef $hSprite, $val)
	_GEng_Sprite_AccelGet(ByRef $hSprite, ByRef $x, ByRef $y)
	_GEng_Sprite_InnertieGet(ByRef $hSprite, ByRef $x, ByRef $y)
	; ---
	_GEng_Sprite_AngleGet(ByRef $hSprite, ByRef $val, $iType = 1)
	_GEng_Sprite_AngleOriginGet(ByRef $hSprite, ByRef $val, $iType = 1)
	; ---
	_GEng_Sprite_AngleSpeedGet(ByRef $hSprite, ByRef $val)
	_GEng_Sprite_AngleMaxSpeedGet(ByRef $hSprite, ByRef $val)
	_GEng_Sprite_AngleAccelGet(ByRef $hSprite, ByRef $val)
	_GEng_Sprite_AngleInnertieGet(ByRef $hSprite, ByRef $val)
#ce
#EndRegion ###


Func _GEng_Sprite_PosGet(ByRef $hSprite, ByRef $x, ByRef $y)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$x = $hSprite[7]
	$y = $hSprite[8]
	Return 1
EndFunc

Func _GEng_Sprite_SizeGet(ByRef $hSprite, ByRef $x, ByRef $y)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$x = $hSprite[9]
	$y = $hSprite[10]
	Return 1
EndFunc

Func _GEng_Sprite_OriginGet(ByRef $hSprite, ByRef $x, ByRef $y)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$x = $hSprite[11]
	$y = $hSprite[12]
	Return 1
EndFunc

; ##############################################################

Func _GEng_Sprite_SpeedGet(ByRef $hSprite, ByRef $x, ByRef $y)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$x = $hSprite[13]
	$y = $hSprite[14]
	Return 1
EndFunc

Func _GEng_Sprite_MaxSpeedGet(ByRef $hSprite, $val)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$val = $hSprite[27]
	Return 1
EndFunc

Func _GEng_Sprite_AccelGet(ByRef $hSprite, ByRef $x, ByRef $y)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$x = $hSprite[15]
	$y = $hSprite[16]
	Return 1
EndFunc

Func _GEng_Sprite_InnertieGet(ByRef $hSprite, ByRef $x, ByRef $y)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$x = $hSprite[31]
	$y = $hSprite[32]
	Return 1
EndFunc

; ##############################################################

Func _GEng_Sprite_AngleGet(ByRef $hSprite, ByRef $val, $iType = 1) ; 1- Degres, 2- Radians
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	Switch $iType
		Case 1
			$val = $hSprite[17] + $hSprite[39]
		Case 2
			$val = $hSprite[18] + $hSprite[40]
	EndSwitch
	; ---
	Return 1
EndFunc

Func _GEng_Sprite_AngleOriginGet(ByRef $hSprite, ByRef $val, $iType = 1) ; 1- Degres, 2- Radians
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	Switch $iType
		Case 1
			$val = $hSprite[39]
		Case 2
			$val = $hSprite[40]
	EndSwitch
	; ---
	Return 1
EndFunc

Func _GEng_Sprite_AngleSpeedGet(ByRef $hSprite, ByRef $val)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$val = $hSprite[19]
	Return 1
EndFunc

Func _GEng_Sprite_AngleMaxSpeedGet(ByRef $hSprite, ByRef $val)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$var = $hSprite[34]
	Return 1
EndFunc

Func _GEng_Sprite_AngleAccelGet(ByRef $hSprite, ByRef $val)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$val = $hSprite[35]
	Return 1
EndFunc

Func _GEng_Sprite_AngleInnertieGet(ByRef $hSprite, ByRef $val)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$val = $hSprite[37]
	Return 1
EndFunc
