VERSION 5.00
Object = "{248DD890-BB45-11CF-9ABC-0080C7E7B78D}#1.0#0"; "MSWINSCK.OCX"
Begin VB.Form frmLynxnet 
   BackColor       =   &H80000000&
   Caption         =   "LynxNet"
   ClientHeight    =   5760
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   10545
   ControlBox      =   0   'False
   LinkTopic       =   "frmChat"
   ScaleHeight     =   5760
   ScaleWidth      =   10545
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox txtListenPort 
      Height          =   285
      Left            =   840
      TabIndex        =   16
      Text            =   "784"
      Top             =   4680
      Width           =   735
   End
   Begin VB.TextBox txtConnectport 
      Height          =   285
      Left            =   120
      TabIndex        =   15
      Text            =   "554"
      Top             =   2280
      Width           =   735
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Connect"
      Height          =   255
      Left            =   2520
      TabIndex        =   12
      ToolTipText     =   "Connect a listening pc on port 554 (CLIENT)"
      Top             =   2640
      Width           =   1335
   End
   Begin VB.TextBox txtNettext 
      Height          =   5415
      Left            =   3960
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   11
      Top             =   360
      Width           =   3855
   End
   Begin VB.TextBox txtConnectname 
      Height          =   285
      Left            =   2520
      TabIndex        =   10
      Text            =   "russ"
      Top             =   1920
      Width           =   1335
   End
   Begin VB.TextBox txtConnectnum 
      Height          =   285
      Left            =   120
      TabIndex        =   9
      Text            =   "192.168.1.8"
      Top             =   1920
      Width           =   1335
   End
   Begin VB.CommandButton cmdClose 
      Caption         =   "Close"
      Enabled         =   0   'False
      Height          =   495
      Left            =   2520
      TabIndex        =   4
      ToolTipText     =   "Close the connection"
      Top             =   5040
      Width           =   1335
   End
   Begin VB.TextBox txtAvatar 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   330
      Left            =   960
      TabIndex        =   1
      Top             =   1440
      Width           =   2055
   End
   Begin VB.Timer tmrUpdate 
      Interval        =   100
      Left            =   3120
      Top             =   840
   End
   Begin VB.TextBox txtin 
      Height          =   5415
      Left            =   7800
      Locked          =   -1  'True
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   7
      Top             =   360
      Width           =   2775
   End
   Begin VB.CommandButton cmdSend 
      Caption         =   "Send"
      Default         =   -1  'True
      Enabled         =   0   'False
      Height          =   375
      Left            =   2520
      TabIndex        =   6
      ToolTipText     =   "Send data"
      Top             =   4440
      Width           =   1335
   End
   Begin VB.TextBox txtOut 
      Height          =   285
      Left            =   240
      TabIndex        =   5
      Top             =   3960
      Width           =   3615
   End
   Begin VB.CommandButton cmdConnect 
      Caption         =   "Connect"
      Height          =   255
      Left            =   120
      TabIndex        =   3
      ToolTipText     =   "Connect a listening pc on port 554 (CLIENT)"
      Top             =   2640
      Width           =   1335
   End
   Begin VB.CommandButton cmdListen 
      Caption         =   "Listen for Connections"
      Height          =   495
      Left            =   240
      TabIndex        =   2
      ToolTipText     =   "Listen for others to connect you (SERVER)"
      Top             =   5040
      Width           =   2055
   End
   Begin MSWinsockLib.Winsock Sck 
      Left            =   0
      Top             =   480
      _ExtentX        =   741
      _ExtentY        =   741
   End
   Begin VB.Label Label2 
      Caption         =   "Chat Window"
      Height          =   255
      Left            =   8040
      TabIndex        =   14
      Top             =   120
      Width           =   1455
   End
   Begin VB.Label Label1 
      Caption         =   "Collaborative Console"
      Height          =   255
      Left            =   4560
      TabIndex        =   13
      Top             =   120
      Width           =   2055
   End
   Begin VB.Image Image1 
      Appearance      =   0  'Flat
      Height          =   795
      Left            =   1560
      Picture         =   "frmChat.frx":0000
      Top             =   600
      Width           =   870
   End
   Begin VB.Label lblAvatar 
      Caption         =   "Your Avatar"
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
      Left            =   1560
      TabIndex        =   0
      Top             =   240
      Width           =   1095
   End
   Begin VB.Label lblState 
      AutoSize        =   -1  'True
      Caption         =   "Network Status"
      Height          =   195
      Left            =   1440
      TabIndex        =   8
      Top             =   3720
      Width           =   1095
   End
End
Attribute VB_Name = "frmLynxnet"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
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
    Else
        cmdSend.Enabled = False
        cmdClose.Enabled = False
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
End Sub

Private Sub cmdConnect_Click()
    Sck.Connect txtConnectnum, txtTxPort
    ' connect to server listening on port XXX
    UpdateState
End Sub

Private Sub cmdSend_Click()
Dim DataWillBeSent As String

    DataWillBeSent = txtAvatar.Text & " > '" & txtOut.Text & "'" ' add your avatar to the data will sent
    Sck.SendData DataWillBeSent ' sent data
    If txtin.Text = "" Then
        txtin.Text = DataWillBeSent
    Else
        txtin.Text = txtin.Text & vbCrLf & DataWillBeSent
    End If
    txtOut.Text = "" ' clear the textbox
    UpdateState
End Sub

Private Sub cmdClose_Click()
    Sck.Close ' close connection
End Sub

Private Sub sck_ConnectionRequest(ByVal requestID As Long)
    If Sck.State <> sckClosed Then Sck.Close ' if not closed the connection close it
    Sck.Accept requestID ' accept the requestid
End Sub

Private Sub Sck_DataArrival(ByVal bytesTotal As Long)
    Dim IncomeData As String
    Sck.GetData IncomeData ' get data
    If txtin.Text = "" Then
        txtin.Text = IncomeData
    Else
        txtin.Text = txtin.Text & vbCrLf & IncomeData ' append the data to the textbox
    End If
End Sub

Private Sub tmrUpdate_Timer()
UpdateState ' update the state of Sck every 100 miliseconds
End Sub

