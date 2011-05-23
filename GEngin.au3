#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.6.1
 Author:         Matwachich

 Script Function:


#ce ----------------------------------------------------------------------------

#include <GDIPlus.au3>

; ##############################################################

Global $__GEng_hGui = -1
Global $__GEng_WinW = -1, $__GEng_WinH = -1
Global $__GEng_hGraphic = -1
Global $__GEng_hBitmap = -1
Global $__GEng_hBuffer = -1
Global $__GEng_FramTimer = 0
; ---
Global Const $__GEng_PI = 4 * ATan(1)

; ##############################################################

Global $__GEng_Debug = 0
Global $_dbg_pen1, $_dbg_pen2, $_dbg_pen3

; ##############################################################

#include "GEngin\GEng_System.au3"
#include "GEngin\GEng_Image.au3"
#include "GEngin\GEng_Sprite.au3"
#include "GEngin\GEng_Sprite_Collision.au3"
#include "GEngin\GEng_Sprite_Animation.au3"
#include "GEngin\GEng_Sprite_Move.au3"
#include "GEngin\GEng_Sprite_Info.au3"
#include "GEngin\GEng_Sprite_Set.au3"
#include "GEngin\GEng_Animation.au3"
#include "GEngin\GEng_Vector.au3"
#include "GEngin\GEng_RotVector.au3"
#include "GEngin\GEng_Draw.au3"
#include "GEngin\GEng_Geometry.au3"

; ##############################################################



; ##############################################################

Func _Dbg_DisplaySpr(ByRef $spr)
	Local $a[39][2] = [ _
	["Img Index",$spr[0]], _
	["Img X",$spr[1]], _
	["Img Y",$spr[2]], _
	["Img W",$spr[3]], _
	["Img H",$spr[4]], _
	["Name",$spr[5]], _
	["hBuffer",$spr[6]], _
	["Pos X",$spr[7]], _
	["Pos Y",$spr[8]], _
	["Width",$spr[9]], _
	["Height",$spr[10]], _
	["Origin X",$spr[11]], _
	["Origin Y",$spr[12]], _
	["Vit X",$spr[13]], _
	["Vit Y",$spr[14]], _
	["Accel X",$spr[15]], _
	["Accel Y",$spr[16]], _
	["Angle Deg",$spr[17]], _
	["Angle Rad",$spr[18]], _
	["Angle Speed",$spr[19]], _
	["hAnim",$spr[20]], _
	["AnimCurrFrame",$spr[21]], _
	["AnimDelay",$spr[22]], _
	["Collision X",$spr[23]], _
	["Collision Y",$spr[24]], _
	["Collision W",$spr[25]], _
	["Collision H",$spr[26]], _
	["VitMax X",$spr[27]], _
	["VitMax Y",$spr[28]], _
	["AccelMax X",$spr[29]], _
	["AccelMax Y",$spr[30]], _
	["Innertie X",$spr[31]], _
	["Innertie Y",$spr[32]], _
	["Move Timer",$spr[33]], _
	["Angle Speed Max",$spr[34]], _
	["Angle Accel",$spr[35]], _
	["Angle Accel Max",$spr[36]], _
	["Angle Innertie",$spr[37]], _
	["Collision Type",$spr[38]] _
	]
	_ArrayDisplay($a)
EndFunc

Func _Dgb($1 = Default, $2 = Default, $3 = Default, $4 = Default, $5 = Default, $6 = Default, $7 = Default, $8 = Default, $9 = Default)
	For $i = 1 To 9
		If Eval($i) <> Default Then ConsoleWrite(Eval($i) & @CRLF)
	Next
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
