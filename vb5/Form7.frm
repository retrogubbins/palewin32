VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "Comdlg32.ocx"
Begin VB.Form Form7 
   Caption         =   "Z80 -> TAP Converter"
   ClientHeight    =   4605
   ClientLeft      =   45
   ClientTop       =   345
   ClientWidth     =   5730
   ControlBox      =   0   'False
   LinkTopic       =   "Form7"
   MaxButton       =   0   'False
   ScaleHeight     =   4605
   ScaleWidth      =   5730
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox Text3 
      Height          =   1215
      Left            =   120
      MultiLine       =   -1  'True
      TabIndex        =   14
      Text            =   "Form7.frx":0000
      Top             =   120
      Width           =   5535
   End
   Begin VB.CommandButton Command4 
      Caption         =   "Close"
      Height          =   492
      Left            =   3720
      TabIndex        =   13
      Top             =   3960
      Width           =   1812
   End
   Begin VB.ComboBox cmbTtype 
      Enabled         =   0   'False
      Height          =   315
      ItemData        =   "Form7.frx":0113
      Left            =   1560
      List            =   "Form7.frx":0120
      Style           =   2  'Dropdown List
      TabIndex        =   12
      Top             =   2520
      Width           =   972
   End
   Begin MSComDlg.CommonDialog CommonDialog1 
      Left            =   3720
      Top             =   1440
      _ExtentX        =   688
      _ExtentY        =   688
      _Version        =   393216
      CancelError     =   -1  'True
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Convert"
      Height          =   1092
      Left            =   2640
      TabIndex        =   10
      Top             =   2520
      Width           =   3012
   End
   Begin VB.TextBox txtTexecute 
      Height          =   372
      Left            =   1560
      TabIndex        =   9
      Text            =   "0"
      Top             =   3960
      Width           =   972
   End
   Begin VB.TextBox txtTstart 
      Height          =   372
      Left            =   1560
      TabIndex        =   8
      Text            =   "7800"
      Top             =   3480
      Width           =   972
   End
   Begin VB.TextBox txtTleng 
      Enabled         =   0   'False
      Height          =   372
      Left            =   1560
      TabIndex        =   7
      Text            =   "287f"
      Top             =   3000
      Width           =   972
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Output TAP File"
      Height          =   372
      Left            =   0
      TabIndex        =   4
      Top             =   2040
      Width           =   1452
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Input Z80 File"
      Height          =   372
      Left            =   0
      TabIndex        =   3
      Top             =   1560
      Width           =   1452
   End
   Begin VB.TextBox Text2 
      Height          =   372
      Left            =   1560
      TabIndex        =   2
      Text            =   "d:\pale\pen2.tap"
      Top             =   2040
      Width           =   4092
   End
   Begin VB.TextBox Text1 
      Height          =   372
      Left            =   1560
      TabIndex        =   0
      Text            =   "d:\pale\pengo.z80"
      Top             =   1560
      Width           =   4092
   End
   Begin VB.Label Label3 
      Caption         =   "Type"
      Height          =   255
      Left            =   120
      TabIndex        =   11
      Top             =   2640
      Width           =   1215
   End
   Begin VB.Label Label4 
      Caption         =   "Execute"
      Height          =   255
      Left            =   120
      TabIndex        =   6
      Top             =   4080
      Width           =   1215
   End
   Begin VB.Label Label1 
      Caption         =   "Start"
      Height          =   255
      Left            =   120
      TabIndex        =   5
      Top             =   3600
      Width           =   1215
   End
   Begin VB.Label Label2 
      Caption         =   "Length"
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Top             =   3120
      Width           =   1215
   End
End
Attribute VB_Name = "Form7"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim out_fnam(100) As Byte
Dim in_fnam(100) As Byte


Private Sub Command1_Click()
Dim f, ret As Integer

On Error GoTo err

CommonDialog1.Filter = "Z80 Files (*.z80)|*.Z80|All files" & _
    "(*.*)|*.*"
CommonDialog1.Flags = cdlOFNHideReadOnly
CommonDialog1.FilterIndex = 1
CommonDialog1.ShowOpen

For f = 1 To Len(CommonDialog1.Filename)
    in_fnam(f - 1) = Asc(Mid$(CommonDialog1.Filename, f, 1))
Next f
in_fnam(f) = 0

Text1.Text = CommonDialog1.Filename

Exit Sub

err:

Exit Sub


End Sub

Private Sub Command2_Click()
Dim f, ret As Integer

On Error GoTo err

CommonDialog1.Filter = "TAP Files (*.tap)|*.TAP|All files" & _
    "(*.*)|*.*"
CommonDialog1.Flags = cdlOFNHideReadOnly
CommonDialog1.FilterIndex = 1
CommonDialog1.ShowOpen

For f = 1 To Len(CommonDialog1.Filename)
    out_fnam(f - 1) = Asc(Mid$(CommonDialog1.Filename, f, 1))
Next f
out_fnam(f) = 0

Text2.Text = CommonDialog1.Filename

Exit Sub

err:

Exit Sub





End Sub

Private Sub Command3_Click()
Dim ret As Integer

  ret = z80_to_tap(in_fnam(0), out_fnam(0), Val("&H" & txtTleng.Text), Val("&H" & txtTstart.Text), cmbTtype.ListIndex, Val("&H" & txtTexecute.Text))

txtTleng.Text = Hex$(ret)

End Sub

Private Sub Command4_Click()
Unload Me

End Sub

Private Sub Form_Load()



'Stop the emulator
Form1.StopEmu
DoEvents

End Sub

Private Sub Form_Unload(Cancel As Integer)


'Restart the emulator
Form1.Timer3.Enabled = True


End Sub

