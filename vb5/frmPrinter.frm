VERSION 5.00
Begin VB.Form frmPrinter 
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "FX80 Printer"
   ClientHeight    =   4605
   ClientLeft      =   45
   ClientTop       =   285
   ClientWidth     =   10710
   ControlBox      =   0   'False
   LinkTopic       =   "Form15"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4605
   ScaleWidth      =   10710
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.OptionButton Option3 
      Caption         =   "ERROR"
      Height          =   255
      Left            =   9660
      TabIndex        =   12
      Top             =   60
      Width           =   915
   End
   Begin VB.CommandButton Command8 
      Caption         =   "Command8"
      Height          =   1335
      Left            =   9720
      TabIndex        =   11
      Top             =   4680
      Width           =   915
   End
   Begin VB.TextBox txtCombuf 
      Height          =   375
      Left            =   6660
      TabIndex        =   9
      Text            =   "Text2"
      Top             =   4920
      Width           =   2655
   End
   Begin VB.CheckBox chkShowCodes 
      Caption         =   "Codes"
      Height          =   255
      Left            =   9720
      TabIndex        =   7
      Top             =   2280
      Width           =   855
   End
   Begin VB.CommandButton Command7 
      Caption         =   "Command7"
      Height          =   915
      Left            =   7740
      TabIndex        =   6
      Top             =   4800
      Width           =   1455
   End
   Begin VB.TextBox Text1 
      BeginProperty Font 
         Name            =   "Courier"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   4575
      Left            =   0
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   5
      Top             =   0
      Width           =   9555
   End
   Begin VB.CommandButton Command6 
      Caption         =   "RESET"
      Height          =   1635
      Left            =   9660
      TabIndex        =   4
      Top             =   360
      Width           =   975
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      ItemData        =   "frmPrinter.frx":0000
      Left            =   9660
      List            =   "frmPrinter.frx":0010
      Style           =   2  'Dropdown List
      TabIndex        =   2
      Top             =   3420
      Width           =   1035
   End
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Interval        =   500
      Left            =   2880
      Top             =   4080
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Close"
      Height          =   435
      Left            =   9660
      TabIndex        =   1
      Top             =   4080
      Width           =   1035
   End
   Begin VB.PictureBox Picture1 
      BackColor       =   &H80000009&
      Height          =   4575
      Left            =   0
      ScaleHeight     =   4515
      ScaleWidth      =   9495
      TabIndex        =   0
      Top             =   0
      Width           =   9555
   End
   Begin VB.Label lblGrafix 
      Caption         =   "Label2"
      Height          =   375
      Left            =   120
      TabIndex        =   10
      Top             =   5160
      Width           =   6135
   End
   Begin VB.Label lblComFULL 
      Caption         =   "Label2"
      Height          =   435
      Left            =   6840
      TabIndex        =   8
      Top             =   5520
      Width           =   2595
   End
   Begin VB.Line Line1 
      X1              =   9660
      X2              =   10620
      Y1              =   2820
      Y2              =   2820
   End
   Begin VB.Label Label1 
      Caption         =   "Type"
      Height          =   255
      Left            =   9660
      TabIndex        =   3
      Top             =   3120
      Width           =   975
   End
End
Attribute VB_Name = "frmPrinter"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit


Dim toggle, posx, posy As Integer
Dim printer_type As Integer
Dim stop_cursor As Integer
Dim text_length As Integer

Dim emu_printer_mode As Integer
Dim grafix_curbyte As Integer
Dim grafix_length As Integer

Dim ep_combuf(5) As Byte
Dim ep_combuf_ptr As Integer

Const EPSON_TEXT = 0
Const EPSON_GRAFIX = 1
Const REAL_LPT1 = 2
Const REAL_LPT2 = 3


Const DISP_LINES = 32
Const DISP_CHARS = 80



Dim uyg As Integer

Private Sub Combo1_Click()

printer_type = Combo1.ListIndex
If printer_type = 0 Then
    Text1.Visible = True
    Picture1.Visible = False
Else
    Text1.Visible = False
    Picture1.Visible = True
End If

set_printer_type (Combo1.ListIndex)

Printer_Reset


End Sub


Private Sub Command1_Click()

Unload Me


End Sub

Private Sub printer_Init()


printer_type = 0    'Pale printer type
Printer_Reset


End Sub



Private Sub Printer_Reset()

posx = 0
posy = 0
toggle = 0
Text1.Text = ""
Picture1.Cls
stop_cursor = 0
text_length = 0
emu_printer_mode = EPSON_TEXT    'current epson printer modde textual or graphic
ep_combuf_ptr = 0
grafix_curbyte = 0
grafix_length = 0
        
clear_combuf

uyg = 0

If printer_type = REAL_LPT1 Or printer_type = REAL_LPT2 Then
    init_printer
End If

'Printer error - of PALE :)
Option3.Value = False

End Sub


Private Sub Command6_Click()

Printer_Reset


End Sub



Private Sub Form_Load()

printer_Init
Combo1.ListIndex = 0


End Sub

Public Sub print_the_data()
Dim zed, f, ret As Integer
Dim qwe, num, X As Integer
Dim dispwidth, dispheight
Dim xzom, yzom As Variant

'Timer1.Enabled = False
'stop_cursor = 1
'print chars as graphics 8 bit
dispheight = DISP_LINES * 8 'lines
dispwidth = DISP_CHARS * 8 'characters wide
xzom = Picture1.Width / dispwidth
yzom = Picture1.Height / dispheight
'Test to see if the cursor char has already been added to the print string
'if so then delete it b4 adding the new data
'If toggle = 1 Then Text1.Text = Left$(Text1.Text, text_length)
'zed = 0
'If printer_type = 0 Then Text1.Text = Left$(Text1.Text, text_length)

For f = 0 To printer_inbuflen
 
' If uyg < 10 Then MsgBox "InbufPTR = " + str(f) + "read  " + str(printer_inbuf(f))
 'lblGrafix.Caption = "InbufPTR = " + str(f) + " posx=" + str(posx) + "posy=" + str(posy) + " grafixcurbyte=" + str(grafix_curbyte)
    
    
    If emu_printer_mode = EPSON_TEXT Then
            ret = epson_print(printer_inbuf(f))
            'zed = zed + ret
            'text_length = text_length + zed '+ 1
    ElseIf emu_printer_mode = EPSON_GRAFIX Then
'            ret = epson_print(printer_inbuf(f))
            num = printer_inbuf(f)
            For X = 7 To 0 Step -1
                ' is this number divisible by this power of two
                'ret = ret & CStr(num \ (2 ^ x))
                If (num \ (2 ^ X)) > 0 Then
                    Picture1.ForeColor = RGB(0, 0, 0)
                    Picture1.Line (posx * xzom, ((posy + 8) - X) * yzom)-(posx * xzom, ((posy + 8) - X - 1) * yzom)
                Else
                    Picture1.ForeColor = RGB(255, 255, 255)
                    Picture1.Line (posx * xzom, ((posy + 8) - X) * yzom)-(posx * xzom, ((posy + 8) - X - 1) * yzom)
                End If
                 ' get the remaining number
                num = num Mod (2 ^ X)
            Next X
            posx = posx + 1
    '        grafix_curbyte = grafix_curbyte + 1
           grafix_curbyte = grafix_curbyte - 1
          '  If grafix_curbyte Mod 256 = 0 Then
           '     posx = 0
            '    posy = posy + 8
            'End If
    '        If grafix_curbyte > grafix_length Then
            If grafix_curbyte < 1 Then
                grafix_length = 0
                grafix_curbyte = 0
                emu_printer_mode = EPSON_TEXT
            End If
    End If
Next f

printer_inbuflen = 0
'stop_cursor = 0
'Timer1.Enabled = True

End Sub


Private Function epson_print(ByVal byt As Byte)
Dim noof_chars_to_add As Integer
        
'GoTo gtg

'noof_chars_to_add = 0
If printer_type = 0 Then
    epson_command (byt)
   If byt = 10 Then   'linefeed charage ret
        Text1.Text = Text1.Text + vbCr + vbLf
        'noof_chars_to_add = noof_chars_to_add + 2
    ElseIf byt = 8 Then    'backspace
        Text1.Text = Left$(Text1.Text, text_length - 1)
        'noof_chars_to_add = noof_chars_to_add - 1
    ElseIf byt >= 32 And byt < 128 Then
        Text1.Text = Text1.Text + Chr$(byt)
        'noof_chars_to_add = noof_chars_to_add + 1
    ElseIf chkShowCodes.Value = vbChecked Then
        Text1.Text = Text1.Text + " [" + str(byt) + "] "
    End If
    epson_print = 0 'noof_chars_to_add

Else
    epson_command (byt)
    If byt = 10 Then   'linefeed charage ret
     '   MsgBox "CR"
                posx = 0
               posy = posy + 8
    End If
    If posy >= (DISP_LINES + 1) * 8 Then posy = 0
    epson_print = 0
End If


gtg:


End Function

        
Private Sub epson_command(ByVal inbyt As Byte)
Dim tmp0, tmp1, tmp2, tmp3, end_command As Byte

    'Assumes a 27 as the first character
    

    ep_combuf(ep_combuf_ptr) = inbyt
    ep_combuf_ptr = ep_combuf_ptr + 1
    If ep_combuf_ptr > 5 Then
        Option3.Value = False
        'frmPrinter.lblComFULL.Caption = "ComBUF Overflow"
        ep_combuf_ptr = 0
    End If
    
  '  txtCombuf.Text = str(ep_combuf(0)) + str(ep_combuf(1)) + str(ep_combuf(2)) + str(ep_combuf(3)) + str(ep_combuf(4))
  
  
'  If uyg < 10 Then MsgBox "epcombuf is  " + str(ep_combuf(0)) + str(ep_combuf(1)) + str(ep_combuf(2)) + str(ep_combuf(3)) + str(ep_combuf(4))
'uyg = uyg + 1

end_command = 0

'    If ep_combuf(0) = 27 And ep_combuf_ptr > 1 Then
    If ep_combuf(0) = 27 Then
        'Now test the buffer to see if its a valid commmand
        If ep_combuf_ptr = 2 Then
            'ONE BYTE COMMANDS
            tmp0 = ep_combuf(1)
            If tmp0 = 56 Then 'disable PO sensor
                    end_command = 1
            ElseIf tmp0 = 57 Then    'enabl PO
                    end_command = 1
            ElseIf tmp0 = 60 Then    'enabl UNI idirect for 1 line
                    end_command = 1
            ElseIf tmp0 = 64 Then    'Init Printer
                    Printer_Reset
                    end_command = 1
            ElseIf tmp0 = 48 Then    'sel 8 lpi
                    end_command = 1
            ElseIf tmp0 = 49 Then    'enabl PO
                    end_command = 1
            ElseIf tmp0 = 79 Then    'enabl PO
                    end_command = 1
            ElseIf tmp0 = 14 Then    'double wid for 1 line
                    end_command = 1
            ElseIf tmp0 = 15 Then    'cond mode
                    end_command = 1
            ElseIf tmp0 = 77 Then    'elite width
                    end_command = 1
            ElseIf tmp0 = 80 Then    'pica width
                    end_command = 1
            ElseIf tmp0 = 69 Then    'emphas
                    end_command = 1
            ElseIf tmp0 = 70 Then    'elite width
                    end_command = 1
            ElseIf tmp0 = 71 Then    'sel doub strik
                    end_command = 1
            ElseIf tmp0 = 72 Then    'canc doub strik
                    end_command = 1
            ElseIf tmp0 = 84 Then    'cancel sub sup
                    end_command = 1
            ElseIf tmp0 = 52 Then    'sel ital
                    end_command = 1
            ElseIf tmp0 = 53 Then    'cancel ital
                    end_command = 1
            ElseIf tmp0 = 54 Then    'en print chars 128-159 , 255
                    end_command = 1
            ElseIf tmp0 = 55 Then    'cancel above enable
                    end_command = 1
            End If
        ElseIf ep_combuf_ptr = 3 Then
            tmp0 = ep_combuf(1)
            tmp1 = ep_combuf(2)
            
            'USED BY VRPINT   ************
            If tmp0 = 51 Then 'enable n/180 lpi line spaceing
                    end_command = 1
                    'MsgBox "ENABLED 180 / " + str(tmp1)
            ElseIf tmp0 = 25 And tmp1 = 48 Then 'turn cut sheet control off
                    end_command = 1
            ElseIf tmp0 = 25 And tmp1 = 52 Then     'turn sheet fed on
                    end_command = 1
            ElseIf tmp0 = 85 And tmp1 = 48 Then    'canc uni dir
                    end_command = 1
            ElseIf tmp0 = 85 And tmp1 = 49 Then    'en uni dir
                    end_command = 1
            ElseIf tmp0 = 115 And tmp1 = 48 Then    'half speed off
                    end_command = 1
            ElseIf tmp0 = 115 And tmp1 = 49 Then    'h s on
                    end_command = 1
            ElseIf tmp0 = 47 Then    'sel vert tab channel 0-7
                    'Tab channel=tmp(1)
                    end_command = 1
            ElseIf tmp0 = 51 Then    'sel n/216 lpi
                    end_command = 1
            ElseIf tmp0 = 65 Then    'sel n/72 lpi
                    end_command = 1
            ElseIf tmp0 = 66 Then    'clear vert  66 0 set tabs too here
                    end_command = 1
            ElseIf tmp0 = 67 Then    '
                    end_command = 1
            ElseIf tmp0 = 68 Then    '
                    If tmp1 = 0 Then end_command = 1 'ANOTHER ONE NEED IN 3 BYTE
            ElseIf tmp0 = 74 Then    'immed n/216 lpi LF
                    end_command = 1
            ElseIf tmp0 = 78 Then    'sel skip over perf
                    end_command = 1
            ElseIf tmp0 = 81 Then    '
                    end_command = 1
            ElseIf tmp0 = 106 Then    '
                    end_command = 1
            ElseIf tmp0 = 108 Then    '
                    end_command = 1
            ElseIf tmp0 = 33 Then    'master select 0 pica 1 elite 4 cond 8 emphas
                    end_command = 1
            ElseIf tmp0 = 107 And tmp1 = 48 Then    'NLQ roman font
                    end_command = 1
            ElseIf tmp0 = 107 And tmp1 = 49 Then    '
                    end_command = 1
            ElseIf tmp0 = 120 And tmp1 = 48 Then    'sel draft
                    end_command = 1
            ElseIf tmp0 = 120 And tmp1 = 49 Then    'sel nlq
                    end_command = 1
            ElseIf tmp0 = 87 And tmp1 = 48 Then    'canc doub wid
                    end_command = 1
            ElseIf tmp0 = 87 And tmp1 = 49 Then    'en doub wid
                    end_command = 1
            ElseIf tmp0 = 45 And tmp1 = 48 Then    'canc unederlin
                    end_command = 1
            ElseIf tmp0 = 45 And tmp1 = 49 Then    'en unederlin
                    end_command = 1
            ElseIf tmp0 = 83 And tmp1 = 48 Then    'sel super s
                    end_command = 1
            ElseIf tmp0 = 83 And tmp1 = 49 Then    'sel sub s
                    end_command = 1
            ElseIf tmp0 = 82 Then            'Int char set=tmp1
                    end_command = 1
            ElseIf tmp0 = 116 Then
                    'selec ital or epson char set
                    end_command = 1
            ElseIf tmp0 = 37 Then
                    'tmp1  selects epso char set or user def set
                    end_command = 1
            ElseIf tmp0 = 38 Then        'sel user def char set
                    end_command = 1
            ElseIf tmp0 = 32 Then        'space in n/32 inch fol each NLQ char
                    end_command = 1
            ElseIf tmp0 = 73 And tmp1 = 48 Then    'sel sub s
                    end_command = 1
            ElseIf tmp0 = 73 And tmp1 = 49 Then    'sprintable codeexp
                    end_command = 1         '0-31 and 128-159
            ElseIf tmp0 = 97 Then        'NLQ justif
                    end_command = 1
            
                     'FOR LYNX VPRINT
            ElseIf tmp0 = 3 Then    '27 3 24 13 at start of VPRINT in 128
                    end_command = 1
            End If
        ElseIf ep_combuf_ptr = 4 Then
            tmp0 = ep_combuf(1)
            tmp1 = ep_combuf(2)
            tmp2 = ep_combuf(3)
            If tmp0 = 67 And tmp1 = 48 Then 'sel page length
                    end_command = 1
            ElseIf tmp0 = 68 Then        'sets upto 32 horiz tabs
                    end_command = 1
            ElseIf tmp0 = 98 Then        'sets upto 16 vert tabs
                    end_command = 1
            ElseIf tmp0 = 101 And tmp1 = 48 Then    'sel sub s
                    end_command = 1
            ElseIf tmp0 = 101 And tmp1 = 49 Then    'sel sub s
                    end_command = 1
            ElseIf tmp0 = 102 And tmp1 = 48 Then    'sel sub s
                    end_command = 1
            ElseIf tmp0 = 102 And tmp1 = 49 Then    'sel sub s
                    end_command = 1
            ElseIf tmp0 = 63 Then ' Reassign graphics mode
                    'KLYZ mode=tmp1 n=tmp2
                    end_command = 1
            ElseIf tmp0 = 75 Then 'single dens graphcis 60dpi GRAFIX
 '                   MsgBox "Havent done this grafix mode yet"
                    grafix_curbyte = tmp1 + 256 * tmp2
                    emu_printer_mode = EPSON_GRAFIX
                    end_command = 1
            ElseIf tmp0 = 76 Then 'double dens 120dpi GRAFIX
                    'KLYZ mode=tmp1 n=tmp2
                    'KLYZ mode=tmp1 n=tmp2
                    'Begin low speed double density graphics,
                    'n1+256*n2 graphic bytes follow
                    'grafix_length = tmp1 + 256 * tmp2
                    grafix_curbyte = tmp1 + 256 * tmp2
                    emu_printer_mode = EPSON_GRAFIX
                    'MsgBox "Graphics Mode Set, length =" + str(grafix_length)
 '                   lblGrafix.Caption = "Last Graphics Mode Set, length =" + str(grafix_length)
                    end_command = 1
            ElseIf tmp0 = 89 Then 'hi speed doubl den GRAFIX
                    'KLYZ mode=tmp1 n=tmp2
'                    MsgBox "Havent done this grafix mode yet"
                    grafix_curbyte = tmp1 + 256 * tmp2
                    emu_printer_mode = EPSON_GRAFIX
                    end_command = 1
            ElseIf tmp0 = 89 Then ' quad den  GRAFIX
                    'KLYZ mode=tmp1 n=tmp2
'                    MsgBox "Havent done this grafix mode yet"
                    grafix_curbyte = tmp1 + 256 * tmp2
                    emu_printer_mode = EPSON_GRAFIX
                    end_command = 1
            End If
        ElseIf ep_combuf_ptr = 5 Then
            tmp0 = ep_combuf(1)
            tmp1 = ep_combuf(2)
            tmp2 = ep_combuf(3)
            tmp3 = ep_combuf(4)
            If tmp0 = 58 And tmp1 = 0 And tmp2 = 0 And tmp3 = 0 Then    'sel sub s
                    'Copy ROM into RAM
                    end_command = 1
            ElseIf tmp0 = 94 Then               '9 PIN Graophics mode
                    'm=tmp1  n1=tmp2  n2=tmp3
                    end_command = 1
            End If
        End If
    Else
        end_command = 1
    End If
    
    If end_command = 1 Then
        clear_combuf
    End If
    
    
End Sub

Private Sub clear_combuf()

        ep_combuf(0) = 0
        ep_combuf(1) = 0
        ep_combuf(2) = 0
        ep_combuf(3) = 0
        ep_combuf(4) = 0
        ep_combuf_ptr = 0


End Sub

