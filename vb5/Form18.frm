VERSION 5.00
Begin VB.Form Form18 
   Caption         =   "J Koushappas MMD Display"
   ClientHeight    =   5985
   ClientLeft      =   120
   ClientTop       =   420
   ClientWidth     =   6705
   LinkTopic       =   "Form18"
   ScaleHeight     =   5985
   ScaleWidth      =   6705
   StartUpPosition =   3  'Windows Default
   Begin VB.PictureBox Picture1 
      BackColor       =   &H80000008&
      FillColor       =   &H00FFFFFF&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      FontTransparent =   0   'False
      ForeColor       =   &H00FFFFFF&
      Height          =   5655
      Left            =   0
      ScaleHeight     =   5595
      ScaleWidth      =   6075
      TabIndex        =   0
      Top             =   0
      Width           =   6135
   End
End
Attribute VB_Name = "Form18"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Function ExamineBit(ByVal Byte1 As Byte, ByVal Bit As Byte)
' doesnt seem to work
 ' Create a bitmask with the 2 to the nth power bit set:
      Mask = 2 ^ Bit
      ' Return the truth state of the 2 to the nth power bit:
      ExamineBit = ((Byte1 And Mask) > 0)
End Function
   
   
   
Private Sub Form_Paint()
Dim ret, xx, yy, f, noof_leg
Dim dispwidth, dispheight
Dim xzom, yzom As Variant
Dim noof_x_leds
Dim thecolour As Byte
Dim cr, cg, cb As Integer



noof_x_leds = 32

dispheight = 8
dispwidth = noof_x_leds

ret = get_jk(jkmap(0))

'Now draw the map onto the piccy
xx = 0
yy = 0

xzom = Picture1.Width / dispwidth
yzom = Picture1.Height / dispheight
'yzom = 1

'Picture1.Cls


For f = 0 To noof_x_leds
 '   If xx = 0 Then Picture1.PSet (xx * xzom, yy * yzom)
'    Picture1.PSet (xx * xzom, yy * yzom), RGB(memmap(f), memmap(f), memmap(f))
'    Picture1.ForeColor = RGB(memmap(f), memmap(f), memmap(f))
    If frmJKMMD.Check5.Value = vbChecked Then
        colcolour = Rnd * 255
    End If
    
    For g = 0 To 7
    
'        Picture1.Line (xx * xzom, yy * yzom)-((xx + 1) * xzom, (yy + 1) * yzom), RGB(255 - jkmap(f), 255 - jkmap(f), jkmap(f)), B

        thecolour = jkmap(f + g * noof_x_leds)
        
        If frmJKMMD.Check3.Value = vbChecked Then
           thecolour = 1 - thecolour
        End If
        
        cr = thecolour * 255
        cg = thecolour * 255
        cb = thecolour * 255
        
        'thecolour = ExamineBit(thecolour, g)
 '       If thecolour And (2 ^ g) > 0 Then
  '          thecolour = 0
       ' Else
         '   thecolour = 255
       ' End If
        If frmJKMMD.Check5.Value = vbChecked Then
            cr = colcolour * thecolour
            cg = colcolour * thecolour
            cb = colcolour * thecolour
        End If
          If frmJKMMD.Check1.Value = vbChecked Then
            cr = cr * Rnd
            cg = cg * Rnd
            cb = cb * Rnd
        End If
        If frmJKMMD.Check2.Value = vbChecked Then
            cr = cr * (((7 - g) + 1) / 8)
            cg = cg * (((7 - g) + 1) / 8)
            cb = cb * (((7 - g) + 1) / 8)
        End If
        If frmJKMMD.Check4.Value = vbChecked And thecolour = 0 Then
            cr = Rnd * 255
            cg = Rnd * 255
            cb = Rnd * 255
        End If
        
       
     '   Picture1.Line (xx * xzom, yy * yzom)-((xx + 1) * xzom, (yy + 1) * yzom), RGB(thecolour, thecolour, thecolour), BF
 '       Picture1.Line (xx * xzom, yy * yzom)-((xx + 1) * xzom, (yy + 1) * yzom), RGB(cr, cg, cb), BF
        
        If frmJKMMD.Check6.Value = vbChecked Then
            If thecolour = 0 Then
             Picture1.FillColor = vbBlack
            Picture1.FillStyle = 0  'solid
                Picture1.Circle (xx * xzom, yy * yzom + (Picture1.Height / 20)), yzom / 7, vbBlack
            Else
             Picture1.FillColor = vbRed
            Picture1.FillStyle = 0  'solid
                Picture1.Circle (xx * xzom, yy * yzom + (Picture1.Height / 20)), yzom / 7, vbRed
            End If
        Else
           Picture1.Line (xx * xzom, yy * yzom)-((xx + 1) * xzom, (yy + 1) * yzom), RGB(cr, cg, cb), BF
        End If
        
        yy = yy + 1
    Next g
    xx = xx + 1
    yy = 0
   
    Next f





End Sub

Private Sub Form_Resize()

Picture1.Cls

Picture1.Width = ScaleWidth
Picture1.Height = ScaleHeight

End Sub

