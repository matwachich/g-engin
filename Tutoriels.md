

# Tuto 1 #

Simple affichage d'un Sprite à l'écran, modifier sa position et sa direction (angle).
```
#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.6.1
 Author:         Matwachich

 Script Function:
	Tutoriel basic pour GEngin
	- Créer une fenètre
	- Afficher une image et lui changer de position et d'angle

#ce ----------------------------------------------------------------------------

Global $scrW = 400, $scrH = 300
Global $x, $y
Opt("MouseCoordMode", 2) ; Pour récupérer la position de la souris par rapport à la fenètre
#include <Misc.au3> ; pour _IsPressed

; d'abors, on inclu GEngin.au3
#include <..\GEngin.au3>

; On démare GEngin, avec une fenètre qui aura pour titre "GEngin - Tuto 1"
; et pour dimensions 400x300 pixels
_GEng_Start("GEngin - Tuto 1", $scrW, $scrH)

; On charge les image que nous allons afficher dans des variables
$img_Gimp = _GEng_ImageLoad("res\gimp.png")

; On créer nos objet sprites, pour l'instant un seul et on le stock dans une variable
$spr_Gimp = _GEng_Sprite_Create()

; On Assigne une image à notr sprite
; Ici, le sprite se vera assigné la taille de l'image qu'on vient de lui assigné (128x128)
_GEng_Sprite_ImageSet($spr_Gimp, $img_Gimp)
_GEng_Sprite_SizeGet($spr_Gimp, $x, $y)
ConsoleWrite("Taille du Sprite: " & $x & "x" & $y & @CRLF)

; On assigne à notre Sprite un point d'origine, c'est le centre de rotation du sprite
; et le point de l'image que l'on positionne. On le place au milieux de l'image
; On aurai pu le faire par: _GEng_Sprite_OriginSet($spr_Gimp, 64, 64)
; mais imaginez que la taille de l'image change, ou soit inconnue!
_GEng_Sprite_OriginSetEx($spr_Gimp, $GEng_Origin_Mid)

; Maintenant, on positionne le Sprite au centre de l'écran
_GEng_Sprite_PosSet($spr_Gimp, $scrW / 2, $scrH / 2)

; A ce stade, rien ne s'affiche encore, car l'écran n'est ni initialisé à une couleur, ni rafraichi
; et on a pas afficher notre sprite.
; On le fait maintenant
MsgBox(0, "GEngin", "Rien ne s'affiche!")
_GEng_ScrFlush(0xFFFFFFFF)
_GEng_Sprite_Draw($spr_Gimp)
_GEng_ScrUpdate()
MsgBox(0, "GEngin", "Sprite au centre de l'écran")

; Maintenant, on change la position du sprite, mais le changement ne sera pris en concidération que
; si on répete les 3 fonction juste au dessu!
_GEng_Sprite_PosSet($spr_Gimp, $scrW / 4, $scrH / 4)
MsgBox(0, "GEngin", "Le Sprite n'a pas changer de position!")

; l'idéal est donc de mettre tout ça dans une boucle
; On en profite pour insérer la modification de l'angle du Sprite
; par un clique Droit, qui ajoute 30° à chaque fois
MsgBox(0, "GEngin", "Clique gauche pour changer la position du Sprite" & @CRLF & _
			"Clique droit pour modifier l'angle")
Global $tmp
Do
	_GEng_ScrFlush(0xFFFFFFFF)
	; ---
	If _IsPressed('01') Then
		$tmp = MouseGetPos()
		_GEng_Sprite_PosSet($spr_Gimp, $tmp[0], $tmp[1])
	EndIf
	If _IsPressed('02') Then
		_GEng_Sprite_AngleAdd($spr_Gimp, 30)
	EndIf
	; ---
	_GEng_Sprite_Draw($spr_Gimp)
	; ---
	_GEng_ScrUpdate()
Until GuiGetMsg() = -3 ; $GUI_EVENT_CLOSE

; On ferme GEngin et on libère les ressources!
_GEng_Shutdown()

; Fin!
```

# Tuto 2 #
Gestion des mouvements (Vitesse, accélération, rotation, innertie ...)
```
#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.6.1
 Author:         Matwachich

 Script Function:
	Tutoriel Basique 2
	- Mouvements dynamiques

 Remarque:
	- Il faut avoir lu le Tuto 1, car ce qui a été expliqué ne le sera pas
		une 2e fois! (les absents ont toujours tort!!! :-p)
#ce ----------------------------------------------------------------------------

Global $scrW = 800, $scrH = 600
Global $x, $y
Opt("MouseCoordMode", 2) ; Pour récupérer la position de la souris par rapport à la fenètre
#include <Misc.au3> ; pour _IsPressed
#include <..\GEngin.au3>

_GEng_Start("GEngin - Tuto 2", $scrW, $scrH)
; ---
$img_Gimp = _GEng_ImageLoad("res\gengin.png", 64, 64)
; ---
$spr_Gimp = _GEng_Sprite_Create()
	_GEng_Sprite_ImageSet($spr_Gimp, $img_Gimp)
	_GEng_Sprite_SizeGet($spr_Gimp, $x, $y)
	_GEng_Sprite_OriginSetEx($spr_Gimp, $GEng_Origin_Mid)
	_GEng_Sprite_PosSet($spr_Gimp, $scrW / 2, $scrH / 2)
; ---

; le nouveau par rapport au Tuto 1 commence ici
; J'assigne la vitesse maximum de mouvement et de rotation de mon sprite
_GEng_Sprite_SpeedSet($spr_Gimp, 0, 0, 100) ; 100 pixels/s
_GEng_Sprite_AngleSpeedSet($spr_Gimp, 0, 30) ; 30 Deg/s

; On met aussi une innertie de mouvement et de rotation,
; pour que le Sprite s'arrète de bouger tout seul si il n'a pas d'accélération
; Plus le valeur est grande, plus l'arret du mouvement est rapide après qu'il
; n'y ai plus d'accélération (voir la boucle principale)
_GEng_Sprite_InnertieSet($spr_Gimp, 100, 100)
_GEng_Sprite_AngleInnertieSet($spr_Gimp, 60)
	
Global $tmp
Do
	_GEng_ScrFlush(0xFFFFFFFF)
	; ---
	Select ; Mouvement
		Case _IsPressed('26') ; Haut
			_GEng_Sprite_AccelSet($spr_Gimp, Default, -500) ; On ne touche pas à l'accélération sur l'axe X (car $x = Default)
		Case _IsPressed('28') ; Bas
			_GEng_Sprite_AccelSet($spr_Gimp, Default, 500) ; Idem
		Case _IsPressed('25') ; Gauche
			_GEng_Sprite_AccelSet($spr_Gimp, -500, Default) ; On ne touche pas à l'accélération sur l'axe Y (car $y = Default)
		Case _IsPressed('27') ; Droite
			_GEng_Sprite_AccelSet($spr_Gimp, 500, Default) ; Idem
		Case Else
			_GEng_Sprite_AccelSet($spr_Gimp, 0, 0) ; accélération nul, c'est l'innertie qui va stoper le mouvement
	EndSelect
	; ---
	Select ; Rotation	
		Case _IsPressed('11') ; Ctrl
			_GEng_Sprite_AngleAccelSet($spr_Gimp, +500)
		Case _IsPressed('10') ; Shift
			_GEng_Sprite_AngleAccelSet($spr_Gimp, -500)
		Case Else
			_GEng_Sprite_AngleAccelSet($spr_Gimp, 0) ; accélération nul, c'est l'innertie qui va stoper le mouvement
	EndSelect
	; ---
	_GEng_Sprite_Draw($spr_Gimp)
	; ---
	_GEng_ScrUpdate()
Until GuiGetMsg() = -3 ; $GUI_EVENT_CLOSE

_GEng_Shutdown()

; Fin!
```

# Tuto 3 #
Utilité de la fonction 