VERSION 5.00
Begin VB.Form Form15 
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "CPM VARS"
   ClientHeight    =   7890
   ClientLeft      =   45
   ClientTop       =   285
   ClientWidth     =   6795
   LinkTopic       =   "Form15"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   7890
   ScaleWidth      =   6795
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton Command1 
      Caption         =   "Close"
      Height          =   495
      Left            =   5040
      TabIndex        =   44
      Top             =   7260
      Width           =   1695
   End
   Begin VB.TextBox Text12 
      Height          =   1995
      Left            =   4320
      MultiLine       =   -1  'True
      TabIndex        =   42
      Text            =   "Form15.frx":0000
      Top             =   180
      Width           =   2475
   End
   Begin VB.TextBox Text11 
      Height          =   975
      Left            =   4320
      MultiLine       =   -1  'True
      TabIndex        =   41
      Top             =   2640
      Width           =   2475
   End
   Begin VB.TextBox Text10 
      Height          =   555
      Left            =   4320
      MultiLine       =   -1  'True
      TabIndex        =   40
      Top             =   4320
      Width           =   2475
   End
   Begin VB.TextBox Text9 
      Height          =   285
      Left            =   3660
      TabIndex        =   39
      Top             =   7320
      Width           =   1095
   End
   Begin VB.TextBox Text8 
      Height          =   285
      Left            =   2880
      TabIndex        =   38
      Top             =   7320
      Width           =   555
   End
   Begin VB.TextBox Text7 
      Height          =   285
      Left            =   2040
      TabIndex        =   37
      Top             =   7320
      Width           =   555
   End
   Begin VB.TextBox Text6 
      Height          =   285
      Left            =   960
      TabIndex        =   36
      Top             =   7320
      Width           =   1035
   End
   Begin VB.TextBox txtVect 
      Height          =   285
      Index           =   6
      Left            =   960
      TabIndex        =   35
      Top             =   4920
      Width           =   1455
   End
   Begin VB.TextBox txtVect 
      Height          =   285
      Index           =   5
      Left            =   960
      TabIndex        =   34
      Top             =   5400
      Width           =   1455
   End
   Begin VB.TextBox txtVect 
      Height          =   285
      Index           =   4
      Left            =   960
      TabIndex        =   33
      Top             =   5700
      Width           =   1455
   End
   Begin VB.TextBox txtVect 
      Height          =   285
      Index           =   3
      Left            =   960
      TabIndex        =   32
      Top             =   6000
      Width           =   1455
   End
   Begin VB.TextBox txtVect 
      Height          =   285
      Index           =   2
      Left            =   960
      TabIndex        =   31
      Top             =   6300
      Width           =   1455
   End
   Begin VB.TextBox txtVect 
      Height          =   285
      Index           =   1
      Left            =   960
      TabIndex        =   30
      Top             =   6600
      Width           =   1455
   End
   Begin VB.TextBox txtVect 
      Height          =   285
      Index           =   0
      Left            =   960
      TabIndex        =   29
      Top             =   6900
      Width           =   1455
   End
   Begin VB.TextBox Text5 
      Height          =   495
      Left            =   720
      MultiLine       =   -1  'True
      TabIndex        =   20
      Top             =   4320
      Width           =   3555
   End
   Begin VB.TextBox Text4 
      Height          =   495
      Left            =   720
      MultiLine       =   -1  'True
      TabIndex        =   19
      Top             =   3720
      Width           =   3555
   End
   Begin VB.TextBox Text3 
      Height          =   975
      Left            =   720
      MultiLine       =   -1  'True
      TabIndex        =   15
      Top             =   2640
      Width           =   3555
   End
   Begin VB.TextBox Text2 
      Height          =   315
      Left            =   720
      TabIndex        =   14
      Top             =   2220
      Width           =   675
   End
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Interval        =   500
      Left            =   5700
      Top             =   5700
   End
   Begin VB.TextBox Text1 
      Height          =   1995
      Left            =   660
      MultiLine       =   -1  'True
      TabIndex        =   0
      Text            =   "Form15.frx":000D
      Top             =   180
      Width           =   3615
   End
   Begin VB.Label Label25 
      Caption         =   "0081"
      Height          =   255
      Left            =   0
      TabIndex        =   43
      Top             =   1980
      Width           =   615
   End
   Begin VB.Label Label24 
      Caption         =   "Restart Vector 6"
      Height          =   255
      Left            =   2520
      TabIndex        =   28
      Top             =   5400
      Width           =   2355
   End
   Begin VB.Label Label23 
      Caption         =   "Restart Vector 5"
      Height          =   255
      Left            =   2520
      TabIndex        =   27
      Top             =   5700
      Width           =   2355
   End
   Begin VB.Label Label22 
      Caption         =   "Restart Vector 4"
      Height          =   255
      Left            =   2520
      TabIndex        =   26
      Top             =   6000
      Width           =   2355
   End
   Begin VB.Label Label21 
      Caption         =   "Restart Vector 3"
      Height          =   255
      Left            =   2520
      TabIndex        =   25
      Top             =   6300
      Width           =   2355
   End
   Begin VB.Label Label20 
      Caption         =   "Restart Vector 2"
      Height          =   255
      Left            =   2520
      TabIndex        =   24
      Top             =   6600
      Width           =   2355
   End
   Begin VB.Label Label19 
      Caption         =   "Restart Vector 1"
      Height          =   255
      Left            =   2520
      TabIndex        =   23
      Top             =   6900
      Width           =   2355
   End
   Begin VB.Label Label18 
      Caption         =   "Restart Vector 7 (debuggers)"
      Height          =   255
      Left            =   2520
      TabIndex        =   22
      Top             =   4980
      Width           =   2355
   End
   Begin VB.Label Label17 
      Caption         =   "BIOS Work Area"
      Height          =   255
      Left            =   4380
      TabIndex        =   21
      Top             =   4140
      Width           =   1395
   End
   Begin VB.Label Label16 
      Caption         =   "Unused (CPM 2.2)"
      Height          =   255
      Left            =   4380
      TabIndex        =   18
      Top             =   3840
      Width           =   1395
   End
   Begin VB.Label Label15 
      Caption         =   "File Buffer"
      Height          =   255
      Left            =   4380
      TabIndex        =   17
      Top             =   0
      Width           =   1215
   End
   Begin VB.Label Label14 
      Caption         =   "File Control Block"
      Height          =   375
      Left            =   4320
      TabIndex        =   16
      Top             =   2400
      Width           =   1275
   End
   Begin VB.Label Label13 
      Caption         =   "Command Length (bytes)"
      Height          =   315
      Left            =   1440
      TabIndex        =   13
      Top             =   2280
      Width           =   2175
   End
   Begin VB.Label Label12 
      Caption         =   "0100"
      Height          =   255
      Left            =   0
      TabIndex        =   12
      Top             =   240
      Width           =   615
   End
   Begin VB.Label Label11 
      Caption         =   "0080"
      Height          =   255
      Left            =   0
      TabIndex        =   11
      Top             =   2280
      Width           =   615
   End
   Begin VB.Label Label10 
      Caption         =   "0060"
      Height          =   255
      Left            =   0
      TabIndex        =   10
      Top             =   3540
      Width           =   615
   End
   Begin VB.Label Label9 
      Caption         =   "0050"
      Height          =   255
      Left            =   0
      TabIndex        =   9
      Top             =   4140
      Width           =   615
   End
   Begin VB.Label Label8 
      Caption         =   "0040"
      Height          =   255
      Left            =   0
      TabIndex        =   8
      Top             =   4680
      Width           =   615
   End
   Begin VB.Label Label7 
      Caption         =   "0038"
      Height          =   255
      Left            =   0
      TabIndex        =   7
      Top             =   4980
      Width           =   615
   End
   Begin VB.Label Label6 
      Caption         =   "0008"
      Height          =   255
      Left            =   0
      TabIndex        =   6
      Top             =   6960
      Width           =   615
   End
   Begin VB.Label Label5 
      Caption         =   "0000"
      Height          =   255
      Left            =   0
      TabIndex        =   5
      Top             =   7380
      Width           =   615
   End
   Begin VB.Label Label4 
      Caption         =   "BDOS Jump"
      Height          =   255
      Left            =   3720
      TabIndex        =   4
      Top             =   7680
      Width           =   975
   End
   Begin VB.Label Label3 
      Caption         =   "DSK Byte"
      Height          =   255
      Left            =   2820
      TabIndex        =   3
      Top             =   7680
      Width           =   795
   End
   Begin VB.Label Label2 
      Caption         =   "IO Byte"
      Height          =   255
      Left            =   2100
      TabIndex        =   2
      Top             =   7680
      Width           =   615
   End
   Begin VB.Label Label1 
      Caption         =   "BIOS Jump"
      Height          =   255
      Left            =   960
      TabIndex        =   1
      Top             =   7680
      Width           =   975
   End
End
Attribute VB_Name = "Form15"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim cpmset(256) As Byte


Private Sub Command1_Click()

Unload Me

End Sub

Private Sub Form_Load()

dump_cpmvars = 1
Timer1.Enabled = True


End Sub

Private Sub Form_Unload(Cancel As Integer)

dump_cpmvars = 0

Timer1.Enabled = False

End Sub




Public Sub update_cpmvars()
Dim retr, f As Integer
Dim u As Byte

Dim t As String


Dim command As Byte, data As Byte, epenable As Byte, motor As Byte, precomp As Byte
Dim doptions As Byte, steprate As Byte, status As Byte, drive As Byte, head As Byte, track As Byte, sector As Byte
Dim raw_motor As Long

    'get_diskstat1(command, data, epenable, motor, precomp, steprate)
    'get_diskstat2(drive, head, track, sector)
    retr = get_cpmvars(cpmset(0))
  
  
      Text6.Text = Hex$(cpmset(0)) + " " + Hex$(cpmset(1)) + " " + Hex$(cpmset(2))
      Text7.Text = Hex$(cpmset(3))
      Text8.Text = Hex$(cpmset(4))
      Text9.Text = Hex$(cpmset(5)) + " " + Hex$(cpmset(6)) + " " + Hex$(cpmset(7))
        For f = 0 To 6
            txtVect(f) = Hex$(cpmset(8 + f * 3)) + " " + Hex$(cpmset(8 + f * 3 + 1)) + " " + Hex$(cpmset(8 + f * 3 + 2))
        Next f
  
        Text5.Text = ""
        Text10.Text = ""
        f = 0
        While f < 16
            u = cpmset(64 + f)
            t = Hex$(u)    '0040
            If Len(t) < 2 Then Text5.Text = Text5.Text + "0"
            Text5.Text = Text5.Text + t
            If u >= 32 And u < 128 Then Text10.Text = Text10.Text + Chr$(u)
            f = f + 1
            If f Mod 8 = 0 Then
                Text5.Text = Text5.Text + vbCrLf
                Text10.Text = Text10.Text + vbCrLf
            End If
        Wend
        
        Text4.Text = ""
        f = 0
        While f < 16
            t = Hex$(cpmset(80 + f)) '0050
            If Len(t) < 2 Then Text4.Text = Text4.Text + "0"
            Text4.Text = Text4.Text + t
            f = f + 1
            If f Mod 8 = 0 Then Text4.Text = Text4.Text + vbCrLf
        Wend
  
        text3.Text = ""
        Text11.Text = ""
        f = 0
        While f < 32
            u = cpmset(96 + f)
            t = Hex$(u)    '0060
            If Len(t) < 2 Then text3.Text = text3.Text + "0"
            text3.Text = text3.Text + t
            If u >= 32 And u < 128 Then Text11.Text = Text11.Text + Chr$(u)
            f = f + 1
            If f Mod 8 = 0 Then text3.Text = text3.Text + vbCrLf
        Wend
      
      Text2.Text = Hex$(cpmset(128))
  
        
        Text1.Text = ""
        Text12.Text = ""
        f = 0
        While f < 127
            u = cpmset(129 + f)
            t = Hex$(u)    '0081
            If Len(t) < 2 Then Text1.Text = Text1.Text + "0"
            Text1.Text = Text1.Text + t
            If u >= 32 And u < 128 Then Text12.Text = Text12.Text + Chr$(u)
            f = f + 1
            If f Mod 16 = 0 Then
                Text1.Text = Text1.Text + vbCrLf
                Text12.Text = Text12.Text + vbCrLf
            End If
            
        Wend
    

End Sub




Private Sub Timer1_Timer()

update_cpmvars


End Sub
