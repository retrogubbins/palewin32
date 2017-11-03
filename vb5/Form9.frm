VERSION 5.00
Begin VB.Form Form9 
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "PaleTape AutoScan"
   ClientHeight    =   7605
   ClientLeft      =   45
   ClientTop       =   285
   ClientWidth     =   6000
   ControlBox      =   0   'False
   LinkTopic       =   "Form9"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   7605
   ScaleWidth      =   6000
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.CheckBox chkOnlylengmatch 
      Caption         =   "Scan Lengths"
      Height          =   375
      Left            =   4200
      TabIndex        =   9
      Top             =   6660
      Visible         =   0   'False
      Width           =   1695
   End
   Begin VB.CommandButton Command4 
      Caption         =   "Cancel"
      Height          =   375
      Left            =   1440
      TabIndex        =   8
      Top             =   7200
      Width           =   855
   End
   Begin VB.TextBox Text2 
      Height          =   6015
      Left            =   60
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   7
      Text            =   "Form9.frx":0000
      Top             =   0
      Width           =   5895
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Defaults"
      Height          =   375
      Left            =   240
      TabIndex        =   6
      Top             =   7200
      Width           =   915
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Close"
      Height          =   495
      Left            =   4560
      TabIndex        =   5
      Top             =   7080
      Width           =   1395
   End
   Begin VB.CommandButton Command1 
      Caption         =   "SCAN"
      Height          =   495
      Left            =   2340
      TabIndex        =   4
      Top             =   7080
      Width           =   1935
   End
   Begin VB.HScrollBar HScroll1 
      Height          =   375
      Left            =   180
      Max             =   101
      TabIndex        =   3
      Top             =   6120
      Width           =   5475
   End
   Begin VB.CheckBox chkScanspeed 
      Caption         =   "Scan All Speeds"
      Height          =   495
      Left            =   120
      TabIndex        =   2
      Top             =   6600
      Value           =   1  'Checked
      Width           =   1575
   End
   Begin VB.TextBox txtLevels 
      Height          =   405
      Left            =   3360
      TabIndex        =   0
      Text            =   "8"
      Top             =   6600
      Width           =   735
   End
   Begin VB.Label Label1 
      Caption         =   "Threshold Levels"
      Height          =   255
      Left            =   1920
      TabIndex        =   1
      Top             =   6720
      Width           =   1335
   End
End
Attribute VB_Name = "Form9"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim during_calc As Integer




Private Sub chkOnlylengmatch_Click()


'If chkOnlylengmatch.Value = vbChecked Then
'    only_lengmatch = 1
'Else
'    only_lengmatch = 0
'End If

'Save_defaults





End Sub
Private Sub Command1_Click()
Dim f, g, ff, ret As Integer
Dim label As String
Dim progr, stepsiz As Integer
Dim tmp, tot_calcs



' YYYYYaaaaaaaaaaaaaaaaaaaaaaaaaaaa


'  Bodgerooooooooony

'If Command1.Caption = "SCAN" Then
'    Command1.Caption = "CANCEL"
    Text2.Text = vbCrLf + vbCrLf + "Starting Scan..." + vbCrLf
    Form12.convert_params
    'Okay scan the tape file
    progr = 0
    stepsiz = (192 - 64) / Val(txtLevels.Text - 1)
    tot_calcs = 6 * Val(txtLevels.Text)
If chkScanspeed = vbUnchecked Then tot_calcs = 6 * Val(txtLevels.Text)
    during_calc = 1
If chkScanspeed = vbUnchecked Then GoTo bodg1
    
    For g = 0 To 5  'tape speed
        GoTo bodg2:
bodg1:
            g = tape_speed
bodg2:
        For f = 64 To 192 Step stepsiz 'Only look in the middle region
            'Form9.Text2.Text = Form9.Text2.Text + "Speed:" + str(g) + " Threshold:" + str(f) + vbCrLf
            progr = progr + 1
            tmp = (progr / tot_calcs) * 100#
            HScroll1.Value = tmp
     '      MsgBox ("fnam is " + fnam1)
             ret = paletape(fnam1(0), fnam2(0), 0, 1, 1, only_lengmatch, f, g, 0, out_t(0), out_v(0), readin, readreq)
            
      '     MsgBox ("ret is " & str(ret))
           
            If ret = 0 Or ret = 7 Or ret = 8 Then
                ff = 0
                label = ""
                While out_v(ff) <> 0 And ff < 30
                    label = label + Chr$(out_v(ff)) 'out_v(ff))
                    ff = ff + 1
                Wend
                Form9.Text2.Text = Form9.Text2.Text + "Speed: " + str(g) + " Threshold: " + Hex$(f) + " - " + label
                If ret = 7 Then
                    Form9.Text2.Text = Form9.Text2.Text + " Bad Checksum" + vbCrLf
                ElseIf ret = 8 Then
                    Form9.Text2.Text = Form9.Text2.Text + str(readin) + " bytes / " + str(readreq) + vbCrLf
                Else
                    Form9.Text2.Text = Form9.Text2.Text + str(readin) + " bytes Ok" + vbCrLf
                End If
            End If
            If during_calc = 0 Then GoTo byeee
            DoEvents
        Next f

If chkScanspeed = vbUnchecked Then GoTo bodg3
    Next g
bodg3:

byeee:

'                    Form9.Text2.Text = Form9.Text2.Text + " Ok  " '+ vbCrLf
'                End If

End Sub

Private Sub Command2_Click()

Unload Me


End Sub

Private Sub Command3_Click()

chkScanspeed = vbChecked

txtLevels = "8"


End Sub

Private Sub Command4_Click()

during_calc = 0


End Sub

Private Sub Form_Load()




   only_lengmatch = 1


End Sub
