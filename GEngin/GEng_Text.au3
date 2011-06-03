#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.6.1
 Author:         Matwachich

 Script Function:


#ce ----------------------------------------------------------------------------

#Region ### Functions ###
#cs
- Main Functions
	_GEng_Font_Create($sFontName = "Arial", $iFontSize = 10, $iFontStyle = 0, $iFormat = 0)
	_GEng_Font_Delete(ByRef $hFont)
	_GEng_Text_Create(ByRef $hFont, $sText = "", $iColor = 0xFFFFFFFF, $iPosX = 0, $iPosY = 0, $iWidth = 0, $iHeight = 0)
	_GEng_Text_FontSet(ByRef $hTxtRect, $hFont = Default)
	_GEng_Text_StringSet(ByRef $hTxtRect, $sText = Default)
	_GEng_Text_StringGet(ByRef $hTxtRect)
	_GEng_Text_PosSet(ByRef $hTxtRect, $iPosX = Default, $iPosY = Default, $iWidth = Default, $iHeight = Default)
	_GEng_Text_PosGet(ByRef $hTxtRect, ByRef $iPosX, ByRef $iPosY, ByRef $iWidth, ByRef $iHeight)
	_GEng_Text_SizeMeasure(ByRef $hFont, $sText, ByRef $w, ByRef $h)
	_GEng_Text_ColorSet(ByRef $hTxtRect, $iColor)
	_GEng_Text_Draw(ByRef $hTxtRect)
	_GEng_Text_Delete(ByRef $hTxtRect)
	__GEng_Text_IsTextRect(ByRef $hTxtRect)
	__GEng_Text_IsFont(ByRef $hFont)
#ce
#EndRegion ###


; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Font_Create
; Description....:	Créer un objet Font pour être utiliser par un Objet Text
; Parameters.....:	$sFontName = Nom de la police de caractères
;					$iFontSize = Taille du texte
;					$iFontStyle = Style du texte (voir _GDIPlus_FontCreate)
;					$iFormat = Voir _GDIPlus_StringFormatCreate
; Return values..:	Objet Font
; Author.........:	Matwachich
; Remarks........:	
; ===========================================================================================================
Func _GEng_Font_Create($sFontName = "Arial", $iFontSize = 10, $iFontStyle = 0, $iFormat = 0)
	Local $hFamily = _GDIPlus_FontFamilyCreate($sFontName)
	Local $ret[2] = [ _
		_GDIPlus_StringFormatCreate($iFormat), _
		_GDIPlus_FontCreate($hFamily, $iFontSize, $iFontStyle) _
		]
	; ---
	_GDIPlus_FontFamilyDispose($hFamily)
	; ---
	Return $ret
EndFunc

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Font_Delete
; Description....:	Supprime un Objet Font
; Parameters.....:	$hFont = Objet Font
; Return values..:	Succes - 1
;					Echec - 0 et @error = 1
; Author.........:	Matwachich
; Remarks........:	Doit être appeler à la fin du script pour chaque objet Font créer
; ===========================================================================================================
Func _GEng_Font_Delete(ByRef $hFont)
	If Not __GEng_Text_IsFont($hFont) Then Return SetError(1, 0, 0)
	; ---
	_GDIPlus_FontDispose($hFont[1])
	_GDIPlus_StringFormatDispose($hFont[0])
	; ---
	$hFont = 0
	; ---
	Return 1
EndFunc

; ##############################################################

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Text_Create
; Description....:	Créer un objet Text à afficher à l'écran
; Parameters.....:	$hFont = Objet Font à utiliser
;					$sText = Text à afficher
;					$iColor = Couleur du texte (0xAARRVVBB) - Défaut = 0xFFFFFFFF (Blanc)
;					$iPosX, $iPosY = Position du texte
;					$iWidth, $iHeight = Largeur et hauteur du rectangle contenant le text (voir remarque)
; Return values..:	Succes - Objet Text
;					Echec - 0 et @error = 1
; Author.........:	Matwachich
; Remarks........:	Il est préférable de laisser $iWidth et $iHeight à 0 (par défaut) pour que les dimensions
;						du rectangle soient calculées automatiquement et être sur que tout le texte sera affiché
; ===========================================================================================================
Func _GEng_Text_Create(ByRef $hFont, $sText = "", $iColor = 0xFFFFFFFF, $iPosX = 0, $iPosY = 0, $iWidth = 0, $iHeight = 0)
	If Not __GEng_Text_IsFont($hFont) Then Return SetError(1, 0, 0)
	; ---
	Local $sPosRect = _GDIPlus_RectFCreate($iPosX, $iPosY, $iWidth, $iHeight)
	Local $hColor = _GDIPlus_BrushCreateSolid($iColor)
	; ---
	Local $ret[4] = [ _
		$hFont, _
		$sText, _
		$sPosRect, _
		$hColor _
		]
	$sPosRect = 0
	; ---
	Return $ret
EndFunc

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Text_FontSet
; Description....:	Change la police (objet Font) utilisé par un Objet Text
; Parameters.....:	$hTxtRect = Objet Text
;					$hFont = Objet Font
; Return values..:	Succes - 1
;					Echec - 0 et @error = 1
; Author.........:	Matwachich
; Remarks........:	
; ===========================================================================================================
Func _GEng_Text_FontSet(ByRef $hTxtRect, $hFont = Default)
	If Not __GEng_Text_IsTextRect($hTxtRect) Then Return SetError(1, 0, 0)
	; ---
	If $hFont <> Default And __GEng_Text_IsFont($hFont) Then
		$hTxtRect[0] = $hFont
	Else
		Return SetError(1, 0, 0)
	EndIf
	; ---
	Return 1
EndFunc

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Text_StringSet
; Description....:	Change le texte affiché par un objet Text
; Parameters.....:	$hTxtRect = Objet Text
;					$sText = Nouveau text
; Return values..:	Succes - 1
;					Echec - 0 et @error = 1
; Author.........:	Matwachich
; Remarks........:	
; ===========================================================================================================
Func _GEng_Text_StringSet(ByRef $hTxtRect, $sText = Default)
	If Not __GEng_Text_IsTextRect($hTxtRect) Then Return SetError(1, 0, 0)
	; ---
	Local $hFont = $hTxtRect[0]
	; ---
	If $sText <> Default Then
		$hTxtRect[1] = $sText
	EndIf
	; ---
	Return 1
EndFunc

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Text_StringGet
; Description....:	Récupère le texte contenu dans un Objet Text
; Parameters.....:	$hTxtRect = Objet Text
; Return values..:	Succes - Text
;					Echec - 0 et @error = 1
; Author.........:	Matwachich
; Remarks........:	
; ===========================================================================================================
Func _GEng_Text_StringGet(ByRef $hTxtRect)
	If Not __GEng_Text_IsTextRect($hTxtRect) Then Return SetError(1, 0, 0)
	; ---
	Return $hTxtRect[1]
EndFunc

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Text_PosSet
; Description....:	Change la position et les dimensions du rectangle affichant le texte d'un Objet Text
; Parameters.....:	$hTxtRect = Objet Text
;					$iPosX, $iPosY, $iWidth, $iHeight = Idem _GEng_Text_Create
; Return values..:	Succes - 1
;					Echec - 0 et @error = 1
; Author.........:	Matwachich
; Remarks........:	Un paramètre laissé par défaut ne sera pas modifier
; ===========================================================================================================
Func _GEng_Text_PosSet(ByRef $hTxtRect, $iPosX = Default, $iPosY = Default, $iWidth = Default, $iHeight = Default)
	If Not __GEng_Text_IsTextRect($hTxtRect) Then Return SetError(1, 0, 0)
	; ---
	Local $Struct = $hTxtRect[2]
	If $iPosX <> Default Then DllStructSetData($Struct, "X", $iPosX)
	If $iPosY <> Default Then DllStructSetData($Struct, "Y", $iPosY)
	If $iWidth <> Default Then DllStructSetData($Struct, "Width", $iWidth)
	If $iHeight <> Default Then DllStructSetData($Struct, "Height", $iHeight)
	; ---
	Return 1
EndFunc

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Text_PosGet
; Description....:	Récupère la position et les dimensions du rectangle affichant le texte d'un Objet Text
; Parameters.....:	$hTxtRect = Objet Text
;					$iPosX, $iPosY, $iWidth, $iHeight = Variables qui vont contenir les informations
;															récupérées (Idem _GEng_Text_Create)
; Return values..:	Succes - 1
;					Echec - 0 et @error = 1
; Author.........:	Matwachich
; Remarks........:	
; ===========================================================================================================
Func _GEng_Text_PosGet(ByRef $hTxtRect, ByRef $iPosX, ByRef $iPosY, ByRef $iWidth, ByRef $iHeight)
	If Not __GEng_Text_IsTextRect($hTxtRect) Then Return SetError(1, 0, 0)
	; ---
	Local $Struct = $hTxtRect[2]
	$iPosX = DllStructSetData($Struct[0], "X", $iPosX)
	$iPosY = DllStructSetData($Struct[0], "Y", $iPosY)
	$iWidth = DllStructSetData($Struct[0], "Width", $iWidth)
	$iHeight = DllStructSetData($Struct[0], "Height", $iHeight)
	; ---
	Return 1
EndFunc

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Text_SizeMeasure
; Description....:	Donne la taille (Largeur, Hauteur) d'un rectangle nécéssaire à l'affichage d'un texte
;						avec un Objet Font spécifique
; Parameters.....:	$hFont = Objet Font
;					$sText = Texte à mesurer
;					$w, $h = Variables qui vont contenir les informations récupérées (Largeur, Hauteur)
; Return values..:	Succes - 1
;					Echec - 0 et @error = 1
; Author.........:	Matwachich
; Remarks........:	
; ===========================================================================================================
Func _GEng_Text_SizeMeasure(ByRef $hFont, $sText, ByRef $w, ByRef $h)
	If Not __GEng_Text_IsFont($hFont) Then Return SetError(1, 0, 0)
	; ---
	Local $tLayout = _GDIPlus_RectFCreate(0, 0, 0, 0)
	Local $ret = _GDIPlus_GraphicsMeasureString($__GEng_hGraphic, $sText, $hFont[1], $tLayout, $hFont[0])
	$tLayout = 0
	If @error Then Return SetError(1, 0, 0)
	; ---
	$w = DllStructGetData($ret[0], "Width")
	$h = DllStructGetData($ret[0], "Height")
	; ---
	$ret = 0
	Return 1
EndFunc

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Text_ColorSet
; Description....:	Modifie la couleur du texte d'un Objet Text
; Parameters.....:	$hTxtRect = Objet Text
;					$iColor = Nouvelle couleur (0xAARRVVBB)
; Return values..:	Succes - 1
;					Echec - 0 et @error = 1
; Author.........:	Matwachich
; Remarks........:	
; ===========================================================================================================
Func _GEng_Text_ColorSet(ByRef $hTxtRect, $iColor)
	If Not __GEng_Text_IsTextRect($hTxtRect) Then Return SetError(1, 0, 0)
	; ---
	Return _GDIPlus_BrushSetSolidColor($hTxtRect[3], $iColor)
EndFunc

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Text_Draw
; Description....:	Affiche un objet Text
; Parameters.....:	$hTxtRect = Objet Text
; Return values..:	Succes - 1
;					Echec - 0 et @error = 1
; Author.........:	Matwachich
; Remarks........:	Doit être appeler pour chaque frame (dans la boucle principale)
; ===========================================================================================================
Func _GEng_Text_Draw(ByRef $hTxtRect)
	If Not __GEng_Text_IsTextRect($hTxtRect) Then Return SetError(1, 0, 0)
	; ---
	Local $hFont = $hTxtRect[0]
	Return _GDIPlus_GraphicsDrawStringEx($__GEng_hBuffer, $hTxtRect[1], $hFont[1], $hTxtRect[2], $hFont[0], $hTxtRect[3])
EndFunc

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Text_Delete
; Description....:	Supprime un objet Text
; Parameters.....:	$hTxtRect = Objet Text
; Return values..:	Succes - 1
;					Echec - 0 et @error = 1
; Author.........:	Matwachich
; Remarks........:	Supprimer un Objet Text ne supprime pas l'objet Font associé
; ===========================================================================================================
Func _GEng_Text_Delete(ByRef $hTxtRect)
	If Not __GEng_Text_IsTextRect($hTxtRect) Then Return SetError(1, 0, 0)
	; ---
	$hTxtRect[2] = 0
	_GDIPlus_BrushDispose($hTxtRect[3])
	$hTxtRect = 0
	; ---
	Return 1
EndFunc

; ##############################################################

Func __GEng_Text_IsTextRect(ByRef $hTxtRect)
	If UBound($hTxtRect) <> 4 Then Return SetError(1, 0, 0)
	; ---
	Return 1
EndFunc

Func __GEng_Text_IsFont(ByRef $hFont)
	If UBound($hFont) <> 2 Then Return SetError(1, 0, 0)
	; ---
	Return 1
EndFunc