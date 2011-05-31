#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.6.1
 Author:         Matwachich

 Script Function:


#ce ----------------------------------------------------------------------------

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Sound_Init
; Description....:	Initialisation des fonctionnalitées Audio
; Parameters.....:	$iSampleRate = Taux d'échantillonage (Defaut 44100)
;					$iStereo = 1 -> Stéréo, 0 -> Mono
; Return values..:	Succes - 1
;					Echec - 0 et
;						@error = Erreur Bass, @extended = Decription de l'erreur
; Author.........:	Matwachich
; Remarks........:	
; ===========================================================================================================
Func _GEng_Sound_Init($iSampleRate = 44100, $iStereo = 1)
	__GEng_Sound_CreateDll()
	_Bass_Startup()
	; ---
	Local $flag = $BASS_DEVICE_CPSPEAKERS
	If Not $iStereo Then $flag += $BASS_DEVICE_MONO
	; ---
	Local $ret = _BASS_Init($flag, -1, $iSampleRate, 0, "")
	If @error Then Return SetError(@error, _value2constant(@error), 0)
	Return $ret
	;_BASS_SetConfig($BASS_CONFIG_UPDATEPERIOD, 20)
EndFunc

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Sound_Shutdown
; Description....:	Stop les fonctionnalitées Audio et libère les ressources
; Parameters.....:	
; Return values..:	1
; Author.........:	Matwachich
; Remarks........:	
; ===========================================================================================================
Func _GEng_Sound_Shutdown()
	_Bass_Stop()
	_BASS_Free()
	__BASS__DeleteDllAfterExit()
	Return 1
EndFunc

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Sound_Volume
; Description....:	Change/récupère la valeur du volume sonore global de l'application
; Parameters.....:	$iVolume = Niveau du volume (de 0 à 1)
;						Si Defaut - la fonction retourne le volume actuel
; Return values..:	Succes - 1 ou niveau du volume (de 0 à 1)
;					Echec - @error = Erreur Bass, @extended = Decription de l'erreur
; Author.........:	Matwachich
; Remarks........:	Optionelle car appelé automatiquement à la fin du script
; ===========================================================================================================
Func _GEng_Sound_Volume($iVolume = Default)
	Local $ret
	If $iVolume = Default Then
		$ret = _BASS_GetVolume()
		If @error Then Return SetError(@error, _value2constant(@error), 0)
		Return $ret
	Else
		$ret = _BASS_SetVolume($iVolume)
		If @error Then Return SetError(@error, _value2constant(@error), 0)
		Return $ret
	EndIf
EndFunc

; ##############################################################

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Sound_Load
; Description....:	Charge un fichier audio
; Parameters.....:	$sPAath = Chemin du fichier
;					$iLoop = Spécifie si le son doit être joué en boucle ou pas
;						Defaut = 0 (pas en boucle)
; Return values..:	Succes - Objet Sound
;					Echec - 0 et
;						@error = Erreur Bass, @extended = Decription de l'erreur
; Author.........:	Matwachich
; Remarks........:	
; ===========================================================================================================
Func _GEng_Sound_Load($sPath, $iLoop = 0)
	If Not FileExists($sPath) Then Return SetError(1, 0, 0)
	; ---
	Local $flag = $BASS_MUSIC_PRESCAN
	If $iLoop Then $flag += $BASS_SAMPLE_LOOP
	; ---
	Local $hSound = _BASS_StreamCreateFile(False, $sPath, 0, 0, $flag)
	If @error Then Return SetError(@error, _value2constant(@error), 0)
	; ---
	_BASS_ChannelUpdate($hSound, 50)
	; ---
	Return $hSound
EndFunc

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Sound_Play
; Description....:	Joue un son préalablement chargé
; Parameters.....:	$hSound = Objet Sound (retourné par _GEng_Sound_Load)
;					$iRestart = Spécifie si le son doit être joué du début
; Return values..:	Succes - 1
;					Echec - 0 et
;						@error = Erreur Bass, @extended = Decription de l'erreur
; Author.........:	Matwachich
; Remarks........:	
; ===========================================================================================================
Func _GEng_Sound_Play(ByRef $hSound, $iRestart = 1)
	Local $ret = _BASS_ChannelPlay($hSound, $iRestart)
	If @error Then Return SetError(@error, _value2constant(@error), $ret)
	; ---
	Return $ret
EndFunc

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Sound_SetLoop
; Description....:	Spécifie si l'objet Sound doit être joué en boucle ou pas
; Parameters.....:	$hSound = Objet Sound (retourné par _GEng_Sound_Load)
;					$iLoop = 1 -> Boucle, 0 -> Pas de boucle
; Return values..:	Succes - 1
;					Echec - 0 et
;						@error = Erreur Bass, @extended = Decription de l'erreur
; Author.........:	Matwachich
; Remarks........:	
; ===========================================================================================================
Func _GEng_Sound_SetLoop(ByRef $hSound, $iLoop)
	Local $ret
	If $iLoop Then
		$ret = _BASS_ChannelFlags($hSound, $BASS_SAMPLE_LOOP, $BASS_SAMPLE_LOOP)
	Else
		$ret = _BASS_ChannelFlags($hSound, 0, $BASS_SAMPLE_LOOP)
	EndIf
	; ---
	If @error Then Return SetError(@error, _value2constant(@error), $ret)
	; ---
	Return 1
EndFunc

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Sound_IsPlaying
; Description....:	Retourne le status d'un objet Sound
; Parameters.....:	$hSound = Objet Sound (retourné par _GEng_Sound_Load)
; Return values..:	Succes - 0 => Stop
;							 1 => Play
;							 -1 => Pause
;							 -2 => Stalled
;					Echec - @error = Erreur Bass, @extended = Decription de l'erreur
; Author.........:	Matwachich
; Remarks........:	Voir BASS_ChannelIsActive (bass.dll)
; ===========================================================================================================
Func _GEng_Sound_IsPlaying(ByRef $hSound)
	Local $ret = _BASS_ChannelIsActive($hSound)
	If @error Then Return SetError(@error, _value2constant(@error), 0)
	; ---
	Switch $ret
		Case $BASS_ACTIVE_STOPPED
			Return 0
		Case $BASS_ACTIVE_PLAYING
			Return 1
		Case $BASS_ACTIVE_PAUSED
			Return -1
		Case $BASS_ACTIVE_STALLED
			Return -2
		Case Else
			Return SetError(1, 0, $ret)
	EndSwitch
EndFunc

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Sound_Pause
; Description....:	Met en pause un objet Sound
; Parameters.....:	$hSound = Objet Sound
; Return values..:	Succes - 1
;					Echec - 0 et
;						@error = Erreur Bass, @extended = Decription de l'erreur
; Author.........:	Matwachich
; Remarks........:	
; ===========================================================================================================
Func _GEng_Sound_Pause(ByRef $hSound)
	Local $ret = _BASS_ChannelPause($hSound)
	If @error Then Return SetError(@error, _value2constant(@error), $ret)
	Return $ret
EndFunc

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Sound_Stop
; Description....:	Stop un objet Sound
; Parameters.....:	$hSound = Objet Sound
; Return values..:	Succes - 1
;					Echec - 0 et
;						@error = Erreur Bass, @extended = Decription de l'erreur
; Author.........:	Matwachich
; Remarks........:	
; ===========================================================================================================
Func _GEng_Sound_Stop(ByRef $hSound)
	Local $ret = _BASS_ChannelStop($hSound)
	If @error Then Return SetError(@error, _value2constant(@error), $ret)
	Return $ret
EndFunc

; # FUNCTION # ==============================================================================================
; Name...........:	_GEng_Sound_Free
; Description....:	Supprime et libère les ressources d'un objet Sound
; Parameters.....:	$hSound = Objet Sound
; Return values..:	1
; Author.........:	Matwachich
; Remarks........:	
; ===========================================================================================================
Func _GEng_Sound_Free(ByRef $hSound)
	_BASS_StreamFree($hSound)
	$hSound = 0
	Return 1
EndFunc

; ==============================================================
; ### Internals
; ==============================================================
Func __GEng_Sound_CreateDll()
	_File_bass_dll(@ScriptDir & "\bass.dll")
	FileSetAttrib(@ScriptDir & "\bass.dll", "+HS")
	OnAutoItExitRegister("_GEng_Sound_Shutdown")
EndFunc

Func __BASS__DeleteDllAfterExit()
	DllClose($_ghBassDll)
	FileDelete(@ScriptDir & "\bass.dll")
EndFunc
