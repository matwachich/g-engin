#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.6.1
 Author:         Matwachich

 Script Function:


#ce ----------------------------------------------------------------------------

#Region ### Functions ###
#cs
- Main Functions
	_GEng_Start($sTitle, $iW, $iH, $iX = -1, $iY = -1, $iStyle = -1, $iExtStyle = -1)
	_GEng_Shutdown()
	_GEng_SetDebug($mode)
	__GEng_GetBuffer()
	__GEng_IsStarted()
#ce
#EndRegion ###


Func _GEng_Start($sTitle, $iW, $iH, $iX = -1, $iY = -1, $iStyle = -1, $iExtStyle = -1)
	$__GEng_hGui = GuiCreate($sTitle, $iW, $iH, $iX, $iY, $iStyle, $iExtStyle)
	If @error Then Return SetError(1, 0, 0)
	; ---
	$__GEng_WinW = $iW
	$__GEng_WinH = $iH
	; ---
	_GDIPlus_Startup()
	; ---
	$__GEng_hGraphic = _GDIPlus_GraphicsCreateFromHWND($__GEng_hGui)
	$__GEng_hBitmap = _GDIPlus_BitmapCreateFromGraphics($iW, $iH, $__GEng_hGraphic)
	$__GEng_hBuffer = __GEng_GetBuffer()
	; ---
	$__GEng_ScreenDC = _WinAPI_GetDC($__GEng_hGui)
	$__GEng_CompatibleDC = _WinAPI_CreateCompatibleDC($__GEng_ScreenDC)
	; ---
	GuiSetState(@SW_SHOW, $__GEng_hGui)
	Return SetError(0, 0, 1)
EndFunc

Func _GEng_Shutdown()
	__GEng_Image_DisposeAll()
	; ---
	_GEng_SetDebug(0)
	; ---
	_WinAPI_ReleaseDC($__GEng_hGui, $__GEng_ScreenDC)
	_WinAPI_ReleaseDC($__GEng_hGui, $__GEng_CompatibleDC)
	_WinAPI_DeleteDC($__GEng_ScreenDC)
	_WinAPI_DeleteDC($__GEng_CompatibleDC)
	; ---
	_GDIPlus_GraphicsDispose($__GEng_hBuffer)
	_GDIPlus_BitmapDispose($__GEng_hBitmap)
	_GDIPlus_GraphicsDispose($__GEng_hGraphic)
	GuiDelete($__GEng_hGui)
EndFunc

Func _GEng_SetDebug($mode = Default)
	If $mode = Default Then Return $__GEng_Debug
	; ---
	_GDIPlus_Startup()
	; ---
	If $mode Then
		$_Arrow = _GDIPlus_ArrowCapCreate(5, 3, 1)
		$_dbg_Arrow1 = _GDIPlus_PenCreate(0xFFFF0000, 2)
		$_dbg_Arrow2 = _GDIPlus_PenCreate(0xFF00FF00, 2)
		$_dbg_Arrow3 = _GDIPlus_PenCreate(0xFF0000FF, 2)
		$_dbg_Arrow4 = _GDIPlus_PenCreate(0xFFb9ba4e, 1)
			_GDIPlus_PenSetCustomEndCap($_dbg_Arrow1, $_Arrow)
			_GDIPlus_PenSetCustomEndCap($_dbg_Arrow2, $_Arrow)
			_GDIPlus_PenSetCustomEndCap($_dbg_Arrow3, $_Arrow)
			_GDIPlus_PenSetCustomEndCap($_dbg_Arrow4, $_Arrow)
			
		$_dbg_pen1 = _GDIPlus_PenCreate(0xFFFF0000, 2)
		$_dbg_pen2 = _GDIPlus_PenCreate(0xFF00FF00, 2)
		$_dbg_pen3 = _GDIPlus_PenCreate(0xFF0000FF, 2)
		$_dbg_pen4 = _GDIPlus_PenCreate(0xFFb9ba4e, 1)
		; ---
		$__GEng_Debug = 1
	Else
		If $__GEng_Debug Then
		_GDIPlus_PenDispose($_dbg_Arrow1)
		_GDIPlus_PenDispose($_dbg_Arrow2)
		_GDIPlus_PenDispose($_dbg_Arrow3)
		_GDIPlus_PenDispose($_dbg_Arrow4)
		_GDIPlus_ArrowCapDispose($_Arrow)
		_GDIPlus_PenDispose($_dbg_pen1)
		_GDIPlus_PenDispose($_dbg_pen2)
		_GDIPlus_PenDispose($_dbg_pen3)
		_GDIPlus_PenDispose($_dbg_pen4)
		; ---
		$__GEng_Debug = 0
		EndIf
	EndIf
EndFunc

; ==============================================================
; ### Internals
; ==============================================================
Func __GEng_GetBuffer()
	Local $hBuffer = _GDIPlus_ImageGetGraphicsContext($__GEng_hBitmap)
	_GDIPlus_GraphicsSetSmoothingMode($hBuffer, 7)
	Return $hBuffer
EndFunc

Func __GEng_IsStarted()
	If $__GEng_hGui = -1 Then Return 0
	Return 1
EndFunc