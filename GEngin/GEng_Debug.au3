#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.6.1
 Author:         Matwachich

 Script Function:


#ce ----------------------------------------------------------------------------

#Region ### Functions ###
#cs
- Main Functions
	_Dbg_DisplaySpr(ByRef $spr)
	_Bench_Start($label = "")
	_Bench_End($t, $label = "")
#ce
#EndRegion ###


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

Func _Bench_Start($label = "")
	Local $t = TimerInit()
	If $label <> "" Then ConsoleWrite("- Start: " & $label & @CRLF)
	Return $t
EndFunc

Func _Bench_End($t, $label = "")
	Local $d = TimerDiff($t)
	ConsoleWrite("- " & $label & " : " & $d & @CRLF)
EndFunc
