VERSION 5.00
Begin VB.Form Form6 
   Caption         =   "Trap List"
   ClientHeight    =   6825
   ClientLeft      =   45
   ClientTop       =   345
   ClientWidth     =   5760
   LinkTopic       =   "Form6"
   ScaleHeight     =   6825
   ScaleWidth      =   5760
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command2 
      Caption         =   "byeee"
      Height          =   1815
      Left            =   5100
      TabIndex        =   2
      Top             =   4680
      Width           =   495
   End
   Begin VB.CommandButton Command1 
      Caption         =   "X"
      Height          =   3492
      Left            =   5040
      TabIndex        =   1
      Top             =   600
      Width           =   612
   End
   Begin VB.TextBox txtTraplist 
      Height          =   5892
      Left            =   240
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   0
      Top             =   240
      Width           =   4692
   End
End
Attribute VB_Name = "Form6"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Command1_Click()

txtTraplist.Text = ""


End Sub

Private Sub Command2_Click()
Unload Me

End Sub

