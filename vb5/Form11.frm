VERSION 5.00
Begin VB.Form Form11 
   BorderStyle     =   5  'Sizable ToolWindow
   Caption         =   "Memory Map"
   ClientHeight    =   5205
   ClientLeft      =   45
   ClientTop       =   300
   ClientWidth     =   5205
   ControlBox      =   0   'False
   LinkTopic       =   "Form11"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5205
   ScaleWidth      =   5205
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   3840
      Top             =   2640
   End
   Begin VB.CommandButton Command4 
      Caption         =   "-"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   960
      TabIndex        =   6
      Top             =   120
      Width           =   372
   End
   Begin VB.CommandButton Command3 
      Caption         =   "+"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   1320
      TabIndex        =   5
      Top             =   120
      Width           =   372
   End
   Begin VB.TextBox txtresol 
      Height          =   285
      Left            =   4440
      TabIndex        =   4
      Text            =   "3"
      Top             =   2880
      Visible         =   0   'False
      Width           =   375
   End
   Begin VB.TextBox txtBno 
      Height          =   288
      Left            =   4440
      TabIndex        =   2
      Text            =   "0"
      Top             =   600
      Visible         =   0   'False
      Width           =   372
   End
   Begin VB.CommandButton Command2 
      Caption         =   "-"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   120
      TabIndex        =   1
      Top             =   120
      Width           =   372
   End
   Begin VB.CommandButton Command1 
      Caption         =   "+"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   480
      TabIndex        =   0
      Top             =   120
      Width           =   372
   End
   Begin VB.PictureBox Picture1 
      BackColor       =   &H80000008&
      FillColor       =   &H00FFFFFF&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      FontTransparent =   0   'False
      ForeColor       =   &H00FFFFFF&
      Height          =   4692
      Left            =   0
      ScaleHeight     =   4635
      ScaleWidth      =   3555
      TabIndex        =   3
      Top             =   0
      Width           =   3612
   End
End
Attribute VB_Name = "Form11"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit



Private Sub Command1_Click()

If membank < 4 Then membank = membank + 1
Form11.Caption = "Bank " + str(membank) + " Resolution " + str(memresol) + " bytes"
Picture1.Cls

Save_defaults

End Sub

Private Sub Command2_Click()
If membank > 0 Then membank = membank - 1
Form11.Caption = "Bank " + str(membank) + " Resolution " + str(memresol) + " bytes"
Picture1.Cls

Save_defaults

End Sub

Private Sub Command3_Click()
If memresol < 8 Then memresol = memresol + 1
Form11.Caption = "Bank " + str(membank) + " Resolution " + str(memresol) + " bytes"

Timer1.Interval = 1000 / memresol

Picture1.Cls

Save_defaults

End Sub

Private Sub Command4_Click()
If memresol > 1 Then memresol = memresol - 1
Form11.Caption = "Bank " + str(membank) + " Resolution " + str(memresol) + " bytes"

Timer1.Interval = 1000 / memresol

Picture1.Cls

Save_defaults

End Sub

Private Sub Form_Load()

load_form11_pos

load_form11_size

Form11.Caption = "Bank " + str(membank) + " Resolution " + str(memresol) + " bytes"

Timer1.Interval = 1000 / memresol

End Sub



Private Sub Form_Resize()

Picture1.Cls

Picture1.Width = ScaleWidth
Picture1.Height = ScaleHeight

End Sub

Private Sub Form_Unload(Cancel As Integer)

save_form11_size
Form5.chkMemmap = vbUnchecked

End Sub

Private Sub Timer1_Timer()
Dim ret, xx, yy, f, noof_leg
Dim dispwidth, dispheight
Dim xzom, yzom As Variant


'If machine_type = LYNX_HARDWARE_4896 Then
If hw_type = LYNX_HARDWARE_48 Or hw_type = LYNX_HARDWARE_96 Then
    dispwidth = 32 * 8
Else
    dispwidth = 64 * 8
End If

dispheight = 65536 / dispwidth
ret = get_memmap(memmap(0), membank)


'Now draw the map onto the piccy
xx = 0
yy = 0

xzom = Picture1.Width / (dispwidth / memresol)
yzom = Picture1.Height / dispheight
'yzom = 1

'Picture1.Cls


For f = 0 To 65535 Step memresol
 '   If xx = 0 Then Picture1.PSet (xx * xzom, yy * yzom)
'    Picture1.PSet (xx * xzom, yy * yzom), RGB(memmap(f), memmap(f), memmap(f))
'    Picture1.ForeColor = RGB(memmap(f), memmap(f), memmap(f))
    
    
    Picture1.Line (xx * xzom, yy * yzom)-((xx + 1) * xzom, (yy + 1) * yzom), RGB(255 - memmap(f), 255 - memmap(f), memmap(f)), B
    xx = xx + 1
    If (xx) Mod (dispwidth / memresol) = 0 Then
        yy = yy + 1
        xx = 0
    End If
Next f

'draw legends
noof_leg = 8

For f = 1 To noof_leg
'    Form11.Line (Form11.ScaleWidth * 0.9, ((f * (65536 / noof_leg)) / dispwidth) * yzom)-(Form11.ScaleWidth * 0.92, ((f * 65536 / noof_leg) / dispwidth) * yzom), RGB(255, 255, 255)
 '   Form11.Print Hex$((f * 65536 / noof_leg))
'    Form11.Line (0, ((f * (65536 / noof_leg)) / dispwidth) * yzom)-(Form11.ScaleWidth * 0.1, ((f * 65536 / noof_leg) / dispwidth) * yzom), RGB(255, 255, 255)
    Picture1.Line (0, ((f * (65536 / noof_leg)) / dispwidth) * yzom)-(100, ((f * 65536 / noof_leg) / dispwidth) * yzom), RGB(255, 255, 255)
    Picture1.Print Hex$((f * 65536 / noof_leg))
Next f

End Sub
