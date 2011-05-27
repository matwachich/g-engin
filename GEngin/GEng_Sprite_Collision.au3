#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.6.1
 Author:         Matwachich

 Script Function:
	GEngin - Sprite collision

#ce ----------------------------------------------------------------------------

#Region ### Functions ###
#cs
- Main Functions
	_GEng_Sprite_CollisionSet(ByRef $hSprite, $iType, $x = Default, $y = Default, $w = Default, $h = Default)
	_GEng_Sprite_Collision($hSprite1, $hSprite2)
	__GEng_CircleVsCircle($c1X, $c1Y, $c1R, $c2X, $c2Y, $c2R)
	__GEng_Dbg_DrawCircleCircle($iDebugPen, $c1X, $c1Y, $c1R, $c2X, $c2Y, $c2R)
	__GEng_CircleVsRect($cX, $cY, $cR, $rX, $rY, $rW, $rH)
	__GEng_Dbg_DrawRectCercle($iDebugPen, $cX, $cY, $cR, $rX, $rY, $rW, $rH)
	__GEng_RectVsRect($x1, $y1, $w1, $h1, $x2, $y2, $w2, $h2)
	__GEng_Dbg_DrawRectRect($iDebugPen, $x1, $y1, $w1, $h1, $x2, $y2, $w2, $h2)
#ce
#EndRegion ###


; pour les tests de collision avec les bord de la fenètre
Global Enum $GEng_ScrBorder_Top, $GEng_ScrBorder_Bot, $GEng_ScrBorder_Left, $GEng_ScrBorder_Right

; $iType: 0 - point, 1 - Carré, 2 - Ellipse
Func _GEng_Sprite_CollisionSet(ByRef $hSprite, $iType, $x = Default, $y = Default, $w = Default, $h = Default)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	$hSprite[$_gSpr_CollType] = $iType ; Collision Type
	; ---
	; Point
	If $iType = 0 Then
		If $x = Default Then
			$hSprite[$_gSpr_CollX] = $hSprite[$_gSpr_OriX]
		Else
			$hSprite[$_gSpr_CollX] = $x
		EndIf
		; ---
		If $y = Default Then
			$hSprite[$_gSpr_CollY] = $hSprite[$_gSpr_OriY]
		Else
			$hSprite[$_gSpr_CollY] = $y
		EndIf
		; ---
		$hSprite[$_gSpr_CollW] = 1
		$hSprite[$_gSpr_CollH] = 1
		; ---
		Return 1
	EndIf
	; ---
	; Carré
	If $iType = 1 Then
		If $x <> Default And $y <> Default And $w <> Default And $h <> Default Then
			$hSprite[$_gSpr_CollX] = $x
			$hSprite[$_gSpr_CollY] = $y
			$hSprite[$_gSpr_CollW] = $w
			$hSprite[$_gSpr_CollH] = $h
		Else
			$hSprite[$_gSpr_CollX] = 0
			$hSprite[$_gSpr_CollY] = 0
			$hSprite[$_gSpr_CollW] = $hSprite[9]
			$hSprite[$_gSpr_CollH] = $hSprite[10]
		EndIf
		; ---
		Return 1
	EndIf
	; ---
	; Cercle
	If $iType = 2 Then
		If $x <> Default And $y <> Default And $w <> Default Then
			$hSprite[$_gSpr_CollX] = $x ; centre X
			$hSprite[$_gSpr_CollY] = $y ; centre Y
			$hSprite[$_gSpr_CollW] = $w ; 1/2 R
			$hSprite[$_gSpr_CollH] = 0
		Else
			$hSprite[$_gSpr_CollX] = $hSprite[$_gSpr_OriX] ; originX
			$hSprite[$_gSpr_CollY] = $hSprite[$_gSpr_OriY] ; originY
			$hSprite[$_gSpr_CollW] = ($hSprite[$_gSpr_Width] + $hSprite[$_gSpr_Height]) / 4  ; sprite size (1/2 moyenne)
			$hSprite[$_gSpr_CollH] = 0
		EndIf
		; ---
		Return 1
	EndIf
	; ---
	Return SetError(1, 0, 0)
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
Func _GEng_Sprite_Collision($hSprite1, $hSprite2)
	If Not __GEng_Sprite_IsSprite($hSprite1) Then Return SetError(1, 0, 0)
	
	; ---
	Local $x1, $y1, $w1, $h1, $type1
	Local $x2, $y2, $w2, $h2, $type2
	
	Switch $hSprite1[$_gSpr_CollType]
		Case 0 ; point
			$x1 = $hSprite1[$_gSpr_PosX] - $hSprite1[$_gSpr_OriX] + $hSprite1[$_gSpr_CollX]
			$y1 = $hSprite1[$_gSpr_PosY] - $hSprite1[$_gSpr_OriY] + $hSprite1[$_gSpr_CollY]
			$w1 = 1
			$h1 = 1
		Case 1 ; rect
			$x1 = $hSprite1[$_gSpr_PosX] - $hSprite1[$_gSpr_OriX] + $hSprite1[$_gSpr_CollX]
			$y1 = $hSprite1[$_gSpr_PosY] - $hSprite1[$_gSpr_OriY] + $hSprite1[$_gSpr_CollY]
			$w1 = $hSprite1[$_gSpr_CollW]
			$h1 = $hSprite1[$_gSpr_CollH]
		Case 2 ; cercle
			$x1 = $hSprite1[$_gSpr_PosX] - $hSprite1[$_gSpr_OriX] + $hSprite1[$_gSpr_CollX]
			$y1 = $hSprite1[$_gSpr_PosY] - $hSprite1[$_gSpr_OriY] + $hSprite1[$_gSpr_CollY]
			$w1 = $hSprite1[$_gSpr_CollW]
			$h1 = 0
	EndSwitch
	$type1 = $hSprite1[$_gSpr_CollType]
	
	; ---
	Switch $hSprite2
		Case $GEng_ScrBorder_Top
			$x2 = 0
			$y2 = -100
			$w2 = $__GEng_WinW
			$h2 = 101
			$type2 = 1 ; Car les bords de l'écran sont assimilés à un carré
		Case $GEng_ScrBorder_Bot
			$x2 = 0
			$y2 = $__GEng_WinH - 1
			$w2 = $__GEng_WinW
			$h2 = 101
			$type2 = 1 ; Car les bords de l'écran sont assimilés à un carré
		Case $GEng_ScrBorder_Left
			$x2 = -100
			$y2 = 0
			$w2 = 101
			$h2 = $__GEng_WinH
			$type2 = 1 ; Car les bords de l'écran sont assimilés à un carré
		Case $GEng_ScrBorder_Right
			$x2 = $__GEng_WinW - 1
			$y2 = 0
			$w2 = 101
			$h2 = $__GEng_WinH
			$type2 = 1 ; Car les bords de l'écran sont assimilés à un carré
		Case Else
			If Not __GEng_Sprite_IsSprite($hSprite2) Then Return SetError(1, 0, 0)
			; ---
			Switch $hSprite2[$_gSpr_CollType]
				Case 0 ; point
					$x2 = $hSprite2[$_gSpr_PosX] - $hSprite2[$_gSpr_OriX] + $hSprite2[$_gSpr_CollX]
					$y2 = $hSprite2[$_gSpr_PosY] - $hSprite2[$_gSpr_OriY] + $hSprite2[$_gSpr_CollY]
					$w2 = 1
					$h2 = 1
				Case 1 ; rect
					$x2 = $hSprite2[$_gSpr_PosX] - $hSprite2[$_gSpr_OriX] + $hSprite2[$_gSpr_CollX]
					$y2 = $hSprite2[$_gSpr_PosY] - $hSprite2[$_gSpr_OriY] + $hSprite2[$_gSpr_CollY]
					$w2 = $hSprite2[$_gSpr_CollW]
					$h2 = $hSprite2[$_gSpr_CollH]
				Case 2 ; cercle
					$x2 = $hSprite2[$_gSpr_PosX] - $hSprite2[$_gSpr_OriX] + $hSprite2[$_gSpr_CollX]
					$y2 = $hSprite2[$_gSpr_PosY] - $hSprite2[$_gSpr_OriY] + $hSprite2[$_gSpr_CollY]
					$w2 = $hSprite2[$_gSpr_CollW]
					$h2 = 0
			EndSwitch
			$type2 = $hSprite2[$_gSpr_CollType]
	EndSwitch
	; ---
	
	; SI: les 2 sont des cercles
	If $type1 = 2 And $type2 = 2 Then
		Return __GEng_CircleVsCircle($x1, $y1, $w1, _
									$x2, $y2, $w2)
	EndIf
	; ---
	
	; SI: il y à un cercle
	If $type1 = 2 Then
		Return __GEng_CircleVsRect($x1, $y1, $w1, _
									$x2, $y2, $w2, $h2)
	EndIf
	If $type2 = 2 Then
		Return __GEng_CircleVsRect($x2, $y2, $w2, _
									$x1, $y1, $w1, $h1)
	EndIf
	; ---
	
	; SI: les 2 sont des rectangles OU des points
	Return __GEng_RectVsRect($x1, $y1, $w1, $h1, _
							$x2, $y2, $w2, $h2)
EndFunc

; ==============================================================
; ### Internals
; ==============================================================
Func __GEng_CircleVsCircle($c1X, $c1Y, $c1R, $c2X, $c2Y, $c2R)
	Local $cDist = Sqrt(($c2X - $c1X)^2 + ($c2Y - $c1Y)^2)
	; ---
	If $cDist <= $c1R + $c2R Then
		__GEng_Dbg_DrawCircleCircle(1, $c1X, $c1Y, $c1R, $c2X, $c2Y, $c2R)
		Return 1
	EndIf
	; ---
	Return 0
EndFunc

Func __GEng_Dbg_DrawCircleCircle($iDebugPen, $c1X, $c1Y, $c1R, $c2X, $c2Y, $c2R)
	If $__GEng_Debug Then
		_GEng_Debug_DrawCircle($iDebugPen, $c1X, $c1Y, $c1R)
		_GEng_Debug_DrawCircle($iDebugPen, $c2X, $c2Y, $c2R)
		; ---
		Sleep(50)
	EndIf
EndFunc

; Thanks: http://stackoverflow.com/questions/401847/circle-rectangle-collision-detection-intersection/3491126#3491126
Func __GEng_CircleVsRect($cX, $cY, $cR, $rX, $rY, $rW, $rH)
	Local $rcX, $rcY
	$rcX = $rX + ($rW / 2)
	$rcY = $rY + ($rH / 2)
	; ---
	Local $w = $rW / 2, $h = $rH / 2
	Local $dx = Abs($rcX - $cX)
	Local $dy = Abs($rcY - $cY)
	; ---
	If ($dx > ($cR + $w)) Or ($dy > ($cR + $h)) Then Return 0
	; ---
	Local $cDistX, $cDistY
	$cDistX = Abs($cX - $rX - $w)
	$cDistY = Abs($cY - $rY - $h)
	; ---
	If ($cDistX <= $w) Or ($cDistY <= $h) Then
		__GEng_Dbg_DrawRectCercle(1, $cX, $cY, $cR, $rX, $rY, $rW, $rH)
		Return 1
	EndIf
	; ---
	Local $cornerDistSq = (($cDistX - $w)^2) + (($cDistY - $h)^2)
	; ---
	If ($cornerDistSq <= ($cR^2)) Then
		__GEng_Dbg_DrawRectCercle(1, $cX, $cY, $cR, $rX, $rY, $rW, $rH)
		Return 1
	Else
		Return 0
	EndIf
EndFunc

Func __GEng_Dbg_DrawRectCercle($iDebugPen, $cX, $cY, $cR, $rX, $rY, $rW, $rH)
	If $__GEng_Debug Then
		_GEng_Debug_DrawCircle($iDebugPen, $cX, $cY, $cR)
		_GEng_Debug_DrawRect($iDebugPen, $rX, $rY, $rW, $rH)
		; ---
		Sleep(50)
	EndIf
EndFunc

Func __GEng_RectVsRect($x1, $y1, $w1, $h1, $x2, $y2, $w2, $h2)
	Local $center1X, $center1Y, $center2X, $center2Y
	$center1X = $x1 + ($w1 / 2)
	$center1Y = $y1 + ($h1 / 2)
	$center2X = $x2 + ($w2 / 2)
	$center2Y = $y2 + ($h2 / 2)
	; ---
	Local $halfW1, $halfH1, $halfW2, $halfH2
	$halfW1 = $w1 / 2
	$halfH1 = $h1 / 2
	$halfW2 = $w2 / 2
	$halfH2 = $h2 / 2
	; ---
	Local $distX, $distY
	$distX = Abs($center1X - $center2X)
	$distY = Abs($center1Y - $center2Y)
	; ---
	If $distX <= $halfW1 + $halfW2 And $distY <= $halfH1 + $halfH2 Then
		__GEng_Dbg_DrawRectRect(1, $x1, $y1, $w1, $h1, $x2, $y2, $w2, $h2)
		Return 1
	EndIf
	; ---
	Return 0
EndFunc

Func __GEng_Dbg_DrawRectRect($iDebugPen, $x1, $y1, $w1, $h1, $x2, $y2, $w2, $h2)
	If $__GEng_Debug Then
		_GEng_Debug_DrawRect($iDebugPen, $x1, $y1, $w1, $h1)
		_GEng_Debug_DrawRect($iDebugPen, $x2, $y2, $w2, $h2)
		Sleep(50)
	EndIf
EndFunc


#cs
http://stackoverflow.com/questions/401847/circle-rectangle-collision-detection-intersection/3491126#3491126

 var rectangleCenter = new PointF((rectangle.X +  rectangle.Width / 2),
                                         (rectangle.Y + rectangle.Height / 2));

        var w = rectangle.Width  / 2;
        var h = rectangle.Height / 2;

        var dx = Math.Abs(circle.X - rectangleCenter.X);
        var dy = Math.Abs(circle.Y - rectangleCenter.Y);

        if (dx > (radius + w) || dy > (radius + h)) return false;


        var circleDistance = new PointF
                                 {
                                     X = Math.Abs(circle.X - rectangle.X - w),
                                     Y = Math.Abs(circle.Y - rectangle.Y - h)
                                 };


        if (circleDistance.X <= (w))
        {
            return true;
        }

        if (circleDistance.Y <= (h))
        {
            return true;
        }

        var cornerDistanceSq = Math.Pow(circleDistance.X - w, 2) + 
                    Math.Pow(circleDistance.Y - h, 2);

        return (cornerDistanceSq <= (Math.Pow(radius, 2)));
    }
#ce
