#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.6.1
 Author:         Matwachich

 Script Function:


#ce ----------------------------------------------------------------------------

#Region ### Functions ###
#cs
- Main Functions
	_GEng_ScrFlush($iBkColor = 0xFFFFFFFF)
	_GEng_ScrUpdate()
	_GEng_FPS_Get($iDelay = 1000)
#ce
#EndRegion ###


; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_ScrFlush
; Description....:	Permet d'éffacer l'écran, en lui donnant une couleur
; Parameters.....:	$iBkColor = Couleur avec la quelle remplire l'écran (Defaut = Blanc)
; Return values..:	Succes - 1
;					Echec - 0
; Author.........:	Matwachich
; Remarks........:	Inutile et couteux en ressource si vous avez un sprite qui fait office de background
; ===========================================================================================================
Func _GEng_ScrFlush($iBkColor = 0xFFFFFFFF)
	Return _GDIPlus_GraphicsClear($__GEng_hBuffer, $iBkColor)
EndFunc

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_ScrUpdate
; Description....:	Valider les opération de déssin (copie le hBitmap dans le hGraphic)
; Parameters.....:	
; Return values..:	Succes - 1
;					Echec - 0
; Author.........:	Matwachich
; Remarks........:	Inspiré par "Sinus Scroller By UEZ"
; ===========================================================================================================
Func _GEng_ScrUpdate()
	;Return _GDIPlus_GraphicsDrawImage($__GEng_hGraphic, $__GEng_hBitmap, 0, 0)
	; --- Fait gagner env. 2ms!
	Local $gdibitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($__GEng_hBitmap)
	_WinAPI_SelectObject($__GEng_hCompatibleDC, $gdibitmap)
	_WinAPI_DeleteObject($gdibitmap)
	Return _WinAPI_BitBlt($__GEng_hDC, 0, 0, $__GEng_WinW, $__GEng_WinH, $__GEng_hCompatibleDC, 0, 0, 0x00CC0020) ; 0x00CC0020 = $SRCCOPY
EndFunc

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_FPS_Get
; Description....:	
; Parameters.....:	
; Return values..:	la valeur du FPS - @extended = temps de génération de la frame passé (ms)
; Author.........:	Matwachich
; Remarks........:	
; ===========================================================================================================
Func _GEng_FPS_Get($iDelay = 1000)
	Local $t, $ret, $err, $ext
	If TimerDiff($__GEng_FPSDisplayTimer) >= $iDelay Or $__GEng_FPSDisplayTimer = 0 Then
		$t = TimerDiff($__GEng_FPSTimer)
		$__GEng_FPSDisplayTimer = TimerInit()
		; ---
		$ret = 1000 / $t
		$ext = $t
		$err = 0
	Else
		$ret = -1
		$err = 1
		$ext = 0
	EndIf
	; ---
	$__GEng_FPSTimer = TimerInit()
	Return SetError($err, $ext, $ret)
EndFunc

