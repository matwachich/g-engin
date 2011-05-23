#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.6.1
 Author:         Matwachich

 Script Function:
	GEngin - Sprite collision

#ce ----------------------------------------------------------------------------

; pour les tests de collision avec les bord de la fenètre
Global Enum $GEng_ScrBorder_Top, $GEng_ScrBorder_Bot, $GEng_ScrBorder_Left, $GEng_ScrBorder_Right

; $iType: 0 - point, 1 - Carré, 2 - Ellipse
Func _GEng_SpriteSetCollision(ByRef $hSprite, $iType, $x = Default, $y = Default, $w = Default, $h = Default)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	If $iType <> 1 And $iType <> 2 Then Return SetError(1, 0, 0)
	; ---
	If $x <> Default And $y <> Default And $w <> Default And $h <> Default Then
		$hSprite[23] = $x
		$hSprite[24] = $y
		$hSprite[25] = $w
		$hSprite[26] = $h
	Else
		$hSprite[23] = 0
		$hSprite[24] = 0
		$hSprite[25] = $hSprite[9]
		$hSprite[26] = $hSprite[10]
	EndIf
	$hSprite[38] = $iType ; Collision Type
	; ---
	Return 1
EndFunc


; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_SpriteCollision
; Description....:	Test si il y a collision entre les 2 sprites en paramètres
; Parameters.....:	$hSprite1, $hSprite2 = Les sprites à tester
; Return values..:	1 - Collision
;					0 - Pas de collision
;					Si @error = 1 - Un des 2 paramètres n'est pas un sprite valide
; Author.........:	Matwachich
; Remarks........:	Collision carré
; ===========================================================================================================
Func _GEng_SpriteCollision($hSprite1, $hSprite2)
	If Not __GEng_Sprite_IsSprite($hSprite1) Then Return SetError(1, 0, 0)
	
	; ---
	Local $pos1[2] = [$hSprite1[23] + $hSprite1[7] - $hSprite1[11], $hSprite1[24] + $hSprite1[8] - $hSprite1[12]]
	Local $size1[2] = [$hSprite1[25], $hSprite1[26]]
	
	; ---
	Switch $hSprite2
		Case $GEng_ScrBorder_Top
			Local $pos2[2] = [0	,	-100]
			Local $size2[2] = [$__GEng_WinW	,	101]
		Case $GEng_ScrBorder_Bot
			Local $pos2[2] = [0	,	$__GEng_WinH - 1]
			Local $size2[2] = [$__GEng_WinW	,	101]
		Case $GEng_ScrBorder_Left
			Local $pos2[2] = [-100	,	0]
			Local $size2[2] = [101	,	$__GEng_WinH]
		Case $GEng_ScrBorder_Right
			Local $pos2[2] = [$__GEng_WinW - 1	,	0]
			Local $size2[2] = [101	,	$__GEng_WinH]
		Case Else
			If Not __GEng_Sprite_IsSprite($hSprite2) Then Return SetError(1, 0, 0)
			Local $pos2[2] = [$hSprite2[23] + $hSprite2[7] - $hSprite2[11], $hSprite2[24] + $hSprite2[8] - $hSprite2[12]]
			Local $size2[2] = [$hSprite2[25],$hSprite2[26]]
	EndSwitch
	; ---
	Local $collision = 0
	; --- Test du point inférieur droit de spr1 OK
	If ($pos1[0] + $size1[0]) > $pos2[0] And ($pos1[0] + $size1[0]) < ($pos2[0] + $size2[0]) And _
	   ($pos1[1] + $size1[1]) > $pos2[1] And ($pos1[1] + $size1[1]) < ($pos2[1] + $size2[1]) Then
		; ---
		$collision = 1
	EndIf
	; --- Test du point supérieur gauche de spr1 OK
	If $pos1[0] > $pos2[0] And $pos1[0] < ($pos2[0] + $size2[0]) And _
	   $pos1[1] > $pos2[1] And $pos1[1] < ($pos2[1] + $size2[1]) Then
		; ---
		$collision = 1
	EndIf
	; --- Test du point inférieur gauche de spr1 OK
	If $pos1[0] > $pos2[0] And $pos1[0] < ($pos2[0] + $size2[0]) And _
	   ($pos1[1] + $size1[1]) > $pos2[1] And ($pos1[1] + $size1[1]) < ($pos2[1] + $size2[1]) Then
		; ---
		$collision = 1
	EndIf
	; --- Test du point supérieur droit de spr 1
	If ($pos1[0] + $size1[0]) > $pos2[0] And ($pos1[0] + $size1[0]) < ($pos2[0] + $size2[0]) And _
	    $pos1[1] > $pos2[1] And $pos1[1] < ($pos2[1] + $size2[1]) Then
		; ---
		$collision = 1
	EndIf
	; --- DEBUG
	If $collision Then
		If $__GEng_Debug Then
			_GDIPlus_GraphicsDrawRect($__GEng_hGraphic, $pos1[0], $pos1[1], $size1[0], $size1[1], $_dbg_pen1)
			_GDIPlus_GraphicsDrawRect($__GEng_hGraphic, $pos2[0], $pos2[1], $size2[0], $size2[1], $_dbg_pen2)
			Sleep(50)
		EndIf
	EndIf
	; ---
	Return $collision
EndFunc

