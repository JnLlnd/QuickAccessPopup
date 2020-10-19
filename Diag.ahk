;------------------------------------------------
Diag(strName, strData, strStartElapsedStop, blnForceForFirstStartup := false)
;------------------------------------------------
{
	static s_intStartTick
	static s_intStartFullTick
	static s_intStartShowTick
	static s_intStartCollectTick

	if !(o_Settings.Launch.blnDiagMode.IniValue or blnForceForFirstStartup)
		return
	
	FormatTime, strNow, %A_Now%, yyyyMMdd@HH:mm:ss
	strDiag := strNow . "." . A_MSec . "`t" . strName . "`t" . strData
	
	if StrLen(strStartElapsedStop)
	{
		strDiag .= "`t" . strStartElapsedStop . "`t" . A_TickCount
		
		if (strStartElapsedStop = "START-REFRESH")
			s_intStartFullTick := A_TickCount
		else if (strStartElapsedStop = "START-SHOW")
			s_intStartShowTick := A_TickCount
		else if (strStartElapsedStop = "START-COLLECT")
			s_intStartCollectTick := A_TickCount
		else if (strStartElapsedStop = "START")
			s_intStartTick := A_TickCount
		else if InStr(strStartElapsedStop, "-REFRESH") ; ELAPSED-REFRESH or STOP-REFRESH
		{
			intTicksAll := A_TickCount - s_intStartFullTick
			strDiag .= "`t" . intTicksAll . "`t" . (intTicksAll > 500 ? "*FLAG1*" : "")
		}
		else if InStr(strStartElapsedStop, "-SHOW") ; ELAPSED-SHOW or STOP-SHOW
		{
			intTicksShow := A_TickCount - s_intStartShowTick
			strDiag .= "`t" . intTicksShow . "`t" . (intTicksShow > 1000 ? "*FLAG2*" : "")
		}
		else if InStr(strStartElapsedStop, "-COLLECT") ; ELAPSED-COLLECT or STOP-COLLECT
		{
			intTicksCollect := A_TickCount - s_intStartCollectTick
			strDiag .= "`t" . intTicksCollect . "`t" . (intTicksCollect > 2000 ? "*FLAG3*" : "")
		}
		else ; ELAPSED
		{
			intTicks := A_TickCount - s_intStartTick
			strDiag .= "`t" . intTicks . "`t" . (intTicks > 2000 and strStartElapsedStop <> "ELAPSED" ? "*FLAG4*" : "")
		}
	}

	; g_strDiagFile := A_WorkingDir . "\" . g_strAppNameFile . "-DIAG.txt"
	strDiagFile := (blnForceForFirstStartup ? StrReplace(g_strDiagFile, "DIAG", "1st_STARTUP") : g_strDiagFile)
	loop
	{
		FileAppend, %strDiag%`n, %strDiagFile%
		if ErrorLevel
			Sleep, 20
	}
	until !ErrorLevel or (A_Index > 50) ; after 1 second (20ms x 50), we have a problem
	
	if (strStartElapsedStop = "STOP")
		s_intStartTick := ""
	else if (strStartElapsedStop = "STOP-REFRESH")
		s_intStartFullTick := ""
	else if (strStartElapsedStop = "STOP-SHOW")
		s_intStartShowTick := ""
	else if (strStartElapsedStop = "STOP-COLLECT")
		s_intStartCollectTick := ""
}
;------------------------------------------------


