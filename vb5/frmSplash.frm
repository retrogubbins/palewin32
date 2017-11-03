VERSION 5.00
Begin VB.Form frmSplash 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   BorderStyle     =   3  'Fixed Dialog
   ClientHeight    =   7635
   ClientLeft      =   7515
   ClientTop       =   5865
   ClientWidth     =   5580
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   Icon            =   "frmSplash.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   7635
   ScaleWidth      =   5580
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   7650
      Left            =   0
      TabIndex        =   0
      Top             =   -60
      Width           =   5550
      Begin VB.Timer Timer1 
         Interval        =   12000
         Left            =   4620
         Top             =   240
      End
      Begin VB.CommandButton Command1 
         Caption         =   "Close"
         Height          =   375
         Left            =   2100
         TabIndex        =   5
         Top             =   6840
         Width           =   1275
      End
      Begin VB.CheckBox Check1 
         BackColor       =   &H80000009&
         Caption         =   "Don't show this again"
         Height          =   255
         Left            =   1740
         TabIndex        =   4
         Top             =   6240
         Width           =   2055
      End
      Begin VB.PictureBox Picture1 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   0  'None
         ForeColor       =   &H80000008&
         Height          =   1095
         Left            =   1320
         Picture         =   "frmSplash.frx":000C
         ScaleHeight     =   1095
         ScaleWidth      =   2775
         TabIndex        =   2
         Top             =   900
         Width           =   2775
      End
      Begin VB.Label Label7 
         BackColor       =   &H80000009&
         Caption         =   "I M P O R T A N T !"
         Height          =   255
         Left            =   1980
         TabIndex        =   11
         Top             =   2700
         Width           =   1635
      End
      Begin VB.Label Label6 
         Alignment       =   2  'Center
         BackColor       =   &H80000009&
         Caption         =   $"frmSplash.frx":91DC
         Height          =   1095
         Left            =   480
         TabIndex        =   10
         Top             =   3000
         Width           =   4515
      End
      Begin VB.Label Label5 
         BackColor       =   &H8000000E&
         Caption         =   "P e t e ' s   L y n x   E m u l a t o r  "
         Height          =   255
         Left            =   1500
         TabIndex        =   9
         Top             =   1980
         Width           =   2415
      End
      Begin VB.Line Line1 
         X1              =   2040
         X2              =   3360
         Y1              =   2400
         Y2              =   2400
      End
      Begin VB.Label Label4 
         Alignment       =   2  'Center
         BackColor       =   &H8000000E&
         Caption         =   "to access the Control Panel"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   1140
         TabIndex        =   8
         Top             =   5700
         Width           =   3195
      End
      Begin VB.Label Label3 
         Alignment       =   2  'Center
         BackColor       =   &H8000000E&
         Caption         =   "to toggle Fullscreen Mode"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   1380
         TabIndex        =   7
         Top             =   4620
         Width           =   2775
      End
      Begin VB.Label Label2 
         Alignment       =   2  'Center
         BackColor       =   &H8000000E&
         Caption         =   "welcome to"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   1440
         TabIndex        =   6
         Top             =   360
         Width           =   2415
      End
      Begin VB.Label Label1 
         Alignment       =   2  'Center
         BackColor       =   &H8000000E&
         Caption         =   "Right Click the Main Screen"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   1260
         TabIndex        =   3
         Top             =   5280
         Width           =   2955
      End
      Begin VB.Label lblCompany 
         Alignment       =   2  'Center
         BackColor       =   &H8000000E&
         Caption         =   "Double Click the Main Screen"
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
         Left            =   1140
         TabIndex        =   1
         Top             =   4260
         Width           =   3135
      End
   End
End
Attribute VB_Name = "frmSplash"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False



Private Sub Command1_Click()

If Check1.Value = vbChecked Then
    showsplash = 0
    Save_defaults
End If

Unload Me


End Sub

Private Sub Timer1_Timer()


Timer1.Enabled = False

Unload Me


End Sub
