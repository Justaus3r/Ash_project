@echo off
CD /D "%~dp0"
set /p updatedlink=<"%~dp0linkv.vr"
call :Download "%updatedlink%" Updated_package.Ecx
:Download
echo strFileURL = "%~1" > Download.vbs
echo     strHDLocation = "%CD%\%~2" >> Download.vbs
echo     Set objXMLHTTP = CreateObject("MSXML2.ServerXMLHTTP") >> Download.vbs
echo     objXMLHTTP.open "GET", strFileURL, false >> Download.vbs
echo objXMLHTTP.send() >> Download.vbs
echo If objXMLHTTP.Status = 200 Then >> Download.vbs
echo Set objADOStream = CreateObject("ADODB.Stream") >> Download.vbs
echo objADOStream.Open>> Download.vbs
echo objADOStream.Type = 1 >> Download.vbs
echo objADOStream.Write objXMLHTTP.ResponseBody >> Download.vbs
echo objADOStream.Position = 0    >> Download.vbs
echo Set objFSO = Createobject("Scripting.FileSystemObject") >> Download.vbs
echo If objFSO.Fileexists(strHDLocation) Then objFSO.DeleteFile strHDLocation >> Download.vbs
echo Set objFSO = Nothing >> Download.vbs
echo objADOStream.SaveToFile strHDLocation >> Download.vbs
echo objADOStream.Close >> Download.vbs
echo Set objADOStream = Nothing >> Download.vbs
echo End if >> Download.vbs
echo Set objXMLHTTP = Nothing >> Download.vbs
cscript Download.vbs >nul 2>&1
del Download.vbs
exit /b
