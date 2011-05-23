#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.6.1
 Author:         Matwachich

 Script Function:


#ce ----------------------------------------------------------------------------

Func _GEng_AngleVectorCreate($rotSpeed = 0, $rotAccel = 0, $rotInner = 0, $rotSpeedMax = 0, $rotAccelMax = 0)
	Local $a[5]
	$a[0] = $rotSpeed
	$a[1] = $rotAccel
	$a[2] = $rotInner
	$a[3] = $rotSpeedMax
	$a[4] = $rotAccelMax
	Return $a
EndFunc

Func _GEng_AngleVectorSet(ByRef $hRotVect, $rotSpeed = Default, $rotAccel = Default, $rotInner = Default, $rotSpeedMax = Default, $rotAccelMax = Default)
	If Not __GEng_AngleVector_IsAngleVector($hRotVect) Then Return SetError(1, 0, 0)
	; ---
	If $rotSpeed <> Default Then $hRotVect[0] = $rotSpeed
	If $rotAccel <> Default Then $hRotVect[1] = $rotAccel
	If $rotInner <> Default Then $hRotVect[2] = $rotInner
	If $rotSpeedMax <> Default Then $hRotVect[3] = $rotSpeedMax
	If $rotAccelMax <> Default Then $hRotVect[4] = $rotAccelMax
	; ---
	Return 1
EndFunc

Func _GEng_AngleVectorApply(ByRef $hRotVect, ByRef $hSprite)
	If Not __GEng_AngleVector_IsAngleVector($hRotVect) Then Return SetError(1, 0, 0)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$hSprite[19] = $hRotVect[0] ; VitRot
	$hSprite[35] = $hRotVect[1] ; AccelRot
	$hSprite[37] = $hRotVect[2] ; InnerRot
	$hSprite[34] = $hRotVect[3] ; VitRotMax
	$hSprite[36] = $hRotVect[4] ; AccelRotMax
	; ---
	Return 1
EndFunc

Func _GEng_AngleVectorAdd(ByRef $hRotVect, ByRef $hSprite)
	If Not __GEng_AngleVector_IsAngleVector($hRotVect) Then Return SetError(1, 0, 0)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$hSprite[19] += $hRotVect[0] ; VitRot
	$hSprite[35] += $hRotVect[1] ; AccelRot
	$hSprite[37] += $hRotVect[2] ; InnerRot
	$hSprite[34] = $hRotVect[3] ; VitRotMax
	$hSprite[36] = $hRotVect[4] ; AccelRotMax
	; ---
	Return 1
EndFunc

; ==============================================================
; ### Internals
; ==============================================================
Func __GEng_AngleVector_IsAngleVector(ByRef $hRotVect)
	If Not IsArray($hRotVect) Then Return SetError(1, 0, 0)
	If UBound($hRotVect) <> 5 Then Return SetError(1, 0, 0)
	; ---
	Return 1
EndFunc
