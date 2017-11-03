Attribute VB_Name = "Module1"
Option Explicit


Global Const PALE_VERSION = 8.9


Const ThisApp = "PALEEmulator"               'dont change this as it upsets registry entries
Const ThisKey = "PETES AMAZING LYNX EMU"

'A copy of the one in Form5
Const form5dev_height As Integer = 9900

Const SEND_LYNX_VIDMODE_0 = 5
Const SEND_LYNX_VIDMODE_1 = 800


Global Const LYNX_HARDWARE_48 = 0
Global Const LYNX_HARDWARE_96 = 1
Global Const LYNX_HARDWARE_128 = 2
Global Const LYNX_HARDWARE_192 = 3
Global Const LYNX_HARDWARE_256 = 4
Global Const LYNX_HARDWARE_SPECCY = 5
Global Const LYNX_HARDWARE_MTX = 6
Global Const LYNX_HARDWARE_JASPER = 7

Global Const TAP_TAPES = 0
Global Const RAW_TAPES = 1

'NOTE The order of these declares is unimportant here
' but in the VC DLL the order must match that held in the .def
'mapping file - NO
Declare Function GetAsyncKeyState Lib "user32" _
        (ByVal vKey As Long) As Integer
Declare Function GetKeyboardState Lib "user32" _
    (ByRef lpKeyState As Byte) As Boolean
Declare Function emu_checktim Lib "paledll.dll" (ByVal checktim_interval As Long) As Long
Declare Function init_emulator Lib "paledll.dll" (ByVal mctype As Long, ByVal hwtype As Long) As Long
Declare Function run_emulator Lib "paledll.dll" () As Long
Declare Function reset_emulator Lib "paledll.dll" () As Long
Declare Function kill_emulator Lib "paledll.dll" () As Long
Declare Function query_emulator Lib "paledll.dll" (ByRef emu_query As Byte, ByRef emu_query2 As Byte, ByRef emu_query3 As Byte, ByRef emu_query4 As Byte) As Long
Declare Function query_6845 Lib "paledll.dll" (ByRef emu_query As Byte, ByRef emu_query2 As Byte, ByRef emu_query3 As Byte, ByRef emu_query4 As Byte) As Long
Declare Function query_sound Lib "paledll.dll" (ByRef emu_query As Byte, ByRef emu_query2 As Byte, ByRef emu_query3 As Byte, ByRef emu_query4 As Byte) As Long
Declare Function flush_sound Lib "paledll.dll" () As Long
Declare Function get_video Lib "paledll.dll" (ByRef video As Byte, ByVal shwagbank As Byte, ByVal fix6845 As Byte, ByVal line_req As Byte, ByRef crtc_regs As Byte) As Long
Declare Function send_key Lib "paledll.dll" (ByVal va As Byte, ByVal shft As Byte) As Long
Declare Function load_lynx_tap Lib "paledll.dll" (ByRef va As Byte, ByRef va2 As Byte, ByVal ttype As Byte) As Long


Declare Function tap2wav Lib "paledll.dll" (ByRef r0 As Byte, ByRef r1 As Byte) As Long


Declare Function load_lev9_tap Lib "paledll.dll" (ByRef va As Byte, ByRef va2 As Byte) As Long
Declare Function set_soundstream Lib "paledll.dll" (ByVal va As Byte) As Long
Declare Function set_hum Lib "paledll.dll" (ByVal va As Byte) As Long
Declare Function set_autospeed Lib "paledll.dll" (ByVal va As Byte) As Long
Declare Function set_c_mode Lib "paledll.dll" (ByVal va As Byte) As Long

Declare Function poke_mem Lib "paledll.dll" (ByVal lo As Long, ByVal va As Long, ByVal bn As Long) As Long
Declare Function peek_mem Lib "paledll.dll" (ByVal lo As Long) As Long
Declare Function set_inp Lib "paledll.dll" (ByVal lo As Long, ByVal va As Long) As Long
Declare Function set_pc Lib "paledll.dll" (ByVal vrt As Long) As Long
Declare Function set_speed Lib "paledll.dll" (ByVal lo As Long) As Long
Declare Function set_trapthis Lib "paledll.dll" (ByVal lo As Long) As Long
Declare Function set_breakin Lib "paledll.dll" (ByVal lo As Long) As Long


Declare Function set_donmi Lib "paledll.dll" (ByVal lo As Long) As Long
Declare Function set_trapaddr Lib "paledll.dll" (ByVal lo As Long) As Long
Declare Function set_P80bit Lib "paledll.dll" (ByVal lo As Long) As Long
Declare Function set_doP80 Lib "paledll.dll" (ByVal lo As Long) As Long

Declare Function s_step Lib "paledll.dll" (ByVal lo As Long) As Long

Declare Function set_iper Lib "paledll.dll" (ByVal lo As Long) As Long
Declare Function set_kbdtype Lib "paledll.dll" (ByVal lo As Long) As Long

Declare Function start_trace Lib "paledll.dll" () As Long
Declare Function stop_trace Lib "paledll.dll" () As Long
Declare Function start_disk_trace Lib "paledll.dll" () As Long
Declare Function stop_disk_trace Lib "paledll.dll" () As Long
Declare Function load_disk_dev Lib "paledll.dll" () As Long

Declare Function z80_to_tap Lib "paledll.dll" (ByRef inva As Byte, ByRef outva2 As Byte, ByVal tlen As Long, ByVal tst As Long, ByVal tend As Long, ByVal texec As Long) As Long

Declare Function screen_mode Lib "paledll.dll" (ByVal tst As Long) As Long
Declare Function set_vidmode Lib "paledll.dll" (ByVal tst As Long) As Long
Declare Function set_sound_div_in Lib "paledll.dll" (ByVal tst As Long) As Long

Declare Function crtc_change Lib "paledll.dll" () As Long

Declare Function send_keymap Lib "paledll.dll" (ByRef keymap As Byte) As Long
Declare Function save_mem_dump Lib "paledll.dll" () As Long
Declare Function save_disk_dump Lib "paledll.dll" () As Long
Declare Function get_memmap Lib "paledll.dll" (ByRef memmap As Byte, ByVal bankno As Byte) As Long
Declare Function get_version Lib "paledll.dll" (ByRef emu_query As Byte) As Long
Declare Function get_sysvar Lib "paledll.dll" (ByRef emu_query As Byte, ByRef emu_query2 As Byte) As Long
'extern  int _stdcall paletape(unsigned char ifil[],unsigned char ofil[],unsigned char verb ,unsigned char t_thresh,unsigned char  tape_speed,unsigned char  raw_tape)
Declare Function paletape Lib "paledll.dll" (ByRef ifi As Byte, ByRef ofi As Byte, ByVal ftft As Byte, ByVal verb As Byte, ByVal nowrites As Byte, ByVal onlylengmatch As Byte, ByVal thrh As Byte, ByVal sped As Byte, ByVal forma As Byte, ByRef otext As Byte, ByRef vtext As Byte, ByRef readinn As Long, ByRef readreqq As Long) As Long
Declare Function build_rom Lib "paledll.dll" (ByRef r0 As Byte, ByRef r1 As Byte, ByRef r2 As Byte, ByRef r3 As Byte, ByRef r4 As Byte, ByRef r5 As Byte, ByRef r6 As Byte, ByRef r7 As Byte, ByRef rompath As Byte) As Long

'Declare Function Z80_Dasm Lib "paledll.dll" (ByRef ifil As Byte, ByRef ofil As Byte, ByVal peecee As Long) As Long
Declare Function disassemble Lib "paledll.dll" (ByRef ofil As Byte, ByVal peecee As Long, ByVal bankno As Long) As Long
Declare Function disassemble_file Lib "paledll.dll" (ByRef ifil As Byte, ByRef ofil As Byte, ByVal offset As Long) As Long


Declare Function get_video_scanvers Lib "paledll.dll" (ByVal devHDC As Long, ByVal w As Long, ByVal h As Long, ByRef bmim As BITMAPINFO, ByVal Fix_6845 As Byte, ByRef crtcreg As Byte) As Long
Declare Function get_printer_data Lib "paledll.dll" (ByRef pbuf As Byte) As Long
Declare Function get_sysclock Lib "paledll.dll" () As Long
Declare Function get_clock_time_diff Lib "paledll.dll" () As Long

Declare Function set_b3_video Lib "paledll.dll" (ByVal tst As Long) As Long
Declare Function set_printer_type Lib "paledll.dll" (ByVal tst As Long) As Long
Declare Function init_printer Lib "paledll.dll" () As Long

Declare Function load_disk Lib "paledll.dll" (ByVal dno As Long, ByRef r0 As Byte) As Long
Declare Function save_disk Lib "paledll.dll" (ByVal dno As Long, ByRef r0 As Byte) As Long
Declare Function set_drive_type Lib "paledll.dll" (ByVal tst As Long, ByVal tst1 As Long, ByVal tst2 As Long) As Long
    
    
'Declare Function get_diskstat1 Lib "paledll.dll" (ByRef command As Byte, ByRef data As Byte, ByRef epenable As Byte, ByRef motor As Byte, ByRef precomp As Byte, ByRef steprate As Byte)
'Declare Function get_diskstat2 Lib "paledll.dll" (ByRef drive As Byte, ByRef head As Byte, ByRef track As Byte, ByRef sector As Byte)
Declare Function get_diskstat1 Lib "paledll.dll" (ByRef set1 As Byte) As Long
Declare Function get_diskstat2 Lib "paledll.dll" (ByRef set2 As Byte) As Long

Declare Function get_cpmvars Lib "paledll.dll" (ByRef set2 As Byte) As Long


Declare Function load_raw Lib "paledll.dll" (ByRef r0 As Byte) As Long
Declare Function save_raw Lib "paledll.dll" (ByRef r0 As Byte) As Long
Declare Function save_wav Lib "paledll.dll" (ByRef r0 As Byte) As Long

Declare Function get_memscan Lib "paledll.dll" (ByRef m0 As Byte) As Long
Declare Function set_memscan Lib "paledll.dll" (ByVal start As Long, ByVal bank As Long) As Long

Declare Function force_raw_play Lib "paledll.dll" () As Long
Declare Function force_raw_stop Lib "paledll.dll" () As Long
Declare Function force_raw_auto Lib "paledll.dll" () As Long


Declare Function rewind_raw Lib "paledll.dll" () As Long
Declare Function force_raw_rec Lib "paledll.dll" () As Long
Declare Function tape_clear Lib "paledll.dll" () As Long

Declare Function get_raw_position Lib "paledll.dll" () As Long
Declare Function get_raw_samples Lib "paledll.dll" () As Long
Declare Function get_raw_motor Lib "paledll.dll" () As Long
Declare Function get_tape_level Lib "paledll.dll" () As Long
Declare Function get_tape_icount Lib "paledll.dll" () As Long
Declare Function set_tape_spd Lib "paledll.dll" (ByVal lo As Long) As Long
Declare Function set_tape_spd_adjust Lib "paledll.dll" (ByVal lo As Long) As Long

Declare Function set_tape_mode Lib "paledll.dll" (ByVal fr As Long) As Long
Declare Function set_tape_inverted Lib "paledll.dll" (ByVal fr As Long) As Long
Declare Function set_raw_threshold Lib "paledll.dll" (ByVal fr As Long) As Long
Declare Function get_raw_threshold Lib "paledll.dll" () As Long
Declare Function set_raw_samprate Lib "paledll.dll" (ByVal fr As Long) As Long
Declare Function get_raw_samprate_index Lib "paledll.dll" () As Long
Declare Function set_raw_position Lib "paledll.dll" (ByVal fr As Long) As Long

Declare Function get_tape_monitor Lib "paledll.dll" (ByRef tapemon As Byte, ByVal tapsamp As Long) As Long
Declare Function load_wav Lib "paledll.dll" (ByRef r0 As Byte) As Long
'Declare Function set_raw_buflen Lib "paledll.dll" (ByVal fr As Long) As Long

Declare Function load_tpa Lib "paledll.dll" (ByRef r0 As Byte) As Long
Declare Function run_tpa Lib "paledll.dll" () As Long
Declare Function set_cpmfix Lib "paledll.dll" (ByVal fr As Long) As Long


Declare Function get_diskscan Lib "paledll.dll" (ByRef m0 As Byte) As Long
Declare Function set_diskscan Lib "paledll.dll" (ByVal start As Long, ByVal drive As Long) As Long
Declare Function load_speccy Lib "paledll.dll" (ByRef r0 As Byte) As Long

Declare Function load_lsf Lib "paledll.dll" (ByRef r0 As Byte) As Long
Declare Function save_lsf Lib "paledll.dll" (ByRef r0 As Byte) As Long

Declare Function start_peripherals Lib "paledll.dll" () As Long
Declare Function get_jk Lib "paledll.dll" (ByRef jkmap As Byte) As Long

Declare Function disaster Lib "paledll.dll" (ByRef fn As Byte, ByVal convert96 As Long, ByVal convert128 As Long, _
 ByVal list_symbols As Long, ByVal number_lines As Long, ByVal decorate_rom_areas As Long, _
 ByVal decorate_subroutines As Long, ByVal decorate_jumps As Long, ByVal PrintHex As Long, _
 ByVal counter As Long, ByVal start As Long, ByVal Maxlines As Long, ByVal verbose As Long, _
 ByRef outdisas As Byte) As Long
Declare Function mem_set_bit Lib "paledll.dll" (ByVal loc As Long, ByVal bitno As Long, ByVal valu As Long, ByVal bankno As Long) As Long

Declare Function tap_to_rom Lib "paledll.dll" (ByRef inva As Byte, ByRef outva2 As Byte) As Long

Declare Function load_yazedisk Lib "paledll.dll" (ByVal dno As Long, ByRef r0 As Byte) As Long
Declare Function save_yazedisk Lib "paledll.dll" (ByVal dno As Long, ByRef r0 As Byte) As Long


'Declare Function serial_input Lib "paledll.dll" (ByVal fr As Long) As Long
'Declare Function serial_output Lib "paledll.dll" (ByVal fr As Long) As Long

'Declare Function get_diskstat Lib "paledll.dll" (ByRef command As Long,
'                        ByRef data As Long,
'                        ByRef epenable As Long,
'                        ByRef motor As Long,
'                        ByRef precomp As Long,
'                        ByRef steprate As Long,
'                        ByRef drive As Long,
'                        ByRef head As Long,
'                        ByRef track As Long,
 '                       ByRef sector As Long)

'Declare Function get_video_scanvers Lib "paledll.dll" (ByRef viddata As Byte,
 '                                                       Byval devHDC As Long,
 '                                                       ByVal w As Long,
 '                                                       ByVal h As Long,
 '                                                       ByRef bmim As BITMAPINFO,
 '                                                       ByVal Fix_6845 As long,
 '                                                       ByRef crtcreg As Byte)


'BITMAPINFO
  Global console_transfer As Boolean

Global rompath(300) As Byte
Global kstring As String
Global pok As Integer
Global query(100000) As Byte
Global query2(100000) As Byte
Global query3(100000) As Byte
Global query4(100000) As Byte

Global xc(65536) As Byte
Global vmem(65536) As String
Global printer_inbuf(2048) As Byte
Global printer_inbuflen As Integer


Global memmap(65536) As Byte
Global display_size As Integer

Global Fix_6845 As Byte
Global get_agg_banks As Byte
Global dump_status As Byte
Global dump_diskstat As Byte
Global dump_cpmvars As Byte

Global dump_sysvar As Byte
Global dump_6845 As Byte
Global dump_memmap As Byte
Global membank As Byte
Global memresol As Byte
Global dump_disas As Byte
Global vidmode As Integer
Global first_run As Integer
Global curfpsdiv As Integer
Global cursecdiv As Integer
Global dis_bank As Integer
Global memscan_bank As Integer

Global show_fps As Integer
Global jogval As Integer
Global enable_altgreen As Boolean
Global showlock As Boolean
Global sizewin As Boolean
Global showsplash As Integer

Global fullscreen As Integer
Global machine_sound As Integer
Global machine_hum As Integer

Global jkmap(256) As Byte    '   8 * 32  4 columns

'0 to x , a machine type is basically a romset
Global machine_type As Integer
'0 = 48 1=96 2=128 3=192 4=256 5=speccyhack 6=jasper
Global hw_type As Integer

Global machine_speed As Integer

Global tsec As Byte    ' rolling timer counter used for delays
Global kbd2(500) As Byte
Global kbd_old(500) As Byte
Global perc_speed As Integer
Global load_type As Byte
Global romrev As Integer
Global current_set As Integer
Global first_time As Integer

Global speed_chang As Integer
Global standard_disp_update As Integer
Global kbd(500) As Byte
Global Language As String
Global s2l_count As Integer
Global inst As String

Global fnam1(400) As Byte
Global fnam2(400) As Byte
Global out_t(500000) As Byte
Global out_v(500000) As Byte
Global verb As Integer
Global t_thresh As Integer
Global tape_speed As Integer
Global raw_tape As Integer
Global last_horiz_disp As Byte

Global sound_div_in As Byte
Global only_lengmatch As Integer
Global readin As Long
Global readreq As Long
Global tape_source_type As Integer


Global Const DISPLAY_SIZE_CUSTOM As Integer = 0

Public Function GetEXEPath() As String
     If Right$(App.Path, 1) = "\" Then
          GetEXEPath$ = App.Path
     Else
          GetEXEPath$ = App.Path & "\"
     End If
End Function



Public Sub buildrom()

Dim fnam0(200) As Byte
Dim fnam1(200) As Byte
Dim fnam2(200) As Byte
Dim fnam3(200) As Byte
Dim fnam4(200) As Byte
Dim fnam5(200) As Byte
Dim fnam6(200) As Byte
Dim fnam7(200) As Byte

Dim f, g, ret As Integer
Dim s As String
Dim s2 As Variant

'MsgBox "VB BUILD ROM"
    'Get Hardware Type
    '1=128 hardware
    '2=hacked for speccy version ??
    s = "SET" + str(machine_type) + "HWTYPE"
    hw_type = GetS(s)
    
'Form2.Label30 = "Machine " + str(machine_type) + " HW type read was " + str(hw_type)

    
    s = "SET" + str(machine_type) + "ROM" + str(0)
    s2 = GetS(s)
    For f = 1 To Len(s2)
        fnam0(f - 1) = Asc(Mid$(s2, f, 1))
    Next f
    fnam0(f) = 0
    
    s = "SET" + str(machine_type) + "ROM" + str(1)
    s2 = GetS(s)
    For f = 1 To Len(s2)
        fnam1(f - 1) = Asc(Mid$(s2, f, 1))
    Next f
    fnam1(f) = 0
    
    s = "SET" + str(machine_type) + "ROM" + str(2)
    s2 = GetS(s)
    For f = 1 To Len(s2)
        fnam2(f - 1) = Asc(Mid$(s2, f, 1))
    Next f
    fnam2(f) = 0
    
    s = "SET" + str(machine_type) + "ROM" + str(3)
    s2 = GetS(s)
    For f = 1 To Len(s2)
        fnam3(f - 1) = Asc(Mid$(s2, f, 1))
    Next f
    fnam3(f) = 0
    
    s = "SET" + str(machine_type) + "ROM" + str(4)
    s2 = GetS(s)
    For f = 1 To Len(s2)
        fnam4(f - 1) = Asc(Mid$(s2, f, 1))
    Next f
    fnam4(f) = 0
    
    s = "SET" + str(machine_type) + "ROM" + str(5)
    s2 = GetS(s)
    For f = 1 To Len(s2)
        fnam5(f - 1) = Asc(Mid$(s2, f, 1))
    Next f
    fnam5(f) = 0
    
    s = "SET" + str(machine_type) + "ROM" + str(6)
    s2 = GetS(s)
    For f = 1 To Len(s2)
        fnam6(f - 1) = Asc(Mid$(s2, f, 1))
    Next f
    fnam6(f) = 0
    
    s = "SET" + str(machine_type) + "ROM" + str(7)
    s2 = GetS(s)
    For f = 1 To Len(s2)
        fnam7(f - 1) = Asc(Mid$(s2, f, 1))
    Next f
    fnam7(f) = 0
    
    
    
    
    s2 = GetEXEPath
    For f = 1 To Len(s2)
        rompath(f - 1) = Asc(Mid$(s2, f, 1))
    Next f
    rompath(f) = 0
    
    
        
    
'ret = build_rom(fnams(0, 0), fnams(1, 0), fnams(2, 0), fnams(3, 0), fnams(4, 0), fnams(5, 0), fnams(6, 0), fnams(7, 0))
ret = build_rom(fnam0(0), fnam1(0), fnam2(0), fnam3(0), fnam4(0), fnam5(0), fnam6(0), fnam7(0), rompath(0))


End Sub


Public Sub Main()
Dim ret As Integer

first_time = 1


dis_bank = 0
memscan_bank = 0

ret = start_peripherals 'DLL call to initilise tape/[rinter and disks


reset_pale


End Sub


Public Sub reset_pale()

Dim ret As Integer
Dim h As Long, w As Long, tmp As Long
   
    ' STARTUP HERE
    printer_inbuflen = 0
    last_horiz_disp = 0
    load_type = 0
    tsec = 0
    Fix_6845 = 1
    romrev = 0
    machine_type = 0
    hw_type = 0
    display_size = 2
    Language = "English"
    vidmode = 0     'start off in Fast Video mode
    tape_source_type = 0
    ret = set_kbdtype(0)    'start off with us/english keyboard
        
'MsgBox "Hello..."
    
'While True
'For h = 1 To 10000
'    w = 1513
'Next h
'DoEvents
'Wend
    
    
    Init_Vid
    
    machine_speed = 2
    machine_sound = 0
    sound_div_in = 16
    machine_hum = 0
    showsplash = 1
    membank = 0
    memresol = 4
    show_fps = 0
    '------------------------------------------- added to 8.5
    dump_status = 0
    dump_memmap = 0
    dump_sysvar = 0
    dump_disas = 0
 
dump_diskstat = 0
'------------------------------------------- added to 8.5
    
    '--- denotes that this is the first time PAle has ever been run on this puter
  '  first_run = 1

    'Now Load in default values from the registry
    If Load_defaults = False Then
        Save_defaults
        reset_form_positions
        init_ROMsets
        Load_defaults
    End If

    

'MsgBox "HERE I AM..."
    
    
    'standard_disp_update = 0
    
    'THESE ARE BOTH HERE FOR WINE
 '   Form2.Show
 '   Form2.Hide
' MsgBox "After load defaults mach type=" + str(machine_type) + "  hardware=" + str(hw_type)


'MsgBox "Show me the way to go home..."

    'SHOW MAIN CONTROL PANEL
    Form5.Show     'altering these has a great effect on WINE stability

    'THESE ARE NOT HERE FOR WINE - NEW addition to allow Form2 to save its position
    'as the load_settings is called from form2.load then its called b4
    'I get a chance to save some defaults to the registry
   ' Form2.Show
    'If dump_status = 0 Then Form2.Hide


'MsgBox "Im tired and I wanna go to bed..."
' MsgBox "b4 build rom mach type=" + str(machine_type) + "  hardware=" + str(hw_type)

 ' Form11.Show
 ' Form11.Hide

    'THIS IS HERE FOR WORKING WINE
'Form2.Show


    With Form1
        '.BackColor = colors(0)
        .Picture1.BackColor = colors(0)
        .Picture1.Cls
        .WindowState = vbNormal
        .Cls
        .Show
        .Refresh
    End With
    
'MsgBox "Form1 copmlete My old friend - mwwwuuuhhhha  hahh  ahhha aahaaaaaa..."
    
    'Get the rom filenames from the registry
    'If first_run is set (1) then save the current directory to the registry and
    'use for all further ROM loads
    buildrom
    
 
'MsgBox "buildrom DONE"
 
 Form2.set_displays
 
    
'MsgBox "Initialising mach type=" + str(machine_type) + "  hardware=" + str(hw_type)
 ' Form2.Show
 'If dump_status = 0 Then Form2.Hide

    ret = init_emulator(machine_type, hw_type)
    If ret = 0 Then MsgBox "Couldnt initialise the emulator, re-start the program :("

 set_speed (Form5.cmbSpeed.ItemData(Form5.cmbSpeed.ListIndex))
    
    
    
'WITH FORM1 STUFF USED TO BE HERE FOR PALE 6.1
'WITH FORM1 STUFF USED TO BE HERE FOR PALE 6.1
'WITH FORM1 STUFF USED TO BE HERE FOR PALE 6.1
'WITH FORM1 STUFF USED TO BE HERE FOR PALE 6.1
'WITH FORM1 STUFF USED TO BE HERE FOR PALE 6.1
'WITH FORM1 STUFF USED TO BE HERE FOR PALE 6.1
'WITH FORM1 STUFF USED TO BE HERE FOR PALE 6.1
'WITH FORM1 STUFF USED TO BE HERE FOR PALE 6.1
'WITH FORM1 STUFF USED TO BE HERE FOR PALE 6.1
'WITH FORM1 STUFF USED TO BE HERE FOR PALE 6.1

'   Form6.Show
   
    
    
    If showsplash = 1 Then frmSplash.Show



 '   Form1.Picture1.Visible = False
        w = Form1.ScaleWidth / Screen.TwipsPerPixelX
        h = Form1.ScaleHeight / Screen.TwipsPerPixelY
 '      ret = get_video_scanvers(gcBufferBits(0), Form1.Picture1.hdc, w, h, curr_line, bmiBuffer, Fix_6845)  ', crtc_regs(0))
 '       ret = get_video_scanvers(gcBufferBits(0),
   '                             Form1.Picture1.hdc,
   '                             w,
   '                             h,
   '                             curr_line,
   '                             bmiBuffer,
   '                             Fix_6845,
  '                              crtc_regs(0))
'    Form1.Picture1.Visible = True


'ret = run_C_emu(Form1.Picture1.hdc, w, h, bmiBuffer)
    

'MsgBox "And Im at the dead end :("

'IF THERES ANYTHING ON THE COMMAND LINE
'THEN TRY TO LOAD IT AS A PALE PROGRAM
If first_time = 1 And command$ <> "" Then
    Form1.Timer2.Enabled = True
Else
    Form1.Timer2.Enabled = False
End If

first_time = 0

If Form5.Height = form5dev_height Then
    dump_diskstat = 1
End If

Form5.cmbTap_type.ListIndex = tape_source_type
'ret = set_raw_buflen(64) 'start 64mb tape buffer


'ret = set_tape_mode(t_type)
'ret = set_tape_spd_adjust(HScroll1.Value)


'NEW SINCE PALE 6.1
'Start timer at end here instead of with form1 load, hopefully gets round a race condition
Form1.Timer3.Enabled = True

End Sub

Public Function GetS(st As String)


GetS = GetSetting(ThisApp, ThisKey, st)



End Function
Public Function SaveS(st As String, valu As Variant)


SaveSetting ThisApp, ThisKey, st, valu



End Function



Public Sub init_ROMdefaults()
Dim f, g As Integer

    SaveSetting ThisApp, ThisKey, "SET" + str(0) + "ROM" + str(0), "lynx48-1.rom"
    SaveSetting ThisApp, ThisKey, "SET" + str(0) + "ROM" + str(1), "lynx48-2.rom"
    SaveSetting ThisApp, ThisKey, "SET" + str(0) + "ROM" + str(2), "none"
    SaveSetting ThisApp, ThisKey, "SET" + str(0) + "ROM" + str(3), "none"
    SaveSetting ThisApp, ThisKey, "SET" + str(0) + "ROM" + str(4), "none"
    SaveSetting ThisApp, ThisKey, "SET" + str(0) + "ROM" + str(5), "none"
    SaveSetting ThisApp, ThisKey, "SET" + str(0) + "ROM" + str(6), "none"
    SaveSetting ThisApp, ThisKey, "SET" + str(0) + "ROM" + str(7), "none"
    SaveSetting ThisApp, ThisKey, "SET" + str(0) + "HWTYPE", "0"
    
    SaveSetting ThisApp, ThisKey, "SET" + str(1) + "ROM" + str(0), "lynx96-1.rom"
    SaveSetting ThisApp, ThisKey, "SET" + str(1) + "ROM" + str(1), "lynx96-2.rom"
    SaveSetting ThisApp, ThisKey, "SET" + str(1) + "ROM" + str(2), "lynx96-3.rom"
    SaveSetting ThisApp, ThisKey, "SET" + str(1) + "ROM" + str(3), "none"
    SaveSetting ThisApp, ThisKey, "SET" + str(1) + "ROM" + str(4), "none"
    SaveSetting ThisApp, ThisKey, "SET" + str(1) + "ROM" + str(5), "none"
    SaveSetting ThisApp, ThisKey, "SET" + str(1) + "ROM" + str(6), "none"
    SaveSetting ThisApp, ThisKey, "SET" + str(1) + "ROM" + str(7), "none"
    SaveSetting ThisApp, ThisKey, "SET" + str(1) + "HWTYPE", "1"
    
    SaveSetting ThisApp, ThisKey, "SET" + str(2) + "ROM" + str(0), "lynx128-1.rom"
    SaveSetting ThisApp, ThisKey, "SET" + str(2) + "ROM" + str(1), "lynx128-2.rom"
    SaveSetting ThisApp, ThisKey, "SET" + str(2) + "ROM" + str(2), "lynx128-3.rom"
    SaveSetting ThisApp, ThisKey, "SET" + str(2) + "ROM" + str(3), "none"
    SaveSetting ThisApp, ThisKey, "SET" + str(2) + "ROM" + str(4), "none"
    SaveSetting ThisApp, ThisKey, "SET" + str(2) + "ROM" + str(5), "none"
    SaveSetting ThisApp, ThisKey, "SET" + str(2) + "ROM" + str(6), "none"
    SaveSetting ThisApp, ThisKey, "SET" + str(2) + "ROM" + str(7), "none"
    SaveSetting ThisApp, ThisKey, "SET" + str(2) + "HWTYPE", "2"

    SaveSetting ThisApp, ThisKey, "SET" + str(3) + "ROM" + str(0), "lynx96-1.rom"
    SaveSetting ThisApp, ThisKey, "SET" + str(3) + "ROM" + str(1), "lynx96-2.rom"
    SaveSetting ThisApp, ThisKey, "SET" + str(3) + "ROM" + str(2), "lynx96-3.rom"
    SaveSetting ThisApp, ThisKey, "SET" + str(3) + "ROM" + str(3), "none"
    SaveSetting ThisApp, ThisKey, "SET" + str(3) + "ROM" + str(4), "none"
    SaveSetting ThisApp, ThisKey, "SET" + str(3) + "ROM" + str(5), "none"
    SaveSetting ThisApp, ThisKey, "SET" + str(3) + "ROM" + str(6), "none"
    SaveSetting ThisApp, ThisKey, "SET" + str(3) + "ROM" + str(7), "dosrom.rom"
    SaveSetting ThisApp, ThisKey, "SET" + str(3) + "HWTYPE", "1"
    
    SaveSetting ThisApp, ThisKey, "SET" + str(4) + "ROM" + str(0), "lynx128-1.rom"
    SaveSetting ThisApp, ThisKey, "SET" + str(4) + "ROM" + str(1), "lynx128-2.rom"
    SaveSetting ThisApp, ThisKey, "SET" + str(4) + "ROM" + str(2), "lynx128-3.rom"
    SaveSetting ThisApp, ThisKey, "SET" + str(4) + "ROM" + str(3), "none"
    SaveSetting ThisApp, ThisKey, "SET" + str(4) + "ROM" + str(4), "none"
    SaveSetting ThisApp, ThisKey, "SET" + str(4) + "ROM" + str(5), "none"
    SaveSetting ThisApp, ThisKey, "SET" + str(4) + "ROM" + str(6), "none"
    SaveSetting ThisApp, ThisKey, "SET" + str(4) + "ROM" + str(7), "dosrom.rom"
    SaveSetting ThisApp, ThisKey, "SET" + str(4) + "HWTYPE", "2"

End Sub


Private Sub init_ROMsets()
Dim f, g As Integer


'Clear the ROM setups
For g = 0 To 7
For f = 0 To 7
    SaveSetting ThisApp, ThisKey, "SET" + str(g) + "ROM" + str(f), "none"
Next f
    SaveSetting ThisApp, ThisKey, "SET" + str(g) + "HWTYPE", "0"
Next g

'Now initialise  the standard defaults as supplied by me
init_ROMdefaults


End Sub


Sub OpenReadme()
Dim fno
Dim line_in
Dim fIndex As Integer
Dim Filename As String
    On Error Resume Next
    ' Open the selected file.
    fno = FreeFile()
    If Language = "English" Then Filename = "Readme-English.txt"
    If Language = "French" Then Filename = "Readme-French.txt"
    
    Open Filename For Input As #fno
    If err Then
        MsgBox "Can't open Language File: " + Filename
        Exit Sub
    End If
    ' Change the mouse pointer to an hourglass.
    Screen.MousePointer = 11
    Form4.Text1.Text = ""
    While Not EOF(fno)
        Input #fno, line_in
        Form4.Text1.Text = Form4.Text1.Text & line_in & vbCr & vbLf
    Wend
    ' Change the form's caption and display the new text.
    Close #fno
    ' Reset the mouse pointer.
    Screen.MousePointer = 0
End Sub





Public Sub load(ByVal ttype As Byte)

Dim buf As String
Dim fnam(200) As Byte
Dim retstring(200) As Byte
Dim f, ret As Integer


Form1.CommonDialog1.CancelError = True    'this traps user hitting cancel button
'  send_to_lynx ("MLOAD" & Chr(34) & Chr(34) & vbCr & vbLf)



'Exit Sub

On Error GoTo err

'IF the Tape type is 1-+ then its an autoload on running Pale so skip the dialog box
If ttype > 9 Then
    ttype = ttype - 10
'    MsgBox "Filename to load is " + Command$
    'strip off the sodding quotes, ffs who thought of this
    'AAarrrgh FFCS WINE!!! doesnt pass the sodding params properly omg wot a pita
'MsgBox "Mid dollar fuckin 1,1 is  " + Mid$(Command$, 1, 1)
'MsgBox "Mid dollar fuckin 2,1 is  " + Mid$(Command$, 2, 1)
'MsgBox "Mid dollar fuckin end-1,1 is  " + Mid$(Command$, Len(Command$) - 1, 1)
'MsgBox "Mid dollar fuckin end,1 is  " + Mid$(Command$, Len(Command$), 1)
'MsgBox " F F S"
    
    If Mid$(command$, 1, 1) = "/" Then  'then we know its pita fwine giving me shit parameters
        Form1.CommonDialog1.Filename = command$  'Mid$(Command$, 1, Len(Command$))
    Else
        Form1.CommonDialog1.Filename = Mid$(command$, 2, Len(command$) - 2)
    End If
   
'    MsgBox "Filename to load is " + Form1.CommonDialog1.Filename
Else
    Form1.CommonDialog1.Filter = "TAP Files (*.tap)|*.tap|All files" & _
        "(*.*)|*.*"
    Form1.CommonDialog1.Flags = cdlOFNHideReadOnly
    Form1.CommonDialog1.FilterIndex = 1
    Form1.CommonDialog1.ShowOpen
End If

For f = 1 To Len(Form1.CommonDialog1.Filename)
    fnam(f - 1) = Asc(Mid$(Form1.CommonDialog1.Filename, f, 1))
Next f
fnam(f) = 0
 
'MsgBox "ELLO PETE"
    
If ttype = 0 Then
    ret = load_lynx_tap(fnam(0), retstring(0), 0)   'BASIC or BINARY load
ElseIf ttype = 1 Then
    ret = load_lynx_tap(fnam(0), retstring(0), 1)  'DATA load
Else
    ret = load_lev9_tap(fnam(0), retstring(0))  'Level9 Fileset load
End If


'MsgBox "AFTER DLL LOAD_LYNXTAP"

If ret = 0 Then
    MsgBox "Sorry, Failed to Load the Tape"
    Form5.Text4.Text = ""
Else
    Form5.Text4.Text = ""
    f = 0
    While retstring(f) <> 0 And f < 200
    Form5.Text4.Text = Form5.Text4.Text + Chr$(retstring(f))
    f = f + 1
    Wend
End If


'MsgBox "B4 end of VB module Load"


Exit Sub

err:
'MsgBox "AN EROR"

Exit Sub

End Sub

Public Sub send_to_lynx(ByVal instuf As String)
Dim a, b, ch, wow, f, ret, keyboard_del As Integer

ret = GetKeyboardState(kbd_old(0))

s2l_count = 1
wow = Len(instuf)

If vidmode = 0 Then
    keyboard_del = SEND_LYNX_VIDMODE_0
Else
    keyboard_del = SEND_LYNX_VIDMODE_1
End If

While s2l_count <= wow
'MsgBox "Wow" + Str(wow) + " S2L Co" + Str(s2l_count)
    For b = 0 To 499
        kbd2(b) = kbd_old(b)
    Next
    ch = Asc(Mid$(instuf, s2l_count, 1))
    If ch = 34 Then
        kbd2(16) = 129 'shift 2 = "
        kbd2(50) = 129 'shift 2 = "
'        ch = 50
    Else
        kbd2(ch) = 129
    End If
    ret = send_keymap(kbd2(0))
    For f = 1 To keyboard_del
        ret = run_emulator()
    Next f
    If ch = 34 Then
        kbd2(16) = 0 'shift 2 = "
        kbd2(50) = 0 'shift 2 = "
'        ch = 50
    Else
        kbd2(ch) = 0
    End If
    ret = send_keymap(kbd2(0))
    For f = 1 To keyboard_del
        ret = run_emulator()
    Next f
    s2l_count = s2l_count + 1
Wend
    


'MsgBox "Woweeeeeeeeee"


End Sub



Public Sub pump_it(ByVal ttype As Byte)

Dim buf As String
Dim fnam(100) As Byte
Dim retstring(200) As Byte
Dim f, ret As Integer
Dim fno
Dim line_in As String
Dim fIndex As Integer
Dim Filename As String


'CommonDialog1.CancelError = True    'this traps user hitting cancel button
'  send_to_lynx ("MLOAD" & Chr(34) & Chr(34) & vbCr & vbLf)
Form1.StopEmu

DoEvents


'Exit Sub

On Error GoTo err

Form1.CommonDialog1.Filter = "TXT Files (*.txt)|*.txt|All files" & _
    "(*.*)|*.*"
Form1.CommonDialog1.Flags = cdlOFNHideReadOnly
Form1.CommonDialog1.FilterIndex = 1
Form1.CommonDialog1.ShowOpen

For f = 1 To Len(Form1.CommonDialog1.Filename)
    fnam(f - 1) = Asc(Mid$(Form1.CommonDialog1.Filename, f, 1))
Next f
fnam(f) = 0
 
 
    On Error Resume Next
    ' Open the selected file.
    fno = FreeFile()
    
    Open Form1.CommonDialog1.Filename For Input As #fno
    If err Then
        MsgBox "Can't open file: " + Filename
        Exit Sub
    End If
    ' Change the mouse pointer to an hourglass.
    Screen.MousePointer = 11
'    Form5.text3.Text = ""
    While Not EOF(fno)
        Input #fno, line_in
'        Form5.text3.Text = Form5.text3.Text & line_in & vbCr & vbLf
 '        send_to_lynx ("WOWWWEEE")
'                send_to_lynx (line_in)
For f = 1 To Len(line_in)

    If Asc(Mid$(line_in, f, 1)) <> 10 Then send_to_lynx (Mid$(line_in, f, 1))
    DoEvents
'    send_to_lynx ("X")
Next f
    send_to_lynx (vbCr)

    
       '   send_to_lynx ("WOWWWEEE")
    '      MsgBox "sent Line"
    Wend
    ' Change the form's caption and display the new text.
    Close #fno
    ' Reset the mouse pointer.
    Screen.MousePointer = 0

'    send_to_lynx (Form5.text3.Text)
    

err:
'MsgBox "AN EROR"

Exit Sub

'Form1.Timer3.Enabled = True


Form1.RunEmu

'DoEvents


End Sub

Public Sub reset_form_positions()
    
    move_all_forms 200, 0
    
End Sub


Public Sub move_all_forms(ByVal sl As Integer, ByVal st As Integer)
Dim Form1H, Form1W As Integer
Dim Form8H, Form8W As Integer
Dim Form5H, Form5W As Integer
Dim Form2H, Form2W As Integer
    
    'default to 2x screen
    Form1W = 256 * 16 * (2) ' + 1) 'Form1.Width '* 0.95
    Form1H = 248 * 16 * (2) ' + 1) 'Form1.Height '* 0.95
   Form8H = 6630: Form8W = 4470
   Form5H = 6145: Form5W = 5220
   Form2H = 6045: Form2W = 8100
   
   'main lynx screen
    SaveSetting ThisApp, ThisKey, "form1_left", sl
    SaveSetting ThisApp, ThisKey, "form1_top", st
    SaveSetting ThisApp, ThisKey, "form1_customwidth", Form1W
    SaveSetting ThisApp, ThisKey, "form1_customheight", Form1H
        
    'system variables to right of screen
    SaveSetting ThisApp, ThisKey, "form8_left", sl + Form1W + 50
    SaveSetting ThisApp, ThisKey, "form8_top", st + Form1H + 50
    
    'status window underneath main screen
    SaveSetting ThisApp, ThisKey, "form2_left", sl
    SaveSetting ThisApp, ThisKey, "form2_top", st + Form1H + 50
        
    'start the control panel to the right of main
    SaveSetting ThisApp, ThisKey, "form5_left", sl + Form1W + 50
    SaveSetting ThisApp, ThisKey, "form5_top", st + Form1H - Form5H - 50
    
    'memory map to right of sysvar
    'Make sure it still onscreen for people with itty bitty monitors and no sense
    If Screen.Width < 1000 Then
        SaveSetting ThisApp, ThisKey, "form11_left", sl + Form1W + 50
    Else
        SaveSetting ThisApp, ThisKey, "form11_left", sl + Form1W + 50 + Form8W + 50
    End If
    SaveSetting ThisApp, ThisKey, "form11_top", st + Form1H + 50 'size the memap to same size as sysvar
    SaveSetting ThisApp, ThisKey, "form11_width", Form8W * 0.6
    SaveSetting ThisApp, ThisKey, "form11_height", Form8H
    
    SaveSetting ThisApp, ThisKey, "DisplaySize", 2  'default to 2x
End Sub

Public Sub save_form_positions()
    SaveSetting ThisApp, ThisKey, "form1_left", Form1.Left
    SaveSetting ThisApp, ThisKey, "form1_top", Form1.Top
    SaveSetting ThisApp, ThisKey, "form2_left", Form2.Left
    SaveSetting ThisApp, ThisKey, "form2_top", Form2.Top
    SaveSetting ThisApp, ThisKey, "form5_left", Form5.Left
    SaveSetting ThisApp, ThisKey, "form5_top", Form5.Top
    SaveSetting ThisApp, ThisKey, "form8_left", Form8.Left
    SaveSetting ThisApp, ThisKey, "form8_top", Form8.Top
    SaveSetting ThisApp, ThisKey, "form11_left", Form11.Left
    SaveSetting ThisApp, ThisKey, "form11_top", Form11.Top
End Sub

Public Sub load_form1_pos()
    Form1.Left = GetSetting(ThisApp, ThisKey, "form1_left")
    Form1.Top = GetSetting(ThisApp, ThisKey, "form1_top")
End Sub
Public Sub load_form2_pos()
    Form2.Left = GetSetting(ThisApp, ThisKey, "form2_left")
    Form2.Top = GetSetting(ThisApp, ThisKey, "form2_top")
End Sub
Public Sub load_form5_pos()
    Form5.Left = GetSetting(ThisApp, ThisKey, "form5_left")
    Form5.Top = GetSetting(ThisApp, ThisKey, "form5_top")
End Sub
Public Sub load_form8_pos()
    Form8.Left = GetSetting(ThisApp, ThisKey, "form8_left")
    Form8.Top = GetSetting(ThisApp, ThisKey, "form8_top")
End Sub
Public Sub load_form11_pos()
    Form11.Left = GetSetting(ThisApp, ThisKey, "form11_left")
    Form11.Top = GetSetting(ThisApp, ThisKey, "form11_top")
End Sub
Public Sub save_screen_size()
    SaveSetting ThisApp, ThisKey, "form1_customwidth", Form1.Width
    SaveSetting ThisApp, ThisKey, "form1_customheight", Form1.Height
End Sub
Public Sub load_screen_size()
    Form1.Width = GetSetting(ThisApp, ThisKey, "form1_customwidth")
    Form1.Height = GetSetting(ThisApp, ThisKey, "form1_customheight")
End Sub
Public Sub save_form11_size()
    SaveSetting ThisApp, ThisKey, "form11_width", Form11.Width
    SaveSetting ThisApp, ThisKey, "form11_height", Form11.Height
End Sub
Public Sub load_form11_size()
    Form11.Width = GetSetting(ThisApp, ThisKey, "form11_width")
    Form11.Height = GetSetting(ThisApp, ThisKey, "form11_height")
End Sub


Public Sub reset_forms()

load_form1_pos
load_form2_pos
load_form5_pos
load_form8_pos
load_form11_pos
load_screen_size
load_form11_size

End Sub


Public Sub Save_defaults()
'Save current settings in the registry
'MsgBox ("thisap=" + ThisApp + " thiskey=" + ThisKey)
    SaveSetting ThisApp, ThisKey, "Language", Language
   SaveSetting ThisApp, ThisKey, "Machine", machine_type ' - 1)
    SaveSetting ThisApp, ThisKey, "Speed", machine_speed
    SaveSetting ThisApp, ThisKey, "DisplaySize", display_size
    SaveSetting ThisApp, ThisKey, "6845Fix", Fix_6845
  '  If Form5.chkSound.Value = vbChecked Then SaveSetting ThisApp, ThisKey, "Sound", "ON"
   SaveSetting ThisApp, ThisKey, "Sound", machine_sound
   SaveSetting ThisApp, ThisKey, "Hum", machine_hum
   SaveSetting ThisApp, ThisKey, "Status", dump_status
   SaveSetting ThisApp, ThisKey, "Dump6845", dump_6845
   SaveSetting ThisApp, ThisKey, "DumpDiskstat", dump_diskstat
   SaveSetting ThisApp, ThisKey, "Sysvar", dump_sysvar
   SaveSetting ThisApp, ThisKey, "Memmap", dump_memmap
   SaveSetting ThisApp, ThisKey, "Fullscreen", fullscreen
   SaveSetting ThisApp, ThisKey, "ShowSplash", showsplash
   SaveSetting ThisApp, ThisKey, "ShowFPS", show_fps
   SaveSetting ThisApp, ThisKey, "Jogval", jogval
   SaveSetting ThisApp, ThisKey, "membank", membank
   SaveSetting ThisApp, ThisKey, "memresol", memresol
   SaveSetting ThisApp, ThisKey, "sound_div_in", sound_div_in
   SaveSetting ThisApp, ThisKey, "vidmode", vidmode
   SaveSetting ThisApp, ThisKey, "HWTYPE", hw_type
   ' If Form5.chkFullscreen.Value = vbChecked Then SaveSetting ThisApp, ThisKey, "Fullscreen", "ON"
   ' If Form5.chkFullscreen.Value = vbUnchecked Then SaveSetting ThisApp, ThisKey, "Fullscreen", "OFF"

    
End Sub
Public Function Load_defaults() As Boolean
Dim fg As String
'Load default settings from the registry
'MsgBox ("thisap=" + ThisApp + " thiskey=" + ThisKey)
    If GetSetting(ThisApp, ThisKey, "Language") = Empty Then
        Load_defaults = False
        Exit Function
    End If
    Language = GetSetting(ThisApp, ThisKey, "Language")
    '    Form5.cmbMachine.Text = GetSetting(ThisApp, ThisKey, "Machine")
   machine_type = GetSetting(ThisApp, ThisKey, "Machine")
hw_type = GetSetting(ThisApp, ThisKey, "HWTYPE")
'If machine_type > 1 Then hw_type = 1

   
   machine_speed = GetSetting(ThisApp, ThisKey, "Speed")
   display_size = GetSetting(ThisApp, ThisKey, "DisplaySize")
   
   machine_sound = GetSetting(ThisApp, ThisKey, "Sound")
   machine_hum = GetSetting(ThisApp, ThisKey, "Hum")
   Fix_6845 = GetSetting(ThisApp, ThisKey, "6845Fix")
   showsplash = GetSetting(ThisApp, ThisKey, "ShowSplash")
  '  romrev = GetSetting(ThisApp, ThisKey, "Romrev")
'MsgBox ("displ loaded was " + str(Val(GetSetting(ThisApp, ThisKey, "DisplaySize"))))

  
  '  fg = GetSetting(ThisApp, ThisKey, "Sound")
 '   If fg = "ON" Then Form5.chkSound.Value = vbChecked
  '  If fg = "OFF" Then Form5.chkSound.Value = vbUnchecked
  dump_status = GetSetting(ThisApp, ThisKey, "Status")
  dump_diskstat = GetSetting(ThisApp, ThisKey, "DumpDiskstat")
  dump_6845 = GetSetting(ThisApp, ThisKey, "Dump6845")
  dump_sysvar = GetSetting(ThisApp, ThisKey, "Sysvar")
  dump_memmap = GetSetting(ThisApp, ThisKey, "Memmap")
  show_fps = GetSetting(ThisApp, ThisKey, "ShowFPS")
  jogval = GetSetting(ThisApp, ThisKey, "Jogval")
  fullscreen = GetSetting(ThisApp, ThisKey, "Fullscreen")
  vidmode = GetSetting(ThisApp, ThisKey, "vidmode")
  membank = GetSetting(ThisApp, ThisKey, "membank")
  sound_div_in = GetSetting(ThisApp, ThisKey, "sound_div_in")
  memresol = GetSetting(ThisApp, ThisKey, "memresol")

    'must be done here before the forms load
    'Nooooooooooooooooo! Must be done After forms have loaded
    'otherwise they attempt to load when fiddled with
    'leading to the inability to save TOP and LEFT at the same time
   ' load_form_positions
 
 '   fg = GetSetting(ThisApp, ThisKey, "Fullscreen")
 '   If fg = "ON" Then Form5.chkFullscreen.Value = vbChecked
 '   If fg = "OFF" Then Form5.chkFullscreen.Value = vbUnchecked
    
    
    Load_defaults = True
End Function



' converts a string to a base2 string
Function StringToBin(ByVal str As String) As String
    Dim ret As String
    Dim X As Long
    Dim length As Long
    
    length = Len(str)
    
    For X = 1 To length
        ret = ret & ByteToBin(Asc(Mid(str, X, 1)))
    Next X
    
    StringToBin = ret
End Function

Function BinToString(ByVal str As String) As String
    Dim ret As String
    Dim length As Long
    Dim X As Long
    
    length = Len(str)
    
    ' check the string is of the correct context
    If length Mod 8 <> 0 Then
        err.Raise vbObjectError, "BinToString", "Binary data out of context."
        
        Exit Function
    End If
    
    For X = 1 To length Step 8
        ret = ret & Chr(BinToByte(Mid(str, X, 8)))
    Next X
    
    BinToString = ret
End Function


' converts an 8bit byte to a base 2 string
Function ByteToBin(ByVal num As Byte) As String
    Dim ret As String
    Dim X As Integer
    
    ret = ""
    For X = 7 To 0 Step -1
        ' is this number divisible by this power of two
        ret = ret & CStr(num \ (2 ^ X))
        
        ' get the remaining number
        num = num Mod (2 ^ X)
    Next X
    
    ByteToBin = ret
End Function

Function BinToByte(ByVal num As String) As Byte
    Dim ret As Byte
    Dim X As Integer
    Dim Y As Integer
    
    ret = 0
    Y = 7 ' this counts down the powers of two
    
    For X = 1 To 8
        ' multiply the binary digit by the power order of two y
        ret = ret + CInt(Mid(num, X, 1)) * (2 ^ Y)
        Y = Y - 1
    Next
    
    BinToByte = ret
End Function

