;#NoTrayIcon

OnMessage(0x202, "CheckSelectText")

~LButton::
	WinGetActiveTitle,Title
	if Title = LikaciGet2Search
		Return
	WinGetText, Text2Search,A
	if Text2Search = 
		Return
	ShowGui()
Return

ShowGui()
{
	global
	Gui, Destroy
	Gui, Font, S12
	Gui, Add, Edit,w323 -WantReturn,%Text2Search%
	Gui, Font,
	Gui, Add,Button,y+10 Default gSearchExit,搜索并退出(&h)
	Gui, Add,Button,x+10 gSearch,搜索(&j)
	Gui, Add,Button,x+10 gCopyExit,复制并退出(&k)
	Gui, Add,Button,x+10 gCopy,复制(&l)
	Gui, Show,,LikaciGet2Search
}

;当用户在Edit控件中点击之后，运行下面的函数，用了检查是否选中文字。
CheckSelectText()
{
	global
	ControlGetFocus,Focus,A
	if Focus != Edit1
		Return
	ClipboardSaved := Clipboard
	Clipboard =
	send,{LButton up}
	Send, ^c
	ClipWait, 0
	if !ErrorLevel
		Text2Search := clipboard
	clipboard := ClipboardSaved
}

SearchExit:
	Gui, Submit
	Run,https://www.google.com/webhp?ie=UTF-8&hl=zh-CN#hl=zh-CN&q=%Text2Search%
	goto GuiClose
Return

Search:
	Gui, Submit
	Run,https://www.google.com/webhp?ie=UTF-8&hl=zh-CN#hl=zh-CN&q=%Text2Search%
Return

copyExit:
	Gui, Submit
	clipboard := Text2Search
	goto GuiClose
Return

copy:
	Gui, Submit
	clipboard := Text2Search
Return

GuiClose:
	ExitApp
Return

GuiEscape:
	gui,Hide
Return
