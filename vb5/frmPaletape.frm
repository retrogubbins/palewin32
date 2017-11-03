VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Object = "{6BF52A50-394A-11D3-B153-00C04F79FAA6}#1.0#0"; "wmp.dll"
Begin VB.Form Form12 
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "PaleTape Tape Reader"
   ClientHeight    =   8115
   ClientLeft      =   45
   ClientTop       =   285
   ClientWidth     =   10830
   ControlBox      =   0   'False
   LinkTopic       =   "Form12"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   8115
   ScaleWidth      =   10830
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox txtT2WI 
      Height          =   285
      Left            =   120
      TabIndex        =   26
      Text            =   "d:\pale\paletape\debug\ok.raw"
      Top             =   5880
      Width           =   3855
   End
   Begin VB.TextBox txtT2WO 
      Height          =   285
      Left            =   120
      TabIndex        =   25
      Text            =   "d:\pale\paletape\debug\ok.raw"
      Top             =   6360
      Width           =   3855
   End
   Begin VB.CommandButton Command11 
      Caption         =   "TAP2WAV (select raw/wav type first)"
      Height          =   615
      Left            =   4080
      TabIndex        =   24
      Top             =   5880
      Width           =   1455
   End
   Begin VB.CheckBox chkShowlinenos 
      Caption         =   "Show Line Numbers"
      Height          =   255
      Left            =   8940
      TabIndex        =   23
      Top             =   60
      Width           =   1875
   End
   Begin VB.CommandButton Command10 
      Caption         =   "-"
      Height          =   255
      Left            =   3540
      TabIndex        =   22
      Top             =   3900
      Width           =   315
   End
   Begin VB.CommandButton Command9 
      Caption         =   "+"
      Height          =   255
      Left            =   3540
      TabIndex        =   21
      Top             =   3600
      Width           =   315
   End
   Begin VB.CommandButton Command8 
      Caption         =   "AutoScan"
      Height          =   615
      Left            =   3960
      TabIndex        =   20
      Top             =   3480
      Width           =   1455
   End
   Begin VB.CheckBox Check1 
      Caption         =   "verbose mode"
      Height          =   195
      Left            =   4080
      TabIndex        =   19
      Top             =   120
      Visible         =   0   'False
      Width           =   1455
   End
   Begin VB.CommandButton Command7 
      Caption         =   "--- Help ---"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   3720
      TabIndex        =   18
      Top             =   4560
      Width           =   1755
   End
   Begin VB.CommandButton Command6 
      Caption         =   "AutoSense"
      Height          =   375
      Left            =   2160
      TabIndex        =   17
      Top             =   4860
      Width           =   1335
   End
   Begin VB.CommandButton Command5 
      Caption         =   "Close"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   8940
      TabIndex        =   16
      Top             =   5160
      Width           =   1815
   End
   Begin MSComDlg.CommonDialog CommonDialog2 
      Left            =   1680
      Top             =   3480
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin MSComDlg.CommonDialog CommonDialog1 
      Left            =   1200
      Top             =   3480
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.ComboBox cmbSpeed 
      Height          =   315
      ItemData        =   "frmPaletape.frx":0000
      Left            =   1200
      List            =   "frmPaletape.frx":0016
      Style           =   2  'Dropdown List
      TabIndex        =   14
      Top             =   4920
      Width           =   855
   End
   Begin VB.CommandButton Command4 
      Caption         =   "Default"
      Height          =   375
      Left            =   2760
      TabIndex        =   12
      Top             =   3720
      Width           =   735
   End
   Begin VB.TextBox txtThresh 
      Height          =   375
      Left            =   2160
      TabIndex        =   11
      Text            =   "85"
      Top             =   3720
      Width           =   615
   End
   Begin VB.TextBox txtOFI 
      Height          =   285
      Left            =   1680
      TabIndex        =   9
      Text            =   "d:\pale\paletape\debug\ok.tap"
      Top             =   3120
      Width           =   3855
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Output TAP File"
      Height          =   255
      Left            =   120
      TabIndex        =   8
      Top             =   3120
      Width           =   1455
   End
   Begin VB.TextBox txtOutput 
      Height          =   2295
      Left            =   120
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   7
      Text            =   "frmPaletape.frx":002C
      Top             =   360
      Width           =   5415
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Input RAW File"
      Height          =   255
      Left            =   120
      TabIndex        =   6
      Top             =   2760
      Width           =   1455
   End
   Begin VB.TextBox txtIFI 
      Height          =   285
      Left            =   1680
      TabIndex        =   5
      Text            =   "d:\pale\paletape\debug\ok.raw"
      Top             =   2760
      Width           =   3855
   End
   Begin VB.ComboBox cmbFormat 
      Height          =   315
      ItemData        =   "frmPaletape.frx":008A
      Left            =   2160
      List            =   "frmPaletape.frx":0094
      Style           =   2  'Dropdown List
      TabIndex        =   3
      Top             =   4320
      Width           =   1335
   End
   Begin VB.TextBox txtInfo 
      BeginProperty Font 
         Name            =   "Courier"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   4695
      Left            =   5640
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   1
      Top             =   360
      Width           =   5175
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Read the tape"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   5640
      TabIndex        =   0
      Top             =   5160
      Width           =   2955
   End
   Begin WMPLibCtl.WindowsMediaPlayer MEDIAPLAYER 
      Height          =   2055
      Left            =   5640
      TabIndex        =   27
      Top             =   5880
      Width           =   4575
      URL             =   ""
      rate            =   1
      balance         =   0
      currentPosition =   0
      defaultFrame    =   ""
      playCount       =   1
      autoStart       =   -1  'True
      currentMarker   =   0
      invokeURLs      =   -1  'True
      baseURL         =   ""
      volume          =   50
      mute            =   0   'False
      uiMode          =   "full"
      stretchToFit    =   0   'False
      windowlessVideo =   0   'False
      enabled         =   0   'False
      enableContextMenu=   -1  'True
      fullScreen      =   0   'False
      SAMIStyle       =   ""
      SAMILang        =   ""
      SAMIFilename    =   ""
      captioningID    =   ""
      enableErrorDialogs=   0   'False
      _cx             =   8070
      _cy             =   3625
   End
   Begin VB.Line Line1 
      X1              =   120
      X2              =   10680
      Y1              =   5760
      Y2              =   5760
   End
   Begin VB.Label Label5 
      Caption         =   "Status Info"
      Height          =   255
      Left            =   240
      TabIndex        =   15
      Top             =   120
      Width           =   915
   End
   Begin VB.Label Label4 
      Caption         =   "Tape Speed"
      Height          =   375
      Left            =   120
      TabIndex        =   13
      Top             =   4980
      Width           =   1095
   End
   Begin VB.Label Label3 
      Caption         =   "Tape Threshold (Hex)"
      Height          =   375
      Left            =   120
      TabIndex        =   10
      Top             =   3840
      Width           =   2055
   End
   Begin VB.Label Label2 
      Caption         =   "File Format"
      Height          =   255
      Left            =   120
      TabIndex        =   4
      Top             =   4380
      Width           =   1095
   End
   Begin VB.Label Label1 
      Caption         =   "Tape Info"
      Height          =   255
      Left            =   5640
      TabIndex        =   2
      Top             =   120
      Width           =   2055
   End
End
Attribute VB_Name = "Form12"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit



Dim ret As Integer
Dim f As Integer

Public Sub clear_texts()
    Form12.txtInfo.Text = ""
    Form12.txtOutput.Text = "OK here goes nothing..." + vbCrLf + vbCrLf
    out_t(0) = 0

End Sub


Public Sub convert_params()
    
t_thresh = Val("&H" & Form12.txtThresh.Text)
tape_speed = Val("&H" & Form12.cmbSpeed.Text)
raw_tape = Val("&H" & Form12.cmbFormat.ListIndex)

For f = 1 To Len(Form12.txtIFI.Text)
    fnam1(f - 1) = Asc(Mid$(Form12.txtIFI.Text, f, 1))
Next f
fnam1(f - 1) = 0

'MsgBox ("fnam1(end) is " + str(fnam1(f - 2)))

For f = 1 To Len(Form12.txtOFI.Text)
    fnam2(f - 1) = Asc(Mid$(Form12.txtOFI.Text, f, 1))
Next f
fnam2(f - 1) = 0

'MsgBox "ok"
'For f = 1 To Len(Form12.CommonDialog1.Filename)
'    fnam(f - 1) = Asc(Mid$(Form12.CommonDialog1.Filename, f, 1))
'Next f
'fnam(f) = 0
'MsgBox "Speed is " + str(tape_speed)
'MsgBox "raw is " + str(raw_tape)
'MsgBox "thresh is " + str(t_thresh)



End Sub


Private Sub parse_output()

If ret = 0 Then
    Form12.txtOutput.Text = Form12.txtOutput.Text + "OK Done it, all smiles :)" + vbCr + vbLf
Else
    Form12.txtOutput.Text = Form12.txtOutput.Text + "arse! an error" + str(ret) + " - "
    If ret = 1 Then Form12.txtOutput.Text = Form12.txtOutput.Text + "Error reading input RAW file"
    If ret = 2 Then Form12.txtOutput.Text = Form12.txtOutput.Text + "Couldnt open file for reading"
    If ret = 3 Then Form12.txtOutput.Text = Form12.txtOutput.Text + "Couldn't Find the A5 Marker" + vbCrLf + "*** try removing the sync zeroes at the start ***" + vbCrLf + "*** did you set the correct speed? ***" + vbCrLf + "*** Check the Threshold Value ***"
    If ret = 4 Then Form12.txtOutput.Text = Form12.txtOutput.Text + "Couldn't Get Recognizable Filename"
    If ret = 5 Then Form12.txtOutput.Text = Form12.txtOutput.Text + "Couldn't Find the A5 Marker(2)" + vbCrLf + "*** try removing the sync zeroes at the start ***" + vbCrLf + "*** did you set the correct speed? ***" + vbCrLf + "*** Check the Threshold Value ***"
    If ret = 6 Then Form12.txtOutput.Text = Form12.txtOutput.Text + "Couldnt open TAP file for writing - dugh!"
    If ret = 7 Then Form12.txtOutput.Text = Form12.txtOutput.Text + "Bad Checksum"
    If ret = 8 Then Form12.txtOutput.Text = Form12.txtOutput.Text + "Wrong File Length"
    Form12.txtOutput.Text = Form12.txtOutput.Text + vbCr + vbLf
End If
    'update the tape info window
  '     Form12.txtInfo.Text = ""
        f = 0
        While out_t(f) <> 0 And f < 10000
        Form12.txtInfo.Text = Form12.txtInfo.Text + Chr$(out_t(f))
        f = f + 1
        Wend
  '   Form12.txtInfo.Text = out_t

'add more info to the Status window
'If verbo = 1 Then
'End If


End Sub



Private Sub Command1_Click()
Dim verbo, tff As Integer


clear_texts
 
convert_params

'If Check1.Value = vbChecked Then verbo = 1 Else verbo = 0
If chkShowlinenos = vbChecked Then tff = 1 Else tff = 0


ret = paletape(fnam1(0), fnam2(0), tff, 0, 0, only_lengmatch, t_thresh, tape_speed, raw_tape, out_t(0), out_v(0), readin, readreq)

parse_output



End Sub

Private Sub Command10_Click()

Dim verbo, tff  As Integer

txtThresh.Text = Hex$(Val("&H" + txtThresh.Text) - 1)

clear_texts
 
convert_params

'If Check1.Value = vbChecked Then verbo = 1 Else verbo = 0
If chkShowlinenos = vbChecked Then tff = 1 Else tff = 0


ret = paletape(fnam1(0), fnam2(0), tff, 0, 0, only_lengmatch, t_thresh, tape_speed, raw_tape, out_t(0), out_v(0), readin, readreq)

parse_output



End Sub

' THIS IS THE TAP 2 WAV
' THIS IS THE TAP 2 WAV
' THIS IS THE TAP 2 WAV
' THIS IS THE TAP 2 WAV

Private Sub Command11_Click()
Dim f, tff As Integer
Dim found As Boolean



Form12.CommonDialog1.Filter = "TAP Files (*.tap)|*.tap|All files" & _
    "(*.*)|*.*"
Form12.CommonDialog1.Flags = cdlOFNHideReadOnly
Form12.CommonDialog1.FilterIndex = 1
Form12.CommonDialog1.ShowOpen

Form12.txtT2WI.Text = Form12.CommonDialog1.Filename

Form12.CommonDialog1.Filter = "WAV Files (*.wav)|*.wav|All files" & _
    "(*.*)|*.*"
Form12.CommonDialog1.Flags = cdlOFNHideReadOnly
Form12.CommonDialog1.FilterIndex = 1
Form12.CommonDialog1.ShowOpen

Form12.txtT2WO.Text = Form12.CommonDialog1.Filename

For f = 1 To Len(Form12.txtT2WI.Text)
    fnam1(f - 1) = Asc(Mid$(Form12.txtT2WI.Text, f, 1))
Next f
fnam1(f - 1) = 0

'MsgBox ("fnam1(end) is " + str(fnam1(f - 2)))

For f = 1 To Len(Form12.txtT2WO.Text)
    fnam2(f - 1) = Asc(Mid$(Form12.txtT2WO.Text, f, 1))
Next f
fnam2(f - 1) = 0

ret = tap2wav(fnam1(0), fnam2(0))

MEDIAPLAYER.Enabled = True
MEDIAPLAYER.URL = Form12.txtT2WO.Text

If ret = 1 Then
    MsgBox ("Sorry It Didn't Work :( ")

MEDIAPLAYER.Enabled = False
    
End If






End Sub

Private Sub Command2_Click()

'Form12.CommonDialog1.Filename = ""

Form12.CommonDialog1.Filter = "RAW Files (*.raw)|*.raw|All files" & _
    "(*.*)|*.*"
Form12.CommonDialog1.Flags = cdlOFNHideReadOnly
Form12.CommonDialog1.FilterIndex = 1
Form12.CommonDialog1.ShowOpen

Form12.txtIFI = Form12.CommonDialog1.Filename

End Sub

Private Sub Command3_Click()



Form12.CommonDialog2.Filter = "TAP Files (*.tap)|*.tap|All files" & _
    "(*.*)|*.*"
Form12.CommonDialog2.Flags = cdlOFNHideReadOnly
Form12.CommonDialog2.FilterIndex = 1
Form12.CommonDialog2.ShowOpen

Form12.txtOFI = Form12.CommonDialog2.Filename


End Sub

Private Sub Command4_Click()

txtThresh = "85"



End Sub

Private Sub Command5_Click()

Unload Me


End Sub

Private Sub Command6_Click()
Dim f, tff As Integer
Dim found As Boolean


convert_params
found = False
For f = 0 To 5
' MsgBox "Doing speed " + str(f)
 clear_texts
    ret = paletape(fnam1(0), fnam2(0), 0, 1, 1, only_lengmatch, t_thresh, f, raw_tape, out_t(0), out_v(0), readin, readreq)
    If ret = 0 Then
        tape_speed = f
        'Form12.cmbSpeed.Text = str(tape_speed)
        Form12.cmbSpeed.ListIndex = tape_speed
        found = True
    End If
Next f
clear_texts

If chkShowlinenos = vbChecked Then tff = 1 Else tff = 0
ret = paletape(fnam1(0), fnam2(0), tff, 0, 0, only_lengmatch, t_thresh, tape_speed, raw_tape, out_t(0), out_v(0), readin, readreq)
parse_output

If found = False Then MsgBox "Sorry, I tried all 6 TAPE speeds but I couldn't read it :("



End Sub

Private Sub Command7_Click()


Form13.Show


End Sub

Private Sub Command8_Click()

Form9.Show


End Sub

Private Sub Command9_Click()



Dim verbo, tff As Integer

txtThresh.Text = Hex$(Val("&H" + txtThresh.Text) + 1)

clear_texts
 
convert_params

'If Check1.Value = vbChecked Then verbo = 1 Else verbo = 0

If chkShowlinenos = vbChecked Then tff = 1 Else tff = 0

ret = paletape(fnam1(0), fnam2(0), tff, 0, 0, only_lengmatch, t_thresh, tape_speed, raw_tape, out_t(0), out_v(0), readin, readreq)

parse_output




End Sub

Private Sub Form_Load()


only_lengmatch = 0

'Stop the emulator
'Form1.StopEmu
'DoEvents


End Sub

Private Sub Form_Unload(Cancel As Integer)


'Restart the emulator
Form1.Timer3.Enabled = True


End Sub

Private Sub txtOutput_Change()

'move to the end of the text
Form12.txtOutput.SelLength = 0
Form12.txtOutput.SelStart = Len(Form12.txtOutput.Text)



End Sub

