#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.6.1
 Author:         Matwachich

 Script Function:


#ce ----------------------------------------------------------------------------

#Region ### Functions ###
#cs
- Main Functions
	_GEng_Sprite_ExtInfoAdd(ByRef $hSprite, $Info)
	_GEng_Sprite_ExtInfoSet(ByRef $hSprite, $index, $Info)
	_GEng_Sprite_ExtInfoGet(ByRef $hSprite, $index)
#ce
#EndRegion ###


Func _GEng_Sprite_ExtInfoAdd(ByRef $hSprite, $Info)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	Local $uB = UBound($hSprite)
	ReDim $hSprite[$uB + 1]
	$hSprite[$uB] = $Info
	Return $uB + 1 - $__GEng_SpritesArrayUB
EndFunc

Func _GEng_Sprite_ExtInfoSet(ByRef $hSprite, $index, $Info)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	If $index > UBound($hSprite) - 1 Then Return SetError(1, 0, 0)
	; ---
	$hSprite[$__GEng_SpritesArrayUB + $index - 1] = $Info
	Return 1
EndFunc

Func _GEng_Sprite_ExtInfoGet(ByRef $hSprite, $index)
	If Not __GEng_Sprite_IsSprite($hSprite) Then Return SetError(1, 0, 0)
	; ---
	If $index > UBound($hSprite) - 1 Then Return SetError(1, 0, 0)
	; ---
	Return $hSprite[$__GEng_SpritesArrayUB + $index - 1]
EndFunc
