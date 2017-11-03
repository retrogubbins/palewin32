Attribute VB_Name = "VidModule"

Option Explicit

' // Global picDisplay variable to speed things up
'Public gpicDisplay As PictureBox

' // WINAPI stuff for fast screen updates
Public Const SRCCOPY = &HCC0020 ' (DWORD) dest = source
Public Const BI_RGB = 0&
Public Const DIB_RGB_COLORS = 0 '  color table in RGBs
Public Const DIB_PAL_COLORS = 1

Public Const MM_TWIPS = 6
Public Const MM_ISOTROPIC = 7
Public Const MM_ANISOTROPIC = 8

Public tog As Boolean
Public curr_line As Integer

Public crtc_regs(18) As Byte

Public bmih, bmiw As Integer


'Public X As Integer


Public Declare Function StretchDIBits Lib "gdi32" (ByVal hdc As Long, ByVal X As Long, ByVal Y As Long, ByVal dx As Long, ByVal dy As Long, ByVal SrcX As Long, ByVal SrcY As Long, ByVal wSrcWidth As Long, ByVal wSrcHeight As Long, lpBits As Any, lpBitsInfo As BITMAPINFO, ByVal wUsage As Long, ByVal dwRop As Long) As Long
'Public Declare Function StretchDIBits Lib "gdi32" (ByVal hdc As Long, ByVal x As Long, ByVal y As Long, ByVal dx As Long, ByVal dy As Long, ByVal SrcX As Long, ByVal SrcY As Long, ByVal wSrcWidth As Long, ByVal wSrcHeight As Long, ByRef lpBits As Any, lpBitsInfo As BITMAPINFO, ByVal wUsage As Long, ByVal dwRop As Long) As Long
'Public Declare Function SetMapMode Lib "gdi32" (ByVal hdc As Long, ByVal x As Long) As Long
   
'Public Declare Function SetStretchBltMode Lib "gdi32" (ByVal hdc As Long, ByVal x As Long) As Long

   
' // Display colors
Public colors(8) As Long
'Public bDisplayShown As Long


Public Type BITMAPINFOHEADER '40 bytes
        biSize As Long
        biWidth As Long
        biHeight As Long
        biPlanes As Integer
        biBitCount As Integer
        biCompression As Long
        biSizeImage As Long
        biXPelsPerMeter As Long
        biYPelsPerMeter As Long
        biClrUsed As Long
        biClrImportant As Long
End Type
Public Type RGBQUAD
        rgbBlue As Byte
        rgbGreen As Byte
        rgbRed As Byte
        rgbReserved As Byte
End Type
Public Type BITMAPINFO
        bmiHeader As BITMAPINFOHEADER
        bmiColors(8) As RGBQUAD
End Type


Public glDisplayXMultiplier As Long
Public glDisplayYMultiplier As Long

Public bmiBuffer As BITMAPINFO
Public gcBufferBits(131072) As Byte
Public gcScanline(512) As Byte

'Public gcBufferBits(65536) As Byte

Public Sub CreateScreenBuffer()

    bmiBuffer.bmiHeader.biSize = Len(bmiBuffer.bmiHeader)
    
    'start off emulating a 128 screen, when the 6845 regs get adjusted
    'this will be set according to the screen mode
    bmiBuffer.bmiHeader.biWidth = crtc_regs(1) * 8 '32x8=256 or 64x8=512
    
    bmiBuffer.bmiHeader.biHeight = crtc_regs(6) * (crtc_regs(9) + 1) '62x4=248
 
    bmiw = bmiBuffer.bmiHeader.biWidth
    bmih = bmiBuffer.bmiHeader.biHeight
    'For single raster line
'    If vidmode = 1 Then bmiBuffer.bmiHeader.biHeight = 1
   
   
    bmiBuffer.bmiHeader.biPlanes = 1
    bmiBuffer.bmiHeader.biBitCount = 8
    bmiBuffer.bmiHeader.biCompression = BI_RGB
    bmiBuffer.bmiHeader.biSizeImage = 0
    bmiBuffer.bmiHeader.biXPelsPerMeter = 4000
    bmiBuffer.bmiHeader.biYPelsPerMeter = 4000
    bmiBuffer.bmiHeader.biClrUsed = 8
    bmiBuffer.bmiHeader.biClrImportant = 0
    InitBitmapColors
End Sub
Public Sub SetBitmapColor(lIndex As Long, lColor As Long)
    bmiBuffer.bmiColors(lIndex).rgbRed = (lColor And &HFF&)
    bmiBuffer.bmiColors(lIndex).rgbGreen = (lColor And &HFF00&) \ 256
    bmiBuffer.bmiColors(lIndex).rgbBlue = (lColor And &HFF0000) \ 65536
End Sub

Public Sub InitBitmapColors()
Dim f As Long
For f = 0 To 7
    SetBitmapColor f, colors(f)
Next f

End Sub

Public Sub Init_Vid()

 ' // Get colors and initialize display
 '   colors(0) = &HC0C0C0
 '   colors(0) = &H80000013
    colors(0) = &H0&      'black
    colors(1) = &HFF0000     'blue
    colors(2) = &HFF&   'red
    colors(3) = &HFF00FF 'magenta FF00FF
    colors(4) = &HFF00&   'green
    colors(5) = &HFFFF00   'cyan
    colors(6) = &HFFFF&   'yellow
    colors(7) = &HFFFFFF 'white
    
    'Defaults (for initial creat screenbuff) from lynx 128
    crtc_regs(0) = &H5F&
    crtc_regs(1) = &H40&
    crtc_regs(2) = &H4C&
    crtc_regs(3) = &H37&
    crtc_regs(4) = &H46&
    crtc_regs(5) = &H1C&
    crtc_regs(6) = &H3F&
    crtc_regs(7) = &H44&
    crtc_regs(8) = &H0&
    crtc_regs(9) = &H3&
    crtc_regs(10) = &H3&
    crtc_regs(11) = &H3&
    crtc_regs(12) = &H0&
    crtc_regs(13) = &H40&
    crtc_regs(14) = &HF&
    crtc_regs(15) = &HFF&
    crtc_regs(16) = &H0&
    crtc_regs(17) = &H0&
        
    
    ' // Set up the screen bitmap in memory
    CreateScreenBuffer

    'SetStretchBltMode Form1.Picture1.hdc, BLACKONWHITE
    tog = True
    curr_line = 0


End Sub




