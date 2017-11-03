VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Begin VB.Form frmRevDisas 
   Caption         =   "Symbolic Disassembler"
   ClientHeight    =   8700
   ClientLeft      =   120
   ClientTop       =   420
   ClientWidth     =   9750
   LinkTopic       =   "Form18"
   ScaleHeight     =   8700
   ScaleWidth      =   9750
   StartUpPosition =   3  'Windows Default
   Begin VB.CheckBox chkVerbose 
      Caption         =   "Verbose"
      Height          =   375
      Left            =   7560
      TabIndex        =   19
      Top             =   5160
      Width           =   1215
   End
   Begin VB.TextBox txtMaxlines 
      Height          =   285
      Left            =   6840
      TabIndex        =   18
      Text            =   "0"
      Top             =   7080
      Width           =   855
   End
   Begin VB.TextBox txtCounter 
      Height          =   285
      Left            =   2760
      TabIndex        =   14
      Text            =   "0"
      Top             =   7080
      Width           =   975
   End
   Begin VB.TextBox txtStart 
      Height          =   285
      Left            =   4800
      TabIndex        =   13
      Text            =   "0"
      Top             =   7080
      Width           =   975
   End
   Begin VB.CheckBox chkListSymbols 
      Caption         =   "List Symbols"
      Height          =   375
      Left            =   7560
      TabIndex        =   12
      Top             =   600
      Width           =   1455
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Process"
      Height          =   735
      Left            =   6240
      TabIndex        =   11
      Top             =   7920
      Width           =   1575
   End
   Begin VB.CheckBox chkHex 
      Caption         =   "Print HEX"
      Height          =   375
      Left            =   7560
      TabIndex        =   10
      Top             =   2160
      Width           =   1215
   End
   Begin VB.CheckBox chkNumLine 
      Caption         =   "Number Lines"
      Height          =   375
      Left            =   7560
      TabIndex        =   9
      Top             =   1440
      Width           =   1575
   End
   Begin VB.CheckBox chkJP 
      Caption         =   "JP Subroutines"
      Height          =   375
      Left            =   7560
      TabIndex        =   8
      Top             =   3960
      Width           =   1455
   End
   Begin VB.CheckBox chkC9 
      Caption         =   "C9 Subroutines"
      Height          =   375
      Left            =   7560
      TabIndex        =   7
      Top             =   3480
      Width           =   1575
   End
   Begin VB.CheckBox chkRom 
      Caption         =   "ROM routines"
      Height          =   375
      Left            =   7560
      TabIndex        =   6
      Top             =   2880
      Width           =   1455
   End
   Begin VB.CheckBox chk128 
      Caption         =   "Lynx 128"
      Height          =   375
      Left            =   3600
      TabIndex        =   5
      Top             =   7920
      Width           =   1215
   End
   Begin VB.CheckBox chk4896 
      Caption         =   "Lynx 48/96"
      Height          =   375
      Left            =   2160
      TabIndex        =   4
      Top             =   7920
      Width           =   1215
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Close"
      Height          =   495
      Left            =   8040
      TabIndex        =   3
      Top             =   8040
      Width           =   1455
   End
   Begin VB.TextBox txtFilename 
      Height          =   375
      Left            =   2160
      TabIndex        =   2
      Text            =   "noname"
      Top             =   7440
      Width           =   4935
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Open File"
      Height          =   495
      Left            =   720
      TabIndex        =   1
      Top             =   7440
      Width           =   1095
   End
   Begin VB.TextBox txtList 
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
      Left            =   240
      MultiLine       =   -1  'True
      TabIndex        =   0
      Text            =   "frmRevDisas.frx":0000
      Top             =   0
      Width           =   7215
   End
   Begin MSComDlg.CommonDialog CommonDialog1 
      Left            =   360
      Top             =   8160
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.Label Label3 
      Caption         =   "Max Lines"
      Height          =   255
      Left            =   6000
      TabIndex        =   17
      Top             =   7080
      Width           =   735
   End
   Begin VB.Label Label2 
      Caption         =   "Offset"
      Height          =   255
      Left            =   4200
      TabIndex        =   16
      Top             =   7080
      Width           =   495
   End
   Begin VB.Label Label1 
      Caption         =   "Start"
      Height          =   255
      Left            =   2160
      TabIndex        =   15
      Top             =   7080
      Width           =   495
   End
End
Attribute VB_Name = "frmRevDisas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim listing(80000) As Byte



Private Sub Command1_Click()


Dim buf As String
Dim fnam(200) As Byte
Dim retstring(200) As Byte

Dim f, ret As Integer
Dim fno
Dim line_in As String
Dim fIndex As Integer
Dim Filename As String
Dim retr, l_count


Dim in_fnam(300) As Byte

'On Error GoTo err

frmRevDisas.CommonDialog1.Filter = "ROM Files (*.rom)|*.rom|All files" & _
    "(*.*)|*.*"
frmRevDisas.CommonDialog1.Flags = cdlOFNHideReadOnly
CommonDialog1.FilterIndex = 1
CommonDialog1.ShowOpen

txtFilename.Text = CommonDialog1.Filename

's = "SET" + str(current_set) + "ROM" + str(Index)
'SaveS s, txtFilename.Text



'For f = 1 To Len(CommonDialog1.Filename)
'    in_fnam(f - 1) = Asc(Mid$(CommonDialog1.Filename, f, 1))
'Next f
'in_fnam(f) = 0

'CommonDialog1.CancelError = True    'this traps user hitting cancel button
'Form1.StopEmu

'DoEvents


'fnam(f) = 0
   ' On Error Resume Next
    ' Open the selected file.
'    fno = FreeFile()
    
'    Open frmRevDisas.CommonDialog1.Filename For Input As #fno
'    If err Then
'        MsgBox "Can't open file: " + Filename
'        Exit Sub
'    End If
    ' Change the mouse pointer to an hourglass.
  '  Screen.MousePointer = 11
'    Form5.text3.Text = ""
    
'   txtList.Text = ""
   
'    While Not EOF(fno)
'        Input #fno, line_in
'        Form5.text3.Text = Form5.text3.Text & line_in & vbCr & vbLf
 '        send_to_lynx ("WOWWWEEE")
'                send_to_lynx (line_in)
'For f = 1 To Len(line_in)
'txtList.Text = txtList.Text + line_in

 '   If Asc(Mid$(line_in, f, 1)) <> 10 Then send_to_lynx (Mid$(line_in, f, 1))
  '  DoEvents
'    send_to_lynx ("X")
'Next f
 '   send_to_lynx (vbCr)

    
       '   send_to_lynx ("WOWWWEEE")
    '      MsgBox "sent Line"
 '   Wend
    ' Change the form's caption and display the new text.
  '  Close #fno
    ' Reset the mouse pointer.
 '   Screen.MousePointer = 0

'    send_to_lynx (Form5.text3.Text)
    

'err:
'MsgBox "AN EROR"

'Exit Sub

'Form1.Timer3.Enabled = True


'        retr = disassemble_file(in_fnam(0), listing(0), 0)
           'Okay, PC address should be the 6th line of the output text
'            f = 0
'            l_count = 0
'            frmRevDisas.txtList.Text = ""
'            While listing(f) <> 0 And f < 500
'                frmRevDisas.txtList.Text = frmRevDisas.txtList.Text + Chr$(listing(f))
'                If query(f) = Asc(vbLf) Then
'                    l_count = l_count + 1
'                    If l_count = 5 Then frmRevDisas.txtList.Text = frmRevDisas.txtList.Text + "->"
'                End If
'                f = f + 1
'            Wend
      '  Else
        
        
'Form1.RunEmu

'DoEvents







End Sub

Private Sub Command2_Click()


frmRevDisas.Hide

End Sub

Private Sub Command3_Click()

Dim f, ret As Integer
Dim in_fnam(300) As Byte

Dim a, b, c, d, e, g, h, i, j, k, l_count As Integer

For f = 1 To Len(txtFilename.Text)
    in_fnam(f - 1) = Asc(Mid$(txtFilename.Text, f, 1))
Next f

a = 0: b = 0: c = 0: d = 0: e = 0: g = 0: h = 0: i = 0: j = 0: k = 0

If chk4896.Value = vbChecked Then a = 1
If chk128.Value = vbChecked Then b = 1
If chkListSymbols.Value = vbChecked Then c = 1
If chkNumLine.Value = vbChecked Then d = 1
If chkRom.Value = vbChecked Then e = 1
If chkC9.Value = vbChecked Then g = 1
If chkJP.Value = vbChecked Then h = 1
If chkHex.Value = vbChecked Then i = 1
If chkVerbose.Value = vbChecked Then j = 1


'Declare Function disaster Lib "paledll.dll" (ByRef fn As Byte, ByVal convert96 As Long, ByVal convert128 As Long, _
' ByVal list_symbols As Long, ByVal number_lines As Long, ByVal decorate_rom_areas As Long, _
' ByVal decorate_subroutines As Long, ByVal decorate_jumps As Long, ByVal PrintHex As Long, _
' ByVal Counter As Long, ByVal Start As Long, ByVal Maxlines As Long, ByVal verbose As Long, _
' ByRef outdisas As Byte)


ret = disaster(in_fnam(0), a, b, c, d, e, g, h, i, Val("&H" & txtCounter.Text), Val("&H" & txtStart.Text), _
 Val(txtMaxlines.Text), j, listing(0))
 
 
 
 MsgBox "Got back - bytes "
    
  If f > 0 Then
    f = 0
    l_count = 0
    frmRevDisas.txtList.Text = CInt(ret)
    While f < ret
        If listing(f) > 32 And listing(f) < 128 Then '00
            frmRevDisas.txtList.Text = frmRevDisas.txtList.Text + Chr$(listing(f))
        End If
        f = f + 1
    Wend
  End If


'For f = 1 To Len(Form5.CommonDialog2.Filename)
'    save_fnam(f - 1) = Asc(Mid$(Form5.CommonDialog2.Filename, f, 1))
'Next f
'save_fnam(f) = 0
'ret = save_disk(dno, save_fnam(0))


 

End Sub
