#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.6.1
 Author:         Matwachich

 Script Function:


#ce ----------------------------------------------------------------------------

#Region ### Functions ###
#cs
- Main Functions
	_GEng_Sprite_Move(ByRef $hSprite)
#ce
#EndRegion ###

Func _GEng_Sprite_Move(ByRef $hSprite)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	If Not $hSprite[33] Then
		$hSprite[33] = TimerInit()
		Return 0
	EndIf
	Local $ms = TimerDiff($hSprite[33]) / 1000
	
	; ##############################################################
	
	; ### Rotation Max ###
	If $hSprite[34] <> 0 Then
		If Abs($hSprite[19]) > Abs($hSprite[34]) Then
			If $hSprite[19] >= 0 Then
				$hSprite[19] = Abs($hSprite[34])
			Else
				$hSprite[19] = -1 * Abs($hSprite[34])
			EndIf
		EndIf
	EndIf
	; ### Application de la rotation ###
	Local $rotVit = $hSprite[19]
		Local $rotVitMax = $hSprite[34]
	Local $rotAccel = $hSprite[35]
	Local $rotInner = $hSprite[37]
	; --- Vitesse
	Local $currAngle = $hSprite[17]
	If $rotVit <> 0 Then
		_GEng_SpriteSetAngle($hSprite, $currAngle + ($rotVit * $ms))
	EndIf
	; --- Accélération
	If $rotAccel <> 0 Then
		$hSprite[19] += $rotAccel * $ms
	EndIf
	; --- Innertie
	Local $tmp
	If $rotInner <> 0 And $hSprite[19] <> 0 Then
		$tmp = $hSprite[19]
		If $hSprite[19] > 0 Then
			$hSprite[19] -= Abs($rotInner) * $ms
		ElseIf $hSprite[19] < 0 Then
			$hSprite[19] += Abs($rotInner) * $ms
		EndIf
		If $hSprite[19] / $tmp < 0 Then $hSprite[19] = 0
	EndIf
	
	; ##############################################################
	
	Local $posX = $hSprite[7], $posY = $hSprite[8] ; Position actuelle
	Local $accelX = $hSprite[15], $accelY = $hSprite[16] ; Accélération
	Local $accelGrand = __GEng_VectorGrandeur($accelX, $accelY)
	;If $accelGrand Then ConsoleWrite("> Accélération: " & $accelX & "	" & $accelY & "	(" & $accelGrand & ")" & @CRLF)
	; ---
	
	; Applique l'accélération
	$hSprite[13] += $accelX * $ms
	$hSprite[14] += $accelY * $ms
	Local $vitGrand = __GEng_VectorGrandeur($hSprite[13], $hSprite[14])
	Local $vitAngle = _GEng_VectorToAngle($hSprite[13], $hSprite[14])
	
	; Vitesse Maximum
	If $hSprite[27] <> 0 And $vitGrand > $hSprite[27] Then
		$tmp = _GEng_AngleToVector($vitAngle, $hSprite[27])
		$hSprite[13] = $tmp[0]
		$hSprite[14] = $tmp[1]
	EndIf
	
	; Position
	$hSprite[7] += $hSprite[13] * $ms
	$hSprite[8] += $hSprite[14] * $ms

	Local $innerX = $hSprite[31], $innerY = $hSprite[32]
	If $innerX <> 0 And $hSprite[13] <> 0 And Not $accelX Then ; Innertie X
		$tmp = $hSprite[13]
		If $hSprite[13] > 0 Then
			$hSprite[13] -= Abs($innerX) * $ms
		ElseIf $hSprite[13] < 0 Then
			$hSprite[13] += Abs($innerX) * $ms
		EndIf
		If $hSprite[13] / $tmp < 0 Then $hSprite[13] = 0
	EndIf
	If $innerY <> 0 And $hSprite[14] <> 0 And Not $accelY Then ; Innertie Y
		$tmp = $hSprite[14]
		If $hSprite[14] > 0 Then
			$hSprite[14] -= Abs($innerY) * $ms
		ElseIf $hSprite[14] < 0 Then
			$hSprite[14] += Abs($innerY) * $ms
		EndIf
		If $hSprite[14] / $tmp < 0 Then $hSprite[14] = 0
	EndIf
	
	; ##############################################################
	
	; Réinitialisation du timer
	$hSprite[33] = TimerInit()
	; ---
	Return 1
EndFunc

Func __GEng_VectorGrandeur($x, $y)
	Return Abs(Sqrt(($x^2) + ($y^2)))
EndFunc

#cs

	Local $currPosX, $currPosY
	$currPosX = $hSprite[7]
	$currPosY = $hSprite[8]
	
	; ### Vitesse Max ###
	Local $currVitAngle = _GEng_VectorToAngle($hSprite[13], $hSprite[14]) ; Pour l'angle de mouvement actuel
	Local $currVitGrandeur = __GEng_VectorGrandeur($hSprite[13], $hSprite[14])
	
	If $hSprite[27] <> 0 Then
		If $currVitGrandeur > Abs($hSprite[27]) Then
			$tmp = _GEng_AngleToVector($currVitAngle, $hSprite[27])
			_GEng_SpriteSetSpeed($hSprite, $tmp[0], $tmp[1])
		EndIf
	EndIf
	; ---
	; Variables
	Local $accelX = $hSprite[15]
	Local $accelY = $hSprite[16]
	Local $innerX = $hSprite[31]
	Local $innerY = $hSprite[32]
	; ---
	
	Local $currAccelGrandeur = __GEng_VectorGrandeur($accelX, $accelY)
	Local $currAccelAngle = _GEng_VectorToAngle($accelX, $accelY)

	If $currAccelGrandeur <> 0 Then ; Accélération
		$currVitGrandeur += $currAccelGrandeur * $ms
		$tmp = _GEng_AngleToVector($currVitAngle, $currVitGrandeur)
		_GEng_SpriteSetSpeed($hSprite, $tmp[0], $tmp[1])
	EndIf
	; ---
	
	Local $vitX = $hSprite[13]
	Local $vitY = $hSprite[14]
	ConsoleWrite(">>> " & $vitX & " - " & $vitY & @CRLF)
	
	If $vitX <> 0 And $vitY <> 0 Then ; Vitesse
		_GEng_SpriteSetPos($hSprite, $currPosX + ($vitX * $ms), $currPosY + ($vitY * $ms))
	EndIf
	; ---
	
	If $innerX <> 0 And $hSprite[13] <> 0 Then ; Innertie X
		$tmp = $hSprite[13]
		If $hSprite[13] > 0 Then
			$hSprite[13] -= Abs($innerX) * $ms
		ElseIf $hSprite[13] < 0 Then
			$hSprite[13] += Abs($innerX) * $ms
		EndIf
		If $hSprite[13] / $tmp < 0 Then $hSprite[13] = 0
	EndIf
	If $innerY <> 0 And $hSprite[14] <> 0 Then ; Innertie Y
		$tmp = $hSprite[14]
		If $hSprite[14] > 0 Then
			$hSprite[14] -= Abs($innerY) * $ms
		ElseIf $hSprite[14] < 0 Then
			$hSprite[14] += Abs($innerY) * $ms
		EndIf
		If $hSprite[14] / $tmp < 0 Then $hSprite[14] = 0
	EndIf
	; ---
#ce

#cs
Func _GEng_Sprite_Move(ByRef $hSprite) ; Appelé par _GEng_SpriteDraw()
	; verifier le timer
	; les maximum
	; appliquer la vitesse
	; appliquer l'accélération
	; appliquer l'innertie
	; initialiser le timer
	; ---
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	If Not $hSprite[33] Then
		$hSprite[33] = TimerInit()
		Return 0
	EndIf
	Local $ms = TimerDiff($hSprite[33]) / 1000
	; ---
	; Verification des maximums
	If $hSprite[27] <> 0 Then
		If Abs($hSprite[13]) > Abs($hSprite[27]) Then ; vitX
			If $hSprite[13] > 0 Then ; Nombre +
				$hSprite[13] = Abs($hSprite[27])
			ElseIf $hSprite[13] < 0 Then ; Nombre -
				$hSprite[13] = -1 * Abs($hSprite[27])
			EndIf
		EndIf
	EndIf
	If $hSprite[28] <> 0 Then
		If Abs($hSprite[14]) > Abs($hSprite[28]) Then ; vitY
			If $hSprite[14] > 0 Then ; Nombre +
				$hSprite[14] = Abs($hSprite[28])
			ElseIf $hSprite[14] < 0 Then ; Nombre -
				$hSprite[14] = -1 * Abs($hSprite[28])
			EndIf
		EndIf
	EndIf
	If $hSprite[29] <> 0 Then
		If Abs($hSprite[15]) > Abs($hSprite[29]) Then ; AccelX
			If $hSprite[15] > 0 Then ; Nombre +
				$hSprite[15] = Abs($hSprite[29])
			ElseIf $hSprite[15] < 0 Then ; Nombre -
				$hSprite[15] = -1 * Abs($hSprite[29])
			EndIf
		EndIf
	EndIf
	If $hSprite[30] <> 0 Then
		If Abs($hSprite[16]) > Abs($hSprite[30]) Then ; AccelY
			If $hSprite[16] > 0 Then ; Nombre +
				$hSprite[16] = Abs($hSprite[30])
			ElseIf $hSprite[16] < 0 Then ; Nombre -
				$hSprite[16] = -1 * Abs($hSprite[30])
			EndIf
		EndIf
	EndIf
	If $hSprite[34] <> 0 Then
		If Abs($hSprite[19]) > Abs($hSprite[34]) Then ; RotSpeed
			If $hSprite[19] > 0 Then ; Nombre +
				$hSprite[19] = Abs($hSprite[34])
			ElseIf $hSprite[19] < 0 Then ; Nombre -
				$hSprite[19] = -1 * Abs($hSprite[34])
			EndIf
		EndIf
	EndIf
	If $hSprite[36] <> 0 Then
		If Abs($hSprite[35]) > Abs($hSprite[36]) Then ; RotAccel
			If $hSprite[35] > 0 Then ; Nombre +
				$hSprite[35] = Abs($hSprite[36])
			ElseIf $hSprite[35] < 0 Then ; Nombre -
				$hSprite[35] = -1 * Abs($hSprite[36])
			EndIf
		EndIf
	EndIf
	; ---
	; Récupération des variables
	Local $vitX = $hSprite[13]
	Local $vitY = $hSprite[14]
	Local $accelX = $hSprite[15]
	Local $accelY = $hSprite[16]
	Local $innerX = $hSprite[31]
	Local $innerY = $hSprite[32]
	Local $rotVit = $hSprite[19]
	Local $rotAccel = $hSprite[35]
	Local $rotInner = $hSprite[37]
	; ---
	; Application de la vitesse
	If $vitX <> 0 Or $vitY <> 0 Then ; Position
		; --- Position Actuelle
		Local $posX = $hSprite[7]
		Local $posY = $hSprite[8]
		; --- Application
		_GEng_SpriteSetPos($hSprite, $posX + ($vitX * $ms), $posY + ($vitY * $ms))
	EndIf
	If $rotVit <> 0 Then ; Rotation
		Local $currAngle = $hSprite[17]
		_GEng_SpriteSetAngle($hSprite, $currAngle + ($rotVit * $ms))
	EndIf
	; ---
	; Application de l'accélération sur la vitesse
	If $accelX <> 0 Or $accelY <> 0 Then ; Position
		$hSprite[13] += $accelX * $ms
		$hSprite[14] += $accelY * $ms
	EndIf
	If $rotAccel <> 0 Then ; Rotation
		$hSprite[19] += $rotAccel * $ms
	EndIf
	; ---
	; Application de l'innertie sur la vitesse
	Local $tmp
	If $innerX <> 0 And $hSprite[13] <> 0 Then
		$tmp = $hSprite[13]
		If $hSprite[13] > 0 Then
			$hSprite[13] -= Abs($innerX) * $ms
		ElseIf $hSprite[13] < 0 Then
			$hSprite[13] += Abs($innerX) * $ms
		EndIf
		If $hSprite[13] / $tmp < 0 Then $hSprite[13] = 0
	EndIf
	If $innerY <> 0 And $hSprite[14] <> 0 Then
		$tmp = $hSprite[14]
		If $hSprite[14] > 0 Then
			$hSprite[14] -= Abs($innerY) * $ms
		ElseIf $hSprite[14] < 0 Then
			$hSprite[14] += Abs($innerY) * $ms
		EndIf
		If $hSprite[14] / $tmp < 0 Then $hSprite[14] = 0
	EndIf
	; --- Rotation
	If $rotInner <> 0 And $hSprite[19] <> 0 Then
		$tmp = $hSprite[19]
		If $hSprite[19] > 0 Then
			$hSprite[19] -= Abs($rotInner) * $ms
		ElseIf $hSprite[19] < 0 Then
			$hSprite[19] += Abs($rotInner) * $ms
		EndIf
		If $hSprite[19] / $tmp < 0 Then $hSprite[19] = 0
	EndIf
	; ---
	; Réinitialisation du timer
	$hSprite[33] = TimerInit()
	; ---
	Return 1
EndFunc
#ce