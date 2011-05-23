#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.6.1
 Author:         Matwachich

 Script Function:


#ce ----------------------------------------------------------------------------

#Region ### Functions ###
#cs
- Main Functions
	_GEng_SpriteCreate($sName, $hImage = Default)
	_GEng_SpriteSetImage(ByRef $hSprite, ByRef $hImage, $x = Default, $y = Default, $w = Default, $h = Default)
	_GEng_SpriteSetImageRect(ByRef $hSprite, $x, $y, $w, $h, $InitSize = 1)
	_GEng_SpriteSetAnimation(ByRef $hSprite, $hAnimation)
	_GEng_SpriteSetCollision(ByRef $hSprite, $iType, $x = Default, $y = Default, $w = Default, $h = Default)
	_GEng_SpriteDraw(ByRef $hSprite, $iCalculateMovements = 1)
	_GEng_SpriteDel(ByRef $hSprite)
	__GEng_Sprite_IsSprite($hSprite)
	__GEng_Sprite_ContainsImage($hSprite)
	__GEng_Sprite_InitArray(ByRef $a, $sName = Default)
#ce
#EndRegion ###

Global $__GEng_Sprites[1] = [0]

Global Const $__GEng_SpritesArrayUB = 42
Global Enum $GEng_Origin_Mid, $GEng_Origin_TL, $GEng_Origin_TR, $GEng_Origin_BL, $GEng_Origin_BR

Func _GEng_Sprite_Create($sName, $hImage = Default)
	Local $hSprite[$__GEng_SpritesArrayUB]
	__GEng_Sprite_InitArray($hSprite, $sName)
	; ---
	If $hImage <> Default Then _GEng_Sprite_ImageSet($hSprite, $hImage)
	_GEng_SpriteAnimRewind($hSprite)
	; ---
	_ArrayAdd($__GEng_Sprites, $sName)
	$__GEng_Sprites[0] += 1
	; ---
	Return $hSprite
EndFunc

Func _GEng_Sprite_ImageSet(ByRef $hSprite, ByRef $hImage, $x = Default, $y = Default, $w = Default, $h = Default) ; If Default => 0,0,ImgW,ImgH
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	If Not __GEng_Image_IsImage($hImage) Then Return SetError(1, 0, 0)
	; ---
	$hSprite[0] = $hImage[0] ; Image Index
	; ---
	If $x <> Default And $y <> Default And $w <> Default And $h <> Default Then
		$hSprite[1] = $x
		$hSprite[2] = $y
		$hSprite[3] = $w
		$hSprite[4] = $h
	Else
		$hSprite[1] = 0
		$hSprite[2] = 0
		$hSprite[3] = $hImage[1]
		$hSprite[4] = $hImage[2]
	EndIf
	; Déjà fait dans _GEng_SpriteSetSize()
	;$hSprite[9] = $hSprite[3]
	;$hSprite[10] = $hSprite[4]
	; ---
	If $hSprite[9] = 0 And $hSprite[10] = 0 Then _ ; Si il n'y avait aucune image dans le sprite
		_GEng_Sprite_SizeSet($hSprite, -1, -1) ; on initialiser la taille (Size) aux dimensions de l'image
	; ---
	Return 1
EndFunc

Func _GEng_Sprite_ImageSetRect(ByRef $hSprite, $x, $y, $w, $h, $InitSize = 1)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$hSprite[1] = $x
	$hSprite[2] = $y
	$hSprite[3] = $w
	$hSprite[4] = $h
	; ---
	If $InitSize Then _
	_GEng_Sprite_SizeSet($hSprite, -1, -1) ; Pour initialiser la taille (Size) aux dimensions de l'image
	; ---
	Return 1
EndFunc

Func _GEng_Sprite_Draw(ByRef $hSprite, $iCalculateMovements = 1)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	If Not __GEng_Sprite_ContainsImage($hSprite) Then Return SetError(1, 0, 0)
	; ---
	If $iCalculateMovements Then _GEng_Sprite_Move($hSprite)
	; ---
	Local $hBuffer = $hSprite[6]
	Local $imgIndex = $hSprite[0]
	; ---
	Local $rotDeg = $hSprite[17]
	Local $rotRad = $hSprite[18]
	; ---
	Local $posX = $hSprite[7], $posY = $hSprite[8]
	Local $oriX = $hSprite[11], $oriY = $hSprite[12]
	Local $sizeW = $hSprite[9], $sizeH = $hSprite[10]
	; ---
	Local $sheetX = $hSprite[1], $sheetY = $hSprite[2]
	Local $sheetW = $hSprite[3], $sheetH = $hSprite[4]
	; ---
	Local $ret
	If $rotDeg = 0 Then ; Si pas de rotation => Dessine sur le buffer principal
		$ret = _GDIPlus_GraphicsDrawImageRectRect($__GEng_hBuffer, $__GEng_Images[$imgIndex], _
		$sheetX, $sheetY, $sheetW, $sheetH, _ ; region de l'image d'origin
		$posX - $oriX, $posY - $oriY, _ ; position à l'écran
		$sizeW, $sizeH) ; taille à l'écran
		
		If $__GEng_Debug Then
			_GDIPlus_GraphicsDrawRect($__GEng_hBuffer, $posX - $oriX, $posY - $oriY, $sizeW, $sizeH)
			_GDIPlus_GraphicsDrawEllipse($__GEng_hBuffer, $posX - $oriX - 2, $posY - $oriY - 2, 4, 4, $_dbg_pen1)
			_GDIPlus_GraphicsDrawEllipse($__GEng_hBuffer, $posX - 2, $posY - 2, 4, 4, $_dbg_pen3)
		EndIf
		
	Else ; Si rotation => Calcule la rotation et position et dessine sur le buffer personnel du sprite
		Local $matrix = _GDIPlus_MatrixCreate()
		_GDIPlus_MatrixRotate($matrix, $rotDeg)
		_GDIPlus_MatrixTranslate($matrix, $posX * Cos(-$rotRad) - $posY * Sin(-$rotRad), $posX * Sin(-$rotRad) + $posY * Cos(-$rotRad))
		_GDIPlus_GraphicsSetTransform($hBuffer, $matrix)
		; ---
		$ret = _GDIPlus_GraphicsDrawImageRectRect($hBuffer, $__GEng_Images[$imgIndex], _
		$sheetX, $sheetY, $sheetW, $sheetH, _
		-1 * $oriX, -1 * $oriY, _
		$sizeW, $sizeH)
		
		If $__GEng_Debug Then
			_GDIPlus_GraphicsDrawLine($hBuffer, 0, 0, 0, 40, $_dbg_pen2)
				_GDIPlus_GraphicsDrawString($hBuffer, "Y", -6, 45)
			_GDIPlus_GraphicsDrawLine($hBuffer, 0, 0, 40, 0, $_dbg_pen2)
				_GDIPlus_GraphicsDrawString($hBuffer, "X", 45, -6)
			_GDIPlus_GraphicsDrawString($hBuffer, $rotDeg & " °", (-1 * $oriX), (-1 * $oriY) - 15)
			_GDIPlus_GraphicsDrawRect($hBuffer, -1 * $oriX, -1 * $oriY, $sizeW, $sizeH)
			_GDIPlus_GraphicsDrawEllipse($hBuffer, (-1 * $oriX) - 2, (-1 * $oriY) - 2, 4, 4, $_dbg_pen1)
			_GDIPlus_GraphicsDrawEllipse($hBuffer, -2, -2, 4, 4, $_dbg_pen3)
		EndIf
		
		; ---
		_GDIPlus_MatrixDispose($matrix)
	EndIf
	
	; ---
	Return $ret
EndFunc

Func _GEng_Sprite_Del(ByRef $hSprite)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	If $hSprite[5] <> "" Then
		Local $i = __GEng_SpriteArraySearch($hSprite[5])
		If $i Then
			_ArrayDelete($__GEng_Sprites, $i)
			$__GEng_Sprites[0] -= 1
		EndIf
	EndIf
	; ---
	$hSprite = 0
	; ---
	Return 1
EndFunc

; ==============================================================
; ### Internals
; ==============================================================
Func __GEng_Sprite_IsSprite($hSprite)
	If Not IsArray($hSprite) Then Return SetError(1, 0, 0)
	If UBound($hSprite) <> $__GEng_SpritesArrayUB Then Return SetError(1, 0, 0)
	; ---
	Return 1
EndFunc

Func __GEng_Sprite_ContainsImage($hSprite)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	If $hSprite[0] = 0 Then Return SetError(1, 0, 0)
	; ---
	Return 1
EndFunc

Func __GEng_SpriteArraySearch($sName)
	For $i = $__GEng_Sprites[0] To 1 Step -1
		If $__GEng_Sprites[$i] = $sName Then Return $i
	Next
	; ---
	Return 0
EndFunc

Func __GEng_Sprite_InitArray(ByRef $a, $sName = Default)
	For $i = 0 To $__GEng_SpritesArrayUB - 1
		$a[$i] = 0
	Next
	;$a[0] = Image Index
	;$a[1] = Img X
	;$a[2] = Img Y
	;$a[3] = Img W
	;$a[4] = Img H
	;-------------
	;- $a[5] = Name
	;$a[6] = hBuffer
	;-------------
	;$a[7] = PosX
	;$a[8] = PosY
	;$a[9] = Width
	;$a[10] = Height
	;$a[11] = OriginX
	;$a[12] = OriginY
	;-------------
	;$a[13] = VitX
	;$a[14] = VitY
	;$a[15] = AccelX
	;$a[16] = AccelY
	;-------------
	;$a[17] = AngleDeg
	;$a[18] = AngleRad
	;$a[19] = VitRot
	;-------------
	;$a[20] = hAnimation
	;$a[21] = CurrFrame
	;$a[22] = AnimDelay
	;-------------
	;$a[23] = CollisionRectX
	;$a[24] = CollisionRectY
	;$a[25] = CollisionRectW
	;$a[26] = CollisionRectH
	;------------- doivent être calculés en valeurs absolues
	;$a[27] = VitX_Max
	;- $a[28] = VitY_Max
	;$a[29] = AccelX_Max
	;- $a[30] = AccelY_Max
	;-------------
	;$a[31] = InnertieX ; Valeur soustraite à la vitesse chaque seconde
	;- $a[32] = InnertieY ; Idem
	;-------------
	;$a[33] = MoveTimer
	;-------------
	;$a[34] = VitRotMax
	;$a[35] = AccelRot
	;- $a[36] = AccelRotMax
	;$a[37] = InnerRot
	;-------------
	;$a[38] = Collision Type (1 - Carré, 2 - Ellipse)
	;-------------
	;$a[39] = AngleOrigin Deg
	;$a[40] = AngleOrigin Rad
	;; ---
	If $sName <> Default Then $a[5] = $sName
	$a[22] = 1 ; AnimDelay Multiplier
	$a[6] = __GEng_GetBuffer()
EndFunc
