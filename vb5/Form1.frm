VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Begin VB.Form Form1 
   Appearance      =   0  'Flat
   AutoRedraw      =   -1  'True
   BackColor       =   &H80000005&
   Caption         =   "  PALE - Pete's Amazing Lynx Emulator"
   ClientHeight    =   6960
   ClientLeft      =   45
   ClientTop       =   345
   ClientWidth     =   6435
   Icon            =   "Form1.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   ScaleHeight     =   6960
   ScaleWidth      =   6435
   Begin VB.Timer Timer2 
      Enabled         =   0   'False
      Interval        =   2000
      Left            =   1800
      Top             =   5400
   End
   Begin VB.PictureBox Picture1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   5010
      Left            =   0
      ScaleHeight     =   5010
      ScaleWidth      =   5925
      TabIndex        =   0
      Top             =   0
      Width           =   5925
      Begin MSComDlg.CommonDialog CommonDialog1 
         Left            =   2640
         Top             =   3720
         _ExtentX        =   688
         _ExtentY        =   688
         _Version        =   393216
      End
      Begin VB.Timer Timer3 
         Enabled         =   0   'False
         Interval        =   100
         Left            =   3960
         Top             =   3360
      End
      Begin VB.Label lblFPS 
         BackStyle       =   0  'Transparent
         Caption         =   "0"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000E&
         Height          =   372
         Left            =   1920
         TabIndex        =   3
         Top             =   0
         Visible         =   0   'False
         Width           =   852
      End
      Begin VB.Label lblLocked 
         BackStyle       =   0  'Transparent
         Caption         =   "Locked"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000E&
         Height          =   372
         Left            =   120
         TabIndex        =   1
         Top             =   0
         Visible         =   0   'False
         Width           =   852
      End
   End
   Begin VB.Label Label1 
      BackStyle       =   0  'Transparent
      Caption         =   "Locked"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   372
      Left            =   0
      TabIndex        =   2
      Top             =   0
      Visible         =   0   'False
      Width           =   852
   End
   Begin VB.Menu mnuPopup 
      Caption         =   "Popup"
      Visible         =   0   'False
      Begin VB.Menu mnuLoadTape 
         Caption         =   "Load Tape"
         Begin VB.Menu mnuLoadBasBin 
            Caption         =   "Basic/Binary"
         End
         Begin VB.Menu mnuLoadData 
            Caption         =   "Data (No name)"
         End
         Begin VB.Menu mnuLoadLev9 
            Caption         =   "Level9 Set"
         End
      End
      Begin VB.Menu mnuSaveTape 
         Caption         =   "Save Tape"
      End
      Begin VB.Menu def7 
         Caption         =   "-"
      End
      Begin VB.Menu mnuRun 
         Caption         =   "Run"
      End
      Begin VB.Menu mnuStop 
         Caption         =   "Stop"
      End
      Begin VB.Menu mnuReset 
         Caption         =   "Reset Lynx"
      End
      Begin VB.Menu def8 
         Caption         =   "-"
      End
      Begin VB.Menu mnuSpeed 
         Caption         =   "Speed"
         Begin VB.Menu mnu25perc 
            Caption         =   "25%"
         End
         Begin VB.Menu mnu50perc 
            Caption         =   "50%"
         End
         Begin VB.Menu mnu100perc 
            Caption         =   "100%"
            Checked         =   -1  'True
         End
         Begin VB.Menu mnu200perc 
            Caption         =   "200%"
         End
         Begin VB.Menu mnu400perc 
            Caption         =   "400%"
         End
      End
      Begin VB.Menu mnuSound 
         Caption         =   "Sound"
         Begin VB.Menu mnuROMSound 
            Caption         =   "ROM"
            Checked         =   -1  'True
         End
         Begin VB.Menu mnuMCSound 
            Caption         =   "MC"
         End
      End
      Begin VB.Menu mnuMachine 
         Caption         =   "Machine"
         Begin VB.Menu mnuL48 
            Caption         =   "Lynx 48K"
         End
         Begin VB.Menu mnuL96 
            Caption         =   "Lynx 96K"
         End
         Begin VB.Menu mnuL128 
            Caption         =   "Lynx 128K"
         End
      End
      Begin VB.Menu mnuFullscreen 
         Caption         =   "Fullscreen"
      End
      Begin VB.Menu def5 
         Caption         =   "-"
      End
      Begin VB.Menu mnuStatus 
         Caption         =   "Status Display"
      End
      Begin VB.Menu def3 
         Caption         =   "-"
      End
      Begin VB.Menu mnuLanguage 
         Caption         =   "Language"
         Begin VB.Menu mnuEnglish 
            Caption         =   "English"
            Checked         =   -1  'True
         End
         Begin VB.Menu mnuFrench 
            Caption         =   "French"
         End
      End
      Begin VB.Menu mnuHelp 
         Caption         =   "Help"
      End
      Begin VB.Menu mnuExit 
         Caption         =   "Exit"
      End
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Const LYNX_ORIGINAL_KEYDEL_4896HW As Integer = 229
Const LYNX_ORIGINAL_KEYREP_4896HW As Integer = 223
Const LYNX_ORIGINAL_KEYDEL_128HW As Integer = 229
Const LYNX_ORIGINAL_KEYREP_128HW As Integer = 223

Const LYNX_HARDWARE_4896 As Integer = 0
Const LYNX_HARDWARE_128 As Integer = 1
Const LYNX_HARDWARE_HACKSPECCY As Integer = 2


Dim menu_run As Integer
Dim menu_load As Integer
Dim menu_stop As Integer

Dim totc As Integer
Dim stop_emu As Integer
Dim now_shift As Byte
Dim andy1 As Integer  'this is acually the speed setin in combo box
Dim noof_cycs_sec As Long
Dim noof_cycs_done As Long
Dim fred As Integer
Dim keyflip As Boolean
Dim curfps As Long

Dim save_left As Integer
Dim save_top As Integer
Dim save_width As Integer
Dim save_height As Integer
Dim save_pwidth As Integer
Dim save_pheight As Integer
Dim emu_running As Integer
Dim orig_keydel As Integer
Dim orig_keyrep As Integer
Dim set1(64) As Byte
Dim set2(64) As Byte

Dim cursec As Integer


Public Sub dump_disassembly()
Dim retr, f, l_count
        retr = disassemble(query(0), jogval, dis_bank)
        If retr <> 0 Then
            'Okay, PC address should be the 6th line of the output text
            f = 0
            l_count = 0
            Form2.txtDisas.Text = ""
            While query(f) <> 0 And f < 500
                Form2.txtDisas.Text = Form2.txtDisas.Text + Chr$(query(f))
                If query(f) = Asc(vbLf) Then
                    l_count = l_count + 1
                    If l_count = 5 Then Form2.txtDisas.Text = Form2.txtDisas.Text + "->"
                End If
                f = f + 1
            Wend
      '  Else
       '     MsgBox "OOOOER"
        End If
End Sub

Public Sub update_diskstat()
Dim retr, f As Integer


Dim command As Byte, data As Byte, epenable As Byte, motor As Byte, precomp As Byte
Dim doptions As Byte, steprate As Byte, status As Byte, drive As Byte, head As Byte, track As Byte, sector As Byte
Dim raw_motor As Long

    'get_diskstat1(command, data, epenable, motor, precomp, steprate)
    'get_diskstat2(drive, head, track, sector)
    retr = get_diskstat1(set1(0))
    retr = get_diskstat2(set2(0))
  
'  MsgBox "set1=" + str(set1(0)) + str(set1(1)) + str(set1(2)) + str(set1(3)) + str(set1(4)) + str(set1(5))
  
    command = set1(0)
    data = set1(1)
    epenable = set1(2)
    motor = set1(3)
    precomp = set1(4)
    steprate = set1(5)
    
    drive = set2(0)
    head = set2(1)
    track = set2(2)
    sector = set2(3)
    status = set2(4)
    doptions = set2(5)
    
    
    Form5.txtCommand.Text = Hex$(command)
    Form5.txtData.Text = Hex$(data)
    If epenable = 1 Then Form5.txtEpenable.Text = "Enabled" Else Form5.txtEpenable.Text = "Disabled"
    
  
'If get_diskrom_enabled() = 1 Then
'  Form2.Label32.Visible = True
'Else
'  Form2.Label32.Visible = False
'End If
    
    
    If motor = 1 Then Form5.txtMotor.Text = "ON" Else Form5.txtMotor.Text = "OFF"
    If precomp = 1 Then Form5.txtPrecomp.Text = "NO" Else Form5.txtPrecomp.Text = "YES"
    If steprate = 1 Then Form5.txtSteprate.Text = "125ns" Else Form5.txtSteprate.Text = "250ns"
    Form5.txtDrive.Text = Hex$(drive)
    Form5.txtHead.Text = Hex$(head)
    Form5.txtTrack.Text = Hex$(track)
    Form5.txtSector.Text = Hex$(sector)
    Form5.txtDiskstat.Text = Hex$(status)
    Form5.txtOptions.Text = Hex$(doptions)

'UPDATE TAPE STATUS 24000000/32768=732
 '   Form5.lbl44.Caption = ((Val(Form5.cmbRawbuf.List(Form5.cmbRawbuf.ListIndex)) * 1024000) / 32768)
   ' Form5.lbl44.Caption = Val(Form5.cmbRawbuf.List(Form5.cmbRawbuf.ListIndex)) * 1024000
    
    'there is another one of these lines in the Tape form itself
    Form5.hscTape.Value = get_raw_position() / ((Val(Form5.cmbRawbuf.List(Form5.cmbRawbuf.ListIndex)) * 1024000) / 32767)
    
    
    
    Form5.txtRawposition = str(get_raw_position())       'yeah wasteful i know :)
    
    Form5.txtRawsamples = str(get_raw_samples())
    
    Form5.txtTapelevel = str(get_tape_level())
 '   Form5.Text1 = str(get_tape_icount())
   
   Form5.txtRawThresh.Text = Hex$(get_raw_threshold())
    raw_motor = get_raw_motor()
    If raw_motor = 1 Then
        Form5.txtRawmotor = "ON"
    Else
        Form5.txtRawmotor = "OFF"
    End If
    

End Sub





Public Sub Update_Statwindow()
Dim retr, f As Integer
       retr = query_emulator(query(0), query2(0), query3(0), query4(0))
    
        Form2.Text5.Text = ""
        f = 0
        While query(f) <> 0 And f < 200
        Form2.Text5.Text = Form2.Text5.Text + Chr$(query(f))
        f = f + 1
        Wend
        Form2.Text13.Text = ""
        f = 0
        While query2(f) <> 0 And f < 200
        Form2.Text13.Text = Form2.Text13.Text + Chr$(query2(f))
        f = f + 1
        Wend
        Form2.Text14.Text = ""
        f = 0
        While query3(f) <> 0 And f < 200
        Form2.Text14.Text = Form2.Text14.Text + Chr$(query3(f))
        f = f + 1
        Wend
    '    f = 0
    '    While query4(f) <> 0 And f < 200
     '   Form6.txtTraplist.Text = Form6.txtTraplist.Text + Chr$(query4(f))
      '  f = f + 1
       ' Wend
        Form2.RefreshRegs
        If dump_6845 = 1 Then
            retr = query_6845(query(0), query2(0), query3(0), query4(0))
            Form2.Text1.Text = ""
            f = 0
            While query3(f) <> 0 And f < 200
            Form2.Text1.Text = Form2.Text1.Text + Chr$(query3(f))
            f = f + 1
            Wend
            Form2.Text2.Text = ""
            f = 0
            While query4(f) <> 0 And f < 200
            Form2.Text2.Text = Form2.Text2.Text + Chr$(query4(f))
            f = f + 1
            Wend
            'Sound Status
            retr = query_sound(query(0), query2(0), query3(0), query4(0))
            Form2.txtSoundstat.Text = ""
            f = 0
            While query3(f) <> 0 And f < 200
            Form2.txtSoundstat.Text = Form2.txtSoundstat.Text + Chr$(query3(f))
            f = f + 1
            Wend
        End If
        If dump_disas = 1 Then dump_disassembly
        
      


        
End Sub






Public Sub RunEmu()
Dim f, g As Integer
Dim a
Dim h As Long, w As Long, ret As Long
Dim retr As Integer
  
If dump_sysvar = 1 And Form8.WindowState = vbNormal Then Form8.Timer1.Enabled = True
If dump_memmap = 1 And Form11.WindowState = vbNormal Then Form11.Timer1.Enabled = True

keyflip = False
While stop_emu = 0
    If crtc_change() = 1 Then
        CreateScreenBuffer
    End If
    ret = run_emulator()
  '  ret = run_emulator()
    If ret = 99 Then stop_emu = 1
    If dump_status = 1 Then Update_Statwindow
    If dump_diskstat = 1 Then update_diskstat       'doubles as the Tape Status as well
    'If dump_cpmvars = 1 Then update_cpmvars
  'DoEvents
    w = Form1.ScaleWidth / Screen.TwipsPerPixelX
    h = Form1.ScaleHeight / Screen.TwipsPerPixelY
    ret = get_video_scanvers(Form1.Picture1.hdc, w, h, bmiBuffer, Fix_6845, crtc_regs(0))
  'ret = 1
  
  DoEvents

    'now work out things that are based on a one second basis
    'so first divide everything until I get a 1 Hz kicker
    If vidmode = 0 Then
        cursec = cursec + 1
    Else
        cursecdiv = cursecdiv + 1
        If cursecdiv = 252 Then
            cursec = cursec + 1
            cursecdiv = 0
        End If
    End If
    If cursec = 25 Then      'okay 1Hz here
       If (Form2.chkShowFPS.Value = vbChecked) Then Form5.lblFPS.Caption = str(curfps) + " FPS"
    '    curfps = 0
        cursec = 0
        If tsec > 0 Then tsec = tsec - 1
        If tsec = 2 Then
             tsec = 0
             load (load_type)
             Form1.SetFocus
        End If
    End If

    If (Form2.chkShowFPS.Value = vbChecked) Then
        Form5.lblFPS.Visible = True
        If ret = 1 Then
              'If vidmode = 0 Then
                  curfps = curfps + 1
              'Else
              '    curfpsdiv = curfpsdiv + 1
               '   If curfpsdiv = 252 Then
                '      curfps = curfps + 1
                 '     curfpsdiv = 0
                 ' End If
              'End If
        
              
              If curfps > 1000 Then curfps = 0
         End If
    End If

    'check to see if any printer stuff done
    If frmPrinter.Visible = True Then
        printer_inbuflen = get_printer_data(printer_inbuf(0))
        If printer_inbuflen > 0 Then frmPrinter.print_the_data
    End If
    
    If Form18.Visible = True Then
        retr = get_jk(jkmap(0))
        Form18.Refresh
    End If
    
Wend
stop_emu = 0
'Form2.Label38.Caption = "Sysclock=" + str(get_sysclock)
'Form5.Label8.Caption = "ClockDiff=" + str(get_clock_time_diff)
'Form1.Label3.Caption = "w is " + str(w) + "  h is " + str(h)
    
'Form1.Label9.Caption = "F1 scalwid=" + str(Form1.ScaleWidth) + "F1 scalheight=" + str(Form1.ScaleHeight)
'Form1.Label10.Caption = "F1 wid=" + str(Form1.Width) + "F1 height=" + str(Form1.Height)
'Form1.Label9.Refresh
'Form1.Label10.Refresh
    
    


'Form1.Label10.Caption = "screen TWIP per Pix X=" + str(Screen.TwipsPerPixelX) + "Screen TWIP per Y=" + str(Screen.TwipsPerPixelY)
'Form1.Label11.Caption = "src WID is " + str(crtc_regs(1) * 8) + " SRC Height is " + str(crtc_regs(6) * 4)
'Form1.Label2.Caption = "biWidth=" + str(bmiBuffer.bmiHeader.biWidth) + " biHeight=" + str(bmiBuffer.bmiHeader.biHeight)

  '  Form1.Picture1.Visible = False
 '       ret = get_video_scanvers(gcBufferBits(0),
   '                             Form1.Picture1.hdc,
   '                             w,
   '                             h,
   '                             bmiBuffer,
   '                             Fix_6845,
  '                              crtc_regs(0))
  '  Form1.Picture1.Visible = True
  '  curfps = curfps + 1
  '  If curfps > 200 Then curfps = 0

End Sub

Public Sub StopEmu()

stop_emu = 1

If Form8.WindowState = vbNormal Then Form8.Timer1.Enabled = False
If Form11.WindowState = vbNormal Then Form11.Timer1.Enabled = False


End Sub


Public Sub ResetEmu()
Dim ret, g, a

stop_emu = 1

DoEvents
'This delay seems to be needed to get round a crash MAYBE at this point !!!
 'its the COULDNT LPAD ROM bug
    'Possibly fixed by now (was the order in which forms were killed
    'solved in the end by exit(-1) from the DLL <-- Bodge
  '   For g = 0 To 60000
   '      a = 23.8 * 8888.9
    ' Next g
        
ret = reset_emulator

'MsgBox "hwtype is " + str(hw_type)

'If hw_type = LYNX_HARDWARE_128 Then
'        orig_keydel = LYNX_ORIGINAL_KEYDEL_128HW
'        orig_keyrep = LYNX_ORIGINAL_KEYREP_128HW
'Else
'        orig_keydel = LYNX_ORIGINAL_KEYDEL_4896HW
'        orig_keyrep = LYNX_ORIGINAL_KEYREP_4896HW
'End If


Timer3.Enabled = True

'ret = set_speed(andy1)

'Main 'reset z80

'Set_EmuSpeed (100)


End Sub



Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
Dim ret, g As Integer

'MsgBox ("CODE is " + Str$(KeyCode) + "  Shift is " + Str$(Shift))

'Call the API and get the array of keyboard settings
ret = GetKeyboardState(kbd(0))

'Form6.txtTraplist.Text = ""
'For g = 0 To 255
'   Form6.txtTraplist.Text = Form6.txtTraplist.Text + str(kbd(g))
'  If g Mod 16 = 0 Then Form6.txtTraplist.Text = Form6.txtTraplist.Text & "  - " & str(g) & vbCr & vbLf
'Next



'send them to the dll
ret = send_keymap(kbd(0))
KeyCode = 0
Shift = 0

End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)

KeyAscii = 0

End Sub
Private Sub Form_KeyUp(KeyCode As Integer, Shift As Integer)
Dim ret As Integer

'Call the API and get the array of keyboard settings
ret = GetKeyboardState(kbd(0))

'send them to the dll
ret = send_keymap(kbd(0))


End Sub

Private Sub Form_Load()

'Combo1.ListIndex = 3
load_form1_pos

'standard_disp_update = 1 'here so that the initial load doesnt set it as Custom - this doesnt work yet
load_screen_size

totc = 0
menu_run = 0 'used as a flag to get round popup problem
pok = 0

'dump_6845 = 0
'dump_status = 0
'perc_speed = 100
andy1 = 100
fred = 0 'splash screen loop var for timer

cursec = 0
curfps = 0
curfpsdiv = 0
cursecdiv = 0
sizewin = True
curr_line = 0

'useautospeed = 1
'set_autospeed (1)

'THESE HAVE BEEN IN FOR AGES WORKING GOOD
'Form5.Show
'Form5.Hide

  
DoEvents

'RunEmu


'new since russprob
'Timer3.Enabled = True

End Sub




'Noooooooo!  this is dealt with by the picture control
'Private Sub Form_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
'If Button = vbRightButton Then Form5.Show
'If Button = vbLeftButton Then
'    dump_status = 1
'    Form2.Show
'End If
'End Sub

Private Sub Form_Resize()
Dim h, w, ret As Integer
'Form1.Width = Form1.Width - (Form1.Width Mod 32)
'MsgBox ("frmwid is " + Str$(Form1.Width))
'Form1.Width = Form1.Width - ((Form1.Width - 1) Mod (8 * ((Form1.Width - 1) \ 256)))
If WindowState = vbMinimized Then
    Form5.WindowState = vbMinimized
    Form2.WindowState = vbMinimized
    Form8.WindowState = vbMinimized
    Form11.WindowState = vbMinimized
End If

If WindowState = 0 Then
    Form5.WindowState = vbNormal
    Form2.WindowState = vbNormal
    Form8.WindowState = vbNormal
    Form11.WindowState = vbNormal
End If


If Not WindowState = vbMinimized And Not WindowState = vbMaximized Then 'if form is not minimised
    Form1.Picture1.Width = Form1.Width '* 0.95
    Form1.Picture1.Height = Form1.Height '* 0.95
w = Form1.ScaleWidth / Screen.TwipsPerPixelX
h = Form1.ScaleHeight / Screen.TwipsPerPixelY
   ret = run_emulator()
   
  
set_vidmode (0)
   ret = get_video_scanvers(Form1.Picture1.hdc, w, h, bmiBuffer, Fix_6845, crtc_regs(0))
set_vidmode (vidmode)

End If



'if standard_disp_update = 0 Then
    'if this isnt a standard display update ie: not a chosen display mode 2x 3x etc
    'then mark the display mode as custom
    'NOOOOO -cant mark the mode as custom by changing Dsize cos it will start resize off  again
    'so just leave it alone
    'and save the windwo values
    'display_size = DISPLAY_SIZE_CUSTOM
'    save_screen_size
    'Save_defaults
'Else
'    standard_disp_update = 0
'End If
'save_screen_size

End Sub

Private Sub Form_Unload(Cancel As Integer)
Dim g, a


stop_emu = 1


DoEvents  'hmmm, how to do this properly?

'While stop_emu = 1
 For g = 0 To 80000
    a = 23.8 * 8888.9
 Next g
   
DoEvents  'hmmm, how to do this properly?
'Wend


'Save_defaults

Form5.quit

'kill_emulator       'just kills sound at moment *BUG cant delete the static class instant




'End

End Sub





Private Sub Picture1_DblClick()

If Not WindowState = vbMinimized And Not WindowState = vbMaximized Then
    
    If fullscreen = 1 Then
        fullscreen = 0
    Else
        fullscreen = 1
    End If
    
    If fullscreen = 1 Then
        save_left = Form1.Left
        save_top = Form1.Top
        save_width = Form1.Width
        save_height = Form1.Height
        save_pwidth = Form1.Picture1.Width
        save_pheight = Form1.Picture1.Height
        Form1.Width = Screen.Height * 1.2
        Form1.Height = Screen.Height
        Form1.Top = 0
        Form1.Left = Screen.Width / 2 - Form1.Width / 2
        Form1.Picture1.Width = Form1.Width
        Form1.Picture1.Height = Form1.Width
        
    Else
        Form1.Left = save_left
        Form1.Top = save_top
        Form1.Width = save_width
        Form1.Height = save_height
        Form1.Picture1.Width = save_pwidth
        Form1.Picture1.Height = save_pheight
        
    End If
    
    
    Save_defaults
    
End If


End Sub

'Private Sub Picture1_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)

'If Button = 1 Then
'    move_all_forms X, Y
'End If


'End Sub

Private Sub Picture1_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)


If Button = 2 Then Form5.Show


End Sub



'Private Sub Timer1_Timer()
'Dim fg, ret As Long
'Dim x_hi, x_lo

'If tsec > 0 Then tsec = tsec - 1

'********************************************************** NOT USED
'every second see how many z80 cycles have been done
'adjust the noof cycles done to become x% * (1/4MHz)*1000000
'ie z80 should do 4000000 cycles every time it returns here
'noof_cycs_sec = andy1 * 16 * noof_cycs_done '500 is speed factor in the dll
'fg = noof_cycs_done
'noof_cycs_done = 0  'reset the cycle counter
'x_hi = 4000 * (perc_speed / 100)
'x_lo = 4000 * ((perc_speed + 1) / 100)
'If noof_cycs_sec > x_hi Then
'    'wait here if too fast ?
'    andy1 = andy1 - 10
'    set_speed (andy1)
'ElseIf noof_cycs_sec < x_lo Then
'    andy1 = andy1 + 10
'    set_speed (andy1)
'End If
'**********************************************

'ret = emu_checktim(Timer1.Interval)
'lblPwid.Caption = str(Picture1.Width) + " x " + str(Picture1.Height)
'lblPwid2.Caption = str(Picture1.ScaleWidth) + " x " + str(Picture1.ScaleHeight)
'If (Form2.chkShowFPS.Value = vbChecked) Then
'    Form5.lblFPS.Visible = True
'    cursec = cursec + 1
'    If cursec = 10 Then      'upate 1Hz
'        If ret = 1 Then
'            Form5.lblFPS.Caption = "L " + str(curfps) + " FPS"
'        Else
'            Form5.lblFPS.Caption = str(curfps) + " FPS"
'        End If
'        curfps = 0
'        cursec = 0
'    End If
'Else
'    Form5.lblFPS.Visible = False
'End If


'If (Form2.chkShowlock.Value = vbChecked And ret = 1) Then
'    lblLocked.Visible = True
'Else
'    lblLocked.Visible = False
'End If

'tut - wasteful here, run all the time, just for a key repeat rate poke
'in future set flag when emu up_and_running
'then poke in once only
'If machine_speed >= 400 Then
        'ret2 = peek_mem(Val("&H" & Text8.Text) + 1)
        'ret = peek_mem(Val("&H" & Text8.Text))
'        ret = poke_mem(Val("&H6233"), Val("&HFF"))
 '       ret = poke_mem(Val("&H6234"), Val("&HFF"))
  '      ret = poke_mem(Val("&H6237"), Val("&HFF"))
   '     ret = poke_mem(Val("&H6238"), Val("&HFF"))
'Speeded up version - no harm in saving some cyc's
'        ret = poke_mem(25139, 255)
'        ret = poke_mem(25140, 255)
'        ret = poke_mem(25143, 255)
'        ret = poke_mem(25144, 255)
'End If

'Text7.Text = "Cycs:" + Str$(noof_cycs_sec) + " andy1:" + Str$(andy1)
'Text7.Text = Text7.Text + "Perc is " + Str$(perc_speed) + "X_hi is " + Str$(x_hi) + "   done:" + Str$(fg)
'End Sub



Private Sub Timer2_Timer()

Timer2.Enabled = False

If command$ <> "" Then
    send_to_lynx ("MLOAD" & Chr(34) & Chr(34) & Chr(13))
    tsec = 6
    
    load_type = 10
    Form1.SetFocus
End If

End Sub

'Private Sub Timer4_Timer()
'Dim noof_times As Integer
'noof_times = noof_times + 1
'If noof_times > 5 Then
'    noof_times = 0
'End If
'    Timer4.Enabled = False
'    If machine_speed >= 400 Then
'        'ret2 = peek_mem(Val("&H" & Text8.Text) + 1)
'        'ret = peek_mem(Val("&H" & Text8.Text))
'        ret = poke_mem(Val("&H6233"), Val("&HFF"))
'        ret = poke_mem(Val("&H6234"), Val("&HFF"))
'        ret = poke_mem(Val("&H6237"), Val("&HFF"))
'        ret = poke_mem(Val("&H6238"), Val("&HFF"))
'    End If
'End Sub

'Private Sub Timer2_Timer()
'Dim ret As Integer
'Dim ret2 As Integer
'Dim dloop As Integer

'dloop = dloop + 1
'If dloop > 3 Then
'    Timer2.Enabled = False
'End If

'MsgBox "hello"


'If machine_speed >= 400 Then
        'ret2 = peek_mem(Val("&H" & Text8.Text) + 1)
        'ret = peek_mem(Val("&H" & Text8.Text))
'        ret = poke_mem(Val("&H6233"), Val("&HFF"))
'        ret = poke_mem(Val("&H6234"), Val("&HFF"))
'        ret = poke_mem(Val("&H6237"), Val("&HFF"))
'        ret = poke_mem(Val("&H6238"), Val("&HFF"))
'End If



'End Sub

'Private Sub Timer2_Timer()

'If fred = 1 Then lbl6.Visible = True
'If fred = 4 Then
'    lbl6.Visible = False
'    Timer2.Enabled = False
'End If
'fred = fred + 1
'End Sub

Private Sub Timer3_Timer()



Timer3.Enabled = False
'Timer4.Enabled = True


RunEmu
End Sub

