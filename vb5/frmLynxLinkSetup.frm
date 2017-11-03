VERSION 5.00
Begin VB.Form frmLynxLinkSetup 
   Caption         =   "LynxLink Setup"
   ClientHeight    =   4455
   ClientLeft      =   120
   ClientTop       =   420
   ClientWidth     =   4560
   LinkTopic       =   "Form19"
   ScaleHeight     =   4455
   ScaleWidth      =   4560
   StartUpPosition =   3  'Windows Default
   Begin VB.Timer Timer1 
      Interval        =   1000
      Left            =   600
      Top             =   3600
   End
   Begin VB.CommandButton cmdDefault 
      Caption         =   "Reset to Default"
      Height          =   495
      Left            =   2880
      TabIndex        =   13
      Top             =   3360
      Width           =   1455
   End
   Begin VB.CheckBox chkSkipWait 
      Caption         =   "SkipWAIT"
      Height          =   255
      Left            =   600
      TabIndex        =   10
      Top             =   3000
      Width           =   1335
   End
   Begin VB.CheckBox chkCPMO 
      Caption         =   "CPM "
      Enabled         =   0   'False
      Height          =   255
      Left            =   2880
      TabIndex        =   9
      Top             =   2640
      Width           =   855
   End
   Begin VB.CommandButton Command1 
      Caption         =   "LynxOS"
      Height          =   975
      Left            =   1680
      TabIndex        =   7
      Top             =   1800
      Width           =   975
   End
   Begin VB.CheckBox chkCPM 
      Caption         =   "CPM "
      Enabled         =   0   'False
      Height          =   255
      Left            =   600
      TabIndex        =   8
      Top             =   2640
      Width           =   855
   End
   Begin VB.CheckBox chkDisplayO 
      Caption         =   "Display"
      Height          =   255
      Left            =   2880
      TabIndex        =   6
      Top             =   2280
      Value           =   1  'Checked
      Width           =   1095
   End
   Begin VB.CheckBox chkSerialO 
      Caption         =   "Serial"
      Height          =   255
      Left            =   2880
      TabIndex        =   5
      Top             =   1920
      Width           =   1095
   End
   Begin VB.CheckBox chkMemO 
      Caption         =   "Memory"
      Height          =   255
      Left            =   2880
      TabIndex        =   4
      Top             =   1560
      Value           =   1  'Checked
      Width           =   1095
   End
   Begin VB.CheckBox chkKeyboard 
      Caption         =   "Keyboard"
      Height          =   255
      Left            =   600
      TabIndex        =   2
      Top             =   2280
      Value           =   1  'Checked
      Width           =   1095
   End
   Begin VB.CheckBox chkSerial 
      Caption         =   "Serial"
      Height          =   255
      Left            =   600
      TabIndex        =   1
      Top             =   1920
      Width           =   1095
   End
   Begin VB.CheckBox chkMemLoc 
      Caption         =   "MEMory"
      Height          =   255
      Left            =   600
      TabIndex        =   0
      Top             =   1560
      Value           =   1  'Checked
      Width           =   1095
   End
   Begin VB.Label Label4 
      Caption         =   "Label4"
      Height          =   375
      Left            =   0
      TabIndex        =   14
      Top             =   3600
      Width           =   1095
   End
   Begin VB.Label Label3 
      Caption         =   "Note: it's extremely easy to end up with a feedback loop - enjoy playing."
      Height          =   495
      Left            =   120
      TabIndex        =   12
      Top             =   960
      Width           =   4215
   End
   Begin VB.Label Label2 
      Caption         =   "(off = blocking MEM input)"
      Height          =   255
      Left            =   0
      TabIndex        =   11
      Top             =   3240
      Width           =   1935
   End
   Begin VB.Line Line24 
      BorderColor     =   &H80000002&
      X1              =   4440
      X2              =   4560
      Y1              =   2880
      Y2              =   2760
   End
   Begin VB.Line Line23 
      BorderColor     =   &H80000002&
      X1              =   4440
      X2              =   4560
      Y1              =   2640
      Y2              =   2760
   End
   Begin VB.Line Line22 
      BorderColor     =   &H80000002&
      X1              =   4080
      X2              =   4560
      Y1              =   2760
      Y2              =   2760
   End
   Begin VB.Line Line21 
      X1              =   4440
      X2              =   4560
      Y1              =   2520
      Y2              =   2400
   End
   Begin VB.Line Line20 
      X1              =   4440
      X2              =   4560
      Y1              =   2280
      Y2              =   2400
   End
   Begin VB.Line Line19 
      X1              =   4080
      X2              =   4560
      Y1              =   2400
      Y2              =   2400
   End
   Begin VB.Line Line18 
      X1              =   4440
      X2              =   4560
      Y1              =   2160
      Y2              =   2040
   End
   Begin VB.Line Line17 
      X1              =   4440
      X2              =   4560
      Y1              =   1920
      Y2              =   2040
   End
   Begin VB.Line Line16 
      X1              =   4080
      X2              =   4560
      Y1              =   2040
      Y2              =   2040
   End
   Begin VB.Line Line15 
      X1              =   4440
      X2              =   4560
      Y1              =   1800
      Y2              =   1680
   End
   Begin VB.Line Line14 
      X1              =   4440
      X2              =   4560
      Y1              =   1560
      Y2              =   1680
   End
   Begin VB.Line Line13 
      X1              =   4080
      X2              =   4560
      Y1              =   1680
      Y2              =   1680
   End
   Begin VB.Line Line12 
      BorderColor     =   &H80000002&
      X1              =   360
      X2              =   480
      Y1              =   2880
      Y2              =   2760
   End
   Begin VB.Line Line11 
      BorderColor     =   &H80000002&
      X1              =   360
      X2              =   480
      Y1              =   2640
      Y2              =   2760
   End
   Begin VB.Line Line10 
      BorderColor     =   &H80000002&
      X1              =   0
      X2              =   480
      Y1              =   2760
      Y2              =   2760
   End
   Begin VB.Line Line9 
      X1              =   360
      X2              =   480
      Y1              =   2520
      Y2              =   2400
   End
   Begin VB.Line Line8 
      X1              =   360
      X2              =   480
      Y1              =   2280
      Y2              =   2400
   End
   Begin VB.Line Line7 
      X1              =   0
      X2              =   480
      Y1              =   2400
      Y2              =   2400
   End
   Begin VB.Line Line6 
      X1              =   360
      X2              =   480
      Y1              =   2160
      Y2              =   2040
   End
   Begin VB.Line Line5 
      X1              =   360
      X2              =   480
      Y1              =   1920
      Y2              =   2040
   End
   Begin VB.Line Line4 
      X1              =   0
      X2              =   480
      Y1              =   2040
      Y2              =   2040
   End
   Begin VB.Line Line3 
      X1              =   360
      X2              =   480
      Y1              =   1800
      Y2              =   1680
   End
   Begin VB.Line Line2 
      X1              =   360
      X2              =   480
      Y1              =   1560
      Y2              =   1680
   End
   Begin VB.Line Line1 
      X1              =   0
      X2              =   480
      Y1              =   1680
      Y2              =   1680
   End
   Begin VB.Label Label1 
      Caption         =   $"frmLynxLinkSetup.frx":0000
      Height          =   735
      Left            =   120
      TabIndex        =   3
      Top             =   120
      Width           =   4215
   End
End
Attribute VB_Name = "frmLynxLinkSetup"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim ret As Integer

Private Sub chkCPM_Click()
ret = mem_set_bit(&H627B, 3, chkCPM.Value, 1)

End Sub

Private Sub chkCPMO_Click()
ret = mem_set_bit(&H627D, 3, chkCPMO.Value, 1)

End Sub

Private Sub chkKeyboard_Click()
ret = mem_set_bit(&H627B, 0, chkKeyboard.Value, 1)

End Sub

Private Sub chkDisplayO_Click()
ret = mem_set_bit(&H627D, 0, chkDisplayO.Value, 1)

End Sub

Private Sub chkMemLoc_Click()
ret = mem_set_bit(&H627B, 1, chkMemLoc.Value, 1)

End Sub

Private Sub chkMemO_Click()
ret = mem_set_bit(&H627D, 1, chkMemO.Value, 1)

End Sub

Private Sub chkSerial_Click()
ret = mem_set_bit(&H627B, 2, chkSerial.Value, 1)

End Sub

Private Sub chkSerialO_Click()
ret = mem_set_bit(&H627D, 2, chkSerialO.Value, 1)

End Sub

Private Sub chkSkipWait_Click()
ret = mem_set_bit(&H627D, 7, chkSkipWait.Value, 1)

End Sub

Private Sub cmdDefault_Click()

chkKeyboard.Value = vbChecked
chkDisplayO.Value = vbChecked

chkMemLoc = vbChecked
chkMemO = vbChecked

chkSerial = vbUnchecked
chkSerialO = vbUnchecked

chkCPM = vbUnchecked
chkCPMO = vbUnchecked

chkSkipWait = vbUnchecked


End Sub

Private Sub Command1_Click()

MsgBox ("See the LynxLink documentation (if it exists) for the full description of the switch/mux software.")



End Sub


Private Sub Timer1_Timer()


  '  If ((peek_mem(&H627D) & &H2) = &H2) Then chkSerialO.Value = vbChecked Else chkSerialO.Value = vbUnchecked
    
   ' Label4.Caption = str((peek_mem(&H627D) & &H2))

End Sub
