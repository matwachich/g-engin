#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.6.1
 Author:         Matwachich

 Script Function:


#ce ----------------------------------------------------------------------------
#Include <Memory.au3>

#Region ### Functions ###
#cs
- Main Functions
	_GEng_ImageLoad($sPath, $imgW = Default, $imgH = Default, $x = Default, $y = Default, $w = Default, $h = Default)
	_GEng_ImageLoadStream($pic, $imgW = Default, $imgH = Default, $x = Default, $y = Default, $w = Default, $h = Default)
	__GEng_Image_IsImage($hImage)
	__GEng_Image_hImg($hImage)
	__GEng_Image_DisposeAll()
	_WinAPI_CreateStreamOnHGlobal($hGlobal = 0, $fDeleteOnRelease = True)
	_GDIPlus_BitmapCreateFromStream($pStream)
	__GDIPlus_ImageGetThumbnail($hImg, $iW, $iH)
	__GEng_ImageLoadDo($hImg, $imgW = Default, $imgH = Default, $x = Default, $y = Default, $w = Default, $h = Default)
#ce
#EndRegion ###

Global $__GEng_Images[1] = [0]

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_ImageLoad
; Description....:	Charge un fichier image pour être utiliser par GEngin
; Parameters.....:	$sPath
;					- Optionels
;					$width, $height = Taille de l'image (non spécifié => Taille du fichier)
;					- Optionels: prendre une partie de l'objet Image (idéal pour les SpriteSheets)
;						Doivent TOUS être spécifiés pour être pris en concidération
;					$x, $y = coordonnées du point supérieur gauche du rectangle à prendre
;					$w, $h = largeur et hauteur du rectangle à prendre
; Return values..:	Succes - Objet Image
;					Echec - 0 et @error = 1
; Author.........:	Matwachich
; Remarks........:	
; ===========================================================================================================
Func _GEng_ImageLoad($sPath, $imgW = Default, $imgH = Default, $x = Default, $y = Default, $w = Default, $h = Default)
	Local $hImg = _GDIPlus_ImageLoadFromFile($sPath)
	If $hImg = -1 Then Return SetError(1, 0, 0)
	; ---
	Return __GEng_ImageLoadDo($hImg, $imgW, $imgH, $x, $y, $w, $h)
EndFunc

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_ImageLoadStream
; Description....:	
; Parameters.....:	
; Return values..:	
; Author.........:	UEZ, ProgAndy
; Remarks........:	
; ===========================================================================================================
Func _GEng_ImageLoadStream($pic, $imgW = Default, $imgH = Default, $x = Default, $y = Default, $w = Default, $h = Default)
	;thanks to ProgAndy for mem allocation lines
	Local $memBitmap, $len, $tMem, $hImage, $hData, $pData, $hStream, $hBitmapFromStream
	$memBitmap = Binary($pic) ;load image  saved in variable (memory) and convert it to binary
    $len =  BinaryLen($memBitmap) ;get length of image

    $hData  = _MemGlobalAlloc($len, 0x0002) ;allocates movable memory  ($GMEM_MOVEABLE = 0x0002)
    $pData = _MemGlobalLock($hData)  ;translate the handle into a pointer
    $tMem =  DllStructCreate("byte[" & $len & "]", $pData) ;create struct
     DllStructSetData($tMem, 1, $memBitmap) ;fill struct with image data
    _MemGlobalUnlock($hData) ;decrements the lock count associated with a memory object that was allocated with GMEM_MOVEABLE

	$hStream = _WinAPI_CreateStreamOnHGlobal($pData) ;Creates a stream object that uses an HGLOBAL memory handle to store the stream contents
	$hBitmapFromStream = _GDIPlus_BitmapCreateFromStream($hStream) ;Creates a Bitmap object based on an IStream COM interface
	$tMem = ""
	Return __GEng_ImageLoadDo($hBitmapFromStream, $imgW, $imgH, $x, $y, $w, $h)
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

Func _WinAPI_CreateStreamOnHGlobal($hGlobal = 0, $fDeleteOnRelease = True)
	Local $aResult = DllCall("ole32.dll", "int", "CreateStreamOnHGlobal", "hwnd", $hGlobal, "int", $fDeleteOnRelease, "ptr*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return $aResult[3]
EndFunc   ;==>_WinAPI_CreateStreamOnHGlobal

Func _GDIPlus_BitmapCreateFromStream($pStream)
	Local $aResult = DllCall($ghGDIPDll, "uint", "GdipCreateBitmapFromStream", "ptr", $pStream, "int*", 0)
	If @error Then Return SetError(@error, @extended, 0)
	Return $aResult[2]
EndFunc   ;==>_GDIPlus_BitmapCreateFromStream

Func __GDIPlus_ImageGetThumbnail($hImg, $iW, $iH)
	Local $ret = DllCall($ghGDIPDll, "int", "GdipGetImageThumbnail", _
                                        "hwnd", $hImg, _
                                        "int", $iW, _
                                        "int", $iH, _
                                        "int*", 0, _
                                        "ptr", 0, _
                                        "ptr", 0)
	If @error Then
		Return SetError(1, 0, 0)
	EndIf
	; ---
	Return SetError(0, 0, $ret[4])
EndFunc

Func __GEng_ImageLoadDo($hImg, $imgW = Default, $imgH = Default, $x = Default, $y = Default, $w = Default, $h = Default)
	Local $width, $height
	If $x <> Default And $y <> Default And $w <> Default And $h <> Default Then
		$width = $w
		$height = $h
	Else
		$x = 0
		$y = 0
		$width = _GDIPlus_ImageGetWidth($hImg)
		$height = _GDIPlus_ImageGetHeight($hImg)
		$w = $width
		$h = $height
	EndIf
	; ---
	Local $gContext, $newBmp, $gNewContext
	$gContext = _GDIPlus_ImageGetGraphicsContext($hImg)
	$newBmp = _GDIPlus_BitmapCreateFromGraphics($width, $height, $gContext)
	$gNewContext = _GDIPlus_ImageGetGraphicsContext($newBmp)
	_GDIPlus_GraphicsDrawImageRectRect($gNewContext, $hImg, $x, $y, $w, $h, 0, 0, $width, $height)
	; ---
	_GDIPlus_GraphicsDispose($gNewContext)
	_GDIPlus_GraphicsDispose($gContext)
	_GDIPlus_ImageDispose($hImg)
	; ---
	If $imgW <> Default And $imgH <> Default Then
		$hImg = __GDIPlus_ImageGetThumbnail($newBmp, $imgW, $imgH)
		_ArrayAdd($__GEng_Images, $hImg)
		_GDIPlus_BitmapDispose($newBmp)
		$width = $imgW
		$height = $imgH
	Else
		_ArrayAdd($__GEng_Images, $newBmp)
	EndIf
	; ---
	$__GEng_Images[0] += 1
	; ---
	Local $ret[3]
	$ret[0] = $__GEng_Images[0]
	$ret[1] = $width
	$ret[2] = $height
	; ---
	Return $ret
EndFunc