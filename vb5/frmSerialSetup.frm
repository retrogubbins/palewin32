VERSION 5.00
Begin VB.Form frmSerialSetup 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Serial Port"
   ClientHeight    =   7545
   ClientLeft      =   45
   ClientTop       =   345
   ClientWidth     =   3750
   ControlBox      =   0   'False
   LinkTopic       =   "Form19"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   7545
   ScaleWidth      =   3750
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdLynxLinkSetup 
      BackColor       =   &H80000016&
      Caption         =   "LynxLink"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   1680
      TabIndex        =   19
      Top             =   1200
      Width           =   1095
   End
   Begin VB.CommandButton Command4 
      Caption         =   "Exit"
      Height          =   495
      Left            =   2520
      TabIndex        =   10
      Top             =   1920
      Width           =   1215
   End
   Begin VB.CommandButton Command5 
      Caption         =   "Help"
      Height          =   615
      Left            =   3120
      TabIndex        =   18
      Top             =   1200
      Width           =   615
   End
   Begin VB.TextBox txtRecPale 
      Height          =   1335
      Left            =   0
      MultiLine       =   -1  'True
      TabIndex        =   16
      Text            =   "frmSerialSetup.frx":0000
      Top             =   6240
      Width           =   3735
   End
   Begin VB.CheckBox chkHexcodes 
      Caption         =   "Hex Codes"
      Height          =   255
      Left            =   1440
      TabIndex        =   15
      Top             =   2160
      Width           =   1095
   End
   Begin VB.CheckBox chkLogall 
      Caption         =   "Log"
      Height          =   255
      Left            =   1440
      TabIndex        =   14
      Top             =   1920
      Width           =   855
   End
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Interval        =   2
      Left            =   0
      Top             =   0
   End
   Begin VB.TextBox txtTransmit 
      Height          =   1095
      Left            =   0
      MultiLine       =   -1  'True
      TabIndex        =   11
      Top             =   3000
      Width           =   3735
   End
   Begin VB.TextBox txtReceive 
      Height          =   1335
      Left            =   0
      MultiLine       =   -1  'True
      TabIndex        =   9
      Text            =   "frmSerialSetup.frx":0016
      Top             =   4560
      Width           =   3735
   End
   Begin VB.TextBox txtSpeed 
      Height          =   285
      Left            =   2400
      TabIndex        =   8
      Text            =   " "
      Top             =   0
      Width           =   735
   End
   Begin VB.TextBox txtComPort 
      Height          =   285
      Left            =   1800
      TabIndex        =   7
      Text            =   " "
      Top             =   0
      Width           =   495
   End
   Begin VB.ComboBox Combo2 
      Height          =   315
      ItemData        =   "frmSerialSetup.frx":002C
      Left            =   120
      List            =   "frmSerialSetup.frx":0048
      Style           =   2  'Dropdown List
      TabIndex        =   5
      Top             =   1080
      Width           =   1155
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Close Port"
      Enabled         =   0   'False
      Height          =   375
      Left            =   120
      TabIndex        =   4
      Top             =   2040
      Width           =   1215
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Open Port"
      Height          =   375
      Left            =   120
      TabIndex        =   3
      Top             =   1560
      Width           =   1215
   End
   Begin VB.CommandButton Command1 
      Caption         =   "ReScan"
      Height          =   375
      Left            =   2160
      TabIndex        =   2
      Top             =   360
      Width           =   975
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      ItemData        =   "frmSerialSetup.frx":0081
      Left            =   120
      List            =   "frmSerialSetup.frx":0083
      Style           =   2  'Dropdown List
      TabIndex        =   0
      Top             =   420
      Width           =   1995
   End
   Begin VB.Label Label5 
      Caption         =   "Receive from PALE Simulation"
      Height          =   255
      Left            =   120
      TabIndex        =   17
      Top             =   6000
      Width           =   2655
   End
   Begin VB.Label Label4 
      Caption         =   "Receive <type in to transmit to the Lynx>"
      Height          =   255
      Left            =   120
      TabIndex        =   13
      Top             =   4200
      Width           =   3375
   End
   Begin VB.Label Label3 
      Caption         =   "Transmit <type in to transmit to the port>"
      Height          =   255
      Left            =   120
      TabIndex        =   12
      Top             =   2640
      Width           =   3255
   End
   Begin VB.Label Label2 
      Caption         =   "Speed"
      Height          =   255
      Left            =   480
      TabIndex        =   6
      Top             =   840
      Width           =   975
   End
   Begin VB.Label Label1 
      Caption         =   "Serial Port"
      Height          =   255
      Left            =   480
      TabIndex        =   1
      Top             =   120
      Width           =   975
   End
End
Attribute VB_Name = "frmSerialSetup"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Public WithEvents MsComm1 As MSComm
Attribute MsComm1.VB_VarHelpID = -1
 
Private Sub Class_Initialize()
    Set MsComm1 = New MSComm
    

End Sub
 
Private Sub Class_Terminate()
    Set MsComm1 = Nothing
End Sub
 





Private Sub cmdLynxLinkSetup_Click()
   
 '  If peek_mem(&H627C) <> &HC3 Then
        frmLynxLinkSetup.Show
  '  Else
  '      MsgBox ("Note: You must have the LynxLink software loaded (on the emulation or real Lynx) at 7800 to be able to control the Link, at present the link works in emulation mode only. In future this setup screen will allow you to control the state of the software in the Real Lynx attached by passing commands through the link itself.")
  
 '   End If

End Sub

Private Sub Combo1_Click()
 'Get COM port number from combo selection
    comport = Val(Mid$(Combo1.Text, 4, 2))
   
   
    txtComPort.Text = comport
End Sub

Private Sub Combo2_Click()
    speed = Val(Combo2.Text)
   
   
    txtSpeed.Text = speed
End Sub

Private Sub Command1_Click()

   Combo1.Clear
   
    Set WMIObjectSet = GetObject("winmgmts:\\.\root\CIMV2").ExecQuery("SELECT * FROM Win32_SerialPort")
          For Each WMIObject In WMIObjectSet
            Combo1.AddItem WMIObject.properties_("DeviceID") & " - " & WMIObject.properties_("caption")
            'Combo2.AddItem WMIObject.properties_("caption")
          Next
          
End Sub

Private Sub Command2_Click()

 
MsComm1.CommPort = txtComPort.Text
MsComm1.DTREnable = "True"
MsComm1.Handshaking = "2"
MsComm1.InBufferSize = "1024"
MsComm1.InputLen = "1"
MsComm1.InputMode = "0"
MsComm1.NullDiscard = "True"
MsComm1.OutBufferSize = "512"
MsComm1.ParityReplace = "?"
MsComm1.RThreshold = "1"  '"26"
MsComm1.RTSEnable = "True"
MsComm1.Settings = txtSpeed.Text + ",n,8,1"
MsComm1.SThreshold = "0"


MsComm1.PortOpen = True

Command2.Enabled = False
Command4.Enabled = False
Command3.Enabled = True

Timer1.Enabled = True



End Sub

Private Sub Command3_Click()

Timer1.Enabled = False

Command2.Enabled = True
Command4.Enabled = True
Command2.Enabled = True

MsComm1.PortOpen = False

End Sub




' A clone of the VB6's Replace function for use under VB5
' Note: many routines in this collection uses the Replace function
Function Replace(Source As String, Find As String, ReplaceStr As String, _
Optional ByVal start As Long = 1, Optional Count As Long = -1, _
Optional Compare As VbCompareMethod = vbBinaryCompare) As String
Dim findLen As Long
Dim replaceLen As Long
Dim Index As Long
Dim counter As Long
findLen = Len(Find)
replaceLen = Len(ReplaceStr)
' this prevents an endless loop
If findLen = 0 Then err.Raise 5
If start < 1 Then start = 1
Index = start
' let's start by assigning the source to the result
Replace = Source
' if Find and ReplaceStr strings have same length, it is possible to
' use an optimized algorithm, based on the Mid$ command
Do
Index = InStr(Index, Replace, Find, Compare)
If Index = 0 Then Exit Do
If findLen = replaceLen Then
' if the find and replace strings have same length
' we can use the faster Mid$ command
Mid$(Replace, Index, findLen) = ReplaceStr
Else
' else we must use concatenation
Replace = Left$(Replace, Index - 1) & ReplaceStr & Mid$(Replace, _
Index + findLen)
End If
' skip over the string just added
Index = Index + replaceLen
' increment the replacement counter
counter = counter + 1
' Note that the Loop Until test will always fail if Count = -1
Loop Until counter = Count
' The next operation serves to keep complete compatibility with
' VB6's Replace function. You can delete it if you prefer.
If start > 1 Then Replace = Mid$(Replace, start)
End Function


Private Sub Command4_Click()
Unload Me

End Sub

Private Sub Command5_Click()
    MsgBox ("The serial code runs from within VB at present - this makes it very very slow on the link to the outside world, this will be fixed by putting in threaded code for the serial driver in the C underlayer.")
    
End Sub

Private Sub Form_Load()

   Set MsComm1 = New MSComm
   
   Combo1.Clear
   Command1_Click   'the Scan Serial Ports button
   
   'select the first available com port
'   If Combo1.ListCount > 0 Then
 '       Combo1.ListIndex = 1
 '  End If
    
   'set to max baudrate 115200   --  MSCOMM will not countenance anything higher in VB5 era I'm working with
   
   Combo2.ListIndex = Combo2.ListCount - 1
   


End Sub


Private Sub MSComm1_OnComm()

Dim Tex As String
Dim ret As Integer

Tex = MsComm1.Input

'If (MsComm1.InputLen < 1) Then GoTo theEnd
'Get X and Y tilt values
'xTILT = Val(Left$(Tex, 6))
'yTILT = Val(Right$(Tex, 8))
'If Abs(xTILT) > 512 Or Abs(yTILT) > 512 Then
'    lblCommsError.Caption = "COMMS ERROR"
'    Timer3.Enabled = True
'    GoTo theEnd
'End If

'Tex = Replace(Tex, "" & vbLf & "", "" & vbCr & "")
If (MsComm1.InputLen < 1) Then GoTo theEnd


If Tex <> "" Then
    If chkLogall.Value = vbChecked Then
        If chkHexcodes.Value = vbChecked Then
            txtReceive.Text = txtReceive.Text + "<" + Hex$(Asc(Tex)) + ">"
        Else
            txtReceive.Text = txtReceive.Text + Tex
        End If
        If Len(txtReceive) > 200 Then
            txtReceive = ""
        End If
    End If
    ret = poke_mem(&H627A, Asc(Tex), 1)
    
End If

 
theEnd:



End Sub



Private Sub txtReceive_KeyPress(KeyAscii As Integer)
Dim ret As Integer


    ret = poke_mem(&H627A, KeyAscii, 1)
    
    If console_transfer = True Then
            frmLynxnet.txtin.Text = frmLynxnet.txtin.Text & Chr$(KeyAscii)
    End If

End Sub


Private Sub txtTransmit_KeyPress(KeyAscii As Integer)


    MsComm1.Output = Chr$(KeyAscii)
    If console_transfer = True Then
            frmLynxnet.txtOut.Text = frmLynxnet.txtOut.Text & Chr$(KeyAscii)
    End If



End Sub

Private Sub Timer1_Timer()
Dim ret As Integer
Dim b As Integer
Dim c As Byte

'check memory location that is used as the console output
'from the LynxLink software code
'
'Lynxlink can work in two ways - one waits for data to be cleared, one doesnt
'this routine uses the former method
b = peek_mem(&H627C)

If b <> 0 Then
    'data is there, copy it to the REAL serial output line
    
    
    
    
    'zero the data in the emulation
    'this will make LynxLink z80 code
    'stop the keypress action and continue running
    ret = poke_mem(&H627C, 0, 1)
    
    If chkLogall.Value = vbChecked And b <> 0 Then
        c = b
        If chkHexcodes.Value = vbChecked Then
            txtRecPale.Text = txtRecPale.Text + "<" + Hex$(b) + ">"
        Else
            txtRecPale.Text = txtRecPale.Text + Chr$(c) 'safety change to byte
        End If
        If Len(txtRecPale) > 200 Then
            txtRecPale = ""
        End If
        txtRecPale.Text = txtRecPale.Text + Chr$(c)
    End If
    
    'check theres no crud
    If b > 127 Then GoTo skip_bads
    If b > 31 Then GoTo good_chars
        
        If b = 13 Then
            MsComm1.Output = Chr$(10)   'send full return to terminals
            MsComm1.Output = Chr$(13)
        End If
        If b = 31 Then
            MsComm1.Output = Chr$(10)   'send full return to terminals
            MsComm1.Output = Chr$(13)
        End If
        If b = 8 Then
            MsComm1.Output = Chr$(8) 'backspace and erase (lynx)
        End If
        If b = 9 Then
            MsComm1.Output = Chr$(9)   'tab
        End If
        If b = 10 Then
            MsComm1.Output = Chr$(10)   'LF
        End If
        If b = 12 Then
            MsComm1.Output = Chr$(20)   'cursor one block right - simulate with a space
        End If
        If b = 22 Then
            MsComm1.Output = Chr$(8)   'cursor one block back - simulate with a delete
        End If
        GoTo skip_bads
        
good_chars:
    
    
    MsComm1.Output = Chr$(b)
  
    If chkLogall.Value = vbChecked And b <> 0 Then
        c = b
        If chkHexcodes.Value = vbChecked Then
            txtTransmit.Text = txtTransmit.Text + "<" + Hex$(b) + ">"
        Else
            txtTransmit.Text = txtTransmit.Text + Chr$(c) 'safety change to byte
        End If
        If Len(txtTransmit) > 200 Then
            txtTransmit = ""
        End If
        txtTransmit.Text = txtTransmit.Text + Chr$(c)
    End If

skip_bads:

End If

   



End Sub
