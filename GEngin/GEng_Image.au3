#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.6.1
 Author:         Matwachich

 Script Function:


#ce ----------------------------------------------------------------------------
#include <Array.au3>

Global $__GEng_Images[1] = [0]

Func _GEng_ImageLoad($sPath, $x = Default, $y = Default, $w = Default, $h = Default)
	Local $gContext, $newBmp, $gNewContext, $imgW, $imgH
	Local $hImg = _GDIPlus_ImageLoadFromFile($sPath)
	If $hImg = -1 Then Return SetError(1, 0, 0)
	; ---
	If $x <> Default And $y <> Default And $w <> Default And $h <> Default Then ; Prendre une partie de l'image
		$gContext = _GDIPlus_ImageGetGraphicsContext($hImg)
		$newBmp = _GDIPlus_BitmapCreateFromGraphics($w, $h, $gContext)
		$gNewContext = _GDIPlus_ImageGetGraphicsContext($newBmp)
		_GDIPlus_GraphicsDrawImageRectRect($gNewContext, $hImg, $x, $y, $w, $h, 0, 0, $w, $h)
		; ---
		_GDIPlus_GraphicsDispose($gNewContext)
		_GDIPlus_GraphicsDispose($gContext)
		_GDIPlus_ImageDispose($hImg)
		; ---
		_ArrayAdd($__GEng_Images, $newBmp)
		$imgW = _GDIPlus_ImageGetWidth($newBmp)
		$imgH = _GDIPlus_ImageGetHeight($newBmp)
	Else
		_ArrayAdd($__GEng_Images, $hImg)
		$imgW = _GDIPlus_ImageGetWidth($hImg)
		$imgH = _GDIPlus_ImageGetHeight($hImg)
	EndIf
	; ---
	$__GEng_Images[0] += 1
	; ---
	Local $ret[3]
	$ret[0] = $__GEng_Images[0]
	$ret[1] = $imgW
	$ret[2] = $imgH
	; ---
	Return $ret
EndFunc

; ==============================================================
; ### Internals
; ==============================================================
Func __GEng_Image_IsImage($hImage)
	If Not IsArray($hImage) Then Return SetError(1, 0, 0)
	If UBound($hImage) <> 3 Then Return SetError(1, 0, 0)
	If $hImage[0] > $__GEng_Images[0] Then Return SetError(1, 0, 0)
	If $hImage[1] = -1 Or $hImage[2] = -1 Then Return SetError(1, 0, 0)
	; ---
	Return 1
EndFunc

Func __GEng_Image_hImg($hImage)
	If Not __GEng_Image_IsImage($hImage) Then Return SetError(1, 0, 0)
	; ---
	Return $__GEng_Images[$hImage[0]]
EndFunc

Func __GEng_Image_DisposeAll()
	For $i = 1 To $__GEng_Images[0]
		_GDIPlus_ImageDispose($__GEng_Images[$i])
		_GDIPlus_BitmapDispose($__GEng_Images[$i])
	Next
EndFunc
