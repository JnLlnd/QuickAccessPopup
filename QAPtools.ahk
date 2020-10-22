;===============================================
/*

Library QAPtools.ahk

v1.0 (2020-10-19): Diag and Url2Var

*/

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


;------------------------------------------------------------
Url2Var(strUrl)
; SAME AS IN QAP SOURCE CODE - INTEGRATE BETTER IF IT SOLVE THE CHECK LICENSE ISSUE
; WinHttp.WinHttpRequest.5.1 and MSXML2.XMLHTTP.6.0 properties:
; 	.GetAllResponseHeaders()
; 	.ResponseText()
; 	.ResponseBody()
; 	.StatusText()
; 	.Status() ; numeric value 200 is success
; see https://docs.microsoft.com/en-us/windows/win32/winhttp/winhttprequest
; see https://www.autohotkey.com/boards/viewtopic.php?f=76&t=66685
;------------------------------------------------------------
{
	strUrl .= (InStr(strUrl, "?") ? "&" : "?") . "cache-breaker=" . A_NowUTC
	
	loop, parse, % "MSXML2.XMLHTTP.6.0|WinHttp.WinHttpRequest.5.1", | ; if MSXML2.XMLHTTP.6.0 don't work, try WinHttp.WinHttpRequest.5.1
	{
		oHttpRequest := ComObjCreate(A_LoopField)
		oHttpRequest.Open("GET", strUrl)
		oHttpRequest.SetRequestHeader("Pragma", "no-cache")
		oHttpRequest.SetRequestHeader("Cache-Control", "no-cache, no-store")
		oHttpRequest.SetRequestHeader("If-Modified-Since", "Sat, 1 Jan 2000 00:00:00 GMT")
		oHttpRequest.Send()
		
		Diag(A_ThisFunc . " URL Root", (InStr(strUrl, "?") ? SubStr(strUrl, 1, InStr(strUrl, "?") - 1) : strUrl), "")
		Diag(A_ThisFunc . " URL", strUrl, "")
		Diag(A_LoopField . " Status" , oHttpRequest.Status(), "")
		Diag(A_LoopField . " StatusText" , oHttpRequest.StatusText(), "")
		Diag(A_LoopField . " GetAllResponseHeaders" , StrReplace(oHttpRequest.GetAllResponseHeaders(), Chr(13) . Chr(10), "|"), "")
		Diag(A_LoopField . " ResponseText" , oHttpRequest.ResponseText(), "")
		
		if (oHttpRequest.StatusText() = "OK") and StrLen(oHttpRequest.ResponseText())
			break
	}

	return oHttpRequest.ResponseText()
}
;------------------------------------------------------------


