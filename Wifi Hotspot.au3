#include <Misc.au3>
#include <Date.au3>

HotKeySet("{ESC}", "Terminate")

Func Terminate()
   Exit 1
EndFunc

main()

Func main()
   MsgBox(0,"WIFI - HOTSPOT", "Welcome to this simple Wifi Hotspot setup!" & @CRLF & @CRLF & "Remember to run this program as administrator")
   $networkName = InputBox("WIFI - HOTSPOT", "Network name: ", "", "", 200, 130)
   $networkPassword = InputBox("WIFI - HOTSPOT", "Network password: ", "", "", 200, 130)
   RunWait(@ComSpec & " /c " & "netsh wlan set hostednetwork mode=allow ssid= "& $networkName & " key= " & $networkPassword & " keyUsage=persistent", @TempDir, @SW_HIDE)
   MsgBox(0,"WIFI - HOTSPOT", "All done.") ;If this doesn't work, please be sure that you executed this program with administrator privileges
EndFunc
