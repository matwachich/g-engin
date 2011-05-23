#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.6.1
 Author:         Matwachich

 Script Function:


#ce ----------------------------------------------------------------------------

#Region ### Functions ###
#cs
- Main Functions
	_GEng_SpriteToPoint_Dist(ByRef $hSprite, $x, $y)
	_GEng_SpriteToPoint_Angle(ByRef $hSprite, $x, $y)
	_GEng_SpriteToPoint_AngleDiff(ByRef $hSprite, $x, $y)
	_GEng_SpriteToPoint_Vector(ByRef $hSprite, $x, $y, $iGrandeur = Default)
	_GEng_SpriteToSprite_Dist(ByRef $hSprite, ByRef $hSprite2)
	_GEng_SpriteToSprite_Angle(ByRef $hSprite, ByRef $hSprite2)
	_GEng_SpriteToSprite_Vector(ByRef $hSprite, ByRef $hSprite2, $iGrandeur = Default)
	_GEng_AngleToVector($iAngle, $iGrandeur = 1)
	_GEng_VectorToAngle($difX, $difY)
	__GEng_GeometryRad2Deg($rad)
	__GEng_GeometryDeg2Rad($nDegrees)
	__GEng_GeometryReduceAngle($iAngle)
#ce
#EndRegion ###


Func _GEng_SpriteToPoint_Dist(ByRef $hSprite, $x, $y)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	Local $x0, $y0
	Local $tmp = _GEng_SpriteGetPos($hSprite)
	$x0 = $tmp[0]
	$y0 = $tmp[1]
	$tmp = 0
	; ---
	$x = $x - $x0
	$y = $y - $y0
	; ---
	$tmp = ($x * $x) + ($y * $y)
	; ---
	Return Sqrt($tmp)
EndFunc

; Retourne l'angle "brute", par rapport au point d'origine de hSprite (Utile pour SetAngle)
Func _GEng_SpriteToPoint_Angle(ByRef $hSprite, $x, $y)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	Local $x0, $y0
	Local $tmp = _GEng_SpriteGetPos($hSprite) ; problème de l'inversion de l'angle
	$x0 = $tmp[0]
	$y0 = $tmp[1]
	$tmp = 0
	; ---
	Local $difX = $x - $x0
	Local $difY = $y - $y0
	$tmp = Abs(ATan($difY / $difX))
	; ---
	If $difX < 0 Then $tmp = $__GEng_PI - $tmp
	If $difY < 0 Then $tmp = $__GEng_PI + ($__GEng_PI - $tmp)
	; ---
	Return __GEng_GeometryRad2Deg($tmp)
EndFunc

; Retourne la différence d'angle entre hSprite et la position donné (Utile pour SetAngleSpeed)
Func _GEng_SpriteToPoint_AngleDiff(ByRef $hSprite, $x, $y) ; 0.2 ms
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	Local $angleDiff = _GEng_SpriteToPoint_Angle($hSprite, $x, $y)
	Local $angleCurr = _GEng_SpriteGetAngle($hSprite)
	If $angleCurr = 0 Then $angleCurr = 360
	; ---
	Local $angleInverse = __GEng_GeometryReduceAngle($angleCurr + 180)
	; ---
	Local $result = 0
	If $angleCurr >= 180 Then
		If $angleDiff < $angleCurr And $angleDiff > $angleInverse Then ; -
			$result = -1 * Abs($angleCurr - $angleDiff)
		Else ; +
			If $angleDiff > $angleCurr Then
				$result = Abs($angleDiff - $angleCurr)
			Else
				$result = Abs(Abs(360 - $angleCurr) + $angleDiff)
			EndIf
		EndIf
	Else
		If $angleDiff > $angleCurr And $angleDiff < $angleInverse Then ; +
			$result = Abs($angleDiff - $angleCurr)
		Else ; -
			If $angleDiff < $angleCurr Then
				$result = -1 * Abs($angleCurr - $angleDiff)
			ElseIf $angleDiff > $angleInverse And $angleDiff < 360 Then
				$result = -1 * Abs($angleCurr + Abs(360 - $angleDiff))
			EndIf
		EndIf
	EndIf
	; ---
	; NE JAMAIS appliquer ici _ReduceAngle(), car elle retourne toujour un angle (+)
	If $result = 360 Then $result = 0 ; cas spécial ou l'algoritme se trompe en retournant 360
	; ---
	Return $result
EndFunc

Func _GEng_SpriteToPoint_Vector(ByRef $hSprite, $x, $y, $iGrandeur = Default)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	Local $x0, $y0
	Local $tmp = _GEng_SpriteGetPos($hSprite)
	$x0 = $tmp[0]
	$y0 = $tmp[1]
	$tmp = 0
	; ---
EndFunc

; ##############################################################

Func _GEng_SpriteToSprite_Dist(ByRef $hSprite, ByRef $hSprite2)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	If Not __GEng_Sprite_IsSprite($hSprite2) Then Return SetError(1, 0, 0)
	; ---
	
EndFunc

Func _GEng_SpriteToSprite_Angle(ByRef $hSprite, ByRef $hSprite2)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	If Not __GEng_Sprite_IsSprite($hSprite2) Then Return SetError(1, 0, 0)
	; ---
	
EndFunc

Func _GEng_SpriteToSprite_Vector(ByRef $hSprite, ByRef $hSprite2, $iGrandeur = Default)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	If Not __GEng_Sprite_IsSprite($hSprite2) Then Return SetError(1, 0, 0)
	; ---
	
EndFunc

; ##############################################################

Func _GEng_AngleToVector($iAngle, $iGrandeur = 1) ; OK
	$iAngle = __GEng_GeometryDeg2Rad($iAngle)
	; ---
	Local $ret[2] = [ _
		Cos($iAngle) * $iGrandeur, _
		Sin($iAngle) * $iGrandeur _
	]
	Return $ret
EndFunc

Func _GEng_VectorToAngle($difX, $difY) ; OK
	If $difX = 0 And $difY = 0 Then Return -1
	; ---
	Local $tmp = Abs(ATan($difY / $difX))
	; ---
	If $difX < 0 Then $tmp = $__GEng_PI - $tmp
	If $difY < 0 Then $tmp = $__GEng_PI + ($__GEng_PI - $tmp)
	; ---
	Local $ret = __GEng_GeometryRad2Deg($tmp)
	Return $ret
EndFunc

; ##############################################################

Func __GEng_GeometryRad2Deg($rad) ; OK
	Local $ret = $rad / ($__GEng_PI / 180)
	Return __GEng_GeometryReduceAngle($ret)
EndFunc

Func __GEng_GeometryDeg2Rad($nDegrees) ; OK
	If $nDegrees >= 360 Then $nDegrees = __GEng_GeometryReduceAngle($nDegrees)
	Return $nDegrees / 57.2957795130823
EndFunc

Func __GEng_GeometryReduceAngle($iAngle) ; OK
	$iAngle = Round($iAngle)
	If $iAngle < 0 Then
		$iAngle = 360 - (Abs($iAngle) - 360)
	EndIf
	While $iAngle >= 360
		$iAngle -= 360
	WEnd
	If $iAngle = 360 Then $iAngle = 0
	Return $iAngle
EndFunc
