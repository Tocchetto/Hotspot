#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

HotKeySet("{ESC}", "Terminate")

Func Terminate()
   Exit 1
EndFunc


main()

Func main()
   #Region ### START Koda GUI section ### Form=C:\Users\Zelp\Google Drive\Pessoal\Bots\Hotspot\Interface.kxf
   $Interface = GUICreate("WIFI - HOTSPOT", 469, 129, 248, 373)
   $nameLabel = GUICtrlCreateLabel("Network name:", 8, 8, 76, 17)
   $passwordLabel = GUICtrlCreateLabel("Network password:", 8, 72, 95, 17)
   $nameInput = GUICtrlCreateInput("", 8, 32, 201, 21)
   $passwordInput = GUICtrlCreateInput("", 8, 96, 201, 21, $ES_PASSWORD)
   $startButton = GUICtrlCreateButton("Start Network", 256, 32, 83, 25)
   $stopButton = GUICtrlCreateButton("Stop Network", 360, 32, 83, 25)
   GUISetState(@SW_SHOW)
   #EndRegion ### END Koda GUI section ###
   $conectionProgressBar = GuiCtrlCreateProgress(300,70,100,20) ;Just for fun

   While 1
	  $nMsg = GUIGetMsg()
	  If not IsAdmin() Then
		 MsgBox(48,"Warning", "For this to work, you have ot run the program as an administrator!")
		 Exit 1
	  EndIf
	  Switch $nMsg
		 Case $GUI_EVENT_CLOSE
			Exit
		 Case $startButton
			GUICtrlSetData($conectionProgressBar, 0)
			GUICtrlSetData($conectionProgressBar, 100)
			Sleep(700)
			If GUICtrlRead($nameInput) == "" Then
			   MsgBox(16, "Error", "You have to enter a name to the network!")
			   GUICtrlSetData($conectionProgressBar, 0)
			ElseIf StringLen(GuiCtrlRead($passwordInput)) < 8 Then
			   MsgBox(16, "Error", "You have to enter a password that has more than 8 characters!")
			   GUICtrlSetData($conectionProgressBar, 0)
			Else
			   RunWait(@ComSpec & " /c " & "netsh wlan set hostednetwork mode=allow ssid="& GUICtrlRead($nameInput) & " key=" & GuiCtrlRead($passwordInput) & " keyUsage=persistent", @TempDir, @SW_HIDE)
			   MsgBox(0, "Success", "Network started!")
			EndIf
		 Case $stopButton
			GUICtrlSetData($conectionProgressBar, 0)
			GUICtrlSetData($conectionProgressBar, 100)
			Sleep(700)
			RunWait(@ComSpec & " /c " & "netsh wlan stop hostednetwork", @TempDir, @SW_HIDE)
			MsgBox(0, "Success", "Network stoped!")
	  EndSwitch
   WEnd
EndFunc
