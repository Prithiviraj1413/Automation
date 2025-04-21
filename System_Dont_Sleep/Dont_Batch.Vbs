Set objShell = CreateObject("WScript.Shell")

Do
    objShell.SendKeys "{NUMLOCK}"
    WScript.Echo "Num Lock key sent at " & Now
    WScript.Sleep 60000 ' Sleep for 1 minute
Loop
