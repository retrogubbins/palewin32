VERSION 5.00
Begin VB.Form Form16 
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "Memory Scanner"
   ClientHeight    =   7935
   ClientLeft      =   45
   ClientTop       =   285
   ClientWidth     =   5205
   LinkTopic       =   "Form16"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   7935
   ScaleWidth      =   5205
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton Command7 
      Caption         =   "+1"
      Height          =   255
      Left            =   3240
      TabIndex        =   14
      Top             =   7620
      Width           =   375
   End
   Begin VB.TextBox Text6 
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
      Left            =   1680
      TabIndex        =   13
      Text            =   "00"
      Top             =   7500
      Width           =   495
   End
   Begin VB.CommandButton Command6 
      Caption         =   "POKE"
      Height          =   375
      Left            =   2280
      TabIndex        =   11
      Top             =   7500
      Width           =   915
   End
   Begin VB.TextBox Text5 
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
      Left            =   60
      TabIndex        =   10
      Text            =   "0000"
      Top             =   7500
      Width           =   1155
   End
   Begin VB.CommandButton Command3 
      Caption         =   "U"
      Height          =   375
      Left            =   1080
      TabIndex        =   9
      Top             =   7080
      Width           =   255
   End
   Begin VB.Timer Timer1 
      Interval        =   250
      Left            =   2040
      Top             =   4020
   End
   Begin VB.CommandButton Command5 
      Caption         =   "Close"
      Height          =   375
      Left            =   3540
      TabIndex        =   8
      Top             =   7080
      Width           =   1455
   End
   Begin VB.TextBox Text4 
      BeginProperty Font 
         Name            =   "Courier"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   7035
      Left            =   3840
      MultiLine       =   -1  'True
      TabIndex        =   7
      Text            =   "Form16.frx":0000
      Top             =   0
      Width           =   1335
   End
   Begin VB.TextBox Text3 
      Height          =   345
      Left            =   2760
      TabIndex        =   6
      Text            =   "0"
      Top             =   7080
      Width           =   735
   End
   Begin VB.CommandButton Command4 
      Caption         =   "Bank"
      Height          =   375
      Left            =   2160
      TabIndex        =   5
      Top             =   7080
      Width           =   555
   End
   Begin VB.TextBox Text2 
      Height          =   345
      Left            =   480
      TabIndex        =   4
      Text            =   "0"
      Top             =   7080
      Width           =   555
   End
   Begin VB.CommandButton Command2 
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
      Left            =   1740
      TabIndex        =   3
      Top             =   7080
      Width           =   375
   End
   Begin VB.CommandButton Command1 
      Caption         =   "-"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   1380
      TabIndex        =   2
      Top             =   7080
      Width           =   375
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
      Height          =   7035
      Left            =   0
      MultiLine       =   -1  'True
      TabIndex        =   0
      Text            =   "Form16.frx":000A
      Top             =   0
      Width           =   3855
   End
   Begin VB.Label Label2 
      Caption         =   "="
      Height          =   255
      Left            =   1320
      TabIndex        =   12
      Top             =   7560
      Width           =   255
   End
   Begin VB.Label Label1 
      Caption         =   "Start"
      Height          =   255
      Left            =   0
      TabIndex        =   1
      Top             =   7140
      Width           =   435
   End
End
Attribute VB_Name = "Form16"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit


Dim memscan(256) As Byte

Dim memscan_bank, start As Integer


Private Sub Command1_Click()

start = (start - 256) Mod 65536
Text2.Text = Hex$(start)

End Sub

Private Sub Command2_Click()

start = (start + 256) Mod 65536
Text2.Text = Hex$(start)

End Sub

Private Sub Command3_Click()

start = Val("&H" + Text2.Text)

End Sub

Private Sub Command4_Click()

memscan_bank = memscan_bank + 1
If memscan_bank > 4 Then memscan_bank = 0


Text3.Text = Hex$(memscan_bank)

End Sub

Private Sub Command5_Click()
Unload Me

End Sub

Private Sub Command6_Click()
Dim ret As Integer


ret = poke_mem(Val("&H" & Text5.Text), Val("&H" & Text6.Text), memscan_bank)



End Sub

Private Sub Command7_Click()
Dim ret As Integer

Text6.Text = Hex$(Val("&H" & Text6.Text) + 1)

ret = poke_mem(Val("&H" & Text5.Text), Val("&H" & Text6.Text), memscan_bank)


End Sub

Private Sub Form_Load()

'dump_memscan = 1
Timer1.Enabled = True
start = 0

'bank = 0       'set in module main()
Text2.Text = Hex$(start)


Text3.Text = Hex$(memscan_bank)
End Sub

Private Sub Form_Unload(Cancel As Integer)

'dump_memscan = 0

Timer1.Enabled = False
End Sub

Private Sub Timer1_Timer()
 Dim f
 Dim u As Byte
 Dim t As String
 Dim retr, s, b As Long
    
 
  
  s = start
  b = memscan_bank
   
   retr = set_memscan(s, b)
   retr = get_memscan(memscan(0))
  
        Text1.Text = ""
        Text4.Text = ""
        f = 0
        Text1.Text = Text1.Text + Hex$(start) + " - "
        While f < 256
            u = memscan(f)
            t = Hex$(u)    '0040
            If Len(t) < 2 Then Text1.Text = Text1.Text + "0"
            Text1.Text = Text1.Text + t + " "
            If u >= 32 And u < 128 Then
                Text4.Text = Text4.Text + Chr$(u)
            Else
                Text4.Text = Text4.Text + "."
            End If
            f = f + 1
            If f Mod 8 = 0 Then
                Text1.Text = Text1.Text + vbCrLf
                Text4.Text = Text4.Text + vbCrLf
                Text1.Text = Text1.Text + Hex$(start + f) + " - "
            End If
        Wend

End Sub
