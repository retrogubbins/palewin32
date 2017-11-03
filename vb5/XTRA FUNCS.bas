Attribute VB_Name = "Module2"
Public Declare Function timeGetTime Lib "winmm.dll" () As Long
Public Declare Function timeBeginPeriod Lib "winmm.dll" (ByVal uPeriod As Long) As Long
Public Declare Function timeEndPeriod Lib "winmm.dll" (ByVal uPeriod As Long) As Long
Public Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)

' // If built with the USE_WINAPI compiler directive defined, vbSpec uses Windows API
' // functions to paint the display. This is faster than raw VB code, and provides the
' // option for selecting scaled display sizes (double and triple size, and so on).
Public Const SRCCOPY = &HCC0020 ' (DWORD) dest = source
Public Declare Function StretchDIBits Lib "gdi32" (ByVal hdc As Long, ByVal X As Long, ByVal y As Long, ByVal dx As Long, ByVal dy As Long, ByVal SrcX As Long, ByVal SrcY As Long, ByVal wSrcWidth As Long, ByVal wSrcHeight As Long, lpBits As Any, lpBitsInfo As BITMAPINFO, ByVal wUsage As Long, ByVal dwRop As Long) As Long
Public Declare Function GetSystemMetrics Lib "user32" (ByVal nIndex As Long) As Long
Public Declare Function StretchDIBitsMono Lib "gdi32" Alias "StretchDIBits" (ByVal hdc As Long, ByVal X As Long, ByVal y As Long, ByVal dx As Long, ByVal dy As Long, ByVal SrcX As Long, ByVal SrcY As Long, ByVal wSrcWidth As Long, ByVal wSrcHeight As Long, lpBits As Any, lpBitsInfo As BITMAPINFOMONO, ByVal wUsage As Long, ByVal dwRop As Long) As Long
Public Const SM_CYCAPTION As Long = 4
Public Const SM_CYMENU As Long = 15
Public Const SM_CXFRAME As Long = 32
Public Const SM_CYFRAME As Long = 33

Public Declare Function BitBlt Lib "gdi32" (ByVal hDestDC As Long, ByVal X As Long, ByVal y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal dwRop As Long) As Long
Public Declare Function SetPixelV Lib "gdi32" (ByVal hdc As Long, ByVal X As Long, ByVal y As Long, ByVal crColor As Long) As Long

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
        bmiColors(16) As RGBQUAD
End Type
Public Type BITMAPINFOMONO
        bmiHeader As BITMAPINFOHEADER
        bmiColors(2) As RGBQUAD
End Type
Public Const BI_RGB = 0&
Public Const DIB_RGB_COLORS = 0 '  color table in RGBs

Public bmiBuffer As BITMAPINFO
Public glBufferBits(24576) As Long

Public glDisplayHeight As Long
Public glDisplayWidth As Long
Public glDisplayVSource As Long ' // Set to glDisplayHeight - 1 to improve display speed
Public glDisplayVSize As Long   ' // Set to -glDisplayHeight to improve display speed
Public glDisplayXMultiplier As Long
Public glDisplayYMultiplier As Long

' // Used by the ZX Printer emulation
Public bmiZXPrinter As BITMAPINFOMONO
Public gcZXPrinterBits() As Byte ' // 32 cols * 1152 rows
Public glZXPrinterBMPHeight As Long

Public glBeeperVal As Long

' // ShellExecute is used for the clickable web URL in the "About..." dialog, not
' //the actual emulator itself
Public Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" (ByVal hWnd As Long, ByVal lpOperation As String, ByVal lpFile As String, ByVal lpParameters As String, ByVal lpDirectory As String, ByVal nShowCmd As Long) As Long

' // MouseCapture functions required for emulating the Kempston Mouse Interface
Public Type POINTAPI
        X As Long
        y As Long
End Type
Public Declare Function GetCursorPos Lib "user32" (lpPoint As POINTAPI) As Long
Public Declare Function GetKeyState Lib "user32" (ByVal nVirtKey As Long) As Integer
Public Const VK_LBUTTON = &H1
Public Const VK_RBUTTON = &H2
Public Const VK_MBUTTON = &H4

Public glMouseType As Long
Public Const MOUSE_NONE = 0&
Public Const MOUSE_KEMPSTON = 1&
Public Const MOUSE_AMIGA = 2&
Public gbMouseGlobal As Long
Public glMouseBtn As Long

' // Most Recently Used (MRU) file class
Public gMRU As MRUList

' // Flag whether SE BASIC ROM is to be used or not
Public gbSEBasicROM As Long

'MM 16.04.2003
Public Type RECT
    iLeft As Integer
    iTop As Integer
    iRight As Integer
    iBottom As Integer
End Type
Public Type POINT
    lX As Long
    lY As Long
End Type
Public Declare Sub GetClientRect Lib "user32" (ByVal hWnd As Long, lpRect As RECT)
Public Declare Sub ClientToScreen Lib "user32" (ByVal hWnd As Long, lpPoint As POINT)
Public Declare Function SetForegroundWindow Lib "user32" (ByVal hWnd As Long) As Long
