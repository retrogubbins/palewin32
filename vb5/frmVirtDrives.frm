VERSION 5.00
Begin VB.Form frmVirtDrives 
   Caption         =   "VirTuAL DrIvEZ"
   ClientHeight    =   3150
   ClientLeft      =   120
   ClientTop       =   420
   ClientWidth     =   3240
   LinkTopic       =   "Form19"
   ScaleHeight     =   3150
   ScaleWidth      =   3240
   StartUpPosition =   3  'Windows Default
   Begin VB.Timer Timer1 
      Interval        =   400
      Left            =   2760
      Top             =   960
   End
   Begin VB.CommandButton Command3 
      Caption         =   "LibDSK/FDRaw Setup"
      Enabled         =   0   'False
      Height          =   615
      Left            =   1440
      TabIndex        =   3
      Top             =   2280
      Width           =   1455
   End
   Begin VB.CommandButton Command2 
      Caption         =   "LSF Loader"
      Enabled         =   0   'False
      Height          =   495
      Left            =   240
      TabIndex        =   2
      Top             =   1560
      Width           =   1455
   End
   Begin VB.CommandButton Command1 
      Caption         =   "TAP Loader"
      Enabled         =   0   'False
      Height          =   495
      Left            =   1200
      TabIndex        =   1
      Top             =   960
      Width           =   1455
   End
   Begin VB.CommandButton cmdRemDisks 
      Caption         =   "Remote Disks"
      Enabled         =   0   'False
      Height          =   495
      Left            =   240
      TabIndex        =   0
      Top             =   360
      Width           =   1455
   End
   Begin VB.Line Line18 
      X1              =   960
      X2              =   1080
      Y1              =   2880
      Y2              =   3000
   End
   Begin VB.Line Line17 
      X1              =   600
      X2              =   480
      Y1              =   2880
      Y2              =   3000
   End
   Begin VB.Line Line15 
      X1              =   1080
      X2              =   1200
      Y1              =   2400
      Y2              =   2280
   End
   Begin VB.Line Line14 
      X1              =   1080
      X2              =   1080
      Y1              =   2640
      Y2              =   2400
   End
   Begin VB.Line Line13 
      X1              =   600
      X2              =   480
      Y1              =   2520
      Y2              =   2280
   End
   Begin VB.Line Line12 
      X1              =   720
      X2              =   600
      Y1              =   2400
      Y2              =   2160
   End
   Begin VB.Line Line11 
      X1              =   840
      X2              =   840
      Y1              =   2400
      Y2              =   2160
   End
   Begin VB.Line Line10 
      X1              =   960
      X2              =   1080
      Y1              =   2400
      Y2              =   2280
   End
   Begin VB.Shape Shape11 
      FillStyle       =   0  'Solid
      Height          =   135
      Left            =   720
      Shape           =   3  'Circle
      Top             =   2760
      Width           =   255
   End
   Begin VB.Shape Shape10 
      Height          =   135
      Left            =   840
      Shape           =   3  'Circle
      Top             =   2520
      Width           =   135
   End
   Begin VB.Shape Shape9 
      Height          =   135
      Left            =   600
      Shape           =   3  'Circle
      Top             =   2520
      Width           =   135
   End
   Begin VB.Shape Shape8 
      Height          =   735
      Left            =   480
      Shape           =   3  'Circle
      Top             =   2280
      Width           =   615
   End
   Begin VB.Line Line9 
      X1              =   2040
      X2              =   2400
      Y1              =   1920
      Y2              =   1680
   End
   Begin VB.Line Line8 
      X1              =   2040
      X2              =   2160
      Y1              =   1920
      Y2              =   1680
   End
   Begin VB.Line Line7 
      X1              =   1800
      X2              =   2160
      Y1              =   1920
      Y2              =   1680
   End
   Begin VB.Shape Shape6 
      Height          =   375
      Left            =   2520
      Top             =   1560
      Width           =   495
   End
   Begin VB.Label Label1 
      Caption         =   "!"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   2760
      TabIndex        =   4
      Top             =   1560
      Width           =   255
   End
   Begin VB.Line Line6 
      X1              =   2880
      X2              =   3120
      Y1              =   2040
      Y2              =   2040
   End
   Begin VB.Shape Shape7 
      Height          =   255
      Left            =   2400
      Top             =   1920
      Width           =   735
   End
   Begin VB.Line Line5 
      X1              =   480
      X2              =   1080
      Y1              =   1320
      Y2              =   1320
   End
   Begin VB.Line Line4 
      X1              =   480
      X2              =   1080
      Y1              =   1200
      Y2              =   1200
   End
   Begin VB.Shape Shape5 
      Height          =   255
      Left            =   240
      Shape           =   3  'Circle
      Top             =   1200
      Width           =   255
   End
   Begin VB.Shape Shape4 
      Height          =   255
      Left            =   0
      Shape           =   3  'Circle
      Top             =   1200
      Width           =   255
   End
   Begin VB.Shape Shape3 
      Height          =   375
      Left            =   0
      Top             =   1080
      Width           =   495
   End
   Begin VB.Line Line3 
      X1              =   2160
      X2              =   2520
      Y1              =   720
      Y2              =   480
   End
   Begin VB.Line Line2 
      X1              =   2160
      X2              =   2280
      Y1              =   720
      Y2              =   480
   End
   Begin VB.Line Line1 
      X1              =   1920
      X2              =   2280
      Y1              =   720
      Y2              =   480
   End
   Begin VB.Shape Shape2 
      Height          =   495
      Left            =   2520
      Shape           =   3  'Circle
      Top             =   360
      Width           =   375
   End
   Begin VB.Shape Shape1 
      Height          =   495
      Left            =   2400
      Shape           =   3  'Circle
      Top             =   360
      Width           =   375
   End
   Begin VB.Label Label2 
      Caption         =   "?"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   720
      TabIndex        =   5
      Top             =   2160
      Width           =   375
   End
End
Attribute VB_Name = "frmVirtDrives"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim flasher As Integer


Private Sub Form_Load()

    flasher = 0


End Sub

Private Sub Timer1_Timer()

If flasher = 0 Then
    flasher = 1
    
    Shape1.Left = Shape1.Left + 50
    Shape2.Left = Shape2.Left - 50
    
    Shape4.Top = Shape4.Top + 50
    Shape5.Top = Shape5.Top - 50
 
    Line7.X1 = Line7.X1 + 50
     Line9.X2 = Line9.X2 - 50
   Shape9.Height = Shape9.Height + 50
   Shape9.Width = Shape9.Width + 50
   
    Shape10.Height = Shape10.Height + 50
   Shape10.Width = Shape10.Width + 50
   
Else
    flasher = 0
    Shape1.Left = Shape1.Left - 50
    Shape2.Left = Shape2.Left + 50

    Shape4.Top = Shape4.Top - 50
    Shape5.Top = Shape5.Top + 50

    Line7.X1 = Line7.X1 - 50
     Line9.X2 = Line9.X2 + 50
    
    Shape9.Height = Shape9.Height - 50
   Shape9.Width = Shape9.Width - 50
      
    Shape10.Height = Shape10.Height - 50
   Shape10.Width = Shape10.Width - 50
  
End If

'Me.Refresh


End Sub
