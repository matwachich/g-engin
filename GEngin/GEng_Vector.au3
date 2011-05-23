#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.6.1
 Author:         Matwachich

 Script Function:


#ce ----------------------------------------------------------------------------

#Region ### Functions ###
#cs
- Main Functions
	_GEng_VectorCreate($vitX = 0, $vitY = 0, $accelX = 0, $accelY = 0, $innerX = 0, $innerY = 0, $vitXMax = 0, $vitYMax = 0, $accelXMax = 0, $accelYMax = 0)
	_GEng_VectorSet(ByRef $hVector, $vitX = Default, $vitY = Default, $accelX = Default, $accelY = Default, _
					$innerX = Default, $innerY = Default, _
					$vitXMax = Default, $vitYMax = Default, $accelXMax = Default, $accelYMax = Default)
	_GEng_VectorApply(ByRef $hVector, ByRef $hSprite)
	_GEng_VectorAdd(ByRef $hVector, ByRef $hSprite)
	; ---
	_GEng_AngleVectorCreate($rotSpeed = 0, $rotAccel = 0, $rotInner = 0, $rotSpeedMax = 0, $rotAccelMax = 0)
	_GEng_AngleVectorSet(ByRef $hRotVect, $rotSpeed = Default, $rotAccel = Default, $rotInner = Default, $rotSpeedMax = Default, $rotAccelMax = Default)
	_GEng_AngleVectorApply(ByRef $hRotVect, ByRef $hSprite)
	_GEng_AngleVectorAdd(ByRef $hRotVect, ByRef $hSprite)
	; ---
	__GEng_Vector_IsVector(ByRef $hVector)
	__GEng_AngleVector_IsRotVector(ByRef $hRotVect)
#ce
#EndRegion ###


Func _GEng_VectorCreate($vitX = 0, $vitY = 0, $accelX = 0, $accelY = 0, $innerX = 0, $innerY = 0, $vitXMax = 0, $vitYMax = 0, $accelXMax = 0, $accelYMax = 0)
	Local $a[10] = [ _
		$vitX, _
		$vitY, _
		$accelX, _
		$accelY, _
		$vitXMax, _
		$vitYMax, _
		$accelXMax, _
		$accelYMax, _
		$innerX, _
		$innerY _
	]
	Return $a
EndFunc

Func _GEng_VectorSet(ByRef $hVector, $vitX = Default, $vitY = Default, $accelX = Default, $accelY = Default, _
					$innerX = Default, $innerY = Default, _
					$vitXMax = Default, $vitYMax = Default, $accelXMax = Default, $accelYMax = Default)
	If Not __GEng_Vector_IsVector($hVector) Then Return SetError(1, 0, 0)
	; ---
	If $vitX <> Default Then $hVector[0] = $vitX
	If $vitY <> Default Then $hVector[1] = $vitY
	If $accelX <> Default Then $hVector[2] = $accelX
	If $accelY <> Default Then $hVector[3] = $accelY
	If $vitXMax <> Default Then $hVector[4] = $vitXMax
	If $vitYMax <> Default Then $hVector[5] = $vitYMax
	If $accelXMax <> Default Then $hVector[6] = $accelXMax
	If $accelYMax <> Default Then $hVector[7] = $accelYMax
	If $innerX <> Default Then $hVector[8] = $innerX
	If $innerY <> Default Then $hVector[9] = $innerY
	; ---
	Return 1
EndFunc

Func _GEng_VectorApply(ByRef $hVector, ByRef $hSprite)
	If Not __GEng_Vector_IsVector($hVector) Then Return SetError(1, 0, 0)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$hSprite[13] = $hVector[0] ; VitX
	$hSprite[14] = $hVector[1] ; VitY
	$hSprite[15] = $hVector[2] ; AccelX
	$hSprite[16] = $hVector[3] ; AccelY
	$hSprite[27] = $hVector[4]  ; VitMaxX
	$hSprite[28] = $hVector[5]  ; VitMaxY
	$hSprite[29] = $hVector[6]  ; AccelMaxX
	$hSprite[30] = $hVector[7]  ; AccelMaxY
	$hSprite[31] = $hVector[8] ; InnerX
	$hSprite[32] = $hVector[9] ; InnerY
	; ---
	Return 1
EndFunc

Func _GEng_VectorAdd(ByRef $hVector, ByRef $hSprite)
	If Not __GEng_Vector_IsVector($hVector) Then Return SetError(1, 0, 0)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$hSprite[13] += $hVector[0] ; VitX
	$hSprite[14] += $hVector[1] ; VitY
	$hSprite[15] += $hVector[2] ; AccelX
	$hSprite[16] += $hVector[3] ; AccelY
	$hSprite[27] = $hVector[4]  ; VitMaxX
	$hSprite[28] = $hVector[5]  ; VitMaxY
	$hSprite[29] = $hVector[6]  ; AccelMaxX
	$hSprite[30] = $hVector[7]  ; AccelMaxY
	$hSprite[31] += $hVector[8] ; InnerX
	$hSprite[32] += $hVector[9] ; InnerY
	; ---
	Return 1
EndFunc

; ==============================================================
; ### Internals
; ==============================================================
Func __GEng_Vector_IsVector(ByRef $hVector)
	If Not IsArray($hVector) Then Return SetError(1, 0, 0)
	If UBound($hVector) <> 10 Then Return SetError(1, 0, 0)
	; ---
	Return 1
EndFunc
