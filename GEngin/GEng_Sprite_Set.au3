#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.6.1
 Author:         Matwachich

 Script Function:


#ce ----------------------------------------------------------------------------

#Region ### Functions ###
#cs
- Main Functions
	_GEng_SpriteSetPos(ByRef $hSprite, $x, $y)
	_GEng_SpriteSetSize(ByRef $hSprite, $w = Default, $h = Default)
	_GEng_SpriteSetOrigin(ByRef $hSprite, $x = Default, $y = Default)
	_GEng_SpriteSetOriginEx(ByRef $hSprite, $eOrigin)
	_GEng_SpriteSetSpeed(ByRef $hSprite, $x, $y)
	_GEng_SpriteSetAccel(ByRef $hSprite, $x, $y)
	_GEng_SpriteSetInnertie(ByRef $hSprite, $x, $y)
	_GEng_SpriteSetAngle(ByRef $hSprite, $iAngle)
	_GEng_SpriteSetAngleOrigin(ByRef $hSprite, $iAngle)
	_GEng_SpriteSetAngleSpeed(ByRef $hSprite, $iAngle, $iMax = 0)
	_GEng_SpriteSetAngleAccel(ByRef $hSprite, $iAngle, $iMax = 0)
	_GEng_spriteSetAngleInnertie(ByRef $hSprite, $iAngle)
#ce
#EndRegion ###


Func _GEng_SpriteSetPos(ByRef $hSprite, $x, $y)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	; J'enregistre la position que JE donne
	$hSprite[7] = $x; - $hSprite[11]
	$hSprite[8] = $y; - $hSprite[12]
	; ---
	Return 1
EndFunc

; Apres setSize, origin est faussé
Func _GEng_SpriteSetSize(ByRef $hSprite, $w = Default, $h = Default) ; If Default => No Change, <= 0 => Image Size
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	If $w <> Default Then
		If $w > 0 Then
			$hSprite[9] = $w
		Else
			$hSprite[9] = $hSprite[3]
		EndIf
	EndIf
	; ---
	If $h <> Default Then
		If $h > 0 Then
			$hSprite[10] = $h
		Else
			$hSprite[10] = $hSprite[4]
		EndIf
	EndIf
	; ---
	Return 1
EndFunc

Func _GEng_SpriteSetOrigin(ByRef $hSprite, $x = Default, $y = Default) ; If Default => No change
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	If $x <> Default Then _
		$hSprite[11] = $x
	If $y <> Default Then _
		$hSprite[12] = $y
	; ---
	Return 1
EndFunc

Func _GEng_SpriteSetOriginEx(ByRef $hSprite, $eOrigin)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	Local $ret = 1, $err = 0
	Switch $eOrigin
		Case $GEng_Origin_Mid
			_GEng_SpriteSetOrigin($hSprite, $hSprite[9] / 2, $hSprite[10] / 2)
		Case $GEng_Origin_TL
			_GEng_SpriteSetOrigin($hSprite, 0, 0)
		Case $GEng_Origin_TR
			_GEng_SpriteSetOrigin($hSprite, $hSprite[9], 0)
		Case $GEng_Origin_BL
			_GEng_SpriteSetOrigin($hSprite, 0, $hSprite[10])
		Case $GEng_Origin_BR
			_GEng_SpriteSetOrigin($hSprite, $hSprite[9], $hSprite[10])
		Case Else
			$ret = 0
			$err = 1
	EndSwitch
	; ---
	Return SetError($err, 0, $ret)
EndFunc

Func _GEng_SpriteSetSpeed(ByRef $hSprite, $x = Default, $y = Default, $max = Default)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	If $x <> Default Then $hSprite[13] = $x
	If $y <> Default Then $hSprite[14] = $y
	; ---
	If $max <> Default Then $hSprite[27] = $max ; somme vectorielle
	; ---
	Return 1
EndFunc

Func _GEng_SpriteAddSpeed(ByRef $hSprite, $x = 0, $y = 0)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$hSprite[13] += $x
	$hSprite[14] += $y
	; ---
	Return 1
EndFunc

Func _GEng_SpriteSubSpeed(ByRef $hSprite, $x = 0, $y = 0)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$hSprite[13] -= $x
	$hSprite[14] -= $y
	; ---
	Return 1
EndFunc

Func _GEng_SpriteSetAccel(ByRef $hSprite, $x, $y)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$hSprite[15] = $x
	$hSprite[16] = $y
	; ---
	Return 1
EndFunc

Func _GEng_SpriteAddAccel(ByRef $hSprite, $x = 0, $y = 0)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$hSprite[15] += $x
	$hSprite[16] += $y
	; ---
	Return 1
EndFunc

Func _GEng_SpriteSubAccel(ByRef $hSprite, $x = 0, $y = 0)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$hSprite[15] -= $x
	$hSprite[16] -= $y
	; ---
	Return 1
EndFunc

Func _GEng_SpriteSetInnertie(ByRef $hSprite, $x, $y)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$hSprite[31] = $x
	$hSprite[32] = $y
	Return 1
EndFunc

Func _GEng_SpriteSetAngle(ByRef $hSprite, $iAngle) ; en degres
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	;$iAngle += $hSprite[39]
	$iAngle = __GEng_GeometryReduceAngle($iAngle)
	; ---
	$hSprite[17] = $iAngle ; deg
	$hSprite[18] = __GEng_GeometryDeg2Rad($iAngle) ; rad
	Return 1
EndFunc

Func _GEng_SpriteSetAngleOrigin(ByRef $hSprite, $iAngle) ; en degres
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$iAngle = __GEng_GeometryReduceAngle($iAngle)
	; ---
	$hSprite[39] = $iAngle
	$hSprite[40] = __GEng_GeometryDeg2Rad($iAngle) ; rad
	Return 1
EndFunc

Func _GEng_SpriteSetAngleSpeed(ByRef $hSprite, $iAngle, $iMax = Default)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$hSprite[19] = $iAngle
	If $iMax <> Default Then $hSprite[34] = $iMax
	Return 1
EndFunc

Func _GEng_SpriteSetAngleAccel(ByRef $hSprite, $iAngle);, $iMax = Default)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$hSprite[35] = $iAngle
	;If $iMax <> Default Then $hSprite[36] = $iMax
	Return 1
EndFunc

Func _GEng_spriteSetAngleInnertie(ByRef $hSprite, $iAngle)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$hSprite[37] = $iAngle
	Return 1
EndFunc
