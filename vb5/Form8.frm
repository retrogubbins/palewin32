VERSION 5.00
Begin VB.Form Form8 
   BorderStyle     =   5  'Sizable ToolWindow
   Caption         =   "System vArIAbLeS"
   ClientHeight    =   7830
   ClientLeft      =   45
   ClientTop       =   300
   ClientWidth     =   4350
   ControlBox      =   0   'False
   LinkTopic       =   "Form8"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   7830
   ScaleWidth      =   4350
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   1320
      Top             =   4920
   End
   Begin VB.TextBox Text2 
      Height          =   7815
      Left            =   2160
      MultiLine       =   -1  'True
      TabIndex        =   1
      Text            =   "Form8.frx":0000
      Top             =   0
      Width           =   2175
   End
   Begin VB.TextBox Text1 
      Height          =   7815
      Left            =   0
      MultiLine       =   -1  'True
      TabIndex        =   0
      Text            =   "Form8.frx":001B
      Top             =   0
      Width           =   2175
   End
End
Attribute VB_Name = "Form8"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Command1_Click()

Unload Me


End Sub

Private Sub Form_Load()

load_form8_pos

End Sub

Private Sub Form_Unload(Cancel As Integer)

Form5.chkSysvar.Value = vbUnchecked
'dump_6845 = 0

End Sub

Private Sub Timer1_Timer()
Dim ret, f


ret = get_sysvar(query(0), query2(0))


Text1.Text = ""
f = 0
While query(f) <> 0 And f < 500
    If query(f) = 5 Then
        Text1.Text = Text1.Text + vbCrLf
    Else
        Text1.Text = Text1.Text + Chr$(query(f))
    End If
    f = f + 1
Wend

Text2.Text = ""
f = 0
While query2(f) <> 0 And f < 500
    If query2(f) = 5 Then
        Text2.Text = Text2.Text + vbCrLf
    Else
        Text2.Text = Text2.Text + Chr$(query2(f))
    End If
    f = f + 1
Wend


End Sub
