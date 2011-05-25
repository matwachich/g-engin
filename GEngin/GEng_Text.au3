#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.6.1
 Author:         Matwachich

 Script Function:


#ce ----------------------------------------------------------------------------

#Region ### Functions ###
#cs
- Main Functions
	_GEng_Font_Create($sFontName = "Arial", $iFontColor = 0xFF000000, $iFontSize = 10, $iFontStyle = 0, $iFormat = Default)
	_GEng_Font_Delete(ByRef $hFont)
	_GEng_Text_Create(ByRef $hFont, $sText = "", $iPosX = 0, $iPosY = 0, $iWidth = 0, $iHeight = 0)
	_GEng_Text_FontSet(ByRef $hTxtRect, $hFont = Default)
	_GEng_Text_StringSet(ByRef $hTxtRect, $sText = Default)
	_GEng_Text_StringGet(ByRef $hTxtRect)
	_GEng_Text_PosSet(ByRef $hTxtRect, $iPosX = Default, $iPosY = Default, $iWidth = Default, $iHeight = Default)
	_GEng_Text_PosGet(ByRef $hTxtRect, ByRef $iPosX, ByRef $iPosY, ByRef $iWidth, ByRef $iHeight)
	_GEng_Text_Draw(ByRef $hTxtRect)
	_GEng_Text_Delet(ByRef $hTxtRect)
	__GEng_Text_IsTextRect(ByRef $hTxtRect)
	__GEng_Text_IsFont(ByRef $hFont)
#ce
#EndRegion ###


Func _GEng_Font_Create($sFontName = "Arial", $iFontColor = 0xFF000000, $iFontSize = 10, $iFontStyle = 0, $iFormat = Default)
	Local $hFamily = _GDIPlus_FontFamilyCreate($sFontName)
	Local $ret[3] = [ _
		_GDIPlus_BrushCreateSolid($iFontColor), _
		_GDIPlus_StringFormatCreate(), _
		_GDIPlus_FontCreate($hFamily, $iFontSize, $iFontStyle) _
		]
	; ---
	_GDIPlus_FontFamilyDispose($hFamily)
	; ---
	Return $ret
EndFunc

Func _GEng_Font_Delete(ByRef $hFont)
	If Not __GEng_Text_IsFont($hFont) Then Return SetError(1, 0, 0)
	; ---
	_GDIPlus_FontDispose($hFont[2])
	_GDIPlus_StringFormatDispose($hFont[1])
	_GDIPlus_BrushDispose($hFont[0])
	; ---
	$hFont = 0
	; ---
	Return 1
EndFunc

Func _GEng_Text_Create(ByRef $hFont, $sText = "", $iPosX = 0, $iPosY = 0, $iWidth = 0, $iHeight = 0)
	If Not __GEng_Text_IsFont($hFont) Then Return SetError(1, 0, 0)
	; ---
	Local $sPosRect = _GDIPlus_RectFCreate($iPosX, $iPosY, $iWidth, $iHeight)
	Local $ret[3] = [ _
		$hFont, _
		$sText, _
		$sPosRect _
		]
	; ---
	Return $ret
EndFunc

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

Func _GEng_Text_StringSet(ByRef $hTxtRect, $sText = Default)
	If Not __GEng_Text_IsTextRect($hTxtRect) Then Return SetError(1, 0, 0)
	; ---
	If $sText <> Default Then $hTxtRect[1] = $sText
	; ---
	Return 1
EndFunc

Func _GEng_Text_StringGet(ByRef $hTxtRect)
	If Not __GEng_Text_IsTextRect($hTxtRect) Then Return SetError(1, 0, 0)
	; ---
	Return $hTxtRect[1]
EndFunc

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

Func _GEng_Text_PosGet(ByRef $hTxtRect, ByRef $iPosX, ByRef $iPosY, ByRef $iWidth, ByRef $iHeight)
	If Not __GEng_Text_IsTextRect($hTxtRect) Then Return SetError(1, 0, 0)
	; ---
	Local $Struct = $hTxtRect[2]
	$iPosX = DllStructSetData($Struct, "X", $iPosX)
	$iPosY = DllStructSetData($Struct, "Y", $iPosY)
	$iWidth = DllStructSetData($Struct, "Width", $iWidth)
	$iHeight = DllStructSetData($Struct, "Height", $iHeight)
	; ---
	Return 1
EndFunc

Func _GEng_Text_Draw(ByRef $hTxtRect)
	If Not __GEng_Text_IsTextRect($hTxtRect) Then Return SetError(1, 0, 0)
	; ---
	Local $hFont = $hTxtRect[0]
	Return _GDIPlus_GraphicsDrawStringEx($__GEng_hGraphic, $hTxtRect[1], $hFont[2], $hTxtRect[2], $hFont[1], $hFont[0])
EndFunc

Func _GEng_Text_Delet(ByRef $hTxtRect)
	If Not __GEng_Text_IsTextRect($hTxtRect) Then Return SetError(1, 0, 0)
	; ---
	$hTxtRect = 0
	; ---
	Return 1
EndFunc

; ##############################################################

Func __GEng_Text_IsTextRect(ByRef $hTxtRect)
	If UBound($hTxtRect) <> 3 Then Return SetError(1, 0, 0)
	; ---
	Return 1
EndFunc

Func __GEng_Text_IsFont(ByRef $hFont)
	If UBound($hFont) <> 3 Then Return SetError(1, 0, 0)
	; ---
	Return 1
EndFunc