VERSION 5.00
Object = "{248DD890-BB45-11CF-9ABC-0080C7E7B78D}#1.0#0"; "MSWINSCK.OCX"
Begin VB.Form frmLynxnet 
   Caption         =   "LynxNet"
   ClientHeight    =   6075
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11610
   ControlBox      =   0   'False
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   9.75
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "frmChat"
   ScaleHeight     =   6075
   ScaleWidth      =   11610
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command1 
      Caption         =   "Help"
      Height          =   615
      Left            =   1560
      TabIndex        =   23
      Top             =   5400
      Width           =   615
   End
   Begin VB.Timer timerJoke 
      Enabled         =   0   'False
      Interval        =   60000
      Left            =   3480
      Top             =   0
   End
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
      Left            =   1440
      TabIndex        =   21
      Top             =   2280
      Width           =   1095
   End
   Begin VB.ComboBox cmbProjectSelect 
      Height          =   360
      ItemData        =   "frmLynxNet.frx":0000
      Left            =   7200
      List            =   "frmLynxNet.frx":0073
      TabIndex        =   19
      Text            =   "select project here"
      Top             =   600
      Width           =   4335
   End
   Begin VB.CommandButton cmdExit 
      Caption         =   "Exit"
      Height          =   495
      Left            =   2520
      TabIndex        =   18
      Top             =   5520
      Width           =   1335
   End
   Begin VB.TextBox txtContex 
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   120
      TabIndex        =   15
      Text            =   "current console data"
      Top             =   5040
      Width           =   3735
   End
   Begin VB.TextBox txtCurrBuff 
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   525
      Left            =   120
      MultiLine       =   -1  'True
      TabIndex        =   14
      Text            =   "frmLynxNet.frx":0474
      Top             =   4560
      Width           =   3735
   End
   Begin VB.CheckBox chkActive 
      Caption         =   "Active"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   10320
      TabIndex        =   13
      Top             =   360
      Width           =   855
   End
   Begin VB.TextBox txtListenPort 
      Alignment       =   2  'Center
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   360
      Left            =   240
      TabIndex        =   12
      Text            =   "784"
      Top             =   3120
      Width           =   855
   End
   Begin VB.TextBox txtRemotePort 
      Alignment       =   2  'Center
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   1800
      TabIndex        =   11
      Text            =   "554"
      Top             =   3480
      Width           =   735
   End
   Begin VB.TextBox txtConsole 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   5055
      Left            =   7200
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   8
      Top             =   960
      Width           =   4335
   End
   Begin VB.TextBox txtConnectnum 
      Alignment       =   2  'Center
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   1440
      TabIndex        =   7
      Text            =   "192.168.1.8"
      Top             =   3120
      Width           =   1335
   End
   Begin VB.CommandButton cmdClose 
      Caption         =   "Close Socket"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   975
      Left            =   2880
      TabIndex        =   3
      Top             =   3120
      Width           =   1095
   End
   Begin VB.TextBox txtAvatar 
      Alignment       =   2  'Center
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   405
      Left            =   1080
      TabIndex        =   0
      Text            =   "Aticratum"
      Top             =   240
      Width           =   2895
   End
   Begin VB.Timer tmrUpdate 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   3120
      Top             =   840
   End
   Begin VB.TextBox txtin 
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "System"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   4335
      Left            =   4080
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   5
      Top             =   360
      Width           =   3015
   End
   Begin VB.TextBox txtOut 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1155
      Left            =   4080
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   4
      Top             =   4800
      Width           =   3015
   End
   Begin VB.CommandButton cmdConnect 
      Caption         =   "Connect"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   1440
      TabIndex        =   2
      Top             =   3840
      Width           =   1335
   End
   Begin VB.CommandButton cmdListen 
      Caption         =   "Listen for Connections"
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
      Left            =   0
      TabIndex        =   1
      Top             =   3480
      Width           =   1335
   End
   Begin MSWinsockLib.Winsock Sck 
      Left            =   360
      Top             =   240
      _ExtentX        =   741
      _ExtentY        =   741
   End
   Begin VB.Label lblAvatarDEMON 
      Alignment       =   2  'Center
      Caption         =   "YOU HAVE INCURRED THE WRATH OF THE DEMONS, YOU WILL BE PUNISHED FOR 1 MINUTE"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Left            =   0
      TabIndex        =   24
      Top             =   1320
      Visible         =   0   'False
      Width           =   3975
   End
   Begin VB.Label lblAvatarGoading 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Left            =   0
      TabIndex        =   22
      Top             =   1080
      Width           =   3975
   End
   Begin VB.Label Label5 
      Caption         =   "Current Project:"
      Height          =   255
      Left            =   7320
      TabIndex        =   20
      Top             =   360
      Width           =   1455
   End
   Begin VB.Line Line1 
      X1              =   240
      X2              =   3720
      Y1              =   3000
      Y2              =   3000
   End
   Begin VB.Label Label4 
      Caption         =   "< enter your aVaTaR or name >"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   1080
      TabIndex        =   17
      Top             =   720
      Width           =   2295
   End
   Begin VB.Label Label3 
      Caption         =   "Status :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   480
      TabIndex        =   16
      Top             =   4200
      Width           =   615
   End
   Begin VB.Label Label2 
      Caption         =   "Chat Window"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   11.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   4200
      TabIndex        =   10
      Top             =   120
      Width           =   1455
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      Caption         =   "Collaborative Console"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   11.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   -1  'True
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   8880
      TabIndex        =   9
      Top             =   120
      Width           =   2295
   End
   Begin VB.Image Image1 
      Appearance      =   0  'Flat
      Height          =   795
      Left            =   120
      Picture         =   "frmLynxNet.frx":0483
      Top             =   120
      Width           =   870
   End
   Begin VB.Label lblState 
      AutoSize        =   -1  'True
      Caption         =   " "
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   360
      Left            =   1080
      TabIndex        =   6
      Top             =   4200
      Width           =   2775
   End
End
Attribute VB_Name = "frmLynxnet"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
   Dim Buff As String
     Dim start_flag As Boolean
 Dim this_is_listener_flag As Boolean


' ***      *** ******   **********  *****
'  ***    ***  **    *  **********  **   *
'   ***  ***   ******       **      *****
'    ******    **    *      **      ****
'     ****     ******       **      **  **
'
' Brings you this source VBTR by Skeleton Soft
' If you want succes Then GoTo http://vbtr.8m.com/
' Visit at: http://vbtr.8m.com/
'
'
' INSTALL:
' 1-Make two .exe of this source
' 2-Run them
' 3-At first one click 'Listen' button
' 4-At second one click 'Connect' button
' 5-Now each one has connected to each other, you can send messages
'
' Note: No animals were harmed in production of this source

Sub UpdateState() ' sub for controling sck.state
    ' is connected ?
    If Sck.State = 7 Then
        cmdSend.Enabled = True
        cmdClose.Enabled = True
        txtConsole.Enabled = True
        'txtin.Enabled = True
        txtOut.Enabled = True
        chkActive.Enabled = True
        If chkActive.Value = vbChecked And frmSerialSetup.Visible = True Then
            If frmSerialSetup.MsComm1.PortOpen = True Then
              console_transfer = True
            End If
        End If
    Else
        cmdSend.Enabled = False
        cmdClose.Enabled = False
        chkActive.Enabled = False
        txtConsole.Enabled = False
        'txtin.Enabled = False
        txtOut.Enabled = False
        console_transfer = False
    End If

    ' print the state of sck
    Select Case Sck.State
        Case 0
            lblState.Caption = "0 - sckClosed"
        Case 1
            lblState.Caption = "1 - sckOpen"
        Case 2
            lblState.Caption = "2 - sckListening"
        Case 3
            lblState.Caption = "3 - sckConnectionPending"
        Case 4
            lblState.Caption = "4 - sckResolvingHost"
        Case 5
            lblState.Caption = "5 - sckHostResolved"
        Case 6
            lblState.Caption = "6 - sckConnecting"
        Case 7
            lblState.Caption = "7 - sckConnected"
        Case 8
            lblState.Caption = "8 - sckClosing"
        Case 9
            lblState.Caption = "9 - sckError"
    End Select
    
End Sub
    
Private Sub cmdListen_Click()
    ' set localport for listening ( you can change it whatever you want )
    Sck.LocalPort = Val(txtListenPort.Text)
    Sck.Listen ' listen for others to connect you
    UpdateState
    cmdConnect.Enabled = False
    cmdExit.Enabled = False
End Sub

Private Sub cmdConnect_Click()
    Sck.Connect txtConnectnum.Text, txtRemotePort.Text
    ' connect to server listening on port XXX
    UpdateState
    cmdListen.Enabled = False
    cmdConnect.Enabled = False
    cmdExit.Enabled = False
  End Sub

Private Sub cmdSend_Click()
Dim DataWillBeSent As String

    DataWillBeSent = txtAvatar.Text & " said, '" & txtOut.Text & "'" ' add your avatar to the data will sent
    Sck.SendData DataWillBeSent ' sent data
    If txtin.Text = "" Then
        txtin.Text = DataWillBeSent
    Else
        txtin.Text = txtin.Text & vbCrLf & vbCrLf & DataWillBeSent
    End If
    txtOut.Text = "" ' clear the textbox
    UpdateState
End Sub

Private Sub cmdClose_Click()
    Sck.Close ' close connection
    cmdListen.Enabled = True
    cmdConnect.Enabled = True
    cmdExit.Enabled = True
    this_is_listener_flag = False
End Sub



Private Sub cmdExit_Click()
    
    
    Unload Me
    
    
End Sub

Private Sub Command1_Click()
    MsgBox ("Note: You must have the LynxLink software loaded (on the emulation or real Lynx) at 7800 to be able to control the Link, at present the link works in emulation mode only. In future this setup screen will allow you to control the state of the software in the Real Lynx attached by passing commands through the link itself.")
    
    MsgBox ("The sockets code is ten lines - it will fall over at the drop of a hat, particularly on closing, 'twill be fixed soon.")
End Sub

Private Sub cmdLynxLinkSetup_Click()

    If peek_mem(&H627C) <> &HC3 Then
        frmLynxLinkSetup.Show
    Else
        Command1_Click
    End If
    

End Sub

Private Sub Form_Load()

    Buff = ""
    start_flag = False
    console_transfer = False
    
End Sub

Private Sub lblAvatar_Click()
    MsgBox ("! ! ! B O O ! ! !")
End Sub

Private Sub Label6_Click()

End Sub

Private Sub sck_ConnectionRequest(ByVal requestID As Long)
    If Sck.State <> sckClosed Then Sck.Close ' if not closed the connection close it
    Sck.Accept requestID ' accept the requestid
    this_is_listener_flag = True
    
End Sub

Public Function Reverse(ByVal sIn As String) As String
    Dim nC As Long
    Dim sOut As String

    For nC = Len(sIn) To 1 Step -1
        sOut = sOut & Mid(sIn, nC, 1)
    Next nC
    
    Reverse = sOut
End Function

Public Function InStrRev(ByVal sIn As String, ByVal _
   sFind As String, Optional nStart As Long = 1, _
    Optional bCompare As VbCompareMethod = vbBinaryCompare) _
    As Long

    Dim nPos As Long
    
    sIn = Reverse(sIn)
    sFind = Reverse(sFind)
    
    nPos = InStr(nStart, sIn, sFind, bCompare)
    If nPos = 0 Then
        InStrRev = 0
    Else
        InStrRev = Len(sIn) - nPos - Len(sFind) + 2
    End If
End Function


Private Sub Sck_DataArrival(ByVal bytesTotal As Long)
    
    Dim IncomeData As String
    Dim FirstBracket As Integer
    Dim SecondBracket As Integer
    Dim Contex As String
  
    Sck.GetData IncomeData ' get the data from the socket
    
    
    If start_flag = False Then
        start_flag = True
        Buff = IncomeData
    Else
        Buff = Buff & vbCrLf & IncomeData ' append the data to the textbox
    End If
    
    'search buffer for console output (this is bracketed by <P< >P>)
    FirstBracket = InStrRev(Buff, "<P<")
    If FirstBracket <> 0 Then
        SecondBracket = InStrRev(Buff, ">P>")
        If SecondBracket <> 0 Then
            If SecondBracket > FirstBracket Then
                'found a pair get the text
                Contex = Mid$(Buff, FirstBracket + 3, SecondBracket - (FirstBracket + 3))
                'remove it from the buffer
                Buff = Left$(Buff, FirstBracket + 2) + Right$(Buff, Len(IncomeData) - (SecondBracket + 2))
                ' and transfer it to the receivinPale textbox
                'BUT - if we are the designated listener then
                'break the loop here to avoid feedback
                If console_transfer = True And this_is_listener_flag = False Then
                        frmSerialSetup.txtRecPale.Text = frmSerialSetup.txtRecPale.Text & Contex
                        Console.Text = Console.Text & Contex
                End If
                txtCurrBuff.Text = ""
                txtContex.Text = Contex
            Else
                'resynch - remove the >p> bracket which is earlier, belonged to a lost start pair
                Buff = Left$(Buff, SecondBracket - 1) + Right$(Buff, Len(IncomeData) - (SecondBracket + 2))
                txtCurrBuff.Text = Buff
                txtContex.Text = "resynching..."
            End If
        End If
    End If
    
    'search again for brackets, if there are none then display whats left as chat
    FirstBracket = InStrRev(Buff, "<P<")
    SecondBracket = InStrRev(Buff, ">P>")
    If FirstBracket = 0 And SecondBracket = 0 Then
        If txtin.Text = "" Then
            txtin.Text = Buff
        Else
           txtin.Text = txtin.Text & vbCrLf & vbCrLf & Buff ' append the data to the textbox
        End If
    End If
 '   Else
        'There are fragments of console still in the buffer
        'if anything it should be an opening bracket without a pair
        'ending it yet.
        





End Sub

Private Sub timerJoke_Timer()


txtAvatar.Enabled = True
 lblAvatarGoading.Visible = True
 lblAvatarDEMON.Visible = False
   
timerJoke.Enabled = False


End Sub

Private Sub tmrUpdate_Timer()
    UpdateState ' update the state of Sck every 100 miliseconds
End Sub

Private Sub txtAvatar_Change()

If Len(txtAvatar.Text) > 5 Then lblAvatarGoading.Caption = "make it a good one..."
If Len(txtAvatar.Text) > 6 Then lblAvatarGoading.Caption = "better..."
If Len(txtAvatar.Text) > 10 Then lblAvatarGoading.Caption = "okay, now we're getting somewhere"
If Len(txtAvatar.Text) > 15 Then lblAvatarGoading.Caption = "well go on then... put an AND in it"
If Len(txtAvatar.Text) > 20 Then lblAvatarGoading.Caption = "you don''t think '' provider of pure majestic power throughout all the universe and defeater of the Scuttlebug armies and their torments of doom'' would be better?"
If Len(txtAvatar.Text) > 26 Then lblAvatarGoading.Caption = "bandwidth costs tha'' knows"
If Len(txtAvatar.Text) > 30 Then lblAvatarGoading.Caption = "enough already! its a SERIAL line"
If Len(txtAvatar.Text) > 32 Then
    lblAvatarGoading.Visible = False
    lblAvatarDEMON.Visible = True
    
    '.Caption = "YOU HAVE INCURRED THE WRATH OF THE DEMONS, YOU WILL BE PUNISHED FOR 1 MINUTE"
    txtAvatar.Text = "FluffyRabbitBunkins"
    txtAvatar.Enabled = False
    timerJoke.Enabled = True
End If

If txtAvatar.Text = "Russ" Or txtAvatar.Text = "russ" Then txtAvatar.Text = txtAvatar.Text + " baby doodski ya dig"

End Sub

Private Sub txtin_Change()
    txtin.SelStart = Len(txtin.Text)
    txtin.SelLength = 0
End Sub

Private Sub txtConsole_Change()
    txtConsole.SelStart = Len(txtConsole.Text)
    txtConsole.SelLength = 0
End Sub


Private Sub txtConsole_keypress(KeyAscii As Integer)
    ' collaborative console send data wrapped in brackets to remote Lynx/Pale installation
    frmSerialSetup.MsComm1.Output = "<P<" & Chr$(KeyAscii) & ">P>"
    

End Sub

