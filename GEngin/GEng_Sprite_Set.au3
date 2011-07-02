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
	_GEng_Sprite_InnertieSet(ByRef $hSprite, $value)
	_GEng_Sprite_AngleSet(ByRef $hSprite, $iAngle)
	_GEng_Sprite_AngleAdd(ByRef $hSprite, $iAngle)
	_GEng_Sprite_AngleSpeedSet(ByRef $hSprite, $iAngle = Default, $iMax = Default)
	_GEng_Sprite_AngleSpeedAdd(ByRef $hSprite, $iAngle)
	_GEng_Sprite_AngleAccelSet(ByRef $hSprite, $iAngle)
	_GEng_Sprite_AngleAccelAdd(ByRef $hSprite, $iAngle)
	_GEng_sprite_AngleInnertieSet(ByRef $hSprite, $iAngle)
#ce
#EndRegion ###


; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Sprite_MasseSet
; Description....:	Ajuste la masse d'un Sprite pour les calcules de collision dynamique
; Parameters.....:	$hSprite = Objet Sprite
;					$iMasse = Valeur de la masse
; Return values..:	Succes - 1
;					Echec - 0 et @error = 1
; Author.........:	Matwachich
; Remarks........:	Une masse de 0 (par défaut lorsqu'un sprite est crée) signifie que le sprite
;						ne sera pas affecté par les collisions dynamiques
; ===========================================================================================================
Func _GEng_Sprite_MasseSet(ByRef $hSprite, $iMasse)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$hSprite[$_gSpr_Masse] = $iMasse
	; ---
	Return 1
EndFunc

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Sprite_PosSet
; Description....:	Modifie la position d'un Objet Sprite
; Parameters.....:	$hSprite = Objet Sprite
;					$x, $y = Nouvelle position
;						Si une valeur est laissé par défaut, elle n'est pas modifié
; Return values..:	Succes - 1
;					Echec - 0 et @error = 1
; Author.........:	Matwachich
; Remarks........:	
; ===========================================================================================================
Func _GEng_Sprite_PosSet(ByRef $hSprite, $x = Default, $y = Default)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	; J'enregistre la position que JE donne
	If $x <> Default Then $hSprite[$_gSpr_PosX] = $x; - $hSprite[11]
	If $y <> Default Then $hSprite[$_gSpr_PosY] = $y; - $hSprite[12]
	; ---
	Return 1
EndFunc

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Sprite_SizeSet
; Description....:	Modifie la taille d'un Objet Sprite
; Parameters.....:	$hSprite = Objet Sprite
;					$w, $h = Nouvelle valeurs de taille
;						Une valeur laissé par défaut n'est pas changé
;						Une valeur négative se vera attribué la taille de l'image assigné au sprite
; Return values..:	Succes - 1
;					Echec - 0 et @error = 1
; Author.........:	Matwachich
; Remarks........:	Apres setSize, origin est faussé
; ===========================================================================================================
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

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Sprite_OriginSet
; Description....:	Modifie le point d'origine d'un Objet Sprite
; Parameters.....:	$hSprite = Objet Sprite
;					$x, $y = Position du point d'origine
;						Une valeur laissé par défaut n'est pas modifié
; Return values..:	Succes - 1
;					Echec - 0 et @error = 1
; Author.........:	Matwachich
; Remarks........:	Cette fonction donne une valeur précise au point d'origine
; ===========================================================================================================
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

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Sprite_OriginSetEx
; Description....:	Modifie le point d'origine d'un Objet Sprite
; Parameters.....:	$hSprite = Objet Sprite
;					$eOrigine = Une des Constantes suivante:
;						$GEng_Origin_Mid = Milieu de l'image (Middle)
;						$GEng_Origin_TL = Coin supérieur gauche de l'image (Top Left)
;						$GEng_Origin_TR = Coin supérieur droit de l'image (Top Right)
;						$GEng_Origin_BL = Coin inférieur gauche de l'image (Bottom Left)
;						$GEng_Origin_BR = Coin supérieur droit de l'image (Bottom Right)
; Return values..:	Succes - 1
;					Echec - 0 et @error = 1
; Author.........:	Matwachich
; Remarks........:	
; ===========================================================================================================
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

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Sprite_AngleOriginSet
; Description....:	Modifie la valeur de l'angle d'origine d'un Sprite (la direction avant de l'image)
; Parameters.....:	$hSprite = Objet Sprite
;					$iAngle = Valeur de l'angle (n'importe quelle valeur)
; Return values..:	Succes - 1
;					Echec - 0 et @error = 1
; Author.........:	Matwachich
; Remarks........:	Exemple: un Sprite contenant l'image d'un avion orienté vers le haut aura un angle
;						d'origine de -90 ou 270
;					L'utilité est que un _GEng_Sprite_AngleSet sera dirigé vers l'avant de l'avion
; ===========================================================================================================
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

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Sprite_SpeedSet
; Description....:	Modifie la vitesse et la vitesse maximale d'un Sprite
; Parameters.....:	$hSprite = Objet Sprite
;					$x, $y = Valeur de la vitesse sur les différents axes
;					$max = Vitesse maximale
;						Une valeur laissé par défaut ne sera pas modifié
; Return values..:	Succes - 1
;					Echec - 0 et @error = 1
; Author.........:	Matwachich
; Remarks........:	La vitesse maximale est le produit vectoriel de $x et $y
; ===========================================================================================================
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

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Sprite_SpeedAdd
; Description....:	Additione les valeur en paramètres à la vitesse actuelle d'un Sprite
; Parameters.....:	$hSprite = Objet Sprite
;					$x, $y = Valeur à ajouter (par défaut: 0)
; Return values..:	Succes - 1
;					Echec - 0 et @error = 1
; Author.........:	Matwachich
; Remarks........:	
; ===========================================================================================================
Func _GEng_Sprite_SpeedAdd(ByRef $hSprite, $x = 0, $y = 0)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$hSprite[$_gSpr_SpeedX] += $x
	$hSprite[$_gSpr_SpeedY] += $y
	; ---
	Return 1
EndFunc

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Sprite_AccelSet
; Description....:	Modifie l'accélération d'un sprite
; Parameters.....:	$hSprite = Objet Sprite
;					$x, $y = Valeur de l'accélération sur les différents axes
;						Une valeur laissé par défaut ne sera pas modifié
; Return values..:	Succes - 1
;					Echec - 0 et @error = 1
; Author.........:	Matwachich
; Remarks........:	
; ===========================================================================================================
Func _GEng_Sprite_AccelSet(ByRef $hSprite, $x = Default, $y = Default)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	If $x <> Default Then $hSprite[$_gSpr_AccelX] = $x
	If $y <> Default Then $hSprite[$_gSpr_AccelY] = $y
	; ---
	Return 1
EndFunc

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Sprite_AccelAdd
; Description....:	Additione les valeur en paramètres à l'accélération actuelle d'un Sprite
; Parameters.....:	$hSprite = Objet Sprite
;					$x, $y = Valeur à ajouter (par défaut: 0)
; Return values..:	Succes - 1
;					Echec - 0 et @error = 1
; Author.........:	Matwachich
; Remarks........:	
; ===========================================================================================================
Func _GEng_Sprite_AccelAdd(ByRef $hSprite, $x = 0, $y = 0)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$hSprite[$_gSpr_AccelX] += $x
	$hSprite[$_gSpr_AccelY] += $y
	; ---
	Return 1
EndFunc

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Sprite_InnertieSet
; Description....:	Modifie l'innertie d'un Sprite
; Parameters.....:	$hSprite = Objet Sprite
;					$value = Valeur de l'innertie
; Return values..:	Succes - 1
;					Echec - 0 et @error = 1
; Author.........:	Matwachich
; Remarks........:	
; ===========================================================================================================
Func _GEng_Sprite_InnertieSet(ByRef $hSprite, $value)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$hSprite[$_gSpr_Innertie] = $value
	Return 1
EndFunc

; ##############################################################

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Sprite_AngleSet
; Description....:	Modifie l'angle (direction) d'un Sprite
; Parameters.....:	$hSprite = Objet Sprite
;					$iAngle = N'importe quelle valeur, elle sera convertie entre 0 et 359
; Return values..:	Succes - 1
;					Echec - 0 et @error = 1
; Author.........:	Matwachich
; Remarks........:	
; ===========================================================================================================
Func _GEng_Sprite_AngleSet(ByRef $hSprite, $iAngle) ; en degres
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$iAngle -= $hSprite[$_gSpr_AngleOriDeg]
	$iAngle = __GEng_GeometryReduceAngle($iAngle)
	; ---
	$hSprite[$_gSpr_AngleDeg] = $iAngle ; deg
	$hSprite[$_gSpr_AngleRad] = __GEng_GeometryDeg2Rad($iAngle) ; rad
	; ---
	Return 1
EndFunc

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Sprite_AngleAdd
; Description....:	Additione la valeur passé en paramètre à l'angle actuel d'un Sprite
; Parameters.....:	$hSprite = Objet Sprite
;					$iAngle = Valeur à ajouter
; Return values..:	Succes - 1
;					Echec - 0 et @error = 1
; Author.........:	Matwachich
; Remarks........:	
; ===========================================================================================================
Func _GEng_Sprite_AngleAdd(ByRef $hSprite, $iAngle = 0)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	Local $newAngle = __GEng_GeometryReduceAngle($hSprite[$_gSpr_AngleDeg] + $iAngle)
	; ---
	$hSprite[$_gSpr_AngleDeg] = $newAngle ; deg
	$hSprite[$_gSpr_AngleRad] = __GEng_GeometryDeg2Rad($newAngle) ; rad
	; ---
	Return 1
EndFunc

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Sprite_AngleSpeedSet
; Description....:	Modifie la vitesse de rotation, et la vitesse de rotation maximale d'un Sprite
; Parameters.....:	$hSprite = Objet Sprite
;					$iAngle = Vitesse de rotation (+ => Horaire, - => Anti-horaire)
;					$iMax = Vitesse maximale (Voir remarque)
; Return values..:	Succes - 1
;					Echec - 0 et @error = 1
; Author.........:	Matwachich
; Remarks........:	La vitesse maximale est prise comme valeur absolue, et est donc valable pour les
;						2 directions de rotation
; ===========================================================================================================
Func _GEng_Sprite_AngleSpeedSet(ByRef $hSprite, $iAngle = Default, $iMax = Default)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	If $iAngle <> Default Then $hSprite[$_gSpr_AngleSpeed] = $iAngle
	If $iMax <> Default Then $hSprite[$_gSpr_AngleSpeedMax] = $iMax
	Return 1
EndFunc

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Sprite_AngleSpeedAdd
; Description....:	Ajoute la valeur en paramètre à la vitesse de rotation actuelle d'un Sprite
; Parameters.....:	$hSprite = Objet Sprite
;					$iAngle = Valeur à ajouter
; Return values..:	Succes - 1
;					Echec - 0 et @error = 1
; Author.........:	Matwachich
; Remarks........:	
; ===========================================================================================================
Func _GEng_Sprite_AngleSpeedAdd(ByRef $hSprite, $iAngle = 0)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$hSprite[$_gSpr_AngleSpeed] += $iAngle
	Return 1
EndFunc

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Sprite_AngleAccelSet
; Description....:	Modifie l'accélération de rotation d'un objet Sprite
; Parameters.....:	$hSprite = Objet Sprite
;					$iAngle = Accélération de rotation
;						Si laissé par défaut, ne sera pas modifiée
; Return values..:	Succes - 1
;					Echec - 0 et @error = 1
; Author.........:	Matwachich
; Remarks........:	
; ===========================================================================================================
Func _GEng_Sprite_AngleAccelSet(ByRef $hSprite, $iAngle = Default)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	If $iAngle <> Default Then $hSprite[$_gSpr_AngleAccel] = $iAngle
	Return 1
EndFunc

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Sprite_AngleAccelAdd
; Description....:	Additione la valeur en paramètre à l'accélération de rotation actuelle d'un Sprite
; Parameters.....:	$hSprite = Objet Sprite
;					$iAngle = Valeur à ajouter
; Return values..:	Succes - 1
;					Echec - 0 et @error = 1
; Author.........:	Matwachich
; Remarks........:	
; ===========================================================================================================
Func _GEng_Sprite_AngleAccelAdd(ByRef $hSprite, $iAngle = 0)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$hSprite[$_gSpr_AngleAccel] += $iAngle
	Return 1
EndFunc

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_sprite_AngleInnertieSet
; Description....:	Modifie l'innertie de rotation d'un Sprite
; Parameters.....:	$hSprite = Objet Sprite
;					$iAngle = Valeur de l'innertie de rotation
; Return values..:	Succes - 1
;					Echec - 0 et @error = 1
; Author.........:	Matwachich
; Remarks........:	
; ===========================================================================================================
Func _GEng_sprite_AngleInnertieSet(ByRef $hSprite, $iAngle = Default)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	If $iAngle <> Default Then $hSprite[$_gSpr_AngleInnertie] = $iAngle
	Return 1
EndFunc

; ##############################################################

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Sprite_ColorMatrixAdd
; Description....:	Modifie les composantes des couleurs de l'image d'un Objet Sprite
; Parameters.....:	$hSprite = Objet Sprite
;					$fRed = Pourcentage à ajouter/soustraire à la composante ROUGE
;					$fGreen = Pourcentage à ajouter/soustraire à la composante VERTE
;					$fBlue = Pourcentage à ajouter/soustraire à la composante BLEU
;					$fAlpha = Pourcentage à ajouter/soustraire à la composante ALPHA (Transparence)
; Return values..:	Succes - 1
;					Echec - 0 et @error = 1
; Author.........:	Matwachich
; Remarks........:	Exemple: $fRed = 0.5 ajoute 50% à la composante rouge, 1.0 ajoute 100%, un nombre supérieur
;						à 1.0 ajoute aussi 100%, un nombre négatif soustrait à la composante en question
;					Cette fonction double le temps nécessaire au dessin du sprite (_GEng_Sprite_Draw)
; ===========================================================================================================
Func _GEng_Sprite_ColorMatrixTranslate(ByRef $hSprite, $fRed = 0, $fGreen = 0, $fBlue = 0, $fAlpha = 0)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	_GDIPlus_ColorMatrixTranslate($hSprite[$_gSpr_ColorMatrix], $fRed, $fGreen, $fBlue, $fAlpha)
	_GDIPlus_ImageAttributesSetColorMatrix($hSprite[$_gSpr_hImgAttrib], 0, True, $hSprite[$_gSpr_ColorMatrixPtr])
	; ---
	$hSprite[$_gSpr_UseColorMatrix] = 1 ; Active l'utilisation de la ColorMatrix
	; ---
	Return 1
EndFunc

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Sprite_ColorMatrixSet
; Description....:	Réinitialise la matrice couleur d'un objet Sprite
; Parameters.....:	$hSprite = Objet Sprite
; Return values..:	Succes - 1
;					Echec - 0 et @error = 1
; Author.........:	Matwachich
; Remarks........:	Cette fonction annule le ralentissement causé par _GEng_Sprite_ColorMatrixTranslate
; ===========================================================================================================
Func _GEng_Sprite_ColorMatrixReset(ByRef $hSprite)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$hSprite[$_gSpr_ColorMatrix] = 0
	$hSprite[$_gSpr_ColorMatrix] = _GDIPlus_ColorMatrixCreate()
	$hSprite[$_gSpr_ColorMatrixPtr] = DllStructGetPtr($hSprite[$_gSpr_ColorMatrix])
	_GDIPlus_ImageAttributesSetColorMatrix($hSprite[$_gSpr_hImgAttrib], 0, True, $hSprite[$_gSpr_ColorMatrixPtr])
	; ---
	$hSprite[$_gSpr_UseColorMatrix] = 0 ; Libère des ressources
	; ---
	Return 1
EndFunc
