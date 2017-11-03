VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "comdlg32.ocx"
Begin VB.Form Form5 
   BorderStyle     =   5  'Sizable ToolWindow
   Caption         =   "PALE Control Panel"
   ClientHeight    =   10890
   ClientLeft      =   45
   ClientTop       =   300
   ClientWidth     =   5130
   ControlBox      =   0   'False
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form5"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   10890
   ScaleWidth      =   5130
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command45 
      Caption         =   "Yaze"
      Height          =   195
      Left            =   3360
      TabIndex        =   134
      Top             =   3120
      Width           =   555
   End
   Begin VB.CommandButton Command44 
      Caption         =   "Yaze"
      Height          =   195
      Left            =   3360
      TabIndex        =   133
      Top             =   2640
      Width           =   555
   End
   Begin VB.CommandButton Command43 
      Caption         =   "Yaze"
      Height          =   195
      Left            =   4440
      TabIndex        =   132
      Top             =   3120
      Width           =   615
   End
   Begin VB.CommandButton Command42 
      Caption         =   "Yaze"
      Height          =   195
      Left            =   4440
      TabIndex        =   131
      Top             =   2640
      Width           =   615
   End
   Begin VB.CommandButton Command41 
      Caption         =   "TAP-ROM"
      Height          =   255
      Left            =   0
      TabIndex        =   130
      ToolTipText     =   "Convert Binary Image to Pale TAP format"
      Top             =   2280
      Width           =   1035
   End
   Begin VB.CommandButton cmdRevdisas 
      Caption         =   "Disaster"
      Enabled         =   0   'False
      Height          =   195
      Left            =   2040
      TabIndex        =   120
      Top             =   0
      Width           =   855
   End
   Begin VB.CommandButton cmdVirtDrives 
      Caption         =   "Virtual Drives"
      Enabled         =   0   'False
      Height          =   375
      Left            =   3960
      TabIndex        =   129
      Top             =   0
      Width           =   1335
   End
   Begin VB.CommandButton Command40 
      Caption         =   "Network"
      Height          =   375
      Left            =   0
      TabIndex        =   128
      Top             =   2520
      Width           =   1455
   End
   Begin VB.ComboBox cmbLanguage 
      Height          =   315
      ItemData        =   "Form5.frx":0000
      Left            =   3840
      List            =   "Form5.frx":000A
      TabIndex        =   127
      Text            =   "Combo1"
      Top             =   6000
      Width           =   1095
   End
   Begin VB.CommandButton cmdSerialSetup 
      Caption         =   "Serial Port"
      Height          =   375
      Left            =   1560
      TabIndex        =   126
      Top             =   2520
      Width           =   1335
   End
   Begin VB.CheckBox MMDisplay 
      Caption         =   "Show John Koushappas MMD Display"
      Height          =   735
      Left            =   5280
      TabIndex        =   125
      Top             =   2640
      Width           =   1815
   End
   Begin VB.CommandButton Command39 
      Caption         =   "Save Disk3"
      Height          =   195
      Left            =   6240
      TabIndex        =   124
      Top             =   4560
      Width           =   975
   End
   Begin VB.CommandButton Command38 
      Caption         =   "Load Disk3"
      Height          =   195
      Left            =   5160
      TabIndex        =   123
      Top             =   4560
      Width           =   1035
   End
   Begin VB.CommandButton Command37 
      Caption         =   "Save Disk2"
      Height          =   195
      Left            =   6240
      TabIndex        =   122
      Top             =   4320
      Width           =   975
   End
   Begin VB.CommandButton Command36 
      Caption         =   "Load Disk2"
      Height          =   195
      Left            =   5160
      TabIndex        =   121
      Top             =   4320
      Width           =   1035
   End
   Begin VB.CommandButton butLoadLSF 
      Caption         =   "Load LSF"
      Height          =   195
      Left            =   4080
      TabIndex        =   119
      Top             =   3480
      Width           =   975
   End
   Begin VB.CommandButton butSaveLSF 
      Caption         =   "Save LSF"
      Height          =   195
      Left            =   4080
      TabIndex        =   118
      Top             =   3720
      Width           =   975
   End
   Begin VB.CommandButton Command35 
      Caption         =   "Load Speccy"
      Height          =   255
      Left            =   3000
      TabIndex        =   117
      Top             =   4740
      Width           =   1095
   End
   Begin VB.CommandButton Command34 
      Caption         =   "Save LDF 1"
      Height          =   195
      Left            =   4080
      TabIndex        =   116
      Top             =   2880
      Width           =   975
   End
   Begin VB.CommandButton Command33 
      Caption         =   "Load LDF 1"
      Height          =   195
      Left            =   2880
      TabIndex        =   115
      Top             =   2880
      Width           =   1035
   End
   Begin VB.CommandButton Command32 
      Caption         =   "CPMFIX"
      Height          =   255
      Left            =   4260
      TabIndex        =   114
      Top             =   10200
      Width           =   735
   End
   Begin VB.TextBox Text2 
      Height          =   315
      Left            =   4200
      TabIndex        =   113
      Text            =   "20"
      Top             =   9780
      Width           =   735
   End
   Begin VB.CommandButton Command31 
      Caption         =   "Run"
      Height          =   375
      Left            =   1080
      TabIndex        =   112
      Top             =   6180
      Width           =   555
   End
   Begin VB.CommandButton cmdLoadtpa 
      Caption         =   "Load TPA"
      Height          =   375
      Left            =   120
      TabIndex        =   111
      Top             =   6180
      Width           =   915
   End
   Begin VB.CommandButton Command23 
      BackColor       =   &H000080FF&
      Caption         =   "auto"
      Height          =   255
      Left            =   540
      TabIndex        =   107
      Top             =   8280
      Width           =   495
   End
   Begin VB.CommandButton cmdTapestop 
      Caption         =   "I I"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   540
      TabIndex        =   48
      ToolTipText     =   "Force Tape Pause"
      Top             =   8520
      Width           =   495
   End
   Begin VB.CommandButton cmdTapeplay 
      Caption         =   ">"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   14.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   435
      Left            =   1020
      TabIndex        =   47
      ToolTipText     =   "Force Tape Start"
      Top             =   8280
      Width           =   555
   End
   Begin VB.CommandButton cmdTaperewind 
      Caption         =   "<<"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   14.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   435
      Left            =   0
      TabIndex        =   49
      ToolTipText     =   "Tape Rewind"
      Top             =   8280
      Width           =   555
   End
   Begin VB.ComboBox cmbTap_type 
      Height          =   315
      ItemData        =   "Form5.frx":001F
      Left            =   1440
      List            =   "Form5.frx":0029
      Style           =   2  'Dropdown List
      TabIndex        =   109
      Top             =   7680
      Width           =   1395
   End
   Begin VB.CommandButton Command22 
      Caption         =   "Printer"
      Height          =   315
      Left            =   1980
      TabIndex        =   88
      Top             =   1680
      Width           =   915
   End
   Begin VB.CommandButton Command20 
      Caption         =   "CPM"
      Height          =   315
      Left            =   1020
      TabIndex        =   86
      Top             =   1680
      Width           =   975
   End
   Begin VB.CommandButton Command30 
      Caption         =   "Save"
      Height          =   315
      Left            =   1680
      TabIndex        =   106
      Top             =   9120
      Width           =   675
   End
   Begin VB.CommandButton Command29 
      Caption         =   "Load"
      Height          =   315
      Left            =   960
      TabIndex        =   105
      Top             =   9120
      Width           =   735
   End
   Begin VB.ComboBox cmbTfileformat 
      Height          =   315
      ItemData        =   "Form5.frx":0044
      Left            =   60
      List            =   "Form5.frx":004E
      TabIndex        =   104
      Text            =   "Combo1"
      Top             =   9120
      Width           =   855
   End
   Begin VB.ComboBox cmbRawbuf 
      Height          =   315
      ItemData        =   "Form5.frx":005C
      Left            =   3360
      List            =   "Form5.frx":006F
      TabIndex        =   102
      Text            =   "Combo1"
      Top             =   10500
      Width           =   735
   End
   Begin VB.ComboBox cmbRawsamprate 
      Height          =   315
      ItemData        =   "Form5.frx":008A
      Left            =   2400
      List            =   "Form5.frx":00AA
      Style           =   2  'Dropdown List
      TabIndex        =   101
      Top             =   9120
      Width           =   975
   End
   Begin VB.CommandButton Command28 
      Caption         =   "Monitor"
      Height          =   255
      Left            =   180
      TabIndex        =   100
      ToolTipText     =   "Signal Monitor"
      Top             =   8820
      Width           =   1215
   End
   Begin VB.CommandButton Command27 
      Caption         =   "-"
      Height          =   195
      Left            =   3480
      TabIndex        =   99
      Top             =   8820
      Width           =   255
   End
   Begin VB.CommandButton Command26 
      Caption         =   "+"
      Height          =   195
      Left            =   3720
      TabIndex        =   98
      Top             =   8820
      Width           =   255
   End
   Begin VB.TextBox txtRawThresh 
      Alignment       =   2  'Center
      Height          =   285
      Left            =   3480
      TabIndex        =   96
      Text            =   "70"
      Top             =   8580
      Width           =   495
   End
   Begin VB.CheckBox chkTapeinvert 
      Caption         =   "Invert Signal"
      Height          =   255
      Left            =   3780
      TabIndex        =   95
      Top             =   9000
      Width           =   1275
   End
   Begin VB.CommandButton Command25 
      Caption         =   "Erase"
      Height          =   435
      Left            =   1980
      TabIndex        =   93
      ToolTipText     =   "Tape Clear"
      Top             =   8280
      Width           =   555
   End
   Begin VB.TextBox Text1 
      Alignment       =   2  'Center
      Height          =   285
      Left            =   3480
      TabIndex        =   92
      Text            =   "0"
      Top             =   8280
      Width           =   495
   End
   Begin VB.HScrollBar HScroll1 
      Height          =   195
      Left            =   4020
      Max             =   100
      TabIndex        =   91
      Top             =   8280
      Value           =   50
      Width           =   915
   End
   Begin VB.TextBox txtTapelevel 
      Height          =   315
      Left            =   2940
      TabIndex        =   89
      Text            =   "0"
      Top             =   8280
      Width           =   435
   End
   Begin VB.CommandButton Command24 
      Caption         =   "MemScan"
      Height          =   315
      Left            =   0
      TabIndex        =   87
      Top             =   1680
      Width           =   1035
   End
   Begin VB.TextBox txtOptions 
      Height          =   315
      Left            =   2880
      TabIndex        =   85
      Text            =   "0"
      Top             =   6060
      Width           =   735
   End
   Begin VB.TextBox txtDiskstat 
      Height          =   315
      Left            =   1080
      TabIndex        =   82
      Text            =   "Text1"
      Top             =   7200
      Width           =   435
   End
   Begin VB.CheckBox Checfk1 
      Caption         =   "Enable REAL Mode"
      Height          =   255
      Left            =   300
      TabIndex        =   81
      Top             =   10200
      Width           =   1875
   End
   Begin VB.TextBox txtRawmotor 
      BackColor       =   &H00FFFF80&
      Height          =   285
      Left            =   3420
      TabIndex        =   80
      Text            =   "OFF"
      Top             =   7680
      Width           =   435
   End
   Begin VB.CommandButton Command21 
      Caption         =   "R"
      Height          =   435
      Left            =   1620
      TabIndex        =   78
      Top             =   8280
      Width           =   315
   End
   Begin VB.TextBox txtSector 
      Height          =   285
      Left            =   3780
      TabIndex        =   77
      Text            =   "Text1"
      Top             =   7320
      Width           =   435
   End
   Begin VB.TextBox txtTrack 
      Height          =   285
      Left            =   3780
      TabIndex        =   76
      Text            =   "Text1"
      Top             =   7020
      Width           =   435
   End
   Begin VB.TextBox txtHead 
      Height          =   285
      Left            =   3780
      TabIndex        =   75
      Text            =   "Text1"
      Top             =   6720
      Width           =   435
   End
   Begin VB.TextBox txtDrive 
      Height          =   315
      Left            =   3780
      TabIndex        =   74
      Text            =   "Text1"
      Top             =   6360
      Width           =   435
   End
   Begin VB.TextBox txtRawsamples 
      Height          =   285
      Left            =   2820
      TabIndex        =   73
      Text            =   "0"
      Top             =   9840
      Width           =   1095
   End
   Begin VB.ComboBox cmbDisktype 
      Height          =   315
      ItemData        =   "Form5.frx":00D2
      Left            =   1440
      List            =   "Form5.frx":00E2
      TabIndex        =   70
      Text            =   "RAW Image"
      Top             =   5760
      Width           =   1395
   End
   Begin VB.TextBox txtData 
      Height          =   285
      Left            =   960
      TabIndex        =   69
      Top             =   6900
      Width           =   555
   End
   Begin VB.TextBox txtCommand 
      Height          =   285
      Left            =   960
      TabIndex        =   68
      Top             =   6600
      Width           =   555
   End
   Begin VB.TextBox txtSteprate 
      Height          =   315
      Left            =   2880
      TabIndex        =   65
      Text            =   "125ns"
      Top             =   7260
      Width           =   735
   End
   Begin VB.TextBox txtPrecomp 
      Height          =   315
      Left            =   2880
      TabIndex        =   64
      Text            =   "Disabled"
      Top             =   6960
      Width           =   735
   End
   Begin VB.TextBox txtMotor 
      Height          =   315
      Left            =   2880
      TabIndex        =   63
      Text            =   "OFF"
      Top             =   6660
      Width           =   735
   End
   Begin VB.TextBox txtEpenable 
      Height          =   315
      Left            =   2880
      TabIndex        =   62
      Text            =   "Enabled"
      Top             =   6360
      Width           =   735
   End
   Begin VB.TextBox txtRawposition 
      Height          =   285
      Left            =   3900
      TabIndex        =   51
      Text            =   "0"
      Top             =   7680
      Width           =   1095
   End
   Begin VB.HScrollBar hscTape 
      Height          =   195
      Left            =   0
      TabIndex        =   50
      Top             =   8040
      Width           =   4995
   End
   Begin VB.CheckBox chkBreakin 
      Caption         =   "Halt Program"
      Height          =   195
      Left            =   3780
      TabIndex        =   46
      Top             =   9240
      Width           =   1275
   End
   Begin MSComDlg.CommonDialog CommonDialog2 
      Left            =   2280
      Top             =   3000
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.CommandButton Command19 
      Caption         =   "Save LDF 0"
      Height          =   195
      Left            =   4080
      TabIndex        =   45
      Top             =   2340
      Width           =   975
   End
   Begin MSComDlg.CommonDialog CommonDialog1 
      Left            =   6000
      Top             =   300
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.CommandButton Command18 
      Caption         =   "Load LDF 0"
      Height          =   195
      Left            =   2880
      TabIndex        =   44
      Top             =   2340
      Width           =   1035
   End
   Begin VB.CommandButton Command17 
      Caption         =   "Load TAP"
      Height          =   375
      Left            =   3000
      TabIndex        =   43
      Top             =   3480
      Width           =   1095
   End
   Begin VB.CommandButton Command16 
      Caption         =   "BREAK"
      Height          =   315
      Left            =   8160
      TabIndex        =   42
      Top             =   2280
      Width           =   735
   End
   Begin VB.CommandButton Command15 
      Caption         =   "List"
      Height          =   315
      Left            =   4080
      TabIndex        =   41
      Top             =   4680
      Width           =   975
   End
   Begin VB.CommandButton Command14 
      Caption         =   "Command14"
      Height          =   495
      Left            =   5520
      TabIndex        =   40
      Top             =   1920
      Width           =   675
   End
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Interval        =   500
      Left            =   3180
      Top             =   240
   End
   Begin VB.CommandButton Command13 
      Caption         =   "X"
      Height          =   315
      Left            =   2280
      TabIndex        =   38
      ToolTipText     =   "Reset display positions"
      Top             =   3780
      Width           =   495
   End
   Begin VB.CommandButton Command12 
      Caption         =   ">"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   300
      Left            =   2520
      TabIndex        =   37
      ToolTipText     =   "Tweak Custom video width"
      Top             =   3480
      Width           =   255
   End
   Begin VB.CommandButton Command11 
      Caption         =   "<"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   300
      Left            =   2280
      TabIndex        =   36
      ToolTipText     =   "Tweak Custom video width"
      Top             =   3480
      Width           =   255
   End
   Begin VB.CommandButton Command10 
      Caption         =   "unlock all dev stuff"
      Height          =   615
      Left            =   5280
      TabIndex        =   29
      Top             =   3480
      Width           =   1335
   End
   Begin VB.CommandButton Command4 
      Caption         =   "S STEP"
      Height          =   375
      Left            =   1020
      TabIndex        =   28
      ToolTipText     =   "Left click SS, Left hold for 2Hz, Right hold for 20Hz"
      Top             =   4800
      Width           =   855
   End
   Begin VB.CommandButton Command8 
      BackColor       =   &H00C0C0C0&
      Caption         =   "RUN Program"
      Height          =   675
      Left            =   4140
      TabIndex        =   26
      Top             =   3960
      Width           =   915
   End
   Begin VB.CommandButton Command7 
      Caption         =   "more"
      Height          =   375
      Left            =   60
      TabIndex        =   25
      Top             =   5280
      Width           =   855
   End
   Begin VB.CheckBox chkSound 
      Caption         =   "Sound"
      Height          =   375
      Left            =   5640
      TabIndex        =   23
      Top             =   1440
      Width           =   1455
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Fix RepeatRate"
      Height          =   375
      Left            =   5460
      TabIndex        =   22
      Top             =   900
      Width           =   1275
   End
   Begin VB.ComboBox cmbDsize 
      Height          =   315
      ItemData        =   "Form5.frx":0112
      Left            =   1200
      List            =   "Form5.frx":0125
      Style           =   2  'Dropdown List
      TabIndex        =   20
      Top             =   3780
      Width           =   972
   End
   Begin VB.TextBox text3 
      Height          =   2175
      Left            =   5160
      TabIndex        =   19
      Text            =   "Text1"
      Top             =   5520
      Width           =   3975
   End
   Begin VB.CommandButton Command5 
      Caption         =   "Send TEXT"
      Height          =   735
      Left            =   8040
      TabIndex        =   18
      Top             =   4680
      Width           =   915
   End
   Begin VB.CommandButton Command2 
      Caption         =   "D"
      Height          =   255
      Left            =   60
      TabIndex        =   17
      ToolTipText     =   "This version of LOAD assumes you've typed MLOAD"""" already"
      Top             =   9720
      Width           =   375
   End
   Begin VB.CommandButton Command1 
      Caption         =   "D"
      Height          =   255
      Left            =   60
      TabIndex        =   16
      ToolTipText     =   "This version of LOAD assumes you've typed LOAD"""" already"
      Top             =   9480
      Width           =   375
   End
   Begin VB.CommandButton cmdLoadLev9 
      Caption         =   "Load LEV9"
      Height          =   375
      Left            =   3000
      TabIndex        =   8
      ToolTipText     =   "After you've loaded the first two parts (the bank loader) click this button and point it at the first file in the adventure set "
      Top             =   3900
      Width           =   1095
   End
   Begin VB.CommandButton cmdLoadBinary 
      Caption         =   "MLoad Binary"
      Height          =   255
      Left            =   420
      TabIndex        =   15
      ToolTipText     =   "Loads MC/BINARY programs, types the MLOAD"""" for you"
      Top             =   9720
      Width           =   1155
   End
   Begin VB.ComboBox cmbSpeed 
      Height          =   315
      ItemData        =   "Form5.frx":0141
      Left            =   960
      List            =   "Form5.frx":0181
      Locked          =   -1  'True
      TabIndex        =   13
      Text            =   "100%"
      Top             =   2940
      Width           =   1215
   End
   Begin VB.ComboBox cmbMachine 
      Height          =   315
      ItemData        =   "Form5.frx":01DA
      Left            =   1080
      List            =   "Form5.frx":01F3
      Locked          =   -1  'True
      TabIndex        =   11
      Text            =   "48K"
      Top             =   3360
      Width           =   1095
   End
   Begin VB.CommandButton cmdExit 
      Caption         =   "E X I T   E M U"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   11.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   555
      Left            =   3000
      TabIndex        =   10
      Top             =   5100
      Width           =   2055
   End
   Begin VB.CommandButton cmdHelp 
      Appearance      =   0  'Flat
      BackColor       =   &H8000000B&
      Caption         =   "--- HELP ---"
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
      Left            =   1020
      TabIndex        =   9
      Top             =   5280
      Width           =   1755
   End
   Begin VB.TextBox Text4 
      BackColor       =   &H80000004&
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Courier"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1935
      Left            =   2940
      MultiLine       =   -1  'True
      TabIndex        =   6
      Top             =   360
      Width           =   2115
   End
   Begin VB.CommandButton cmdReset 
      Caption         =   "X"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Left            =   60
      TabIndex        =   5
      ToolTipText     =   "RESET the Emulator"
      Top             =   4320
      Width           =   855
   End
   Begin VB.CommandButton cmdStop 
      Caption         =   "I I"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   13.5
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   1020
      TabIndex        =   4
      ToolTipText     =   "Pause the Emulator"
      Top             =   4320
      Width           =   852
   End
   Begin VB.CommandButton cmdRun 
      Caption         =   ">"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   18
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   852
      Left            =   1920
      TabIndex        =   3
      ToolTipText     =   "Starts the Emulator"
      Top             =   4320
      Width           =   852
   End
   Begin VB.CommandButton cmdSaveTape 
      Caption         =   "Save BASIC"
      Height          =   375
      Left            =   3000
      TabIndex        =   1
      ToolTipText     =   "Saves the current BASIC program"
      Top             =   4320
      Width           =   1095
   End
   Begin VB.CommandButton cmdLoadBasic 
      Caption         =   "Load BASIC"
      Height          =   255
      Left            =   420
      TabIndex        =   0
      ToolTipText     =   "Loads BASIC programs, types the LOAD"""" for you"
      Top             =   9480
      Width           =   1155
   End
   Begin VB.Frame Frame1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000008&
      BorderStyle     =   0  'None
      Caption         =   "Frame1"
      ForeColor       =   &H80000008&
      Height          =   1695
      Left            =   0
      TabIndex        =   30
      Top             =   0
      Width           =   2895
      Begin VB.CheckBox chkStatus 
         BackColor       =   &H80000012&
         Caption         =   "Status Display"
         ForeColor       =   &H8000000E&
         Height          =   255
         Left            =   120
         TabIndex        =   35
         Top             =   1320
         Width           =   1395
      End
      Begin VB.CheckBox chkMemmap 
         BackColor       =   &H80000012&
         Caption         =   "Memory Map"
         ForeColor       =   &H8000000E&
         Height          =   252
         Left            =   120
         TabIndex        =   34
         Top             =   960
         Width           =   1335
      End
      Begin VB.CheckBox chkSysvar 
         BackColor       =   &H80000012&
         Caption         =   "SysVars"
         ForeColor       =   &H8000000E&
         Height          =   252
         Left            =   1500
         TabIndex        =   33
         Top             =   960
         Width           =   975
      End
      Begin VB.Label lblFPS 
         BackColor       =   &H80000008&
         Caption         =   "0 FPS"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000E&
         Height          =   255
         Left            =   1740
         TabIndex        =   39
         Top             =   1320
         Visible         =   0   'False
         Width           =   1095
      End
      Begin VB.Line Line6 
         BorderColor     =   &H8000000E&
         X1              =   840
         X2              =   2880
         Y1              =   840
         Y2              =   840
      End
      Begin VB.Image Image1 
         Appearance      =   0  'Flat
         Height          =   795
         Left            =   0
         Picture         =   "Form5.frx":022A
         Top             =   0
         Width           =   870
      End
      Begin VB.Label Label5 
         BackColor       =   &H80000012&
         Caption         =   "Label5"
         ForeColor       =   &H8000000E&
         Height          =   255
         Left            =   900
         TabIndex        =   32
         Top             =   600
         Width           =   1995
      End
      Begin VB.Label Label6 
         BackColor       =   &H80000012&
         Caption         =   "Label6"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000E&
         Height          =   255
         Left            =   900
         TabIndex        =   31
         Top             =   180
         Width           =   1995
      End
   End
   Begin VB.CommandButton Command9 
      Caption         =   "ROM Edit"
      Height          =   255
      Left            =   1980
      TabIndex        =   27
      Top             =   1980
      Width           =   915
   End
   Begin VB.CommandButton Command6 
      Caption         =   "TapeRead"
      Height          =   255
      Left            =   1020
      TabIndex        =   24
      ToolTipText     =   "Convert RAW sound file into Pale TAP format"
      Top             =   1980
      Width           =   975
   End
   Begin VB.CommandButton cmdConvert 
      Caption         =   "Z80-TAP"
      Height          =   255
      Left            =   0
      TabIndex        =   2
      ToolTipText     =   "Convert Binary Image to Pale TAP format"
      Top             =   1980
      Width           =   1035
   End
   Begin VB.Line Line8 
      X1              =   3000
      X2              =   4980
      Y1              =   3360
      Y2              =   3360
   End
   Begin VB.Label Label25 
      Caption         =   "Buffer"
      Height          =   255
      Left            =   2640
      TabIndex        =   110
      Top             =   10560
      Width           =   555
   End
   Begin VB.Label Label8 
      Caption         =   "Type"
      Height          =   255
      Left            =   900
      TabIndex        =   108
      Top             =   7740
      Width           =   495
   End
   Begin VB.Label lbl44 
      Height          =   255
      Left            =   3000
      TabIndex        =   103
      Top             =   5700
      Width           =   1935
   End
   Begin VB.Line Line7 
      X1              =   3420
      X2              =   3420
      Y1              =   8280
      Y2              =   9420
   End
   Begin VB.Label Label24 
      Caption         =   "Threshold"
      Height          =   255
      Left            =   4020
      TabIndex        =   97
      Top             =   8820
      Width           =   795
   End
   Begin VB.Label Label23 
      Caption         =   "Speed Adjust"
      Height          =   255
      Left            =   4020
      TabIndex        =   94
      Top             =   8520
      Width           =   1035
   End
   Begin VB.Label Label22 
      Caption         =   "Level"
      Height          =   255
      Left            =   2400
      TabIndex        =   90
      Top             =   10200
      Width           =   495
   End
   Begin VB.Label Label21 
      Caption         =   "Options"
      Height          =   255
      Left            =   1680
      TabIndex        =   84
      Top             =   6120
      Width           =   735
   End
   Begin VB.Line Line3 
      BorderWidth     =   2
      X1              =   60
      X2              =   4860
      Y1              =   7620
      Y2              =   7620
   End
   Begin VB.Label Label20 
      Caption         =   "Status"
      Height          =   255
      Left            =   120
      TabIndex        =   83
      Top             =   7260
      Width           =   675
   End
   Begin VB.Label Label19 
      Caption         =   "Motor"
      Height          =   255
      Left            =   2940
      TabIndex        =   79
      Top             =   7740
      Width           =   495
   End
   Begin VB.Label Label18 
      Caption         =   "Total Samples"
      Height          =   255
      Left            =   1680
      TabIndex        =   72
      Top             =   9840
      Width           =   1035
   End
   Begin VB.Label Label32 
      Caption         =   "Type"
      Height          =   255
      Left            =   900
      TabIndex        =   71
      Top             =   5820
      Width           =   435
   End
   Begin VB.Label Label17 
      Caption         =   "Data"
      Height          =   255
      Left            =   120
      TabIndex        =   67
      Top             =   6960
      Width           =   615
   End
   Begin VB.Label Label16 
      Caption         =   "Command"
      Height          =   255
      Left            =   120
      TabIndex        =   66
      Top             =   6660
      Width           =   795
   End
   Begin VB.Label Label39 
      Caption         =   "StepRate"
      Height          =   255
      Left            =   1680
      TabIndex        =   61
      Top             =   7260
      Width           =   735
   End
   Begin VB.Label Label40 
      Caption         =   "Precompens."
      Height          =   255
      Left            =   1680
      TabIndex        =   60
      Top             =   6960
      Width           =   1155
   End
   Begin VB.Label Label43 
      Caption         =   "Motor"
      Height          =   255
      Left            =   1680
      TabIndex        =   59
      Top             =   6720
      Width           =   675
   End
   Begin VB.Line Line4 
      BorderColor     =   &H80000005&
      X1              =   3660
      X2              =   3660
      Y1              =   6060
      Y2              =   7560
   End
   Begin VB.Label Label15 
      Caption         =   "Eprom Enable"
      Height          =   255
      Left            =   1680
      TabIndex        =   58
      Top             =   6420
      Width           =   1215
   End
   Begin VB.Label Label14 
      Caption         =   "Drive"
      Height          =   255
      Left            =   4260
      TabIndex        =   57
      Top             =   6420
      Width           =   495
   End
   Begin VB.Label Label13 
      Caption         =   "Sector"
      Height          =   255
      Left            =   4260
      TabIndex        =   56
      Top             =   7320
      Width           =   675
   End
   Begin VB.Label Label12 
      Caption         =   "Track"
      Height          =   255
      Left            =   4260
      TabIndex        =   55
      Top             =   7020
      Width           =   675
   End
   Begin VB.Label Label11 
      Caption         =   "Head"
      Height          =   255
      Left            =   4260
      TabIndex        =   54
      Top             =   6720
      Width           =   495
   End
   Begin VB.Label Label10 
      Caption         =   "Tape"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   60
      TabIndex        =   53
      Top             =   7620
      Width           =   735
   End
   Begin VB.Label Label9 
      Caption         =   "Disk"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   60
      TabIndex        =   52
      Top             =   5700
      Width           =   675
   End
   Begin VB.Line Line5 
      BorderColor     =   &H80000009&
      X1              =   2880
      X2              =   0
      Y1              =   4200
      Y2              =   4200
   End
   Begin VB.Line Line2 
      X1              =   3060
      X2              =   4980
      Y1              =   5040
      Y2              =   5040
   End
   Begin VB.Label Label7 
      Caption         =   "Display Size"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   180
      TabIndex        =   21
      Top             =   3840
      Width           =   975
   End
   Begin VB.Label Label3 
      Caption         =   "Speed"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   180
      TabIndex        =   14
      Top             =   2940
      Width           =   735
   End
   Begin VB.Label Label2 
      Caption         =   "Type"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   180
      TabIndex        =   12
      Top             =   3420
      Width           =   615
   End
   Begin VB.Label Label1 
      Caption         =   "Tape Info"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   3000
      TabIndex        =   7
      Top             =   60
      Width           =   915
   End
   Begin VB.Line Line1 
      BorderColor     =   &H80000009&
      X1              =   2880
      X2              =   2880
      Y1              =   0
      Y2              =   5760
   End
End
Attribute VB_Name = "Form5"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit


'If you change this value you must change it in MOdule.Bas too
'in the main reset routine
Const dev_height As Integer = 9900

Const norm_height As Integer = 6130
Dim frm_height_save As Integer


Dim save_fnam(100) As Byte

Private Sub butLoadLSF_Click()
Dim buf As String
Dim fnam(200) As Byte
Dim retstring(200) As Byte
Dim f, ret As Long

Form5.CommonDialog1.CancelError = True    'this traps user hitting cancel button

On Error GoTo err

Form5.CommonDialog1.Filter = "LSF Files (*.lsf)|*.LSF|All files" & _
    "(*.*)|*.*"
Form5.CommonDialog1.Flags = cdlOFNHideReadOnly
Form5.CommonDialog1.FilterIndex = 1
Form5.CommonDialog1.ShowOpen

For f = 1 To Len(Form5.CommonDialog1.Filename)
    fnam(f - 1) = Asc(Mid$(Form5.CommonDialog1.Filename, f, 1))
Next f
fnam(f - 1) = 0
   
ret = load_lsf(fnam(0))

'txtRawsamples.Text = str(ret)
'hscTape.Value = get_raw_position()
Exit Sub
err:
'MsgBox "AN EROR"
Exit Sub
Form1.SetFocus

End Sub

Private Sub butSaveLSF_Click()

Dim f, ret As Integer


Form5.CommonDialog2.CancelError = True    'this traps user hitting cancel button


On Error GoTo err

Form5.CommonDialog2.Filter = "LSF Files (*.lsf)|*.LSF|All files" & _
    "(*.*)|*.*"
Form5.CommonDialog2.Flags = cdlOFNHideReadOnly
Form5.CommonDialog2.FilterIndex = 1
Form5.CommonDialog2.ShowSave

For f = 1 To Len(Form5.CommonDialog2.Filename)
    save_fnam(f - 1) = Asc(Mid$(Form5.CommonDialog2.Filename, f, 1))
Next f
save_fnam(f) = 0

'MsgBox ("HI THERE")

ret = save_lsf(save_fnam(0))

Exit Sub

err:

Exit Sub


End Sub



'Private Sub Check1_Click()
'Dim ret
'If Checfk1.Value = vbChecked Then
 '   ret = set_tape_mode(1)
'Else
'    ret = set_tape_mode(0)
'End If
'Form1.SetFocus
'End Sub

Private Sub chkTapeinvert_Click()
Dim ret

ret = set_tape_inverted(1)


End Sub



Private Sub cmbDisktype_DropDown()
cmbDisktype.Locked = False


End Sub

Private Sub cmbDisktype_KeyDown(KeyCode As Integer, Shift As Integer)
cmbDisktype.Locked = True

End Sub

Private Sub cmbRawbuf_Click()

Dim ret




cmbRawbuf.Locked = True

'ret = set_raw_buflen(Val(cmbRawbuf.List(cmbRawbuf.ListIndex)))



End Sub


Private Sub cmbRawbuf_DropDown()

cmbRawbuf.Locked = False

End Sub

Private Sub cmbRawbuf_KeyDown(KeyCode As Integer, Shift As Integer)

cmbRawbuf.Locked = True

End Sub

Private Sub cmbRawsamprate_Click()

Dim ret
cmbRawsamprate.Locked = True

ret = set_raw_samprate(Val(cmbRawsamprate.List(cmbRawsamprate.ListIndex)))

End Sub

Private Sub Loadraw()

Dim buf As String
Dim fnam(200) As Byte
Dim retstring(200) As Byte
Dim f, ret As Integer

Form5.CommonDialog1.CancelError = True    'this traps user hitting cancel button

On Error GoTo err

Form5.CommonDialog1.Filter = "RAW Files (*.RAW)|*.RAW|All files" & _
    "(*.*)|*.*"
Form5.CommonDialog1.Flags = cdlOFNHideReadOnly
Form5.CommonDialog1.FilterIndex = 1
Form5.CommonDialog1.ShowOpen

For f = 1 To Len(Form5.CommonDialog1.Filename)
    fnam(f - 1) = Asc(Mid$(Form5.CommonDialog1.Filename, f, 1))
Next f
fnam(f - 1) = 0
   
ret = load_raw(fnam(0))
'MsgBox "AFTER DLL LOAD_LYNXDISK"
'If ret = 1 Then
'    MsgBox "Sorry, Failed to Load the RAW"
'End If
'txtRawsamples.Text = str(ret)
'hscTape.Value = get_raw_position()


Exit Sub

err:
'MsgBox "AN EROR"

Exit Sub


Form1.SetFocus



End Sub

Private Sub cmbRawsamprate_DropDown()
cmbRawsamprate.Locked = False

End Sub

Private Sub cmbRawsamprate_KeyDown(KeyCode As Integer, Shift As Integer)
cmbRawsamprate.Locked = True
End Sub

Private Sub cmbTfileformat_Click()


cmbTfileformat.Locked = True

End Sub

Private Sub cmbTfileformat_DropDown()
cmbTfileformat.Locked = False
End Sub

Private Sub cmbTfileformat_KeyDown(KeyCode As Integer, Shift As Integer)
cmbTfileformat.Locked = True

End Sub

Private Sub cmdLoadraw_Click()

Loadraw

End Sub



Private Sub cmbTap_type_Click()
Dim ret

tape_source_type = cmbTap_type.ListIndex

ret = set_tape_mode(tape_source_type)

Form1.SetFocus


End Sub

Private Sub cmdRevdisas_Click()

frmRevDisas.Show



End Sub

Private Sub cmdSerialSetup_Click()

frmSerialSetup.Show

End Sub

Private Sub cmdTapestop_Click()
Dim ret

txtRawmotor.BackColor = RGB(255, 255, 255)


ret = force_raw_stop()


Form1.SetFocus


End Sub


Private Sub cmdTapeplay_Click()
Dim ret

ret = force_raw_play()
'set_tape_operation(1)

txtRawmotor.BackColor = RGB(0, 255, 0)

Form1.SetFocus

End Sub

Private Sub cmdTaperewind_Click()
Dim ret

ret = rewind_raw()

Form1.SetFocus

End Sub

Private Sub Saveraw()
Dim buf As String
Dim fnam(200) As Byte
Dim retstring(200) As Byte
Dim f, ret As Integer


If hscTape.Value = 0 Then MsgBox "Tape Counter is at ZERO this file will be empty!!!"


Form5.CommonDialog1.CancelError = True    'this traps user hitting cancel button

On Error GoTo err

Form5.CommonDialog1.Filter = "RAW Files (*.RAW)|*.RAW|All files" & _
    "(*.*)|*.*"
Form5.CommonDialog1.Flags = cdlOFNHideReadOnly
Form5.CommonDialog1.FilterIndex = 1
Form5.CommonDialog1.ShowSave

For f = 1 To Len(Form5.CommonDialog1.Filename)
    fnam(f - 1) = Asc(Mid$(Form5.CommonDialog1.Filename, f, 1))
Next f
fnam(f - 1) = 0
   
ret = save_raw(fnam(0))


Exit Sub

err:
'MsgBox "AN EROR"

Exit Sub


Form1.SetFocus


End Sub
Private Sub cmSaveraw_Click()
Saveraw

End Sub

Private Sub cmdVirtDrives_Click()
    frmVirtDrives.Show
    
End Sub

Private Sub Command20_Click()

Form15.Show

End Sub

Private Sub Command25_Click()

Dim ret

ret = tape_clear()
Form1.SetFocus


End Sub

Private Sub Command26_Click()
Dim ret


txtRawThresh.Text = Hex$(Val("&H" & txtRawThresh.Text) + 8)

ret = set_raw_threshold(Val("&H" & txtRawThresh.Text))

ret = rewind_raw()

Form1.SetFocus
End Sub

Private Sub Command27_Click()
Dim ret

txtRawThresh.Text = Hex$(Val("&H" & txtRawThresh.Text) - 8)
ret = set_raw_threshold(Val("&H" & txtRawThresh.Text))

ret = rewind_raw()

Form1.SetFocus
End Sub

Private Sub Command28_Click()

frmTapemon.Show

End Sub

Private Sub Loadwav()
Dim buf As String
Dim fnam(200) As Byte
Dim retstring(200) As Byte
Dim f, ret As Long

Form5.CommonDialog1.CancelError = True    'this traps user hitting cancel button

On Error GoTo err

Form5.CommonDialog1.Filter = "WAV Files (*.WAV)|*.WAV|All files" & _
    "(*.*)|*.*"
Form5.CommonDialog1.Flags = cdlOFNHideReadOnly
Form5.CommonDialog1.FilterIndex = 1
Form5.CommonDialog1.ShowOpen

For f = 1 To Len(Form5.CommonDialog1.Filename)
    fnam(f - 1) = Asc(Mid$(Form5.CommonDialog1.Filename, f, 1))
Next f
fnam(f - 1) = 0
   
ret = load_wav(fnam(0))

Form5.cmbRawsamprate.ListIndex = get_raw_samprate_index()

'txtRawsamples.Text = str(ret)
'hscTape.Value = get_raw_position()



Exit Sub

err:
'MsgBox "AN EROR"

Exit Sub

  
Form1.SetFocus




End Sub

Private Sub cmdLoadWAV_Click()

Loadwav


End Sub

Private Sub Command29_Click()

If cmbTfileformat.ListIndex = 0 Then
  Loadraw
Else
  Loadwav
End If


End Sub

Private Sub Command30_Click()
If cmbTfileformat.ListIndex = 0 Then
  Saveraw
Else
  Savewav
End If

End Sub





Private Sub Loadtpa()
Dim buf As String
Dim fnam(200) As Byte
Dim retstring(200) As Byte
Dim f, ret As Long

Form5.CommonDialog1.CancelError = True    'this traps user hitting cancel button

On Error GoTo err

Form5.CommonDialog1.Filter = "COM Files (*.COM)|*.COM|All files" & _
    "(*.*)|*.*"
Form5.CommonDialog1.Flags = cdlOFNHideReadOnly
Form5.CommonDialog1.FilterIndex = 1
Form5.CommonDialog1.ShowOpen

For f = 1 To Len(Form5.CommonDialog1.Filename)
    fnam(f - 1) = Asc(Mid$(Form5.CommonDialog1.Filename, f, 1))
Next f
fnam(f - 1) = 0
   
ret = load_tpa(fnam(0))

'txtRawsamples.Text = str(ret)
'hscTape.Value = get_raw_position()
Exit Sub
err:
'MsgBox "AN EROR"
Exit Sub
Form1.SetFocus
End Sub


Private Sub cmdLoadtpa_Click()

Loadtpa



End Sub

Private Sub Command31_Click()
Dim ret

ret = run_tpa()


End Sub

Private Sub Command32_Click()
Dim ret

ret = set_cpmfix(Val(Text2.Text))

End Sub

Private Sub Command33_Click()


load_a_disk (1)



End Sub

Private Sub Command34_Click()

save_a_disk (1)

End Sub

Private Sub Command35_Click()


load_a_speccy



End Sub

Private Sub Command36_Click()

load_a_disk (2)

End Sub

Private Sub Command37_Click()

save_a_disk (2)

End Sub

Private Sub Command38_Click()

load_a_disk (3)

End Sub

Private Sub Command39_Click()

save_a_disk (3)

End Sub

Private Sub Command40_Click()

frmLynxnet.Show


End Sub

Private Sub Command41_Click()

frmRomMulator.Show

End Sub

Private Sub Command42_Click()

save_a_yazedisk (0)


End Sub

Private Sub Command43_Click()

save_a_yazedisk (1)

End Sub

Private Sub Command44_Click()

load_a_yazedisk (0)


End Sub

Private Sub Command45_Click()

load_a_yazedisk (1)


End Sub

Private Sub hscTape_Scroll()

    
'    Form5.hscTape.Value = get_raw_position() /
 '   ((Val(Form5.cmbRawbuf.List(Form5.cmbRawbuf.ListIndex)) * 1024000) / 32767)

Dim ret

ret = set_raw_position(hscTape.Value * ((Val(Form5.cmbRawbuf.List(Form5.cmbRawbuf.ListIndex)) * 1024000) / 32767))


End Sub

Private Sub Image1_Click()

'Unlock all dev stuff  ?
MsgBox ("Day after day, day after day, We stuck, nor breath nor motion; As idle as a painted ship Upon a painted ocean.")




End Sub

Private Sub MMDisplay_Click()

If Form18.Visible = False Then
    Form18.Show
    frmJKMMD.Show
Else
    Form18.Hide
    frmJKMMD.Show
    
End If

End Sub

Private Sub Text1_KeyDown(KeyCode As Integer, Shift As Integer)

KeyCode = 0

End Sub

Private Sub Text1_KeyPress(KeyAscii As Integer)

KeyAscii = 0


End Sub




Private Sub chkBreakin_Click()
Dim ret

If chkBreakin.Value = vbChecked Then
    ret = set_breakin(1)
Else
    ret = set_breakin(0)
End If



End Sub

Private Sub cmbDsize_Change()

'This flag is set to indicate to Form1 (the screen)
'that the change in screen size is due to a 2x 3x 4x display mode
'standard rather than the user reszing the form manually - custom
'If cmbDsize.ListIndex <> 4 Then standard_disp_update = 1
standard_disp_update = 1

display_size = cmbDsize.ListIndex
If display_size = DISPLAY_SIZE_CUSTOM Then   'should be 5 but ive not used Itemdata() round the above line
   load_screen_size
Else
    'Add the 1 to get round stretchbits problem with 1:1 blitting
   If display_size = 1 Then
         Form1.Width = 256 * 16 * (display_size) + 1  'Form1.Width '* 0.95
        Form1.Height = 248 * 16 * (display_size) + 1  'Form1.Height '* 0.95
    Else
       Form1.Width = 256 * 16 * (display_size)   'Form1.Width '* 0.95
        Form1.Height = 248 * 16 * (display_size) + 8 'Form1.Height '* 0.95
    End If
   'HiresScreenBLIT
   save_screen_size
End If

   
Save_defaults

End Sub

Private Sub cmbDsize_Click()

cmbDsize_Change

End Sub

Private Sub cmbDsize_DropDown()

cmbDsize.Locked = False

End Sub

Private Sub cmbDsize_KeyDown(KeyCode As Integer, Shift As Integer)

cmbDsize.Locked = True


End Sub

Private Sub cmbLanguage_DropDown()

cmbLanguage.Locked = False


End Sub

Private Sub cmbLanguage_KeyDown(KeyCode As Integer, Shift As Integer)

cmbLanguage.Locked = True


End Sub

Private Sub cmbMachine_Click()
Dim ret

cmbMachine.Locked = True

machine_type = cmbMachine.ItemData(cmbMachine.ListIndex)

Save_defaults

Form1.StopEmu

DoEvents


reset_pale

'Unload Form2
If dump_status = 1 Then
    Form2.set_displays
End If

'ret = set_tape_mode(t_type)


Form1.Timer3.Enabled = True


End Sub

Private Sub cmbMachine_DropDown()

cmbMachine.Locked = False


End Sub

Private Sub cmbMachine_KeyDown(KeyCode As Integer, Shift As Integer)

cmbMachine.Locked = True

End Sub

Private Sub cmbSpeed_Change()

machine_speed = Form5.cmbSpeed.ListIndex

Save_defaults

set_speed (Form5.cmbSpeed.ItemData(Form5.cmbSpeed.ListIndex))
perc_speed = Form5.cmbSpeed.ItemData(Form5.cmbSpeed.ListIndex)

'Form1.Timer2.Enabled = True

cmbSpeed.Locked = True



End Sub

Private Sub cmbSpeed_DropDown()

cmbSpeed.Locked = False


End Sub

Private Sub cmbSpeed_KeyDown(KeyCode As Integer, Shift As Integer)

cmbSpeed.Locked = True


End Sub

Private Sub Command11_Click()

   Form1.Width = Form1.Width - 8

   'HiresScreenBLIT
   save_screen_size

End Sub

Private Sub Command12_Click()

   Form1.Width = Form1.Width + 8

'   HiresScreenBLIT
   save_screen_size
'   Form1.Width = 256 * 16 * (display_size + 1) 'Form1.Width '* 0.95
'   Form1.Height = 248 * 16 * (display_size + 1) 'Form1.Height '* 0.95
   


End Sub



Private Sub Command13_Click()

reset_form_positions

reset_forms

Form1.SetFocus


End Sub

Private Sub Command14_Click()


Form1.Height = Form1.Height + 24

End Sub

Private Sub Command15_Click()

send_to_lynx ("LIST" & Chr(13))
Form1.SetFocus

End Sub



Private Sub Command17_Click()

send_to_lynx ("MLOAD" & Chr(34) & Chr(34) & Chr(13))

 
tsec = 6
load_type = 0
Form1.SetFocus

End Sub


Private Sub load_a_disk(dno As Integer)


Dim buf As String
Dim fnam(200) As Byte
Dim retstring(200) As Byte
Dim f, ret As Integer

Form5.CommonDialog1.CancelError = True    'this traps user hitting cancel button

On Error GoTo err

If Form5.cmbDisktype.ItemData(Form5.cmbDisktype.ListIndex) = 0 Then
    Form5.CommonDialog1.Filter = "LDF Files (*.LDF)|*.LDF|All files" & _
         "(*.*)|*.*"
ElseIf Form5.cmbDisktype.ItemData(Form5.cmbDisktype.ListIndex) = 1 Then
    Form5.CommonDialog1.Filter = "DSK Files (*.DSK)|*.DSK|All files" & _
         "(*.*)|*.*"
End If


Form5.CommonDialog1.Flags = cdlOFNHideReadOnly
Form5.CommonDialog1.FilterIndex = 1
Form5.CommonDialog1.ShowOpen

For f = 1 To Len(Form5.CommonDialog1.Filename)
    fnam(f - 1) = Asc(Mid$(Form5.CommonDialog1.Filename, f, 1))
Next f
fnam(f) = 0
   
ret = load_disk(dno, fnam(0))
'MsgBox "AFTER DLL LOAD_LYNXDISK"
If ret = 1 Then
    MsgBox "Sorry, Failed to Load the Disk"
End If

Exit Sub

err:
'MsgBox "AN EROR"

Exit Sub




End Sub



Private Sub load_a_yazedisk(dno As Integer)


Dim buf As String
Dim fnam(200) As Byte
Dim retstring(200) As Byte
Dim f, ret As Integer

Form5.CommonDialog1.CancelError = True    'this traps user hitting cancel button

On Error GoTo err

Form5.CommonDialog1.Filter = "YAZ Files (*.YAZ)|*.YAZ|All files" & "(*.*)|*.*"



Form5.CommonDialog1.Flags = cdlOFNHideReadOnly
Form5.CommonDialog1.FilterIndex = 1
Form5.CommonDialog1.ShowOpen

For f = 1 To Len(Form5.CommonDialog1.Filename)
    fnam(f - 1) = Asc(Mid$(Form5.CommonDialog1.Filename, f, 1))
Next f
fnam(f) = 0
   
ret = load_yazedisk(dno, fnam(0))
'MsgBox "AFTER DLL LOAD_LYNXDISK"
If ret = 1 Then
    MsgBox "Sorry, Failed to Load the Disk"
End If

Exit Sub

err:
'MsgBox "AN EROR"

Exit Sub




End Sub



Private Sub Command18_Click()

load_a_disk (0)



End Sub

Private Sub save_a_disk(dno As Integer)

Dim f, ret As Integer

Form5.CommonDialog2.CancelError = True    'this traps user hitting cancel button


On Error GoTo err

Form5.CommonDialog2.Filter = "LDF Files (*.ldf)|*.LDF|All files" & _
    "(*.*)|*.*"
Form5.CommonDialog2.Flags = cdlOFNHideReadOnly
Form5.CommonDialog2.FilterIndex = 1
Form5.CommonDialog2.ShowSave

For f = 1 To Len(Form5.CommonDialog2.Filename)
    save_fnam(f - 1) = Asc(Mid$(Form5.CommonDialog2.Filename, f, 1))
Next f
save_fnam(f) = 0


ret = save_disk(dno, save_fnam(0))



Exit Sub

err:

Exit Sub




End Sub


Private Sub save_a_yazedisk(dno As Integer)

Dim f, ret As Integer

Form5.CommonDialog2.CancelError = True    'this traps user hitting cancel button


On Error GoTo err

Form5.CommonDialog2.Filter = "YAZ Files (*.yaz)|*.YAZ|All files" & _
    "(*.*)|*.*"
Form5.CommonDialog2.Flags = cdlOFNHideReadOnly
Form5.CommonDialog2.FilterIndex = 1
Form5.CommonDialog2.ShowSave

For f = 1 To Len(Form5.CommonDialog2.Filename)
    save_fnam(f - 1) = Asc(Mid$(Form5.CommonDialog2.Filename, f, 1))
Next f
save_fnam(f) = 0


ret = save_yazedisk(dno, save_fnam(0))



Exit Sub

err:

Exit Sub




End Sub



Private Sub Command19_Click()

save_a_disk (0)



End Sub

Private Sub Command21_Click()
Dim ret

'ret = force_raw_start()

txtRawmotor.BackColor = RGB(255, 0, 0)

ret = force_raw_rec()

Form1.SetFocus

End Sub

Private Sub Command22_Click()


frmPrinter.Show



End Sub

Private Sub Savewav()
Dim buf As String
Dim fnam(200) As Byte
Dim retstring(200) As Byte
Dim f, ret As Integer

If hscTape.Value = 0 Then MsgBox "Tape Counter is at ZERO this file will be empty!!!"

Form5.CommonDialog1.CancelError = True    'this traps user hitting cancel button

On Error GoTo err

Form5.CommonDialog1.Filter = "WAV Files (*.WAV)|*.WAV|All files" & _
    "(*.*)|*.*"
Form5.CommonDialog1.Flags = cdlOFNHideReadOnly
Form5.CommonDialog1.FilterIndex = 1
Form5.CommonDialog1.ShowSave

For f = 1 To Len(Form5.CommonDialog1.Filename)
    fnam(f - 1) = Asc(Mid$(Form5.CommonDialog1.Filename, f, 1))
Next f
fnam(f - 1) = 0
   
ret = save_wav(fnam(0))


Exit Sub

err:
'MsgBox "AN EROR"

Exit Sub



End Sub
Private Sub Command23_Click()

Dim ret

txtRawmotor.BackColor = RGB(0, 200, 255)



ret = force_raw_auto()


End Sub

Private Sub Command24_Click()

Form16.Show


End Sub

'Private Sub Command14_Click()

'Form1.Height = Form1.Height + 24

'End Sub

Private Sub Command4_Click()

 '   s_step (0)
 '   Form1.Update_Statwindow
 

End Sub

Private Sub Command4_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)

s_step (0)
Form1.Update_Statwindow
 
If Button = vbRightButton Then
    Timer1.Interval = 50
Else
    Timer1.Interval = 700
End If


Timer1.Enabled = True



End Sub

Private Sub Command4_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)

Timer1.Enabled = False


End Sub

Private Sub Command5_Click()

'send_to_lynx ("LOAD" & Chr(34) & Chr(34) & Chr(13))
pump_it (0)


End Sub



Private Sub Command9_Click()

Form14.Show 'vbModal


End Sub


Private Sub chkSysvar_Click()

If chkSysvar.Value = vbChecked Then
    Form8.Show
    dump_sysvar = 1
    Form8.Timer1.Enabled = True
Else
    Form8.Hide
    dump_sysvar = 0
    Form8.Timer1.Enabled = False
End If

Save_defaults

End Sub

Private Sub chkMemmap_Click()

If chkMemmap.Value = vbChecked Then
    Form11.Show
    dump_memmap = 1
    Form11.Timer1.Enabled = True
Else
    Form11.Hide
    dump_memmap = 0
    Form11.Timer1.Enabled = False
End If


Save_defaults

End Sub

Private Sub chkSound_Click()

'If chkSound.Value = vbChecked Then
'    chkSound.Value = vbUnchecked
'    set_soundstream (1)
'Else
'    chkSound.Value = vbChecked
'    set_soundstream (0)
'End If


End Sub

Private Sub chkStatus_Click()

If chkStatus.Value = vbChecked Then
    Form2.Show
    dump_status = 1
    Form2.set_displays
 '   dump_6845 = 1
Else
    Form2.set_displays
    Form2.Hide
    dump_status = 0
  '  dump_6845 = 0
End If

Save_defaults

End Sub

Private Sub cmbLanguage_Click()

cmbLanguage.Locked = True

If cmbLanguage.Text = "English" Then Setup_English
If cmbLanguage.Text = "Francais" Then Setup_French
Save_defaults
End Sub



Private Sub Setup_French()
Dim ret As Integer


Form5.cmdLoadBasic.Caption = "Charger Basic"
Form5.cmdLoadBinary.Caption = "Charger Binaire"
'Form5.cmdLoadData.Caption = "Charger Data (sans nom)"
Form5.cmdSaveTape.Caption = "Sauvegarder k7 TAP"
'Form5.cmdRun.Caption = "Executer"
'Form5.cmdStop.Caption = "Stop"
'Form5.cmdReset.Caption = "RAZ"
'Form5.cmdSpeed.Caption = "Vitesse"
'Form5.cmdSound.Caption = "Son"
'Form5.chkFullscreen.Caption = "Plein écran"
'Form5.chkStatus.Caption = "Status vidéo"
'Form5.cmdLanguage.Caption = "Langage"
Form5.cmdHelp.Caption = "Aide"
Form5.cmdExit.Caption = "Quitter"

Language = "French"
'Form5.cmdFrench.Checked = True
'Form5.cmdEnglish.Checked = False
ret = set_kbdtype(1)



End Sub


Private Sub Setup_English()
Dim ret As Integer

Form5.cmdLoadBasic.Caption = "Load Basic"
Form5.cmdLoadBinary.Caption = "Load Binary"
'Form5.cmdLoadData.Caption = "Load Data (no name)"
Form5.cmdSaveTape.Caption = "Save to TAP"
'Form5.cmdRun.Caption = "Run"
'Form5.cmdStop.Caption = "Stop"
'Form5.cmdReset.Caption = "Reset"
'Form5.cmdSpeed.Caption = "Speed"
'Form5.cmdSound.Caption = "Sound"
'Form5.chkFullscreen.Caption = "Fullscreen"
'Form5.chkStatus.Caption = "Status"
'Form5.cmdLanguage.Caption = "Language"
Form5.cmdHelp.Caption = "Help"
Form5.cmdExit.Caption = "Exit"
Language = "English"

'Form5.cmdFrench.Checked = False
'Form5.cmdEnglish.Checked = True
ret = set_kbdtype(0)


End Sub







Private Sub cmbSpeed_Click()

cmbSpeed_Change


End Sub



Private Sub cmdConvert_Click()

Form7.Show


End Sub

Private Sub cmdLoadBasic_click()



send_to_lynx ("LOAD" & Chr(34) & Chr(34) & Chr(13))
tsec = 3
load_type = 0
Form1.SetFocus
'load (0)




End Sub

Private Sub cmdLoadBinary_Click()

send_to_lynx ("MLOAD" & Chr(34) & Chr(34) & Chr(13))

 
tsec = 3
load_type = 0
Form1.SetFocus

End Sub
Private Sub cmdLoadData_click()

load (1)
Form1.SetFocus

End Sub
Private Sub cmdLoadLev9_click()

load (2)
Form1.SetFocus

End Sub
Private Sub cmdRun_click()

Form1.RunEmu

'If emu_running = 0 Then Form1.RunEmu
Form1.SetFocus


End Sub

Private Sub cmdSaveTape_Click()
Dim f, ret As Integer


Form1.CommonDialog1.CancelError = True    'this traps user hitting cancel button


On Error GoTo err

Form1.CommonDialog1.Filename = ""
Form1.CommonDialog1.Filter = "TAP Files (*.tap)|*.TAP|All files" & _
    "(*.*)|*.*"
Form1.CommonDialog1.Flags = cdlOFNHideReadOnly
Form1.CommonDialog1.FilterIndex = 1
Form1.CommonDialog1.ShowSave

For f = 1 To Len(Form1.CommonDialog1.Filename)
    save_fnam(f - 1) = Asc(Mid$(Form1.CommonDialog1.Filename, f, 1))
Next f
save_fnam(f) = 0

'Text2.Text = CommonDialog1.Filename

send_to_lynx ("SAVE" & Chr(34) & Form1.CommonDialog1.Filename & Chr(34) & Chr(13))

Exit Sub

err:

Exit Sub






End Sub

Private Sub cmdStatus_Click()

End Sub

Private Sub cmdStop_click()

'If emu_running = 1 Then Form1.StopEmu
Form1.StopEmu

End Sub
Private Sub cmdReset_click()
  
    
    
Form1.ResetEmu

Form1.SetFocus


End Sub

Private Sub cmdHelp_Click()

Form3.Show 'vbModal


End Sub

Public Sub quit()

If Form1.WindowState <> 1 Then
    save_form_positions
    save_screen_size
    save_form11_size
End If

kill_emulator

Unload Form2
DoEvents

Unload Form1
DoEvents

Unload Form2
'DoEvents

Unload Me
End


End Sub



Private Sub cmdExit_Click()

quit

End Sub


Private Sub Command1_Click()


Dim ret As Integer

load (0)
Form1.SetFocus

End Sub

Private Sub Command2_Click()


load (0)
Form1.SetFocus

End Sub

Private Sub Command3_Click()

'Dim ret As Integer

'If machine_speed >= 400 Then
        'ret2 = peek_mem(Val("&H" & Text8.Text) + 1)
        'ret = peek_mem(Val("&H" & Text8.Text))
'        ret = poke_mem(Val("&H6233"), Val("&HFF"))
'        ret = poke_mem(Val("&H6234"), Val("&HFF"))
'        ret = poke_mem(Val("&H6237"), Val("&HFF"))
'        ret = poke_mem(Val("&H6238"), Val("&HFF"))



'send_to_lynx ("SAVE" & Chr(34) & "NONAME" & Chr(34) & Chr(13))


End Sub


Private Sub Command6_Click()

Form12.Show


End Sub

Private Sub Command7_Click()


If Form5.Height <> dev_height Then
    dump_diskstat = 1
    frm_height_save = Form5.Height
    Form5.Height = dev_height
Else
    dump_diskstat = 0
    Form5.Height = norm_height
'    Form5.Height = frm_height_save
End If



End Sub

Private Sub Command8_Click()

send_to_lynx ("RUN" & Chr(13))
Form1.SetFocus

End Sub






Private Sub Form_Load()
Dim ret, f

load_form5_pos

Height = norm_height


ret = get_version(query(0))
Label5.Caption = ""
f = 0
While query(f) <> 0 And f < 200
Label5.Caption = Label5.Caption + Chr$(query(f))
f = f + 1
Wend

Label6.Caption = "Pale Version:" + str(PALE_VERSION)


If Language = "English" Then cmbLanguage.ListIndex = 0
If Language = "French" Then cmbLanguage.ListIndex = 1

'MsgBox "just before mach type stuff in FORM5 LOAD"
If machine_type = 0 Then Form5.cmbMachine.Text = "48K"
If machine_type = 1 Then Form5.cmbMachine.Text = "96K"
If machine_type = 2 Then Form5.cmbMachine.Text = "128K"
If machine_type = 3 Then Form5.cmbMachine.Text = "96K Disk"
If machine_type = 4 Then Form5.cmbMachine.Text = "128K Disk"
If machine_type = 5 Then Form5.cmbMachine.Text = "USER1"
If machine_type = 6 Then Form5.cmbMachine.Text = "USER2"
'Form5.cmbMachine.ListIndex = machine_type

'frmPrinter.Show
'MsgBox "just AFTER mach type stuff in FORM5 LOAD"



Form5.cmbDsize.ListIndex = display_size
Form5.cmbSpeed.ListIndex = machine_speed

If dump_status = 1 Then chkStatus = vbChecked
If dump_sysvar = 1 Then chkSysvar = vbChecked
If dump_memmap = 1 Then chkMemmap = vbChecked

'MsgBox "END FORM 5 LOAD"
cmbRawsamprate.ListIndex = 0
cmbRawbuf.ListIndex = 3
cmbTfileformat.ListIndex = 0

cmbDisktype.ListIndex = 0


End Sub


Private Sub HScroll1_Change()
Dim ret

ret = set_tape_spd_adjust(HScroll1.Value)

'Also set in the DLL !!!
Text1.Text = str(HScroll1.Value - 50)


End Sub

Private Sub Timer1_Timer()
  
  
  s_step (0)
  Form1.Update_Statwindow
   
   
End Sub
Private Sub cmbDisktype_click()
Dim ret

cmbDisktype.Locked = True

'MsgBox "Setting DISK type from COMBO change" + str(cmbDisktype.ListIndex)
If cmbDisktype.ItemData(cmbDisktype.ListIndex) = 3 Then
    ret = set_drive_type(0, 80, 2)
Else
    ret = set_drive_type(0, 40, cmbDisktype.ItemData(cmbDisktype.ListIndex))
End If




End Sub




Private Sub load_a_speccy()

Dim buf As String
Dim fnam(200) As Byte
Dim retstring(200) As Byte
Dim f, ret As Integer

Form5.CommonDialog1.CancelError = True    'this traps user hitting cancel button

On Error GoTo err

Form5.CommonDialog1.Filter = "TAP Files (*.TAP)|*.TAP|All files" & _
         "(*.*)|*.*"

Form5.CommonDialog1.Flags = cdlOFNHideReadOnly
Form5.CommonDialog1.FilterIndex = 1
Form5.CommonDialog1.ShowOpen

For f = 1 To Len(Form5.CommonDialog1.Filename)
    fnam(f - 1) = Asc(Mid$(Form5.CommonDialog1.Filename, f, 1))
Next f
fnam(f) = 0
   
ret = load_speccy(fnam(0))

MsgBox "AFTER DLL LOAD_SPECCY"
If ret = 1 Then
    MsgBox "Sorry, Failed to Load the TAPE"
End If

err:

End Sub
