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
	_GEng_FPS_Start()
	_GEng_FPS_End()
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
	_WinAPI_SelectObject($__GEng_CompatibleDC, $gdibitmap)
	_WinAPI_DeleteObject($gdibitmap)
	Return _WinAPI_BitBlt($__GEng_ScreenDC, 0, 0, $__GEng_WinW, $__GEng_WinH, $__GEng_CompatibleDC, 0, 0, 0x00CC0020) ; 0x00CC0020 = $SRCCOPY
EndFunc

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_FPS_Start
; Description....:	Démare un timer pour le calcule de FPS
; Parameters.....:	
; Return values..:	1
; Author.........:	Matwachich
; Remarks........:	A appeler au début de la boucle principale, avant les opérations de déssin
; ===========================================================================================================
Func _GEng_FPS_Start()
	$__GEng_FrameTimer = TimerInit()
	Return 1
EndFunc

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_FPS_End
; Description....:	
; Parameters.....:	
; Return values..:	la valeur du FPS - @extended = temps de génération de la frame passé (ms)
; Author.........:	Matwachich
; Remarks........:	A appeler à la fin des opération de déssin, c'est à dire, juste après _GEng_ScrUpdate
; ===========================================================================================================
Func _GEng_FPS_End()
	Local $t = TimerDiff($__GEng_FrameTimer)
	Return SetError(0, $t, 1000 / $t)	
EndFunc