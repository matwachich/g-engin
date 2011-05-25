#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.6.1
 Author:         Matwachich

 Script Function:


#ce ----------------------------------------------------------------------------

#include <GDIPlus.au3>
#include <Array.au3>

; ##############################################################

Global $__GEng_hGui = -1
Global $__GEng_WinW = -1, $__GEng_WinH = -1
Global $__GEng_hGraphic = -1
Global $__GEng_hBitmap = -1
Global $__GEng_hBuffer = -1
Global $__GEng_FrameTimer = 0
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
#include "GEngin\GEng_Sprite_Dynamics.au3"
#include "GEngin\GEng_Sprite_Get.au3"
#include "GEngin\GEng_Sprite_Set.au3"
#include "GEngin\GEng_Sprite_Append.au3"
#include "GEngin\GEng_Animation.au3"
#include "GEngin\GEng_Draw.au3"
#include "GEngin\GEng_Geometry.au3"
#include "GEngin\GEng_Text.au3"
; ---
#include "GEngin\GEng_Debug.au3"
