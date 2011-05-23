#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.6.1
 Author:         Matwachich

 Script Function:


#ce ----------------------------------------------------------------------------

Func _GEng_DrawStart($iBkColor = 0xFFFFFFFF)
	$__GEng_FramTimer = TimerInit()
	Return _GDIPlus_GraphicsClear($__GEng_hBuffer, $iBkColor)
EndFunc

Func _GEng_DrawEnd()
	Local $ret = _GDIPlus_GraphicsDrawImage($__GEng_hGraphic, $__GEng_hBitmap, 0, 0)
	SetExtended(TimerDiff($__GEng_FramTimer))
	Return $ret
EndFunc
