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


Func _GEng_ScrFlush($iBkColor = 0xFFFFFFFF)
	Return _GDIPlus_GraphicsClear($__GEng_hBuffer, $iBkColor)
EndFunc

Func _GEng_ScrUpdate()
	Return _GDIPlus_GraphicsDrawImage($__GEng_hGraphic, $__GEng_hBitmap, 0, 0)
EndFunc

Func _GEng_FPS_Start()
	$__GEng_FrameTimer = TimerInit()
EndFunc

Func _GEng_FPS_End()
	Local $t = TimerDiff($__GEng_FrameTimer)
	Return SetError(0, $t, 1000 / $t)	
EndFunc