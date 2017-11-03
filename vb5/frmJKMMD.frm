VERSION 5.00
Begin VB.Form frmJKMMD 
   Caption         =   "MMD Hardware Setup"
   ClientHeight    =   3315
   ClientLeft      =   120
   ClientTop       =   420
   ClientWidth     =   3765
   LinkTopic       =   "Form19"
   ScaleHeight     =   3315
   ScaleWidth      =   3765
   StartUpPosition =   3  'Windows Default
   Begin VB.CheckBox Check6 
      Caption         =   "LEDs"
      Height          =   255
      Left            =   360
      TabIndex        =   5
      Top             =   2760
      Width           =   2295
   End
   Begin VB.CheckBox Check5 
      Caption         =   "Random Coloured Columns"
      Height          =   255
      Left            =   1320
      TabIndex        =   4
      Top             =   3600
      Visible         =   0   'False
      Width           =   2295
   End
   Begin VB.CheckBox Check4 
      Caption         =   "Shaded Background"
      Height          =   255
      Left            =   360
      TabIndex        =   3
      Top             =   2160
      Width           =   2295
   End
   Begin VB.CheckBox Check3 
      Caption         =   "Invert"
      Height          =   255
      Left            =   360
      TabIndex        =   2
      Top             =   1560
      Width           =   2295
   End
   Begin VB.CheckBox Check2 
      Caption         =   "Fade Effect"
      Height          =   255
      Left            =   360
      TabIndex        =   1
      Top             =   960
      Width           =   2295
   End
   Begin VB.CheckBox Check1 
      Caption         =   "Random Colours"
      Height          =   255
      Left            =   360
      TabIndex        =   0
      Top             =   360
      Width           =   2295
   End
End
Attribute VB_Name = "frmJKMMD"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Check6_Click()

Form18.Picture1.Cls


End Sub
