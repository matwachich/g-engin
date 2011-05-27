#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.6.1
 Author:         Matwachich

 Script Function:


#ce ----------------------------------------------------------------------------

#Region ### Functions ###
#cs
- Main Functions
	_GEng_Debug_DrawVect($iDbgPen, $x0, $y0, $x1, $y1)
	_GEng_Debug_DrawVectAngle($iDbgPen, $x0, $y0, $iAngle, $iGrandeur)
	_GEng_Debug_DrawLine($iDbgPen, $x0, $y0, $x1, $y1)
	_GEng_Debug_DrawLineAngle($iDbgPen, $x0, $y0, $iAngle, $iGrandeur)
	_GEng_Debug_DrawRect($iDbgPen, $x, $y, $w, $h)
	_GEng_Debug_DrawCircle($iDbgPen, $x, $y, $r)
	_Dbg_DisplaySpr(ByRef $spr)
	_Bench_Start($label = "")
	_Bench_End($t, $label = "")
#ce
#EndRegion ###

Global $bench = 0


Func _GEng_Debug_DrawVect($iDbgPen, $x0, $y0, $x1, $y1, $hBuffer = Default)
	If $hBuffer = Default Then
		Return _GDIPlus_GraphicsDrawLine($__GEng_hBuffer, $x0, $y0, $x1, $y1, Eval("_dbg_Arrow" & $iDbgPen))
	Else
		Return _GDIPlus_GraphicsDrawLine($hBuffer, $x0, $y0, $x1, $y1, Eval("_dbg_Arrow" & $iDbgPen))
	EndIf
EndFunc

Func _GEng_Debug_DrawVectAngle($iDbgPen, $x0, $y0, $iAngle, $iGrandeur, $hBuffer = Default)
	Local $tmp = _GEng_AngleToVector($iAngle, $iGrandeur)
	If $hBuffer = Default Then
		Return _GDIPlus_GraphicsDrawLine($__GEng_hBuffer, $x0, $y0, $tmp[0], $tmp[1], Eval("_dbg_Arrow" & $iDbgPen))
	Else
		Return _GDIPlus_GraphicsDrawLine($hBuffer, $x0, $y0, $tmp[0], $tmp[1], Eval("_dbg_Arrow" & $iDbgPen))
	EndIf
EndFunc

Func _GEng_Debug_DrawLine($iDbgPen, $x0, $y0, $x1, $y1, $hBuffer = Default)
	If $hBuffer = Default Then
		Return _GDIPlus_GraphicsDrawLine($__GEng_hBuffer, $x0, $y0, $x1, $y1, Eval("_dbg_Pen" & $iDbgPen))
	Else
		Return _GDIPlus_GraphicsDrawLine($hBuffer, $x0, $y0, $x1, $y1, Eval("_dbg_Pen" & $iDbgPen))
	EndIf
EndFunc

Func _GEng_Debug_DrawLineAngle($iDbgPen, $x0, $y0, $iAngle, $iGrandeur, $hBuffer = Default)
	Local $tmp = _GEng_AngleToVector($iAngle, $iGrandeur)
	If $hBuffer = Default Then
		Return _GDIPlus_GraphicsDrawLine($__GEng_hBuffer, $x0, $y0, $tmp[0], $tmp[1], Eval("_dbg_Pen" & $iDbgPen))
	Else
		Return _GDIPlus_GraphicsDrawLine($hBuffer, $x0, $y0, $tmp[0], $tmp[1], Eval("_dbg_Pen" & $iDbgPen))
	EndIf
EndFunc

Func _GEng_Debug_DrawRect($iDbgPen, $x, $y, $w, $h, $hBuffer = Default)
	If $hBuffer = Default Then
		Return _GDIPlus_GraphicsDrawRect($__GEng_hBuffer, $x, $y, $w, $h, Eval("_dbg_Pen" & $iDbgPen))
	Else
		Return _GDIPlus_GraphicsDrawRect($hBuffer, $x, $y, $w, $h, Eval("_dbg_Pen" & $iDbgPen))
	EndIf
EndFunc

Func _GEng_Debug_DrawCircle($iDbgPen, $x, $y, $r, $hBuffer = Default)
	If $hBuffer = Default Then
		Return _GDIPlus_GraphicsDrawEllipse($__GEng_hBuffer, $x - $r, $y - $r, $r * 2, $r * 2, Eval("_dbg_Pen" & $iDbgPen))
	Else
		Return _GDIPlus_GraphicsDrawEllipse($hBuffer, $x - $r, $y - $r, $r * 2, $r * 2, Eval("_dbg_Pen" & $iDbgPen))
	EndIf
EndFunc

Func _Dbg_DisplaySpr(ByRef $spr)
	Local $a[36][2] = [ _
	["_gSpr_hBuffer",		$spr[0]], _
	["_gSpr_iImg",			$spr[1]], _
	["_gSpr_ImgX",			$spr[2]], _
	["_gSpr_ImgY",			$spr[3]], _
	["_gSpr_ImgW",			$spr[4]], _
	["_gSpr_ImgH",			$spr[5]], _
	["_gSpr_PosX",			$spr[6]], _
	["_gSpr_PosY",			$spr[7]], _
	["_gSpr_Width",			$spr[8]], _
	["_gSpr_Height",			$spr[9]], _
	["_gSpr_OriX",			$spr[10]], _
	["_gSpr_OriY",		$spr[11]], _
	["_gSpr_SpeedX",		$spr[12]], _
	["_gSpr_SpeedY",			$spr[13]], _
	["_gSpr_AccelX",			$spr[14]], _
	["_gSpr_AccelY",			$spr[15]], _
	["_gSpr_SpeedMax",			$spr[16]], _
	["_gSpr_InnertieX",		$spr[17]], _
	["_gSpr_InnertieY",		$spr[18]], _
	["_gSpr_AngleDeg",		$spr[19]], _
	["_gSpr_AngleRad",			$spr[20]], _
	["_gSpr_AngleSpeed",	$spr[21]], _
	["_gSpr_AngleAccel",		$spr[22]], _
	["_gSpr_AngleSpeedMax",		$spr[23]], _
	["_gSpr_AngleInnertie",		$spr[24]], _
	["_gSpr_AngleOriDeg",		$spr[25]], _
	["_gSpr_AngleOriRad",		$spr[26]], _
	["_gSpr_AnimFrame",		$spr[27]], _
	["_gSpr_AnimDelayMulti",		$spr[28]], _
	["_gSpr_CollX",		$spr[29]], _
	["_gSpr_CollY",		$spr[30]], _
	["_gSpr_CollW",		$spr[31]], _
	["_gSpr_CollH",		$spr[32]], _
	["_gSpr_CollType",		$spr[33]], _
	["_gSpr_MoveTimer",	$spr[34]], _
	["_gSpr_AnimTimer",		$spr[35]] _
	]
	_ArrayDisplay($a)
EndFunc

Func _Bench_Start(ByRef $t)
	$t = TimerInit()
	;If $label <> "" Then ConsoleWrite("- Start: " & $label & @CRLF)
EndFunc

Func _Bench_End(ByRef $t, $label = "")
	If $bench = 0 Then
		$bench = TimerDiff($t)
	Else
		$bench += TimerDiff($t)
		$bench = $bench / 2
	EndIf
	ConsoleWrite("- " & $label & " : " & $bench & @CRLF)
EndFunc
