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
	$x = $hSprite[$_gSpr_PosX]
	$y = $hSprite[$_gSpr_PosY]
	Return 1
EndFunc

Func _GEng_Sprite_SizeGet(ByRef $hSprite, ByRef $x, ByRef $y)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$x = $hSprite[$_gSpr_Width]
	$y = $hSprite[$_gSpr_Height]
	Return 1
EndFunc

Func _GEng_Sprite_OriginGet(ByRef $hSprite, ByRef $x, ByRef $y)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$x = $hSprite[$_gSpr_OriX]
	$y = $hSprite[$_gSpr_OriY]
	Return 1
EndFunc

; ##############################################################

Func _GEng_Sprite_SpeedGet(ByRef $hSprite, ByRef $x, ByRef $y)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$x = $hSprite[$_gSpr_SpeedX]
	$y = $hSprite[$_gSpr_SpeedY]
	Return 1
EndFunc

Func _GEng_Sprite_MaxSpeedGet(ByRef $hSprite, $val)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$val = $hSprite[$_gSpr_SpeedMax]
	Return 1
EndFunc

Func _GEng_Sprite_AccelGet(ByRef $hSprite, ByRef $x, ByRef $y)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$x = $hSprite[$_gSpr_AccelX]
	$y = $hSprite[$_gSpr_AccelY]
	Return 1
EndFunc

Func _GEng_Sprite_InnertieGet(ByRef $hSprite, ByRef $x, ByRef $y)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$x = $hSprite[$_gSpr_InnertieX]
	$y = $hSprite[$_gSpr_InnertieY]
	Return 1
EndFunc

; ##############################################################

Func _GEng_Sprite_AngleGet(ByRef $hSprite, ByRef $val, $iType = 1) ; 1- Degres, 2- Radians
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	Switch $iType
		Case 1
			$val = $hSprite[$_gSpr_AngleDeg] + $hSprite[$_gSpr_AngleOriDeg]
		Case 2
			$val = $hSprite[$_gSpr_AngleRad] + $hSprite[$_gSpr_AngleOriRad]
	EndSwitch
	; ---
	Return 1
EndFunc

Func _GEng_Sprite_AngleOriginGet(ByRef $hSprite, ByRef $val, $iType = 1) ; 1- Degres, 2- Radians
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	Switch $iType
		Case 1
			$val = $hSprite[$_gSpr_AngleOriDeg]
		Case 2
			$val = $hSprite[$_gSpr_AngleOriRad]
	EndSwitch
	; ---
	Return 1
EndFunc

Func _GEng_Sprite_AngleSpeedGet(ByRef $hSprite, ByRef $val)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$val = $hSprite[$_gSpr_AngleSpeed]
	Return 1
EndFunc

Func _GEng_Sprite_AngleMaxSpeedGet(ByRef $hSprite, ByRef $val)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$var = $hSprite[$_gSpr_AngleSpeedMax]
	Return 1
EndFunc

Func _GEng_Sprite_AngleAccelGet(ByRef $hSprite, ByRef $val)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$val = $hSprite[$_gSpr_AngleAccel]
	Return 1
EndFunc

Func _GEng_Sprite_AngleInnertieGet(ByRef $hSprite, ByRef $val)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$val = $hSprite[$_gSpr_AngleInnertie]
	Return 1
EndFunc
