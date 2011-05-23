#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.6.1
 Author:         Matwachich

 Script Function:


#ce ----------------------------------------------------------------------------

#Region ### Functions ###
#cs
- Main Functions
	_GEng_SpriteGetPos(ByRef $hSprite)
	_GEng_SpriteGetSize(ByRef $hSprite)
	_GEng_SpriteGetOrigin(ByRef $hSprite)
	; ---
	_GEng_SpriteGetSpeed(ByRef $hSprite)
	_GEng_SpriteGetAccel(ByRef $hSprite)
	_GEng_SpriteGetInnertie(ByRef $hSprite)
	_GEng_SpriteGetMaxSpeed(ByRef $hSprite)
	_GEng_SpriteGetMaxAccel(ByRef $hSprite)
	; ---
	_GEng_SpriteGetAngle(ByRef $hSprite)
	_GEng_SpriteGetAngleSpeed(ByRef $hSprite)
	_GEng_SpriteGetAngleAccel(ByRef $hSprite)
	_GEng_SpriteGetAngleSpeedMax(ByRef $hSprite)
	_GEng_SpriteGetAngleAccelMax(ByRef $hSprite)
	_GEng_SpriteGetAngleInnertie(ByRef $hSprite)
#ce
#EndRegion ###


Func _GEng_SpriteGetPos(ByRef $hSprite)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	Local $ret[2]
	$ret[0] = $hSprite[7]
	$ret[1] = $hSprite[8]
	Return $ret
EndFunc

Func _GEng_SpriteGetSize(ByRef $hSprite)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	Local $ret[2]
	$ret[0] = $hSprite[9]
	$ret[1] = $hSprite[10]
	Return $ret
EndFunc

Func _GEng_SpriteGetOrigin(ByRef $hSprite)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	Local $ret[2]
	$ret[0] = $hSprite[11]
	$ret[1] = $hSprite[12]
	Return $ret
EndFunc

; ##############################################################

Func _GEng_SpriteGetSpeed(ByRef $hSprite)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	Local $ret[2]
	$ret[0] = $hSprite[13]
	$ret[1] = $hSprite[14]
	Return $ret
EndFunc

Func _GEng_SpriteGetAccel(ByRef $hSprite)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	Local $ret[2]
	$ret[0] = $hSprite[15]
	$ret[1] = $hSprite[16]
	Return $ret
EndFunc

Func _GEng_SpriteGetInnertie(ByRef $hSprite)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	Local $ret[2]
	$ret[0] = $hSprite[31]
	$ret[1] = $hSprite[32]
	Return $ret
EndFunc

Func _GEng_SpriteGetMaxSpeed(ByRef $hSprite)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	Local $ret[2]
	$ret[0] = $hSprite[27]
	$ret[1] = $hSprite[28]
	Return $ret
EndFunc

Func _GEng_SpriteGetMaxAccel(ByRef $hSprite)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	Local $ret[2]
	$ret[0] = $hSprite[29]
	$ret[1] = $hSprite[30]
	Return $ret
EndFunc

; ##############################################################

Func _GEng_SpriteGetAngle(ByRef $hSprite, $iType = 1) ; 1- Degres, 2- Radians
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	Switch $iType
		Case 1
			Return $hSprite[17] + $hSprite[39]
		Case 2
			Return $hSprite[18] + $hSprite[40]
	EndSwitch
EndFunc

Func _GEng_SpriteGetAngleOrigin(ByRef $hSprite)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	Return $hSprite[39]
EndFunc

Func _GEng_SpriteGetAngleSpeed(ByRef $hSprite)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	Return $hSprite[19]
EndFunc

Func _GEng_SpriteGetAngleAccel(ByRef $hSprite)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	Return $hSprite[35]
EndFunc

Func _GEng_SpriteGetAngleSpeedMax(ByRef $hSprite)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	Return $hSprite[34]
EndFunc

Func _GEng_SpriteGetAngleAccelMax(ByRef $hSprite)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	Return $hSprite[36]
EndFunc

Func _GEng_SpriteGetAngleInnertie(ByRef $hSprite)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	Return $hSprite[37]
EndFunc
