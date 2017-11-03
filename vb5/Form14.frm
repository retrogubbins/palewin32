VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Begin VB.Form Form14 
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "ROM Builder"
   ClientHeight    =   4035
   ClientLeft      =   45
   ClientTop       =   285
   ClientWidth     =   5055
   ControlBox      =   0   'False
   LinkTopic       =   "Form14"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4035
   ScaleWidth      =   5055
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton Command2 
      Caption         =   "x"
      Height          =   255
      Index           =   7
      Left            =   1140
      TabIndex        =   37
      Top             =   3120
      Width           =   255
   End
   Begin VB.CommandButton Command2 
      Caption         =   "x"
      Height          =   255
      Index           =   6
      Left            =   1140
      TabIndex        =   36
      Top             =   2760
      Width           =   255
   End
   Begin VB.CommandButton Command2 
      Caption         =   "x"
      Height          =   255
      Index           =   5
      Left            =   1140
      TabIndex        =   35
      Top             =   2400
      Width           =   255
   End
   Begin VB.CommandButton Command2 
      Caption         =   "x"
      Height          =   255
      Index           =   4
      Left            =   1140
      TabIndex        =   34
      Top             =   2040
      Width           =   255
   End
   Begin VB.CommandButton Command2 
      Caption         =   "x"
      Height          =   255
      Index           =   3
      Left            =   1140
      TabIndex        =   33
      Top             =   1680
      Width           =   255
   End
   Begin VB.CommandButton Command2 
      Caption         =   "x"
      Height          =   255
      Index           =   2
      Left            =   1140
      TabIndex        =   32
      Top             =   1320
      Width           =   255
   End
   Begin VB.CommandButton Command2 
      Caption         =   "x"
      Height          =   255
      Index           =   1
      Left            =   1140
      TabIndex        =   31
      Top             =   960
      Width           =   255
   End
   Begin VB.CommandButton Command2 
      Caption         =   "x"
      Height          =   255
      Index           =   0
      Left            =   1140
      TabIndex        =   30
      Top             =   600
      Width           =   255
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      ItemData        =   "Form14.frx":0000
      Left            =   3420
      List            =   "Form14.frx":001C
      Style           =   2  'Dropdown List
      TabIndex        =   28
      Top             =   120
      Width           =   1515
   End
   Begin VB.CommandButton Command4 
      Caption         =   "Reset Archive to Default"
      Height          =   375
      Left            =   120
      TabIndex        =   27
      Top             =   3600
      Width           =   2175
   End
   Begin MSComDlg.CommonDialog CommonDialog1 
      Left            =   240
      Top             =   4080
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Close"
      Height          =   495
      Left            =   3000
      TabIndex        =   26
      Top             =   3480
      Width           =   1695
   End
   Begin VB.TextBox txtROM 
      Height          =   285
      Index           =   7
      Left            =   1440
      TabIndex        =   25
      Text            =   "none"
      Top             =   3120
      Width           =   3495
   End
   Begin VB.TextBox txtROM 
      Height          =   285
      Index           =   6
      Left            =   1440
      TabIndex        =   24
      Text            =   "none"
      Top             =   2760
      Width           =   3495
   End
   Begin VB.TextBox txtROM 
      Height          =   285
      Index           =   5
      Left            =   1440
      TabIndex        =   23
      Text            =   "none"
      Top             =   2400
      Width           =   3495
   End
   Begin VB.TextBox txtROM 
      Height          =   285
      Index           =   4
      Left            =   1440
      TabIndex        =   22
      Text            =   "none"
      Top             =   2040
      Width           =   3495
   End
   Begin VB.TextBox txtROM 
      Height          =   285
      Index           =   3
      Left            =   1440
      TabIndex        =   21
      Text            =   "none"
      Top             =   1680
      Width           =   3495
   End
   Begin VB.TextBox txtROM 
      Height          =   285
      Index           =   2
      Left            =   1440
      TabIndex        =   20
      Text            =   "none"
      Top             =   1320
      Width           =   3495
   End
   Begin VB.TextBox txtROM 
      Height          =   285
      Index           =   1
      Left            =   1440
      TabIndex        =   19
      Text            =   "none"
      Top             =   960
      Width           =   3495
   End
   Begin VB.CommandButton Command1 
      Caption         =   "E000-FFFF"
      Height          =   255
      Index           =   7
      Left            =   120
      TabIndex        =   18
      Top             =   3120
      Width           =   975
   End
   Begin VB.CommandButton Command1 
      Caption         =   "C000-DFFF"
      Height          =   255
      Index           =   6
      Left            =   120
      TabIndex        =   17
      Top             =   2760
      Width           =   975
   End
   Begin VB.CommandButton Command1 
      Caption         =   "A000-BFFF"
      Height          =   255
      Index           =   5
      Left            =   120
      TabIndex        =   16
      Top             =   2400
      Width           =   975
   End
   Begin VB.CommandButton Command1 
      Caption         =   "8000-9FFF"
      Height          =   255
      Index           =   4
      Left            =   120
      TabIndex        =   15
      Top             =   2040
      Width           =   975
   End
   Begin VB.CommandButton Command1 
      Caption         =   "6000-7FFF"
      Height          =   255
      Index           =   3
      Left            =   120
      TabIndex        =   14
      Top             =   1680
      Width           =   975
   End
   Begin VB.CommandButton Command1 
      Caption         =   "4000-5FFF"
      Height          =   255
      Index           =   2
      Left            =   120
      TabIndex        =   13
      Top             =   1320
      Width           =   975
   End
   Begin VB.CommandButton Command1 
      Caption         =   "2000-3FFF"
      Height          =   255
      Index           =   1
      Left            =   120
      TabIndex        =   12
      Top             =   960
      Width           =   975
   End
   Begin VB.CommandButton Command1 
      Caption         =   "0000-1FFF"
      Height          =   255
      Index           =   0
      Left            =   120
      TabIndex        =   11
      Top             =   600
      Width           =   975
   End
   Begin VB.TextBox txtROM 
      Height          =   285
      Index           =   0
      Left            =   1440
      TabIndex        =   2
      Text            =   "none"
      Top             =   600
      Width           =   3495
   End
   Begin VB.ComboBox cmbROMset 
      Height          =   315
      ItemData        =   "Form14.frx":0057
      Left            =   960
      List            =   "Form14.frx":0070
      Style           =   2  'Dropdown List
      TabIndex        =   1
      Top             =   120
      Width           =   1215
   End
   Begin VB.Label Label10 
      Caption         =   "Hardware"
      Height          =   315
      Left            =   2580
      TabIndex        =   29
      Top             =   180
      Width           =   795
   End
   Begin VB.Label Label9 
      Caption         =   "E000-FFFF"
      Height          =   255
      Left            =   720
      TabIndex        =   10
      Top             =   5880
      Width           =   975
   End
   Begin VB.Label Label8 
      Caption         =   "C000-DFFF"
      Height          =   255
      Left            =   360
      TabIndex        =   9
      Top             =   5640
      Width           =   975
   End
   Begin VB.Label Label7 
      Caption         =   "A000-BFFF"
      Height          =   255
      Left            =   360
      TabIndex        =   8
      Top             =   5400
      Width           =   975
   End
   Begin VB.Label Label6 
      Caption         =   "8000-9FFF"
      Height          =   255
      Left            =   360
      TabIndex        =   7
      Top             =   5280
      Width           =   975
   End
   Begin VB.Label Label5 
      Caption         =   "6000-7FFF"
      Height          =   255
      Left            =   600
      TabIndex        =   6
      Top             =   5400
      Width           =   975
   End
   Begin VB.Label Label4 
      Caption         =   "4000-5FFF"
      Height          =   255
      Left            =   360
      TabIndex        =   5
      Top             =   5880
      Width           =   975
   End
   Begin VB.Label Label3 
      Caption         =   "2000-3FFF"
      Height          =   255
      Left            =   120
      TabIndex        =   4
      Top             =   5880
      Width           =   975
   End
   Begin VB.Label Label2 
      Caption         =   "0000-1FFF"
      Height          =   255
      Left            =   840
      TabIndex        =   3
      Top             =   5880
      Width           =   975
   End
   Begin VB.Label Label1 
      Caption         =   "ROM Set:"
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   180
      Width           =   795
   End
End
Attribute VB_Name = "Form14"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Private Sub cmbROMset_Click()

'MsgBox "Index is " + str(cmbROMset.ListIndex)

current_set = cmbROMset.ItemData(cmbROMset.ListIndex)

'retrieve rom set from registry
get_current_romset


End Sub

Private Sub Combo1_Click()

Dim s As String

s = "SET" + str(current_set) + "HWTYPE"
SaveS s, Combo1.ItemData(Combo1.ListIndex)




End Sub

Private Sub Command1_Click(Index As Integer)
Dim s As String

Form14.CommonDialog1.Filter = "ROM Files (*.rom)|*.rom|All files" & _
    "(*.*)|*.*"
Form14.CommonDialog1.Flags = cdlOFNHideReadOnly
CommonDialog1.FilterIndex = 1
CommonDialog1.ShowOpen

txtROM(Index).Text = CommonDialog1.Filename

s = "SET" + str(current_set) + "ROM" + str(Index)
SaveS s, txtROM(Index).Text

End Sub

Private Sub get_current_romset()
Dim f As Integer
Dim s As String

For f = 0 To 7
    s = "SET" + str(current_set) + "ROM" + str(f)
    txtROM(f).Text = GetS(s)
Next f
    
s = "SET" + str(current_set) + "HWTYPE"
hw_type = Val(GetS(s))

Combo1.ListIndex = hw_type


End Sub




Private Sub save_current_romset()
Dim f As Integer
Dim s As String

For f = 0 To 7
    s = "SET" + str(current_set) + "ROM" + str(f)
    SaveS s, txtROM(f).Text
Next f

s = "SET" + str(current_set) + "HWTYPE"
SaveS s, hw_type



End Sub



Private Sub Command2_Click(Index As Integer)
Dim s As String
txtROM(Index).Text = "none"

s = "SET" + str(current_set) + "ROM" + str(Index)
SaveS s, txtROM(Index).Text


End Sub

Private Sub Command3_Click()

MsgBox "If you changed the currently running Machine you may have to Restart PALE (or Change Machine Type and Back again)"


Unload Me

End Sub

Private Sub Command4_Click()

init_ROMdefaults


End Sub

Private Sub Form_Load()


'Stop the emulator
Form1.StopEmu
DoEvents

cmbROMset.ListIndex = current_set

'current_set = cmbROMset.ItemData(cmbROMset.ListIndex)
current_set = cmbROMset.ItemData(cmbROMset.ListIndex)

'retrieve rom sets from registry
get_current_romset

End Sub

Private Sub Form_Unload(Cancel As Integer)


'Restart the emulator
Form1.Timer3.Enabled = True


End Sub

