VERSION 5.00
Begin VB.Form frmTapemon 
   BorderStyle     =   5  'Sizable ToolWindow
   Caption         =   "Tape Monitor"
   ClientHeight    =   2775
   ClientLeft      =   60
   ClientTop       =   300
   ClientWidth     =   4050
   LinkTopic       =   "Form17"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2775
   ScaleWidth      =   4050
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.PictureBox Picture1 
      AutoRedraw      =   -1  'True
      BackColor       =   &H80000001&
      Height          =   2715
      Left            =   0
      ScaleHeight     =   2655
      ScaleWidth      =   3975
      TabIndex        =   0
      Top             =   0
      Width           =   4035
      Begin VB.CommandButton Command4 
         Caption         =   "+"
         Height          =   255
         Left            =   240
         TabIndex        =   5
         Top             =   300
         Width           =   255
      End
      Begin VB.CommandButton Command3 
         Caption         =   "-"
         Height          =   255
         Left            =   0
         TabIndex        =   4
         Top             =   300
         Width           =   255
      End
      Begin VB.CommandButton Command2 
         Caption         =   "+"
         Height          =   255
         Left            =   240
         TabIndex        =   2
         Top             =   0
         Width           =   255
      End
      Begin VB.CommandButton Command1 
         Caption         =   "-"
         Height          =   255
         Left            =   0
         TabIndex        =   1
         Top             =   0
         Width           =   255
      End
      Begin VB.Timer Timer1 
         Interval        =   200
         Left            =   2040
         Top             =   420
      End
      Begin VB.Label Label2 
         BackColor       =   &H80000007&
         Caption         =   "Zoom"
         ForeColor       =   &H8000000E&
         Height          =   255
         Left            =   480
         TabIndex        =   6
         Top             =   360
         Width           =   675
      End
      Begin VB.Label Label1 
         BackColor       =   &H80000007&
         Caption         =   "Rate"
         ForeColor       =   &H8000000E&
         Height          =   255
         Left            =   480
         TabIndex        =   3
         Top             =   60
         Width           =   675
      End
   End
End
Attribute VB_Name = "frmTapemon"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim tape_monitor(512) As Byte
Dim tape_monitor_last(512) As Byte

Dim tapsamp As Integer


Private Sub update_tape_monitor()
Dim ret, xx, yy, f, noof_leg
Dim dispwidth, dispheight
Dim xzom, yzom, xx_last, yy_last As Variant

dispheight = 256
dispwidth = tapsamp
xzom = Picture1.Width / dispwidth
yzom = Picture1.Height / dispheight

'Rubout the old line
xx = 0
yy = 128
xx_last = xx
yy_last = yy
For f = 1 To 512
    Picture1.Line (xx_last * xzom, yy_last * yzom)-(xx * xzom, yy * yzom), RGB(0, 0, 0) ', B
    xx_last = xx
    yy_last = yy
    xx = xx + 1
    yy = tape_monitor_last(xx)
Next f

Picture1.PSet (0, Picture1.Height / 2)



'Draw the tape monitor
xx = 0
yy = 128
xx_last = xx
yy_last = yy
For f = 1 To 512
 '   If xx = 0 Then Picture1.PSet (xx * xzom, yy * yzom)
'    Picture1.PSet (xx * xzom, yy * yzom), RGB(memmap(f), memmap(f), memmap(f))
'    Picture1.ForeColor = RGB(memmap(f), memmap(f), memmap(f))
    Picture1.Line (xx_last * xzom, yy_last * yzom)-(xx * xzom, yy * yzom), RGB(255, 255, 255) ', B
    xx_last = xx
    yy_last = yy
    xx = xx + 1
    yy = tape_monitor(xx)
    tape_monitor_last(xx) = yy
Next f


End Sub


Private Sub Command1_Click()

If Timer1.Interval < 1000 Then Timer1.Interval = Timer1.Interval + 25

End Sub

Private Sub Command2_Click()

If Timer1.Interval > 25 Then Timer1.Interval = Timer1.Interval - 25

End Sub

Private Sub Command3_Click()

Picture1.Cls


If tapsamp < (512 - 50) Then tapsamp = tapsamp + 50


End Sub

Private Sub Command4_Click()

Picture1.Cls

If tapsamp > 50 Then tapsamp = tapsamp - 50

End Sub

Private Sub Form_Load()

Dim f

For f = 0 To 511
    tape_monitor(f) = 0
    tape_monitor_last(f) = 0
Next f
tapsamp = 512

Timer1.Enabled = True

End Sub


Private Sub Form_Resize()

Picture1.Cls

Picture1.Width = ScaleWidth
Picture1.Height = ScaleHeight

End Sub


Private Sub Form_Unload(Cancel As Integer)

Timer1.Enabled = False


End Sub

Private Sub Timer1_Timer()
Dim ret

ret = get_tape_monitor(tape_monitor(0), tapsamp)


update_tape_monitor




End Sub
