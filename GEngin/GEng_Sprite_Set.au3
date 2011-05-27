#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.6.1
 Author:         Matwachich

 Script Function:


#ce ----------------------------------------------------------------------------

#Region ### Functions ###
#cs
- Main Functions
	_GEng_Sprite_PosSet(ByRef $hSprite, $x = Default, $y = Default)
	_GEng_Sprite_SizeSet(ByRef $hSprite, $w = Default, $h = Default)
	_GEng_Sprite_OriginSet(ByRef $hSprite, $x = Default, $y = Default)
	_GEng_Sprite_OriginSetEx(ByRef $hSprite, $eOrigin)
	_GEng_Sprite_AngleOriginSet(ByRef $hSprite, $iAngle)
	_GEng_Sprite_SpeedSet(ByRef $hSprite, $x = Default, $y = Default, $max = Default)
	_GEng_Sprite_SpeedAdd(ByRef $hSprite, $x = 0, $y = 0)
	_GEng_Sprite_AccelSet(ByRef $hSprite, $x, $y)
	_GEng_Sprite_AccelAdd(ByRef $hSprite, $x = 0, $y = 0)
	_GEng_Sprite_InnertieSet(ByRef $hSprite, $x, $y)
	_GEng_Sprite_AngleSet(ByRef $hSprite, $iAngle)
	_GEng_Sprite_AngleAdd(ByRef $hSprite, $iAngle)
	_GEng_Sprite_AngleSpeedSet(ByRef $hSprite, $iAngle = Default, $iMax = Default)
	_GEng_Sprite_AngleSpeedAdd(ByRef $hSprite, $iAngle)
	_GEng_Sprite_AngleAccelSet(ByRef $hSprite, $iAngle)
	_GEng_Sprite_AngleAccelAdd(ByRef $hSprite, $iAngle)
	_GEng_sprite_AngleInnertieSet(ByRef $hSprite, $iAngle)
#ce
#EndRegion ###


Func _GEng_Sprite_PosSet(ByRef $hSprite, $x = Default, $y = Default)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	; J'enregistre la position que JE donne
	If $x <> Default Then $hSprite[$_gSpr_PosX] = $x; - $hSprite[11]
	If $y <> Default Then $hSprite[$_gSpr_PosY] = $y; - $hSprite[12]
	; ---
	Return 1
EndFunc

; Apres setSize, origin est faussé
Func _GEng_Sprite_SizeSet(ByRef $hSprite, $w = Default, $h = Default) ; If Default => No Change, <= 0 => Image Size
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	If $w <> Default Then
		If $w > 0 Then
			$hSprite[$_gSpr_Width] = $w
		Else
			$hSprite[$_gSpr_Width] = $hSprite[$_gSpr_ImgW]
		EndIf
	EndIf
	; ---
	If $h <> Default Then
		If $h > 0 Then
			$hSprite[$_gSpr_Height] = $h
		Else
			$hSprite[$_gSpr_Height] = $hSprite[$_gSpr_ImgH]
		EndIf
	EndIf
	; ---
	Return 1
EndFunc

Func _GEng_Sprite_OriginSet(ByRef $hSprite, $x = Default, $y = Default) ; If Default => No change
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	If $x <> Default Then _
		$hSprite[$_gSpr_OriX] = $x
	If $y <> Default Then _
		$hSprite[$_gSpr_OriY] = $y
	; ---
	Return 1
EndFunc

Func _GEng_Sprite_OriginSetEx(ByRef $hSprite, $eOrigin)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	Local $ret = 1, $err = 0
	Switch $eOrigin
		Case $GEng_Origin_Mid
			_GEng_Sprite_OriginSet($hSprite, $hSprite[$_gSpr_Width] / 2, $hSprite[$_gSpr_Height] / 2)
		Case $GEng_Origin_TL
			_GEng_Sprite_OriginSet($hSprite, 0, 0)
		Case $GEng_Origin_TR
			_GEng_Sprite_OriginSet($hSprite, $hSprite[$_gSpr_Width], 0)
		Case $GEng_Origin_BL
			_GEng_Sprite_OriginSet($hSprite, 0, $hSprite[$_gSpr_Height])
		Case $GEng_Origin_BR
			_GEng_Sprite_OriginSet($hSprite, $hSprite[$_gSpr_Width], $hSprite[$_gSpr_Height])
		Case Else
			$ret = 0
			$err = 1
	EndSwitch
	; ---
	Return SetError($err, 0, $ret)
EndFunc

Func _GEng_Sprite_AngleOriginSet(ByRef $hSprite, $iAngle) ; en degres
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$iAngle = __GEng_GeometryReduceAngle($iAngle)
	; ---
	$hSprite[$_gSpr_AngleOriDeg] = $iAngle
	$hSprite[$_gSpr_AngleOriRad] = __GEng_GeometryDeg2Rad($iAngle) ; rad
	Return 1
EndFunc

; ##############################################################

Func _GEng_Sprite_SpeedSet(ByRef $hSprite, $x = Default, $y = Default, $max = Default)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	If $x <> Default Then $hSprite[$_gSpr_SpeedX] = $x
	If $y <> Default Then $hSprite[$_gSpr_SpeedY] = $y
	; ---
	If $max <> Default Then $hSprite[$_gSpr_SpeedMax] = $max ; somme vectorielle
	; ---
	Return 1
EndFunc

Func _GEng_Sprite_SpeedAdd(ByRef $hSprite, $x = 0, $y = 0)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$hSprite[$_gSpr_SpeedX] += $x
	$hSprite[$_gSpr_SpeedY] += $y
	; ---
	Return 1
EndFunc

Func _GEng_Sprite_AccelSet(ByRef $hSprite, $x, $y)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$hSprite[$_gSpr_AccelX] = $x
	$hSprite[$_gSpr_AccelY] = $y
	; ---
	Return 1
EndFunc

Func _GEng_Sprite_AccelAdd(ByRef $hSprite, $x = 0, $y = 0)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$hSprite[$_gSpr_AccelX] += $x
	$hSprite[$_gSpr_AccelY] += $y
	; ---
	Return 1
EndFunc

Func _GEng_Sprite_InnertieSet(ByRef $hSprite, $x, $y)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$hSprite[$_gSpr_InnertieX] = $x
	$hSprite[$_gSpr_InnertieY] = $y
	Return 1
EndFunc

; ##############################################################

Func _GEng_Sprite_AngleSet(ByRef $hSprite, $iAngle) ; en degres
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	;$iAngle += $hSprite[39]
	$iAngle = __GEng_GeometryReduceAngle($iAngle)
	; ---
	$hSprite[$_gSpr_AngleDeg] = $iAngle ; deg
	$hSprite[$_gSpr_AngleRad] = __GEng_GeometryDeg2Rad($iAngle) ; rad
	; ---
	Return 1
EndFunc

Func _GEng_Sprite_AngleAdd(ByRef $hSprite, $iAngle)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	Local $newAngle = __GEng_GeometryReduceAngle($hSprite[$_gSpr_AngleDeg] + $iAngle)
	; ---
	$hSprite[$_gSpr_AngleDeg] = $newAngle ; deg
	$hSprite[$_gSpr_AngleRad] = __GEng_GeometryDeg2Rad($newAngle) ; rad
	; ---
	Return 1
EndFunc

Func _GEng_Sprite_AngleSpeedSet(ByRef $hSprite, $iAngle = Default, $iMax = Default)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	If $iAngle <> Default Then $hSprite[$_gSpr_AngleSpeed] = $iAngle
	If $iMax <> Default Then $hSprite[$_gSpr_AngleSpeedMax] = $iMax
	Return 1
EndFunc

Func _GEng_Sprite_AngleSpeedAdd(ByRef $hSprite, $iAngle)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$hSprite[$_gSpr_AngleSpeed] += $iAngle
	Return 1
EndFunc

Func _GEng_Sprite_AngleAccelSet(ByRef $hSprite, $iAngle)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$hSprite[$_gSpr_AngleAccel] = $iAngle
	Return 1
EndFunc

Func _GEng_Sprite_AngleAccelAdd(ByRef $hSprite, $iAngle)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$hSprite[$_gSpr_AngleAccel] += $iAngle
	Return 1
EndFunc

Func _GEng_sprite_AngleInnertieSet(ByRef $hSprite, $iAngle)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$hSprite[$_gSpr_AngleInnertie] = $iAngle
	Return 1
EndFunc
