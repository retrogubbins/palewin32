VERSION 5.00
Begin VB.Form Form2 
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "Status Display"
   ClientHeight    =   8100
   ClientLeft      =   30
   ClientTop       =   285
   ClientWidth     =   11355
   ControlBox      =   0   'False
   Icon            =   "Form2.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   8100
   ScaleWidth      =   11355
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command14 
      Caption         =   "DISKED"
      Height          =   375
      Left            =   9300
      TabIndex        =   112
      Top             =   6600
      Width           =   975
   End
   Begin VB.TextBox Text12 
      Height          =   315
      Left            =   3120
      TabIndex        =   111
      Text            =   "16"
      Top             =   5100
      Width           =   375
   End
   Begin VB.CommandButton Command23 
      Height          =   255
      Left            =   7380
      TabIndex        =   108
      Top             =   1920
      Width           =   375
   End
   Begin VB.CommandButton Command19 
      Caption         =   "Bank"
      Height          =   255
      Left            =   7920
      TabIndex        =   106
      Top             =   4800
      Width           =   855
   End
   Begin VB.CheckBox Check1 
      Caption         =   "Show Bank3 Video"
      Height          =   615
      Left            =   6540
      TabIndex        =   105
      Top             =   6360
      Width           =   1155
   End
   Begin VB.CommandButton Command22 
      Caption         =   "Command22"
      Height          =   315
      Left            =   6420
      TabIndex        =   102
      Top             =   7320
      Width           =   555
   End
   Begin VB.CommandButton Command21 
      Caption         =   "Command21"
      Height          =   375
      Left            =   5520
      TabIndex        =   101
      Top             =   7260
      Width           =   735
   End
   Begin VB.TextBox Text4 
      Height          =   315
      Left            =   4620
      TabIndex        =   100
      Text            =   "00"
      Top             =   7320
      Width           =   735
   End
   Begin VB.CommandButton Command17 
      Caption         =   "Disk Dump"
      Height          =   255
      Left            =   6540
      TabIndex        =   99
      Top             =   5160
      Width           =   1155
   End
   Begin VB.CommandButton Command16 
      Caption         =   "Stop Trace"
      Height          =   255
      Left            =   120
      TabIndex        =   98
      Top             =   6660
      Width           =   1455
   End
   Begin VB.CommandButton Command15 
      Caption         =   "DISK TRACE"
      Height          =   315
      Left            =   120
      TabIndex        =   97
      Top             =   6360
      Width           =   1455
   End
   Begin VB.Frame frmP80_4896 
      Caption         =   "PORT 80                VIDEO LATCH"
      Height          =   2175
      Left            =   0
      TabIndex        =   32
      Top             =   0
      Width           =   4155
      Begin VB.Label lblVidlatch4896 
         Caption         =   "00"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   1980
         TabIndex        =   64
         Top             =   1800
         Width           =   495
      End
      Begin VB.Line Line10 
         X1              =   2940
         X2              =   2940
         Y1              =   1200
         Y2              =   1560
      End
      Begin VB.Line Line9 
         X1              =   2700
         X2              =   2700
         Y1              =   960
         Y2              =   1560
      End
      Begin VB.Line Line8 
         X1              =   2460
         X2              =   2460
         Y1              =   720
         Y2              =   1560
      End
      Begin VB.Line Line7 
         X1              =   2220
         X2              =   2220
         Y1              =   480
         Y2              =   1560
      End
      Begin VB.Line Line6 
         X1              =   1980
         X2              =   1980
         Y1              =   1560
         Y2              =   480
      End
      Begin VB.Line Line5 
         X1              =   1740
         X2              =   1740
         Y1              =   1560
         Y2              =   720
      End
      Begin VB.Line Line4 
         X1              =   1500
         X2              =   1500
         Y1              =   1560
         Y2              =   960
      End
      Begin VB.Line Line2 
         X1              =   1260
         X2              =   1260
         Y1              =   1560
         Y2              =   1200
      End
      Begin VB.Label Label19 
         Caption         =   "Frame Blanking"
         Height          =   255
         Left            =   240
         TabIndex        =   40
         Top             =   960
         Width           =   1335
      End
      Begin VB.Shape Shape1 
         BackStyle       =   1  'Opaque
         FillColor       =   &H000000FF&
         FillStyle       =   0  'Solid
         Height          =   135
         Index           =   0
         Left            =   1200
         Top             =   1560
         Width           =   135
      End
      Begin VB.Label Label18 
         Caption         =   "Line Blanking Mono"
         Height          =   255
         Left            =   180
         TabIndex        =   39
         Top             =   720
         Width           =   1455
      End
      Begin VB.Shape Shape1 
         BackStyle       =   1  'Opaque
         FillColor       =   &H000000FF&
         FillStyle       =   0  'Solid
         Height          =   135
         Index           =   1
         Left            =   1440
         Top             =   1560
         Width           =   135
      End
      Begin VB.Shape Shape1 
         BackStyle       =   1  'Opaque
         FillColor       =   &H000000FF&
         FillStyle       =   0  'Solid
         Height          =   135
         Index           =   2
         Left            =   1680
         Top             =   1560
         Width           =   135
      End
      Begin VB.Shape Shape1 
         BackStyle       =   1  'Opaque
         FillColor       =   &H000000FF&
         FillStyle       =   0  'Solid
         Height          =   135
         Index           =   3
         Left            =   1920
         Top             =   1560
         Width           =   135
      End
      Begin VB.Shape Shape1 
         BackStyle       =   1  'Opaque
         FillColor       =   &H000000FF&
         FillStyle       =   0  'Solid
         Height          =   135
         Index           =   4
         Left            =   2160
         Top             =   1560
         Width           =   135
      End
      Begin VB.Shape Shape1 
         BackStyle       =   1  'Opaque
         FillColor       =   &H000000FF&
         FillStyle       =   0  'Solid
         Height          =   135
         Index           =   5
         Left            =   2400
         Top             =   1560
         Width           =   135
      End
      Begin VB.Shape Shape1 
         BackStyle       =   1  'Opaque
         FillColor       =   &H000000FF&
         FillStyle       =   0  'Solid
         Height          =   135
         Index           =   6
         Left            =   2640
         Top             =   1560
         Width           =   135
      End
      Begin VB.Shape Shape1 
         BackStyle       =   1  'Opaque
         FillColor       =   &H000000FF&
         FillStyle       =   0  'Solid
         Height          =   135
         Index           =   7
         Left            =   2880
         Top             =   1560
         Width           =   135
      End
      Begin VB.Label Label17 
         Caption         =   "CPU Access"
         Height          =   255
         Left            =   900
         TabIndex        =   38
         Top             =   480
         Width           =   975
      End
      Begin VB.Label Label16 
         Caption         =   "Alt. Green Select"
         Height          =   255
         Left            =   840
         TabIndex        =   37
         Top             =   240
         Width           =   1275
      End
      Begin VB.Label Label15 
         Caption         =   "BANK3 /CASEN"
         Height          =   255
         Left            =   2160
         TabIndex        =   36
         Top             =   240
         Width           =   1335
      End
      Begin VB.Label Label13 
         Caption         =   "BANK2 /CASEN"
         Height          =   255
         Left            =   2400
         TabIndex        =   35
         Top             =   480
         Width           =   1335
      End
      Begin VB.Label Label5 
         Caption         =   "Cass Motor Enable"
         Height          =   255
         Left            =   2640
         TabIndex        =   34
         Top             =   720
         Width           =   1455
      End
      Begin VB.Label Label2 
         Caption         =   "Speaker Enable"
         Height          =   255
         Left            =   2880
         TabIndex        =   33
         Top             =   960
         Width           =   1215
      End
   End
   Begin VB.Frame frmP7F_4896 
      Caption         =   "PORT 7F     BANK LATCH"
      Height          =   2175
      Left            =   4140
      TabIndex        =   77
      Top             =   0
      Width           =   3195
      Begin VB.Label Label46 
         Caption         =   "/WREN1"
         Height          =   255
         Left            =   2340
         TabIndex        =   86
         Top             =   960
         Width           =   735
      End
      Begin VB.Shape Shape3 
         BackStyle       =   1  'Opaque
         FillColor       =   &H000000FF&
         FillStyle       =   0  'Solid
         Height          =   135
         Index           =   0
         Left            =   660
         Top             =   1560
         Width           =   135
      End
      Begin VB.Label Label45 
         Caption         =   "WREN2"
         Height          =   255
         Left            =   2100
         TabIndex        =   85
         Top             =   720
         Width           =   675
      End
      Begin VB.Shape Shape3 
         BackStyle       =   1  'Opaque
         FillColor       =   &H000000FF&
         FillStyle       =   0  'Solid
         Height          =   135
         Index           =   1
         Left            =   900
         Top             =   1560
         Width           =   135
      End
      Begin VB.Shape Shape3 
         BackStyle       =   1  'Opaque
         FillColor       =   &H000000FF&
         FillStyle       =   0  'Solid
         Height          =   135
         Index           =   2
         Left            =   1140
         Top             =   1560
         Width           =   135
      End
      Begin VB.Shape Shape3 
         BackStyle       =   1  'Opaque
         FillColor       =   &H000000FF&
         FillStyle       =   0  'Solid
         Height          =   135
         Index           =   3
         Left            =   1380
         Top             =   1560
         Width           =   135
      End
      Begin VB.Shape Shape3 
         BackStyle       =   1  'Opaque
         FillColor       =   &H000000FF&
         FillStyle       =   0  'Solid
         Height          =   135
         Index           =   4
         Left            =   1620
         Top             =   1560
         Width           =   135
      End
      Begin VB.Shape Shape3 
         BackStyle       =   1  'Opaque
         FillColor       =   &H000000FF&
         FillStyle       =   0  'Solid
         Height          =   135
         Index           =   5
         Left            =   1860
         Top             =   1560
         Width           =   135
      End
      Begin VB.Shape Shape3 
         BackStyle       =   1  'Opaque
         FillColor       =   &H000000FF&
         FillStyle       =   0  'Solid
         Height          =   135
         Index           =   6
         Left            =   2100
         Top             =   1560
         Width           =   135
      End
      Begin VB.Shape Shape3 
         BackStyle       =   1  'Opaque
         FillColor       =   &H000000FF&
         FillStyle       =   0  'Solid
         Height          =   135
         Index           =   7
         Left            =   2340
         Top             =   1560
         Width           =   135
      End
      Begin VB.Label Label44 
         Caption         =   "WREN3"
         Height          =   255
         Left            =   1860
         TabIndex        =   84
         Top             =   480
         Width           =   675
      End
      Begin VB.Label Label43 
         Caption         =   "WREN4"
         Height          =   255
         Left            =   1620
         TabIndex        =   83
         Top             =   240
         Width           =   675
      End
      Begin VB.Label Label42 
         Caption         =   "/RDEN0"
         Height          =   255
         Left            =   840
         TabIndex        =   82
         Top             =   240
         Width           =   735
      End
      Begin VB.Label Label41 
         Caption         =   "/RDEN1"
         Height          =   255
         Left            =   600
         TabIndex        =   81
         Top             =   480
         Width           =   735
      End
      Begin VB.Label Label40 
         Caption         =   "RDEN2/3"
         Height          =   255
         Left            =   300
         TabIndex        =   80
         Top             =   720
         Width           =   795
      End
      Begin VB.Label Label39 
         Caption         =   "RDEN4"
         Height          =   255
         Left            =   180
         TabIndex        =   79
         Top             =   960
         Width           =   615
      End
      Begin VB.Label lblBanklatch4896 
         Caption         =   "00"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   1440
         TabIndex        =   78
         Top             =   1800
         Width           =   495
      End
      Begin VB.Line Line26 
         X1              =   720
         X2              =   720
         Y1              =   1560
         Y2              =   1200
      End
      Begin VB.Line Line25 
         X1              =   960
         X2              =   960
         Y1              =   1560
         Y2              =   960
      End
      Begin VB.Line Line24 
         X1              =   1200
         X2              =   1200
         Y1              =   1560
         Y2              =   720
      End
      Begin VB.Line Line23 
         X1              =   1440
         X2              =   1440
         Y1              =   1560
         Y2              =   480
      End
      Begin VB.Line Line22 
         X1              =   1680
         X2              =   1680
         Y1              =   480
         Y2              =   1560
      End
      Begin VB.Line Line21 
         X1              =   1920
         X2              =   1920
         Y1              =   720
         Y2              =   1560
      End
      Begin VB.Line Line20 
         X1              =   2160
         X2              =   2160
         Y1              =   960
         Y2              =   1560
      End
      Begin VB.Line Line19 
         X1              =   2400
         X2              =   2400
         Y1              =   1200
         Y2              =   1560
      End
   End
   Begin VB.Frame frmP80_128 
      Caption         =   "PORT 80                VIDEO LATCH"
      Height          =   2175
      Left            =   0
      TabIndex        =   87
      Top             =   0
      Width           =   4155
      Begin VB.Label Label55 
         Caption         =   "Speaker Enable"
         Height          =   255
         Left            =   2880
         TabIndex        =   96
         Top             =   960
         Width           =   1215
      End
      Begin VB.Label Label54 
         Caption         =   "Serial HS Out"
         Height          =   255
         Left            =   2640
         TabIndex        =   95
         Top             =   720
         Width           =   1455
      End
      Begin VB.Label Label53 
         Caption         =   "Cassette Enable"
         Height          =   255
         Left            =   2400
         TabIndex        =   94
         Top             =   480
         Width           =   1515
      End
      Begin VB.Label Label52 
         Caption         =   "Cassette Motor Enable"
         Height          =   255
         Left            =   2160
         TabIndex        =   93
         Top             =   240
         Width           =   1875
      End
      Begin VB.Label Label51 
         Caption         =   "Alt. Green Select"
         Height          =   255
         Left            =   840
         TabIndex        =   92
         Top             =   240
         Width           =   1275
      End
      Begin VB.Label Label50 
         Caption         =   "CPU Access"
         Height          =   255
         Left            =   900
         TabIndex        =   91
         Top             =   480
         Width           =   975
      End
      Begin VB.Shape Shape4 
         BackStyle       =   1  'Opaque
         FillColor       =   &H000000FF&
         FillStyle       =   0  'Solid
         Height          =   135
         Index           =   7
         Left            =   2880
         Top             =   1560
         Width           =   135
      End
      Begin VB.Shape Shape4 
         BackStyle       =   1  'Opaque
         FillColor       =   &H000000FF&
         FillStyle       =   0  'Solid
         Height          =   135
         Index           =   6
         Left            =   2640
         Top             =   1560
         Width           =   135
      End
      Begin VB.Shape Shape4 
         BackStyle       =   1  'Opaque
         FillColor       =   &H000000FF&
         FillStyle       =   0  'Solid
         Height          =   135
         Index           =   5
         Left            =   2400
         Top             =   1560
         Width           =   135
      End
      Begin VB.Shape Shape4 
         BackStyle       =   1  'Opaque
         FillColor       =   &H000000FF&
         FillStyle       =   0  'Solid
         Height          =   135
         Index           =   4
         Left            =   2160
         Top             =   1560
         Width           =   135
      End
      Begin VB.Shape Shape4 
         BackStyle       =   1  'Opaque
         FillColor       =   &H000000FF&
         FillStyle       =   0  'Solid
         Height          =   135
         Index           =   3
         Left            =   1920
         Top             =   1560
         Width           =   135
      End
      Begin VB.Shape Shape4 
         BackStyle       =   1  'Opaque
         FillColor       =   &H000000FF&
         FillStyle       =   0  'Solid
         Height          =   135
         Index           =   2
         Left            =   1680
         Top             =   1560
         Width           =   135
      End
      Begin VB.Shape Shape4 
         BackStyle       =   1  'Opaque
         FillColor       =   &H000000FF&
         FillStyle       =   0  'Solid
         Height          =   135
         Index           =   1
         Left            =   1440
         Top             =   1560
         Width           =   135
      End
      Begin VB.Label Label49 
         Caption         =   "Line Blanking Mono"
         Height          =   255
         Left            =   180
         TabIndex        =   90
         Top             =   720
         Width           =   1455
      End
      Begin VB.Shape Shape4 
         BackStyle       =   1  'Opaque
         FillColor       =   &H000000FF&
         FillStyle       =   0  'Solid
         Height          =   135
         Index           =   0
         Left            =   1200
         Top             =   1560
         Width           =   135
      End
      Begin VB.Label Label48 
         Caption         =   "Serial Data Out"
         Height          =   255
         Left            =   240
         TabIndex        =   89
         Top             =   960
         Width           =   1335
      End
      Begin VB.Line Line34 
         X1              =   1260
         X2              =   1260
         Y1              =   1560
         Y2              =   1200
      End
      Begin VB.Line Line33 
         X1              =   1500
         X2              =   1500
         Y1              =   1560
         Y2              =   960
      End
      Begin VB.Line Line32 
         X1              =   1740
         X2              =   1740
         Y1              =   1560
         Y2              =   720
      End
      Begin VB.Line Line31 
         X1              =   1980
         X2              =   1980
         Y1              =   1560
         Y2              =   480
      End
      Begin VB.Line Line30 
         X1              =   2220
         X2              =   2220
         Y1              =   480
         Y2              =   1560
      End
      Begin VB.Line Line29 
         X1              =   2460
         X2              =   2460
         Y1              =   720
         Y2              =   1560
      End
      Begin VB.Line Line28 
         X1              =   2700
         X2              =   2700
         Y1              =   960
         Y2              =   1560
      End
      Begin VB.Line Line27 
         X1              =   2940
         X2              =   2940
         Y1              =   1200
         Y2              =   1560
      End
      Begin VB.Label lblVidlatch128 
         Caption         =   "00"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   1980
         TabIndex        =   88
         Top             =   1800
         Width           =   495
      End
   End
   Begin VB.Frame frmP82_128 
      Caption         =   "PORT 82     BANK LATCH"
      Height          =   2175
      Left            =   4140
      TabIndex        =   41
      Top             =   0
      Width           =   3195
      Begin VB.Line Line18 
         X1              =   2400
         X2              =   2400
         Y1              =   1200
         Y2              =   1560
      End
      Begin VB.Line Line17 
         X1              =   2160
         X2              =   2160
         Y1              =   960
         Y2              =   1560
      End
      Begin VB.Line Line16 
         X1              =   1920
         X2              =   1920
         Y1              =   720
         Y2              =   1560
      End
      Begin VB.Line Line15 
         X1              =   1680
         X2              =   1680
         Y1              =   480
         Y2              =   1560
      End
      Begin VB.Line Line14 
         X1              =   1440
         X2              =   1440
         Y1              =   1560
         Y2              =   480
      End
      Begin VB.Line Line13 
         X1              =   1200
         X2              =   1200
         Y1              =   1560
         Y2              =   720
      End
      Begin VB.Line Line12 
         X1              =   960
         X2              =   960
         Y1              =   1560
         Y2              =   960
      End
      Begin VB.Line Line11 
         X1              =   720
         X2              =   720
         Y1              =   1560
         Y2              =   1200
      End
      Begin VB.Label lblBanklatch128 
         Caption         =   "00"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   1440
         TabIndex        =   65
         Top             =   1800
         Width           =   495
      End
      Begin VB.Label Label27 
         Caption         =   "RDEN4"
         Height          =   255
         Left            =   2340
         TabIndex        =   49
         Top             =   960
         Width           =   615
      End
      Begin VB.Label Label26 
         Caption         =   "RDEN2"
         Height          =   255
         Left            =   2100
         TabIndex        =   48
         Top             =   720
         Width           =   675
      End
      Begin VB.Label Label25 
         Caption         =   "/RDEN1"
         Height          =   255
         Left            =   1860
         TabIndex        =   47
         Top             =   480
         Width           =   975
      End
      Begin VB.Label Label24 
         Caption         =   "/RDEN0"
         Height          =   255
         Left            =   1620
         TabIndex        =   46
         Top             =   240
         Width           =   975
      End
      Begin VB.Label Label23 
         Caption         =   "WREN4"
         Height          =   255
         Left            =   840
         TabIndex        =   45
         Top             =   240
         Width           =   735
      End
      Begin VB.Label Label22 
         Caption         =   "COLSEL"
         Height          =   255
         Left            =   660
         TabIndex        =   44
         Top             =   480
         Width           =   975
      End
      Begin VB.Shape Shape2 
         BackStyle       =   1  'Opaque
         FillColor       =   &H000000FF&
         FillStyle       =   0  'Solid
         Height          =   135
         Index           =   7
         Left            =   2340
         Top             =   1560
         Width           =   135
      End
      Begin VB.Shape Shape2 
         BackStyle       =   1  'Opaque
         FillColor       =   &H000000FF&
         FillStyle       =   0  'Solid
         Height          =   135
         Index           =   6
         Left            =   2100
         Top             =   1560
         Width           =   135
      End
      Begin VB.Shape Shape2 
         BackStyle       =   1  'Opaque
         FillColor       =   &H000000FF&
         FillStyle       =   0  'Solid
         Height          =   135
         Index           =   5
         Left            =   1860
         Top             =   1560
         Width           =   135
      End
      Begin VB.Shape Shape2 
         BackStyle       =   1  'Opaque
         FillColor       =   &H000000FF&
         FillStyle       =   0  'Solid
         Height          =   135
         Index           =   4
         Left            =   1620
         Top             =   1560
         Width           =   135
      End
      Begin VB.Shape Shape2 
         BackStyle       =   1  'Opaque
         FillColor       =   &H000000FF&
         FillStyle       =   0  'Solid
         Height          =   135
         Index           =   3
         Left            =   1380
         Top             =   1560
         Width           =   135
      End
      Begin VB.Shape Shape2 
         BackStyle       =   1  'Opaque
         FillColor       =   &H000000FF&
         FillStyle       =   0  'Solid
         Height          =   135
         Index           =   2
         Left            =   1140
         Top             =   1560
         Width           =   135
      End
      Begin VB.Shape Shape2 
         BackStyle       =   1  'Opaque
         FillColor       =   &H000000FF&
         FillStyle       =   0  'Solid
         Height          =   135
         Index           =   1
         Left            =   900
         Top             =   1560
         Width           =   135
      End
      Begin VB.Label Label21 
         Caption         =   "WREN2"
         Height          =   255
         Left            =   420
         TabIndex        =   43
         Top             =   720
         Width           =   975
      End
      Begin VB.Shape Shape2 
         BackStyle       =   1  'Opaque
         FillColor       =   &H000000FF&
         FillStyle       =   0  'Solid
         Height          =   135
         Index           =   0
         Left            =   660
         Top             =   1560
         Width           =   135
      End
      Begin VB.Label Label20 
         Caption         =   "/WREN1"
         Height          =   255
         Left            =   120
         TabIndex        =   42
         Top             =   960
         Width           =   735
      End
   End
   Begin VB.HScrollBar HScroll4 
      Height          =   195
      Left            =   1800
      Max             =   32
      Min             =   4
      TabIndex        =   75
      Top             =   5400
      Value           =   16
      Width           =   1695
   End
   Begin VB.CommandButton Command10 
      Caption         =   "Set Iperiod"
      Height          =   255
      Left            =   6600
      TabIndex        =   72
      Top             =   6000
      Width           =   1095
   End
   Begin VB.TextBox txtIperi 
      Height          =   255
      Left            =   6600
      TabIndex        =   70
      Text            =   "80000"
      Top             =   5760
      Width           =   1095
   End
   Begin VB.CommandButton Command9 
      Caption         =   ">"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1935
      Left            =   7380
      TabIndex        =   69
      Top             =   0
      Width           =   375
   End
   Begin VB.CommandButton Command8 
      Caption         =   "Jog"
      Height          =   255
      Left            =   9660
      TabIndex        =   68
      Top             =   4800
      Width           =   795
   End
   Begin VB.TextBox txtDisas 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   4755
      Left            =   7800
      MaxLength       =   65535
      MultiLine       =   -1  'True
      TabIndex        =   67
      Text            =   "Form2.frx":030A
      Top             =   0
      Width           =   3435
   End
   Begin VB.CommandButton Command7 
      Caption         =   "Close"
      Height          =   315
      Left            =   5640
      TabIndex        =   66
      Top             =   4680
      Width           =   1995
   End
   Begin VB.Frame Frame4 
      Caption         =   "Options"
      Height          =   1575
      Left            =   5220
      TabIndex        =   58
      Top             =   2220
      Width           =   2535
      Begin VB.CheckBox chkVidMode 
         Caption         =   "Accurate Video"
         Height          =   255
         Left            =   240
         TabIndex        =   73
         Top             =   240
         Width           =   2115
      End
      Begin VB.CheckBox chkShowFPS 
         Caption         =   "Show FPS"
         Height          =   252
         Left            =   240
         TabIndex        =   62
         Top             =   480
         Width           =   1812
      End
      Begin VB.CheckBox Check2 
         Caption         =   "CRTC / Sound Status"
         Height          =   252
         Left            =   240
         TabIndex        =   61
         Top             =   1200
         Value           =   1  'Checked
         Width           =   2172
      End
      Begin VB.CheckBox chkSound 
         Caption         =   "Sound (requires restart)"
         Height          =   252
         Left            =   240
         TabIndex        =   60
         Top             =   720
         Width           =   2175
      End
      Begin VB.HScrollBar HScroll1 
         Height          =   255
         Left            =   240
         Max             =   4
         TabIndex        =   59
         Top             =   960
         Width           =   1695
      End
      Begin VB.Label Label28 
         Caption         =   "Hum"
         Height          =   255
         Left            =   1980
         TabIndex        =   63
         Top             =   960
         Width           =   375
      End
   End
   Begin VB.CommandButton Command4 
      Caption         =   "dev stuff"
      Height          =   255
      Left            =   120
      TabIndex        =   57
      Top             =   4740
      Width           =   855
   End
   Begin VB.CheckBox chk6845Fix 
      Caption         =   "Flicker Fix"
      Height          =   252
      Left            =   6540
      TabIndex        =   56
      Top             =   5460
      Width           =   1215
   End
   Begin VB.TextBox txtSoundstat 
      Height          =   255
      Left            =   2220
      TabIndex        =   53
      Text            =   "lah di dah di dah di di di dah"
      Top             =   4740
      Width           =   3015
   End
   Begin VB.Frame Frame3 
      Caption         =   "6845 CRTC Registers"
      Height          =   855
      Left            =   0
      TabIndex        =   50
      Top             =   3780
      Width           =   7755
      Begin VB.TextBox Text1 
         Height          =   255
         Left            =   120
         TabIndex        =   52
         Text            =   "wonderful spam... wonderful spam..."
         Top             =   240
         Width           =   7515
      End
      Begin VB.TextBox Text2 
         Height          =   255
         Left            =   120
         TabIndex        =   51
         Text            =   "a mild suffusion of pink"
         Top             =   540
         Width           =   7515
      End
   End
   Begin VB.CommandButton Command6 
      Caption         =   "Set Trap Addr"
      Height          =   852
      Left            =   2940
      TabIndex        =   31
      Top             =   6060
      Width           =   732
   End
   Begin VB.TextBox txtTrapaddr 
      Height          =   288
      Left            =   2940
      TabIndex        =   30
      Text            =   "fffe"
      Top             =   5700
      Width           =   732
   End
   Begin VB.CommandButton cmdStoptrap 
      Caption         =   "Stop TRAP"
      Height          =   372
      Left            =   1740
      TabIndex        =   29
      Top             =   6180
      Width           =   1092
   End
   Begin VB.CommandButton cmdStarttrap 
      Caption         =   "Start TRAP"
      Height          =   372
      Left            =   1740
      TabIndex        =   28
      Top             =   5700
      Width           =   1092
   End
   Begin VB.CommandButton Command5 
      Caption         =   "MEM DUMP"
      Height          =   252
      Left            =   120
      TabIndex        =   27
      Top             =   5160
      Width           =   1452
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Stop Trace"
      Height          =   255
      Left            =   120
      TabIndex        =   26
      Top             =   6060
      Width           =   1452
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Start Disk Dump Trace (~4MB /second)"
      Height          =   615
      Left            =   120
      TabIndex        =   25
      Top             =   5460
      Width           =   1455
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Trap List"
      Height          =   252
      Left            =   1740
      TabIndex        =   24
      Top             =   6660
      Width           =   1092
   End
   Begin VB.TextBox Text3 
      Height          =   288
      Left            =   5700
      TabIndex        =   22
      Text            =   "695d"
      Top             =   6300
      Width           =   612
   End
   Begin VB.CommandButton Command11 
      Caption         =   "SET PC"
      Height          =   372
      Left            =   5100
      TabIndex        =   21
      Top             =   6660
      Width           =   1212
   End
   Begin VB.TextBox Text5 
      Height          =   300
      Left            =   0
      TabIndex        =   12
      Text            =   "ooer, its dead"
      Top             =   2640
      Width           =   5172
   End
   Begin VB.TextBox Text6 
      Height          =   288
      Left            =   4380
      TabIndex        =   11
      Text            =   "77"
      Top             =   6480
      Width           =   612
   End
   Begin VB.CommandButton Command12 
      Caption         =   "POKE"
      Height          =   252
      Left            =   3780
      TabIndex        =   10
      Top             =   6780
      Width           =   1212
   End
   Begin VB.TextBox Text7 
      Height          =   288
      Left            =   4380
      TabIndex        =   9
      Text            =   "625c"
      Top             =   6180
      Width           =   612
   End
   Begin VB.CommandButton Command13 
      Caption         =   "DPEEK"
      Height          =   252
      Left            =   3780
      TabIndex        =   8
      Top             =   5880
      Width           =   1212
   End
   Begin VB.TextBox Text8 
      Height          =   288
      Left            =   4380
      TabIndex        =   7
      Text            =   "625c"
      Top             =   5220
      Width           =   612
   End
   Begin VB.TextBox Text9 
      Height          =   288
      Left            =   4380
      TabIndex        =   6
      Text            =   "0"
      Top             =   5580
      Width           =   612
   End
   Begin VB.TextBox Text10 
      Height          =   288
      Left            =   5700
      TabIndex        =   5
      Text            =   "0"
      Top             =   5460
      Width           =   492
   End
   Begin VB.CommandButton Command18 
      Caption         =   "Set Port"
      Height          =   252
      Left            =   5100
      TabIndex        =   4
      Top             =   5760
      Width           =   1212
   End
   Begin VB.TextBox Text11 
      Height          =   288
      Left            =   5700
      TabIndex        =   3
      Text            =   "80"
      Top             =   5220
      Width           =   492
   End
   Begin VB.CommandButton Command20 
      Caption         =   "FF Port"
      Height          =   252
      Left            =   5100
      TabIndex        =   2
      Top             =   6000
      Width           =   1212
   End
   Begin VB.TextBox Text13 
      Height          =   348
      Left            =   0
      TabIndex        =   1
      Text            =   "distinctly non-stackish"
      Top             =   3240
      Width           =   5172
   End
   Begin VB.TextBox Text14 
      Height          =   225
      Left            =   8040
      TabIndex        =   0
      Text            =   "fruit and nutcake"
      Top             =   6300
      Width           =   2055
   End
   Begin VB.Label lbltrpa 
      Caption         =   "Label32"
      Height          =   315
      Left            =   7980
      TabIndex        =   110
      Top             =   6600
      Width           =   1155
   End
   Begin VB.Label lbltrp 
      Caption         =   "Label32"
      Height          =   315
      Left            =   7920
      TabIndex        =   109
      Top             =   7020
      Width           =   1395
   End
   Begin VB.Label Label33 
      Caption         =   "0"
      Height          =   255
      Left            =   8940
      TabIndex        =   107
      Top             =   4800
      Width           =   675
   End
   Begin VB.Label Label30 
      Caption         =   "Label30"
      Height          =   315
      Left            =   2280
      TabIndex        =   104
      Top             =   7500
      Width           =   2295
   End
   Begin VB.Label Label29 
      Caption         =   "Label29"
      Height          =   315
      Left            =   360
      TabIndex        =   103
      Top             =   7500
      Width           =   1695
   End
   Begin VB.Label Label35 
      Caption         =   "Sound Divisor"
      Height          =   195
      Left            =   1920
      TabIndex        =   76
      Top             =   5160
      Width           =   1095
   End
   Begin VB.Line Line1 
      X1              =   6480
      X2              =   6480
      Y1              =   5220
      Y2              =   7020
   End
   Begin VB.Label Label31 
      Caption         =   "(mess with these at your peril)"
      Height          =   255
      Left            =   8220
      TabIndex        =   74
      Top             =   5880
      Width           =   2235
   End
   Begin VB.Label lblJogval 
      Caption         =   "0"
      Height          =   195
      Left            =   10500
      TabIndex        =   71
      Top             =   4800
      Width           =   615
   End
   Begin VB.Label Label14 
      Caption         =   "You found the secret bit...   :)"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Left            =   7980
      TabIndex        =   55
      Top             =   5400
      Width           =   3195
   End
   Begin VB.Label Label1 
      Caption         =   "Sound Status"
      Height          =   255
      Left            =   1140
      TabIndex        =   54
      Top             =   4740
      Width           =   1095
   End
   Begin VB.Label Label3 
      Caption         =   "PC"
      Height          =   255
      Left            =   5340
      TabIndex        =   23
      Top             =   6360
      Width           =   375
   End
   Begin VB.Label Label4 
      Caption         =   "Z80 Registers"
      Height          =   255
      Left            =   120
      TabIndex        =   20
      Top             =   2400
      Width           =   1095
   End
   Begin VB.Label Label6 
      Caption         =   "Addr"
      Height          =   255
      Left            =   3780
      TabIndex        =   19
      Top             =   6180
      Width           =   495
   End
   Begin VB.Label Label7 
      Caption         =   "Value"
      Height          =   255
      Left            =   3780
      TabIndex        =   18
      Top             =   6540
      Width           =   495
   End
   Begin VB.Label Label8 
      Caption         =   "Addr"
      Height          =   255
      Left            =   3780
      TabIndex        =   17
      Top             =   5220
      Width           =   495
   End
   Begin VB.Label Label9 
      Caption         =   "Value"
      Height          =   255
      Left            =   3780
      TabIndex        =   16
      Top             =   5580
      Width           =   495
   End
   Begin VB.Label Label10 
      Caption         =   "Addr"
      Height          =   255
      Left            =   5100
      TabIndex        =   15
      Top             =   5220
      Width           =   495
   End
   Begin VB.Label Label11 
      Caption         =   "Value"
      Height          =   255
      Left            =   5100
      TabIndex        =   14
      Top             =   5460
      Width           =   495
   End
   Begin VB.Label Label12 
      Caption         =   "Z80 Stack"
      Height          =   255
      Left            =   120
      TabIndex        =   13
      Top             =   3000
      Width           =   975
   End
End
Attribute VB_Name = "Form2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit


Const dev_height As Integer = 7395
Const norm_height As Integer = 5340
Const norm_width As Integer = 7830
Const dev_width As Integer = 11340

Dim frm_height_save As Integer
Dim frm_width_save As Integer

Dim andy1 As Integer  'this is acually the speed setin in combo box





Private Sub Check1_Click()

If Check1.Value = vbChecked Then

set_b3_video (1)


Else

set_b3_video (0)


End If


End Sub

Private Sub Check2_Click()


If Check2.Value = vbChecked Then
    dump_6845 = 1
Else
    dump_6845 = 0
End If

Save_defaults

End Sub




Private Sub chk6845Fix_Click()

If chk6845Fix.Value = vbChecked Then
    Fix_6845 = 1
Else
    Fix_6845 = 0
End If

Save_defaults

End Sub



Private Sub chkVidMode_Click()
Dim ret


If chkVidMode.Value = vbChecked Then
    vidmode = 1
'    Check3.Value = vbChecked
'    c_mode = 1
'    ret = set_c_mode(c_mode)
    txtIperi.Text = "252"
    ret = set_iper(252)

    Form5.chkStatus = vbUnchecked   'makes  this form hide itself so the emu speeds up

Else
    vidmode = 0
'    Check3.Value = vbChecked
'    c_mode = 0
'    ret = set_c_mode(c_mode)
'    useautospeed = 1
'    set_autospeed (1)
txtIperi.Text = "50000"
    ret = set_iper(50000)
End If

set_vidmode (vidmode)

Save_defaults

If Form1.Visible = True Then Form1.SetFocus


End Sub

Private Sub chkShowFPS_Click()


If chkShowFPS.Value = vbChecked Then
    show_fps = 1
Else
    show_fps = 0
End If

Save_defaults



End Sub



Private Sub cmdClose_Click()

Unload Me


End Sub



Private Sub chkSound_Click()

If chkSound.Value = vbChecked Then
    set_soundstream (1)
    machine_sound = 1
Else
    set_soundstream (0)
    machine_sound = 0
End If

Save_defaults

End Sub



Private Sub cmdStarttrap_Click()
Dim ret As Long

ret = set_trapthis(1)
lbltrp.Caption = str(ret)


End Sub

Private Sub cmdStoptrap_Click()
Dim ret As Long

ret = set_trapthis(0)
lbltrp.Caption = str(ret)

End Sub



Private Sub Command1_Click()


Form6.Show


End Sub

Private Sub Command10_Click()
Dim ret

'ret = set_speed(Val(txtIperi.Text))

ret = set_iper(Val(txtIperi.Text))

End Sub

'Sub Command1_Click()
    
    
 '   send_to_lynx ("MLOAD" & Chr(34) & Chr(34) & vbCr & vbLf)


'End Sub







Private Sub Command11_Click()
Dim rt As Integer


rt = Val("&H" & Text3.Text)

set_pc (rt)


End Sub

Private Sub Command12_Click()
Dim ret As Integer

'ret = poke_mem(Val("&H" & Text7.Text), Val("&H" & Text6.Text))

End Sub

Private Sub Command13_Click()
Dim ret As Integer
Dim ret2 As Integer

ret = peek_mem(Val("&H" & Text8.Text))
ret2 = peek_mem(Val("&H" & Text8.Text) + 1)

Text9.Text = Hex$(ret) + Hex$(ret2)



End Sub



Private Sub Command14_Click()

Form17.Show


End Sub

Private Sub Command15_Click()
start_disk_trace

End Sub

Private Sub Command16_Click()
stop_disk_trace

End Sub

Private Sub Command17_Click()
Dim ret

ret = save_disk_dump


End Sub

'Private Sub SetSpeed_Click()
'Dim ret As Integer

'.Text12
'andy1 = Val(Text12.Text)

'ret = set_speed(andy1)
'End Sub


Private Sub Command18_Click()
Dim ret As Integer

'set value ret to a in command for a port
Dim andy1 As Integer
Dim andy2 As Integer

'andy1 = Val("&H" & Form1.Text11.Text) + 1
andy1 = Val("&H" & Text11.Text)
Text11.Text = Hex$(andy1)
andy2 = Val("&H" & Text10.Text)
'Form1.Text7.Text = Hex$(Val("&H" & Form1.Text7.Text) + 1)


ret = set_inp(andy1, andy2)


End Sub
' **************************************************************
' **************************************************************
' **************************************************************
' **************************************************************
' **************************************************************
' **************************************************************
' **************************************************************



Private Sub Command19_Click()

dis_bank = dis_bank + 1
If dis_bank > 4 Then dis_bank = 0


Label33.Caption = str(dis_bank)

End Sub

Private Sub Command2_Click()

start_trace


End Sub




Private Sub Command23_Click()

If dump_disas = 0 Then
    frm_width_save = Form2.Width
    Form2.Width = dev_width 'expand the form
    dump_disas = 1
Else
    Form2.Width = norm_width 'contract the form
    dump_disas = 0
End If

If Form2.Height <> dev_height Then
    frm_height_save = Form2.Height
    Form2.Height = dev_height
Else
   Form2.Height = norm_height
 '   Form2.Height = frm_height_save
End If


End Sub



Private Sub Command3_Click()

stop_trace


End Sub

Private Sub Command20_Click()

Dim ret As Integer

'ff in command for a port
Dim andy1 As Integer

andy1 = Val("&H" & Text11.Text) ' + 1
ret = set_inp(andy1, 255)



End Sub





Private Sub Command4_Click()


If Form2.Height <> dev_height Then
    frm_height_save = Form2.Height
    Form2.Height = dev_height
Else
'    Form2.Height = frm_height_save
    Form2.Height = norm_height
End If




End Sub

Private Sub Command5_Click()
Dim ret As Long

ret = save_mem_dump



End Sub

Private Sub Command6_Click()
Dim ret As Long

ret = set_trapaddr(Val("&H" & txtTrapaddr.Text))
lbltrpa.Caption = str(ret)

End Sub




Private Sub Command8_Click()

jogval = jogval + 1
If jogval > 3 Then jogval = 0
lblJogval = jogval


Form1.dump_disassembly


Save_defaults



End Sub


Private Sub Command7_Click()

Form5.chkStatus = vbUnchecked


End Sub

Private Sub Command9_Click()

If dump_disas = 0 Then
    frm_width_save = Form2.Width
    Form2.Width = dev_width 'expand the form
    dump_disas = 1
Else
'    Form2.Width = frm_width_save 'contract the form
    Form2.Width = norm_width 'contract the form
    dump_disas = 0
End If





End Sub

Public Sub set_displays()


Label29.Caption = "hwtype is " + str(hw_type)

If (hw_type = LYNX_HARDWARE_48) Or (hw_type = LYNX_HARDWARE_96) Then
 frmP80_4896.Visible = True
 frmP7F_4896.Visible = True
 frmP80_4896.Refresh
 frmP7F_4896.Refresh
 frmP80_128.Visible = False
 frmP82_128.Visible = False
Else
 frmP80_128.Visible = True
 frmP82_128.Visible = True
 frmP80_128.Refresh
 frmP82_128.Refresh
 frmP80_4896.Visible = False
 frmP7F_4896.Visible = False
End If


End Sub



Private Sub Form_Load()


'MsgBox "FORM2 LOAD"

load_form2_pos

Height = norm_height
Width = norm_width

set_displays

If machine_sound = 1 Then Form2.chkSound.Value = vbChecked
Form2.HScroll1.Value = machine_hum
Form2.Check2.Value = dump_6845


'If get_agg_banks = 1 Then
'    Check4.Value = vbChecked
'Else
'    Check4.Value = vbUnchecked
'End If

If Fix_6845 = 1 Then
    chk6845Fix.Value = vbChecked
Else
    chk6845Fix.Value = vbUnchecked
End If


If vidmode = 1 Then
    chkVidMode.Value = vbChecked
Else
    chkVidMode.Value = vbUnchecked
End If
 
HScroll4.Value = sound_div_in

'dump_6845 = 1
'dump_status = 1

'Form9.Show

 '     set_donmi (1)
    
'cmbDisktype.ListIndex = 0


'MsgBox "END  FORM2 LOAD"


End Sub

Private Sub Form_Unload(Cancel As Integer)

'dump_status = 0
'dump_6845 = 0

Form5.chkStatus = vbUnchecked
'set_soundstream (0)
'Form5.chkSysvar.Value = vbUnchecked

End Sub


Sub RefreshRegs()
Dim qwe, num, X As Integer
Dim video_latch As Integer
Dim bank_latch As Integer

'show status of ports 80 & 82 on display
'             "89 29 xxx xxxxxxx"
'search thru until get space

'Form2.Text14.Text = "80,80,12"

qwe = 1

While qwe < 16 And Mid$(Form2.Text14.Text, qwe, 1) <> ","
    qwe = qwe + 1
Wend

video_latch = Val("&H" + Left$(Form2.Text14.Text, qwe))

'MsgBox ("p80 is " + "&H" + Left$(Form2.Text14.Text, qwe))
bank_latch = Val("&H" + Right$(Form2.Text14.Text, Len(Form2.Text14.Text) - qwe))

'MsgBox ("p82 is " + str(p82))

'p7f = Val("&H" + Right$(Form2.Text14.Text, Len(Form2.Text14.Text) - qwe))


If hw_type = LYNX_HARDWARE_48 Or hw_type = LYNX_HARDWARE_96 Then
    lblVidlatch4896 = Hex$(video_latch)
    lblBanklatch4896 = Hex$(bank_latch)
Else
    lblVidlatch128 = Hex$(video_latch)
    lblBanklatch128 = Hex$(bank_latch)
End If

'Stop


num = video_latch
For X = 7 To 0 Step -1
     ' is this number divisible by this power of two
     'ret = ret & CStr(num \ (2 ^ x))
     If (num \ (2 ^ X)) > 0 Then
        If hw_type = LYNX_HARDWARE_48 Or hw_type = LYNX_HARDWARE_96 Then
            Form2.Shape1.Item(7 - X).FillColor = &HFF&
        Else
            Form2.Shape4.Item(7 - X).FillColor = &HFF&
        End If
     Else
        If hw_type = LYNX_HARDWARE_48 Or hw_type = LYNX_HARDWARE_96 Then
            Form2.Shape1.Item(7 - X).FillColor = &H0&
        Else
            Form2.Shape4.Item(7 - X).FillColor = &H0&
        End If
     End If
     
     ' get the remaining number
     num = num Mod (2 ^ X)
 Next X
 
    num = bank_latch
    
    For X = 7 To 0 Step -1
     ' is this number divisible by this power of two
     'ret = ret & CStr(num \ (2 ^ x))
     If (num \ (2 ^ X)) > 0 Then
        If hw_type = LYNX_HARDWARE_48 Or hw_type = LYNX_HARDWARE_96 Then
            Form2.Shape3.Item(7 - X).FillColor = &HFF&
        Else
            Form2.Shape2.Item(7 - X).FillColor = &HFF&
        End If
     Else
        If hw_type = LYNX_HARDWARE_48 Or hw_type = LYNX_HARDWARE_96 Then
            Form2.Shape3.Item(7 - X).FillColor = &H0&
        Else
            Form2.Shape2.Item(7 - X).FillColor = &H0&
        End If
     End If
     
     ' get the remaining number
     num = num Mod (2 ^ X)
 Next X
    

'Text12.Text = str(andy1)

End Sub

Private Sub HScroll1_Change()


If HScroll1.Value > 0 Then
    set_hum (HScroll1.Value)
    machine_hum = HScroll1.Value
Else
    set_hum (0)
    machine_hum = 0
End If


Save_defaults


End Sub

'Private Sub HScroll2_Change()
'Form1.Timer1.Interval = HScroll2.Value
'lblAutointerval.Caption = str(HScroll2.Value)
'End Sub

'private Sub HScroll3_Change()
'Dim ret
'cowval = HScroll3.Value
'ret = set_cowval(cowval)
'End Sub

Private Sub HScroll4_Change()
Dim ret


    ret = set_sound_div_in(HScroll4.Value)
    sound_div_in = HScroll4.Value

Text12.Text = str(sound_div_in)

Save_defaults

End Sub


