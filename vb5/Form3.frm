VERSION 5.00
Begin VB.Form Form3 
   BackColor       =   &H8000000E&
   BorderStyle     =   4  'Fixed ToolWindow
   ClientHeight    =   7785
   ClientLeft      =   30
   ClientTop       =   330
   ClientWidth     =   2700
   LinkTopic       =   "Form3"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   7785
   ScaleWidth      =   2700
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton Command3 
      Caption         =   "Lynx Commands"
      Default         =   -1  'True
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   372
      Left            =   240
      TabIndex        =   14
      Top             =   6840
      Width           =   2172
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Help"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   372
      Left            =   240
      TabIndex        =   11
      Top             =   6360
      Width           =   2172
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Ok"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   372
      Left            =   240
      TabIndex        =   9
      Top             =   7320
      Width           =   2172
   End
   Begin VB.PictureBox Picture2 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   855
      Left            =   240
      Picture         =   "Form3.frx":0000
      ScaleHeight     =   855
      ScaleWidth      =   2175
      TabIndex        =   4
      Top             =   120
      Width           =   2175
   End
   Begin VB.PictureBox Picture1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   1035
      Left            =   0
      Picture         =   "Form3.frx":5F9C
      ScaleHeight     =   1035
      ScaleWidth      =   2700
      TabIndex        =   3
      Top             =   960
      Width           =   2700
   End
   Begin VB.Label Label12 
      Alignment       =   2  'Center
      BackColor       =   &H8000000E&
      Caption         =   "John Elliot"
      Height          =   255
      Left            =   120
      TabIndex        =   16
      Top             =   3840
      Width           =   2415
   End
   Begin VB.Label Label9 
      Alignment       =   2  'Center
      BackColor       =   &H8000000E&
      Caption         =   "LIBDSK Disk Library"
      Height          =   255
      Left            =   120
      TabIndex        =   15
      Top             =   3600
      Width           =   2415
   End
   Begin VB.Label Label11 
      Alignment       =   2  'Center
      BackColor       =   &H8000000E&
      Caption         =   "for such a great micro..."
      Height          =   255
      Left            =   120
      TabIndex        =   13
      Top             =   6000
      Width           =   2415
   End
   Begin VB.Label Label10 
      Alignment       =   2  'Center
      BackColor       =   &H8000000E&
      Caption         =   "Special respect to Camputers"
      Height          =   255
      Left            =   120
      TabIndex        =   12
      Top             =   5760
      Width           =   2415
   End
   Begin VB.Label Label8 
      Alignment       =   2  'Center
      BackColor       =   &H8000000E&
      Caption         =   "Contributions from Russell Davis, Adrian, Paul, Harald & special thanks to Martyn Smith for the excellent 128 information"
      Height          =   855
      Left            =   120
      TabIndex        =   10
      Top             =   4200
      Width           =   2415
   End
   Begin VB.Label Label7 
      Alignment       =   2  'Center
      BackColor       =   &H8000000E&
      Caption         =   "Big Thanks for information from"
      Height          =   255
      Left            =   120
      TabIndex        =   8
      Top             =   5220
      Width           =   2415
   End
   Begin VB.Label Label6 
      Alignment       =   2  'Center
      BackColor       =   &H8000000E&
      Caption         =   "Z80 Core Engine"
      Height          =   255
      Left            =   120
      TabIndex        =   7
      Top             =   3000
      Width           =   2415
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      BackColor       =   &H8000000E&
      Caption         =   "Pete Todd"
      Height          =   255
      Left            =   120
      TabIndex        =   6
      Top             =   2640
      Width           =   2415
   End
   Begin VB.Label Label5 
      Alignment       =   2  'Center
      BackColor       =   &H8000000E&
      Caption         =   "www.binarydinosaurs.co.uk "
      Height          =   255
      Left            =   120
      TabIndex        =   5
      Top             =   5460
      Width           =   2415
   End
   Begin VB.Label Label4 
      Alignment       =   2  'Center
      BackColor       =   &H8000000E&
      Caption         =   "Marcel de Kogel"
      Height          =   255
      Left            =   120
      TabIndex        =   2
      Top             =   3240
      Width           =   2415
   End
   Begin VB.Label Label3 
      Alignment       =   2  'Center
      BackColor       =   &H8000000E&
      Caption         =   "Emulator Programming"
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Top             =   2400
      Width           =   2415
   End
   Begin VB.Label Label2 
      BackColor       =   &H8000000E&
      Caption         =   "P e t e ' s   L y n x   E m u l a t o r  "
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   2040
      Width           =   2415
   End
End
Attribute VB_Name = "Form3"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Command1_Click()


Unload Me


End Sub

Private Sub Command2_Click()

Form4.Show vbModal


End Sub

Private Sub Command3_Click()

Form10.Show vbModal


End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)

'If KeyAscii = Asc("p") Then Form2.BorderStyle = 2


End Sub


