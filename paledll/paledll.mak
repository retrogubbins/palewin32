# Microsoft Developer Studio Generated NMAKE File, Format Version 4.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Dynamic-Link Library" 0x0102

!IF "$(CFG)" == ""
CFG=paledll - Win32 Debug
!MESSAGE No configuration specified.  Defaulting to paledll - Win32 Debug.
!ENDIF 

!IF "$(CFG)" != "paledll - Win32 Release" && "$(CFG)" !=\
 "paledll - Win32 Debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE on this makefile
!MESSAGE by defining the macro CFG on the command line.  For example:
!MESSAGE 
!MESSAGE NMAKE /f "paledll.mak" CFG="paledll - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "paledll - Win32 Release" (based on\
 "Win32 (x86) Dynamic-Link Library")
!MESSAGE "paledll - Win32 Debug" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE 
!ERROR An invalid configuration is specified.
!ENDIF 

!IF "$(OS)" == "Windows_NT"
NULL=
!ELSE 
NULL=nul
!ENDIF 
################################################################################
# Begin Project
# PROP Target_Last_Scanned "paledll - Win32 Debug"
MTL=mktyplib.exe
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "paledll - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir ".."
# PROP Intermediate_Dir "Release"
# PROP Target_Dir ""
OUTDIR=.\..
INTDIR=.\Release

ALL : "$(OUTDIR)\paledll.dll"

CLEAN : 
	-@erase "..\paledll.dll"
	-@erase ".\Release\dskopen.obj"
	-@erase ".\Release\dskcheck.obj"
	-@erase ".\Release\drvcpcem.obj"
	-@erase ".\Release\crc16.obj"
	-@erase ".\Release\PalePRINTER.obj"
	-@erase ".\Release\rpcserv.obj"
	-@erase ".\Release\dskdirty.obj"
	-@erase ".\Release\PaleUTILS.obj"
	-@erase ".\Release\dskreprt.obj"
	-@erase ".\Release\drvcfi.obj"
	-@erase ".\Release\rpccli.obj"
	-@erase ".\Release\dsklphys.obj"
	-@erase ".\Release\ztape.obj"
	-@erase ".\Release\PaleTAPS.obj"
	-@erase ".\Release\dskjni.obj"
	-@erase ".\Release\rpcwin32.obj"
	-@erase ".\Release\compress.obj"
	-@erase ".\Release\drvwin32.obj"
	-@erase ".\Release\dskseek.obj"
	-@erase ".\Release\drvdos16.obj"
	-@erase ".\Release\PaleROM.obj"
	-@erase ".\Release\SoundServer.obj"
	-@erase ".\Release\remote.obj"
	-@erase ".\Release\drvrcpm.obj"
	-@erase ".\Release\rpcfossl.obj"
	-@erase ".\Release\dskread.obj"
	-@erase ".\Release\dsktread.obj"
	-@erase ".\Release\PaleIO.obj"
	-@erase ".\Release\IOPort.obj"
	-@erase ".\Release\PaleVID.obj"
	-@erase ".\Release\PaleKEYB.obj"
	-@erase ".\Release\dskretry.obj"
	-@erase ".\Release\error.obj"
	-@erase ".\Release\dskstat.obj"
	-@erase ".\Release\compsq.obj"
	-@erase ".\Release\rpcpack.obj"
	-@erase ".\Release\drvdos32.obj"
	-@erase ".\Release\dskfmt.obj"
	-@erase ".\Release\rpctios.obj"
	-@erase ".\Release\dsktrkid.obj"
	-@erase ".\Release\PaleSound.obj"
	-@erase ".\Release\rpcmap.obj"
	-@erase ".\Release\compbz2.obj"
	-@erase ".\Release\dsksgeom.obj"
	-@erase ".\Release\drvposix.obj"
	-@erase ".\Release\dskpars.obj"
	-@erase ".\Release\Paledisk.obj"
	-@erase ".\Release\z80.obj"
	-@erase ".\Release\dskrtrd.obj"
	-@erase ".\Release\drvnwasp.obj"
	-@erase ".\Release\dskerror.obj"
	-@erase ".\Release\dsksecid.obj"
	-@erase ".\Release\rpcfork.obj"
	-@erase ".\Release\z80dasm.obj"
	-@erase ".\Release\drvqm.obj"
	-@erase ".\Release\drvntwdm.obj"
	-@erase ".\Release\crctable.obj"
	-@erase ".\Release\dskcmt.obj"
	-@erase ".\Release\drvmyz80.obj"
	-@erase ".\Release\dskgeom.obj"
	-@erase ".\Release\drvlinux.obj"
	-@erase ".\Release\compgz.obj"
	-@erase ".\Release\PaleMEM.obj"
	-@erase ".\Release\dskwrite.obj"
	-@erase ".\Release\drvwin16.obj"
	-@erase ".\Release\drvadisk.obj"
	-@erase ".\Release\pale.obj"
	-@erase "..\paledll.lib"
	-@erase "..\paledll.exp"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

"$(INTDIR)" :
    if not exist "$(INTDIR)/$(NULL)" mkdir "$(INTDIR)"

# ADD BASE CPP /nologo /MT /W3 /GX /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /YX /c
# ADD CPP /nologo /MT /W2 /GX /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /YX /c
CPP_PROJ=/nologo /MT /W2 /GX /D "WIN32" /D "NDEBUG" /D "_WINDOWS"\
 /Fp"$(INTDIR)/paledll.pch" /YX /Fo"$(INTDIR)/" /c 
CPP_OBJS=.\Release/
CPP_SBRS=
# ADD BASE MTL /nologo /D "NDEBUG" /win32
# ADD MTL /nologo /D "NDEBUG" /win32
MTL_PROJ=/nologo /D "NDEBUG" /win32 
# ADD BASE RSC /l 0x809 /d "NDEBUG"
# ADD RSC /l 0x809 /d "NDEBUG" /i /libdsk-1.1.5/include" "
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
BSC32_FLAGS=/nologo /o"$(OUTDIR)/paledll.bsc" 
BSC32_SBRS=
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /dll /machine:I386
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /dll /machine:I386
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib /nologo /subsystem:windows /dll /incremental:no\
 /pdb:"$(OUTDIR)/paledll.pdb" /machine:I386 /def:".\pale.def"\
 /out:"$(OUTDIR)/paledll.dll" /implib:"$(OUTDIR)/paledll.lib" 
DEF_FILE= \
	".\pale.def"
LINK32_OBJS= \
	"$(INTDIR)/dskopen.obj" \
	"$(INTDIR)/dskcheck.obj" \
	"$(INTDIR)/drvcpcem.obj" \
	"$(INTDIR)/crc16.obj" \
	"$(INTDIR)/PalePRINTER.obj" \
	"$(INTDIR)/rpcserv.obj" \
	"$(INTDIR)/dskdirty.obj" \
	"$(INTDIR)/PaleUTILS.obj" \
	"$(INTDIR)/dskreprt.obj" \
	"$(INTDIR)/drvcfi.obj" \
	"$(INTDIR)/rpccli.obj" \
	"$(INTDIR)/dsklphys.obj" \
	"$(INTDIR)/ztape.obj" \
	"$(INTDIR)/PaleTAPS.obj" \
	"$(INTDIR)/dskjni.obj" \
	"$(INTDIR)/rpcwin32.obj" \
	"$(INTDIR)/compress.obj" \
	"$(INTDIR)/drvwin32.obj" \
	"$(INTDIR)/dskseek.obj" \
	"$(INTDIR)/drvdos16.obj" \
	"$(INTDIR)/PaleROM.obj" \
	"$(INTDIR)/SoundServer.obj" \
	"$(INTDIR)/remote.obj" \
	"$(INTDIR)/drvrcpm.obj" \
	"$(INTDIR)/rpcfossl.obj" \
	"$(INTDIR)/dskread.obj" \
	"$(INTDIR)/dsktread.obj" \
	"$(INTDIR)/PaleIO.obj" \
	"$(INTDIR)/IOPort.obj" \
	"$(INTDIR)/PaleVID.obj" \
	"$(INTDIR)/PaleKEYB.obj" \
	"$(INTDIR)/dskretry.obj" \
	"$(INTDIR)/error.obj" \
	"$(INTDIR)/dskstat.obj" \
	"$(INTDIR)/compsq.obj" \
	"$(INTDIR)/rpcpack.obj" \
	"$(INTDIR)/drvdos32.obj" \
	"$(INTDIR)/dskfmt.obj" \
	"$(INTDIR)/rpctios.obj" \
	"$(INTDIR)/dsktrkid.obj" \
	"$(INTDIR)/PaleSound.obj" \
	"$(INTDIR)/rpcmap.obj" \
	"$(INTDIR)/compbz2.obj" \
	"$(INTDIR)/dsksgeom.obj" \
	"$(INTDIR)/drvposix.obj" \
	"$(INTDIR)/dskpars.obj" \
	"$(INTDIR)/Paledisk.obj" \
	"$(INTDIR)/z80.obj" \
	"$(INTDIR)/dskrtrd.obj" \
	"$(INTDIR)/drvnwasp.obj" \
	"$(INTDIR)/dskerror.obj" \
	"$(INTDIR)/dsksecid.obj" \
	"$(INTDIR)/rpcfork.obj" \
	"$(INTDIR)/z80dasm.obj" \
	"$(INTDIR)/drvqm.obj" \
	"$(INTDIR)/drvntwdm.obj" \
	"$(INTDIR)/crctable.obj" \
	"$(INTDIR)/dskcmt.obj" \
	"$(INTDIR)/drvmyz80.obj" \
	"$(INTDIR)/dskgeom.obj" \
	"$(INTDIR)/drvlinux.obj" \
	"$(INTDIR)/compgz.obj" \
	"$(INTDIR)/PaleMEM.obj" \
	"$(INTDIR)/dskwrite.obj" \
	"$(INTDIR)/drvwin16.obj" \
	"$(INTDIR)/drvadisk.obj" \
	"$(INTDIR)/pale.obj" \
	"C:\MSDEVSTD\LIB\WINMM.LIB"

"$(OUTDIR)\paledll.dll" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ELSEIF  "$(CFG)" == "paledll - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "paledll_"
# PROP BASE Intermediate_Dir "paledll_"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir ".."
# PROP Intermediate_Dir "paledll_"
# PROP Target_Dir ""
OUTDIR=.\..
INTDIR=.\paledll_

ALL : "$(OUTDIR)\paledll.dll"

CLEAN : 
	-@erase ".\paledll_\vc40.pdb"
	-@erase ".\paledll_\vc40.idb"
	-@erase "..\paledll.dll"
	-@erase ".\paledll_\crc16.obj"
	-@erase ".\paledll_\error.obj"
	-@erase ".\paledll_\dskcheck.obj"
	-@erase ".\paledll_\drvcpcem.obj"
	-@erase ".\paledll_\dskopen.obj"
	-@erase ".\paledll_\dsktrkid.obj"
	-@erase ".\paledll_\compgz.obj"
	-@erase ".\paledll_\dskdirty.obj"
	-@erase ".\paledll_\rpcserv.obj"
	-@erase ".\paledll_\dskreprt.obj"
	-@erase ".\paledll_\ztape.obj"
	-@erase ".\paledll_\dskpars.obj"
	-@erase ".\paledll_\dsklphys.obj"
	-@erase ".\paledll_\compsq.obj"
	-@erase ".\paledll_\rpcwin32.obj"
	-@erase ".\paledll_\compress.obj"
	-@erase ".\paledll_\drvwin32.obj"
	-@erase ".\paledll_\drvcfi.obj"
	-@erase ".\paledll_\drvdos16.obj"
	-@erase ".\paledll_\rpccli.obj"
	-@erase ".\paledll_\PaleROM.obj"
	-@erase ".\paledll_\dskgeom.obj"
	-@erase ".\paledll_\PalePRINTER.obj"
	-@erase ".\paledll_\drvrcpm.obj"
	-@erase ".\paledll_\rpcfossl.obj"
	-@erase ".\paledll_\PaleMEM.obj"
	-@erase ".\paledll_\dsktread.obj"
	-@erase ".\paledll_\PaleVID.obj"
	-@erase ".\paledll_\remote.obj"
	-@erase ".\paledll_\dskretry.obj"
	-@erase ".\paledll_\PaleSound.obj"
	-@erase ".\paledll_\PaleUTILS.obj"
	-@erase ".\paledll_\dskstat.obj"
	-@erase ".\paledll_\PaleIO.obj"
	-@erase ".\paledll_\IOPort.obj"
	-@erase ".\paledll_\dskcmt.obj"
	-@erase ".\paledll_\drvdos32.obj"
	-@erase ".\paledll_\rpcpack.obj"
	-@erase ".\paledll_\rpctios.obj"
	-@erase ".\paledll_\SoundServer.obj"
	-@erase ".\paledll_\PaleTAPS.obj"
	-@erase ".\paledll_\dsksgeom.obj"
	-@erase ".\paledll_\compbz2.obj"
	-@erase ".\paledll_\z80.obj"
	-@erase ".\paledll_\drvposix.obj"
	-@erase ".\paledll_\Paledisk.obj"
	-@erase ".\paledll_\dskseek.obj"
	-@erase ".\paledll_\drvnwasp.obj"
	-@erase ".\paledll_\dskrtrd.obj"
	-@erase ".\paledll_\dskerror.obj"
	-@erase ".\paledll_\dskfmt.obj"
	-@erase ".\paledll_\dsksecid.obj"
	-@erase ".\paledll_\drvqm.obj"
	-@erase ".\paledll_\rpcmap.obj"
	-@erase ".\paledll_\rpcfork.obj"
	-@erase ".\paledll_\z80dasm.obj"
	-@erase ".\paledll_\dskread.obj"
	-@erase ".\paledll_\drvntwdm.obj"
	-@erase ".\paledll_\crctable.obj"
	-@erase ".\paledll_\pale.obj"
	-@erase ".\paledll_\drvmyz80.obj"
	-@erase ".\paledll_\PaleKEYB.obj"
	-@erase ".\paledll_\drvlinux.obj"
	-@erase ".\paledll_\dskjni.obj"
	-@erase ".\paledll_\dskwrite.obj"
	-@erase ".\paledll_\drvwin16.obj"
	-@erase ".\paledll_\drvadisk.obj"
	-@erase "..\paledll.ilk"
	-@erase "..\paledll.lib"
	-@erase "..\paledll.exp"
	-@erase "..\paledll.pdb"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

"$(INTDIR)" :
    if not exist "$(INTDIR)/$(NULL)" mkdir "$(INTDIR)"

# ADD BASE CPP /nologo /MTd /W3 /Gm /GX /Zi /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /YX /c
# ADD CPP /nologo /MTd /W2 /Gm /GX /Zi /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /YX /c
CPP_PROJ=/nologo /MTd /W2 /Gm /GX /Zi /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS"\
 /Fp"$(INTDIR)/paledll.pch" /YX /Fo"$(INTDIR)/" /Fd"$(INTDIR)/" /c 
CPP_OBJS=.\paledll_/
CPP_SBRS=
# ADD BASE MTL /nologo /D "_DEBUG" /win32
# ADD MTL /nologo /D "_DEBUG" /win32
MTL_PROJ=/nologo /D "_DEBUG" /win32 
# ADD BASE RSC /l 0x809 /d "_DEBUG"
# ADD RSC /l 0x809 /d "_DEBUG" /i /libdsk-1.1.5/include" "
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
BSC32_FLAGS=/nologo /o"$(OUTDIR)/paledll.bsc" 
BSC32_SBRS=
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /dll /debug /machine:I386
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /dll /debug /machine:I386
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib /nologo /subsystem:windows /dll /incremental:yes\
 /pdb:"$(OUTDIR)/paledll.pdb" /debug /machine:I386 /def:".\pale.def"\
 /out:"$(OUTDIR)/paledll.dll" /implib:"$(OUTDIR)/paledll.lib" 
DEF_FILE= \
	".\pale.def"
LINK32_OBJS= \
	"$(INTDIR)/crc16.obj" \
	"$(INTDIR)/error.obj" \
	"$(INTDIR)/dskcheck.obj" \
	"$(INTDIR)/drvcpcem.obj" \
	"$(INTDIR)/dskopen.obj" \
	"$(INTDIR)/dsktrkid.obj" \
	"$(INTDIR)/compgz.obj" \
	"$(INTDIR)/dskdirty.obj" \
	"$(INTDIR)/rpcserv.obj" \
	"$(INTDIR)/dskreprt.obj" \
	"$(INTDIR)/ztape.obj" \
	"$(INTDIR)/dskpars.obj" \
	"$(INTDIR)/dsklphys.obj" \
	"$(INTDIR)/compsq.obj" \
	"$(INTDIR)/rpcwin32.obj" \
	"$(INTDIR)/compress.obj" \
	"$(INTDIR)/drvwin32.obj" \
	"$(INTDIR)/drvcfi.obj" \
	"$(INTDIR)/drvdos16.obj" \
	"$(INTDIR)/rpccli.obj" \
	"$(INTDIR)/PaleROM.obj" \
	"$(INTDIR)/dskgeom.obj" \
	"$(INTDIR)/PalePRINTER.obj" \
	"$(INTDIR)/drvrcpm.obj" \
	"$(INTDIR)/rpcfossl.obj" \
	"$(INTDIR)/PaleMEM.obj" \
	"$(INTDIR)/dsktread.obj" \
	"$(INTDIR)/PaleVID.obj" \
	"$(INTDIR)/remote.obj" \
	"$(INTDIR)/dskretry.obj" \
	"$(INTDIR)/PaleSound.obj" \
	"$(INTDIR)/PaleUTILS.obj" \
	"$(INTDIR)/dskstat.obj" \
	"$(INTDIR)/PaleIO.obj" \
	"$(INTDIR)/IOPort.obj" \
	"$(INTDIR)/dskcmt.obj" \
	"$(INTDIR)/drvdos32.obj" \
	"$(INTDIR)/rpcpack.obj" \
	"$(INTDIR)/rpctios.obj" \
	"$(INTDIR)/SoundServer.obj" \
	"$(INTDIR)/PaleTAPS.obj" \
	"$(INTDIR)/dsksgeom.obj" \
	"$(INTDIR)/compbz2.obj" \
	"$(INTDIR)/z80.obj" \
	"$(INTDIR)/drvposix.obj" \
	"$(INTDIR)/Paledisk.obj" \
	"$(INTDIR)/dskseek.obj" \
	"$(INTDIR)/drvnwasp.obj" \
	"$(INTDIR)/dskrtrd.obj" \
	"$(INTDIR)/dskerror.obj" \
	"$(INTDIR)/dskfmt.obj" \
	"$(INTDIR)/dsksecid.obj" \
	"$(INTDIR)/drvqm.obj" \
	"$(INTDIR)/rpcmap.obj" \
	"$(INTDIR)/rpcfork.obj" \
	"$(INTDIR)/z80dasm.obj" \
	"$(INTDIR)/dskread.obj" \
	"$(INTDIR)/drvntwdm.obj" \
	"$(INTDIR)/crctable.obj" \
	"$(INTDIR)/pale.obj" \
	"$(INTDIR)/drvmyz80.obj" \
	"$(INTDIR)/PaleKEYB.obj" \
	"$(INTDIR)/drvlinux.obj" \
	"$(INTDIR)/dskjni.obj" \
	"$(INTDIR)/dskwrite.obj" \
	"$(INTDIR)/drvwin16.obj" \
	"$(INTDIR)/drvadisk.obj" \
	"C:\MSDEVSTD\LIB\WINMM.LIB"

"$(OUTDIR)\paledll.dll" : "$(OUTDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

!ENDIF 

.c{$(CPP_OBJS)}.obj:
   $(CPP) $(CPP_PROJ) $<  

.cpp{$(CPP_OBJS)}.obj:
   $(CPP) $(CPP_PROJ) $<  

.cxx{$(CPP_OBJS)}.obj:
   $(CPP) $(CPP_PROJ) $<  

.c{$(CPP_SBRS)}.sbr:
   $(CPP) $(CPP_PROJ) $<  

.cpp{$(CPP_SBRS)}.sbr:
   $(CPP) $(CPP_PROJ) $<  

.cxx{$(CPP_SBRS)}.sbr:
   $(CPP) $(CPP_PROJ) $<  

################################################################################
# Begin Target

# Name "paledll - Win32 Release"
# Name "paledll - Win32 Debug"

!IF  "$(CFG)" == "paledll - Win32 Release"

!ELSEIF  "$(CFG)" == "paledll - Win32 Debug"

!ENDIF 

################################################################################
# Begin Source File

SOURCE=.\ztape.cpp

!IF  "$(CFG)" == "paledll - Win32 Release"

DEP_CPP_ZTAPE=\
	{$(INCLUDE)}"\sys\TYPES.H"\
	{$(INCLUDE)}"\sys\STAT.H"\
	
NODEP_CPP_ZTAPE=\
	".\="\
	

"$(INTDIR)\ztape.obj" : $(SOURCE) $(DEP_CPP_ZTAPE) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "paledll - Win32 Debug"

DEP_CPP_ZTAPE=\
	{$(INCLUDE)}"\sys\TYPES.H"\
	{$(INCLUDE)}"\sys\STAT.H"\
	

"$(INTDIR)\ztape.obj" : $(SOURCE) $(DEP_CPP_ZTAPE) "$(INTDIR)"


!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\z80.cpp

!IF  "$(CFG)" == "paledll - Win32 Release"

DEP_CPP_Z80_C=\
	{$(INCLUDE)}"\sys\TYPES.H"\
	{$(INCLUDE)}"\sys\STAT.H"\
	".\Z80.h"\
	".\Pale.h"\
	".\PaleTAPS.h"\
	".\PaleMEM.h"\
	".\Z80DAA.h"\
	".\Z80CDx86.h"\
	".\Z80Codes.h"\
	".\Z80IO.h"\
	
NODEP_CPP_Z80_C=\
	".\ei_addr"\
	".\ei_addr=R.PC.W.l;"\
	".\if"\
	

"$(INTDIR)\z80.obj" : $(SOURCE) $(DEP_CPP_Z80_C) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "paledll - Win32 Debug"

DEP_CPP_Z80_C=\
	{$(INCLUDE)}"\sys\TYPES.H"\
	{$(INCLUDE)}"\sys\STAT.H"\
	".\Z80.h"\
	".\Pale.h"\
	".\PaleTAPS.h"\
	".\PaleMEM.h"\
	".\Z80DAA.h"\
	".\Z80CDx86.h"\
	".\Z80Codes.h"\
	".\Z80IO.h"\
	

"$(INTDIR)\z80.obj" : $(SOURCE) $(DEP_CPP_Z80_C) "$(INTDIR)"


!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\SoundServer.cpp
DEP_CPP_SOUND=\
	".\SoundServer.h"\
	

"$(INTDIR)\SoundServer.obj" : $(SOURCE) $(DEP_CPP_SOUND) "$(INTDIR)"


# End Source File
################################################################################
# Begin Source File

SOURCE=.\pale.cpp

!IF  "$(CFG)" == "paledll - Win32 Release"

DEP_CPP_PALE_=\
	{$(INCLUDE)}"\sys\TYPES.H"\
	{$(INCLUDE)}"\sys\STAT.H"\
	".\Z80.h"\
	".\libdsk.h"\
	".\Z80Dasm.h"\
	".\palesound.h"\
	".\Paledisk.h"\
	".\PaleIO.h"\
	".\PaleMEM.h"\
	".\PaleUTILS.h"\
	".\Pale.h"\
	".\PaleVID.h"\
	".\PalePRINTER.h"\
	".\PaleTAPS.h"\
	".\PaleROM.h"\
	".\Z80IO.h"\
	
NODEP_CPP_PALE_=\
	".\emu_speed"\
	

"$(INTDIR)\pale.obj" : $(SOURCE) $(DEP_CPP_PALE_) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "paledll - Win32 Debug"

DEP_CPP_PALE_=\
	{$(INCLUDE)}"\sys\TYPES.H"\
	{$(INCLUDE)}"\sys\STAT.H"\
	".\Z80.h"\
	".\libdsk.h"\
	".\Z80Dasm.h"\
	".\palesound.h"\
	".\Paledisk.h"\
	".\PaleIO.h"\
	".\PaleMEM.h"\
	".\PaleUTILS.h"\
	".\Pale.h"\
	".\PaleVID.h"\
	".\PalePRINTER.h"\
	".\PaleTAPS.h"\
	".\PaleROM.h"\
	".\Z80IO.h"\
	

"$(INTDIR)\pale.obj" : $(SOURCE) $(DEP_CPP_PALE_) "$(INTDIR)"


!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=C:\MSDEVSTD\LIB\WINMM.LIB

!IF  "$(CFG)" == "paledll - Win32 Release"

!ELSEIF  "$(CFG)" == "paledll - Win32 Debug"

!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\pale.def

!IF  "$(CFG)" == "paledll - Win32 Release"

!ELSEIF  "$(CFG)" == "paledll - Win32 Debug"

!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\z80dasm.cpp

"$(INTDIR)\z80dasm.obj" : $(SOURCE) "$(INTDIR)"


# End Source File
################################################################################
# Begin Source File

SOURCE=.\libdsk.h

!IF  "$(CFG)" == "paledll - Win32 Release"

!ELSEIF  "$(CFG)" == "paledll - Win32 Debug"

!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\rpcwin32.c"
DEP_CPP_RPCWI=\
	".\libdsk-1.1.5\lib\drvi.h"\
	".\libdsk-1.1.5\lib\remote.h"\
	".\libdsk-1.1.5\lib\rpcwin32.h"\
	".\libdsk-1.1.5\lib\crc16.h"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\drv.h"\
	
NODEP_CPP_RPCWI=\
	".\libdsk-1.1.5\lib\linux\fd.h"\
	".\libdsk-1.1.5\lib\linux\fdreg.h"\
	

"$(INTDIR)\rpcwin32.obj" : $(SOURCE) $(DEP_CPP_RPCWI) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\rpctios.c"
DEP_CPP_RPCTI=\
	".\libdsk-1.1.5\lib\drvi.h"\
	".\libdsk-1.1.5\lib\remote.h"\
	".\libdsk-1.1.5\lib\rpctios.h"\
	".\libdsk-1.1.5\lib\crc16.h"\
	{$(INCLUDE)}"\sys\STAT.H"\
	{$(INCLUDE)}"\sys\TYPES.H"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\drv.h"\
	
NODEP_CPP_RPCTI=\
	".\libdsk-1.1.5\lib\linux\fd.h"\
	".\libdsk-1.1.5\lib\linux\fdreg.h"\
	

"$(INTDIR)\rpctios.obj" : $(SOURCE) $(DEP_CPP_RPCTI) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\rpcserv.c"
DEP_CPP_RPCSE=\
	".\libdsk-1.1.5\lib\drvi.h"\
	".\libdsk-1.1.5\lib\rpcfuncs.h"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\drv.h"\
	
NODEP_CPP_RPCSE=\
	".\libdsk-1.1.5\lib\linux\fd.h"\
	".\libdsk-1.1.5\lib\linux\fdreg.h"\
	

"$(INTDIR)\rpcserv.obj" : $(SOURCE) $(DEP_CPP_RPCSE) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\rpcpack.c"
DEP_CPP_RPCPA=\
	".\libdsk-1.1.5\lib\drvi.h"\
	".\libdsk-1.1.5\lib\rpcfuncs.h"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\drv.h"\
	
NODEP_CPP_RPCPA=\
	".\libdsk-1.1.5\lib\linux\fd.h"\
	".\libdsk-1.1.5\lib\linux\fdreg.h"\
	

"$(INTDIR)\rpcpack.obj" : $(SOURCE) $(DEP_CPP_RPCPA) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\rpcmap.c"
DEP_CPP_RPCMA=\
	".\libdsk-1.1.5\lib\drvi.h"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\drv.h"\
	
NODEP_CPP_RPCMA=\
	".\libdsk-1.1.5\lib\linux\fd.h"\
	".\libdsk-1.1.5\lib\linux\fdreg.h"\
	

"$(INTDIR)\rpcmap.obj" : $(SOURCE) $(DEP_CPP_RPCMA) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\rpcfossl.c"
DEP_CPP_RPCFO=\
	".\libdsk-1.1.5\lib\drvi.h"\
	".\libdsk-1.1.5\lib\remote.h"\
	".\libdsk-1.1.5\lib\rpcfossl.h"\
	".\libdsk-1.1.5\lib\crc16.h"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\drv.h"\
	
NODEP_CPP_RPCFO=\
	".\libdsk-1.1.5\lib\linux\fd.h"\
	".\libdsk-1.1.5\lib\linux\fdreg.h"\
	

"$(INTDIR)\rpcfossl.obj" : $(SOURCE) $(DEP_CPP_RPCFO) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\rpcfork.c"
DEP_CPP_RPCFOR=\
	".\libdsk-1.1.5\lib\drvi.h"\
	".\libdsk-1.1.5\lib\remote.h"\
	".\libdsk-1.1.5\lib\rpcfork.h"\
	{$(INCLUDE)}"\sys\TYPES.H"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\drv.h"\
	
NODEP_CPP_RPCFOR=\
	".\libdsk-1.1.5\lib\linux\fd.h"\
	".\libdsk-1.1.5\lib\linux\fdreg.h"\
	

"$(INTDIR)\rpcfork.obj" : $(SOURCE) $(DEP_CPP_RPCFOR) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\rpccli.c"
DEP_CPP_RPCCL=\
	".\libdsk-1.1.5\lib\drvi.h"\
	".\libdsk-1.1.5\lib\rpcfuncs.h"\
	".\libdsk-1.1.5\lib\remote.h"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\drv.h"\
	
NODEP_CPP_RPCCL=\
	".\libdsk-1.1.5\lib\linux\fd.h"\
	".\libdsk-1.1.5\lib\linux\fdreg.h"\
	

"$(INTDIR)\rpccli.obj" : $(SOURCE) $(DEP_CPP_RPCCL) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\remote.c"
DEP_CPP_REMOT=\
	".\libdsk-1.1.5\lib\drvi.h"\
	".\libdsk-1.1.5\lib\rpcfuncs.h"\
	".\libdsk-1.1.5\lib\remote.h"\
	".\libdsk-1.1.5\lib\remall.h"\
	".\libdsk-1.1.5\lib\remote.inc"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\drv.h"\
	".\libdsk-1.1.5\lib\rpctios.h"\
	".\libdsk-1.1.5\lib\rpcwin32.h"\
	".\libdsk-1.1.5\lib\rpcfossl.h"\
	".\libdsk-1.1.5\lib\rpcfork.h"\
	
NODEP_CPP_REMOT=\
	".\libdsk-1.1.5\lib\linux\fd.h"\
	".\libdsk-1.1.5\lib\linux\fdreg.h"\
	

"$(INTDIR)\remote.obj" : $(SOURCE) $(DEP_CPP_REMOT) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\dskwrite.c"
DEP_CPP_DSKWR=\
	".\libdsk-1.1.5\lib\drvi.h"\
	".\libdsk-1.1.5\lib\compi.h"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\drv.h"\
	".\libdsk-1.1.5\lib\compress.h"\
	
NODEP_CPP_DSKWR=\
	".\libdsk-1.1.5\lib\linux\fd.h"\
	".\libdsk-1.1.5\lib\linux\fdreg.h"\
	

"$(INTDIR)\dskwrite.obj" : $(SOURCE) $(DEP_CPP_DSKWR) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\dsktrkid.c"
DEP_CPP_DSKTR=\
	".\libdsk-1.1.5\lib\drvi.h"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\drv.h"\
	
NODEP_CPP_DSKTR=\
	".\libdsk-1.1.5\lib\linux\fd.h"\
	".\libdsk-1.1.5\lib\linux\fdreg.h"\
	

"$(INTDIR)\dsktrkid.obj" : $(SOURCE) $(DEP_CPP_DSKTR) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\dsktread.c"
DEP_CPP_DSKTRE=\
	".\libdsk-1.1.5\lib\drvi.h"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\drv.h"\
	
NODEP_CPP_DSKTRE=\
	".\libdsk-1.1.5\lib\linux\fd.h"\
	".\libdsk-1.1.5\lib\linux\fdreg.h"\
	

"$(INTDIR)\dsktread.obj" : $(SOURCE) $(DEP_CPP_DSKTRE) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\dskstat.c"
DEP_CPP_DSKST=\
	".\libdsk-1.1.5\lib\drvi.h"\
	".\libdsk-1.1.5\lib\compi.h"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\drv.h"\
	".\libdsk-1.1.5\lib\compress.h"\
	
NODEP_CPP_DSKST=\
	".\libdsk-1.1.5\lib\linux\fd.h"\
	".\libdsk-1.1.5\lib\linux\fdreg.h"\
	

"$(INTDIR)\dskstat.obj" : $(SOURCE) $(DEP_CPP_DSKST) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\dsksgeom.c"
DEP_CPP_DSKSG=\
	".\libdsk-1.1.5\lib\drvi.h"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\drv.h"\
	
NODEP_CPP_DSKSG=\
	".\libdsk-1.1.5\lib\linux\fd.h"\
	".\libdsk-1.1.5\lib\linux\fdreg.h"\
	

"$(INTDIR)\dsksgeom.obj" : $(SOURCE) $(DEP_CPP_DSKSG) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\dskseek.c"
DEP_CPP_DSKSE=\
	".\libdsk-1.1.5\lib\drvi.h"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\drv.h"\
	
NODEP_CPP_DSKSE=\
	".\libdsk-1.1.5\lib\linux\fd.h"\
	".\libdsk-1.1.5\lib\linux\fdreg.h"\
	

"$(INTDIR)\dskseek.obj" : $(SOURCE) $(DEP_CPP_DSKSE) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\dsksecid.c"
DEP_CPP_DSKSEC=\
	".\libdsk-1.1.5\lib\drvi.h"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\drv.h"\
	
NODEP_CPP_DSKSEC=\
	".\libdsk-1.1.5\lib\linux\fd.h"\
	".\libdsk-1.1.5\lib\linux\fdreg.h"\
	

"$(INTDIR)\dsksecid.obj" : $(SOURCE) $(DEP_CPP_DSKSEC) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\dskrtrd.c"
DEP_CPP_DSKRT=\
	".\libdsk-1.1.5\lib\drvi.h"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\drv.h"\
	
NODEP_CPP_DSKRT=\
	".\libdsk-1.1.5\lib\linux\fd.h"\
	".\libdsk-1.1.5\lib\linux\fdreg.h"\
	

"$(INTDIR)\dskrtrd.obj" : $(SOURCE) $(DEP_CPP_DSKRT) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\dskretry.c"
DEP_CPP_DSKRE=\
	".\libdsk-1.1.5\lib\drvi.h"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\drv.h"\
	
NODEP_CPP_DSKRE=\
	".\libdsk-1.1.5\lib\linux\fd.h"\
	".\libdsk-1.1.5\lib\linux\fdreg.h"\
	

"$(INTDIR)\dskretry.obj" : $(SOURCE) $(DEP_CPP_DSKRE) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\dskreprt.c"
DEP_CPP_DSKREP=\
	".\libdsk-1.1.5\lib\drvi.h"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\drv.h"\
	
NODEP_CPP_DSKREP=\
	".\libdsk-1.1.5\lib\linux\fd.h"\
	".\libdsk-1.1.5\lib\linux\fdreg.h"\
	

"$(INTDIR)\dskreprt.obj" : $(SOURCE) $(DEP_CPP_DSKREP) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\dskread.c"
DEP_CPP_DSKREA=\
	".\libdsk-1.1.5\lib\drvi.h"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\drv.h"\
	
NODEP_CPP_DSKREA=\
	".\libdsk-1.1.5\lib\linux\fd.h"\
	".\libdsk-1.1.5\lib\linux\fdreg.h"\
	

"$(INTDIR)\dskread.obj" : $(SOURCE) $(DEP_CPP_DSKREA) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\dskpars.c"
DEP_CPP_DSKPA=\
	".\libdsk-1.1.5\lib\drvi.h"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\drv.h"\
	
NODEP_CPP_DSKPA=\
	".\libdsk-1.1.5\lib\linux\fd.h"\
	".\libdsk-1.1.5\lib\linux\fdreg.h"\
	

"$(INTDIR)\dskpars.obj" : $(SOURCE) $(DEP_CPP_DSKPA) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\dskopen.c"
DEP_CPP_DSKOP=\
	".\libdsk-1.1.5\lib\drvi.h"\
	".\libdsk-1.1.5\lib\drivers.h"\
	".\libdsk-1.1.5\lib\compress.h"\
	".\libdsk-1.1.5\lib\drivers.inc"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\drv.h"\
	
NODEP_CPP_DSKOP=\
	".\libdsk-1.1.5\lib\linux\fd.h"\
	".\libdsk-1.1.5\lib\linux\fdreg.h"\
	

"$(INTDIR)\dskopen.obj" : $(SOURCE) $(DEP_CPP_DSKOP) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\dsklphys.c"
DEP_CPP_DSKLP=\
	".\libdsk-1.1.5\lib\drvi.h"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\drv.h"\
	
NODEP_CPP_DSKLP=\
	".\libdsk-1.1.5\lib\linux\fd.h"\
	".\libdsk-1.1.5\lib\linux\fdreg.h"\
	

"$(INTDIR)\dsklphys.obj" : $(SOURCE) $(DEP_CPP_DSKLP) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\dskjni.c"
DEP_CPP_DSKJN=\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\libdsk.h"\
	
NODEP_CPP_DSKJN=\
	".\libdsk-1.1.5\lib\uk_co_demon_seasip_libdsk_LibDsk.h"\
	".\libdsk-1.1.5\lib\uk_co_demon_seasip_libdsk_Drive.h"\
	".\libdsk-1.1.5\lib\uk_co_demon_seasip_libdsk_Geometry.h"\
	".\libdsk-1.1.5\lib\uk_co_demon_seasip_libdsk_FormatType.h"\
	

"$(INTDIR)\dskjni.obj" : $(SOURCE) $(DEP_CPP_DSKJN) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\dskgeom.c"
DEP_CPP_DSKGE=\
	".\libdsk-1.1.5\lib\drvi.h"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\drv.h"\
	
NODEP_CPP_DSKGE=\
	".\libdsk-1.1.5\lib\linux\fd.h"\
	".\libdsk-1.1.5\lib\linux\fdreg.h"\
	

"$(INTDIR)\dskgeom.obj" : $(SOURCE) $(DEP_CPP_DSKGE) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\dskfmt.c"
DEP_CPP_DSKFM=\
	".\libdsk-1.1.5\lib\drvi.h"\
	".\libdsk-1.1.5\lib\compi.h"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\drv.h"\
	".\libdsk-1.1.5\lib\compress.h"\
	
NODEP_CPP_DSKFM=\
	".\libdsk-1.1.5\lib\linux\fd.h"\
	".\libdsk-1.1.5\lib\linux\fdreg.h"\
	

"$(INTDIR)\dskfmt.obj" : $(SOURCE) $(DEP_CPP_DSKFM) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\dskerror.c"
DEP_CPP_DSKER=\
	".\libdsk-1.1.5\lib\drvi.h"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\drv.h"\
	
NODEP_CPP_DSKER=\
	".\libdsk-1.1.5\lib\linux\fd.h"\
	".\libdsk-1.1.5\lib\linux\fdreg.h"\
	

"$(INTDIR)\dskerror.obj" : $(SOURCE) $(DEP_CPP_DSKER) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\dskdirty.c"
DEP_CPP_DSKDI=\
	".\libdsk-1.1.5\lib\drvi.h"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\drv.h"\
	
NODEP_CPP_DSKDI=\
	".\libdsk-1.1.5\lib\linux\fd.h"\
	".\libdsk-1.1.5\lib\linux\fdreg.h"\
	

"$(INTDIR)\dskdirty.obj" : $(SOURCE) $(DEP_CPP_DSKDI) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\dskcmt.c"
DEP_CPP_DSKCM=\
	".\libdsk-1.1.5\lib\drvi.h"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\drv.h"\
	
NODEP_CPP_DSKCM=\
	".\libdsk-1.1.5\lib\linux\fd.h"\
	".\libdsk-1.1.5\lib\linux\fdreg.h"\
	

"$(INTDIR)\dskcmt.obj" : $(SOURCE) $(DEP_CPP_DSKCM) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\dskcheck.c"
DEP_CPP_DSKCH=\
	".\libdsk-1.1.5\lib\drvi.h"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\drv.h"\
	
NODEP_CPP_DSKCH=\
	".\libdsk-1.1.5\lib\linux\fd.h"\
	".\libdsk-1.1.5\lib\linux\fdreg.h"\
	

"$(INTDIR)\dskcheck.obj" : $(SOURCE) $(DEP_CPP_DSKCH) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\drvwin32.c"
DEP_CPP_DRVWI=\
	".\libdsk-1.1.5\lib\drvi.h"\
	".\libdsk-1.1.5\lib\drvwin32.h"\
	".\libdsk-1.1.5\lib\rpcfuncs.h"\
	".\libdsk-1.1.5\lib\w95defs.h"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\drv.h"\
	
NODEP_CPP_DRVWI=\
	".\libdsk-1.1.5\lib\linux\fd.h"\
	".\libdsk-1.1.5\lib\linux\fdreg.h"\
	

"$(INTDIR)\drvwin32.obj" : $(SOURCE) $(DEP_CPP_DRVWI) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\drvwin16.c"
DEP_CPP_DRVWIN=\
	".\libdsk-1.1.5\lib\drvi.h"\
	".\libdsk-1.1.5\lib\drvwin16.h"\
	".\libdsk-1.1.5\lib\w16defs.h"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\drv.h"\
	
NODEP_CPP_DRVWIN=\
	".\libdsk-1.1.5\lib\linux\fd.h"\
	".\libdsk-1.1.5\lib\linux\fdreg.h"\
	

"$(INTDIR)\drvwin16.obj" : $(SOURCE) $(DEP_CPP_DRVWIN) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\drvrcpm.c"
DEP_CPP_DRVRC=\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\drvi.h"\
	".\libdsk-1.1.5\lib\drvrcpm.h"\
	{$(INCLUDE)}"\sys\TYPES.H"\
	{$(INCLUDE)}"\sys\STAT.H"\
	{$(INCLUDE)}"\sys\UTIME.H"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\drv.h"\
	
NODEP_CPP_DRVRC=\
	".\libdsk-1.1.5\lib\linux\fd.h"\
	".\libdsk-1.1.5\lib\linux\fdreg.h"\
	

"$(INTDIR)\drvrcpm.obj" : $(SOURCE) $(DEP_CPP_DRVRC) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\drvqm.c"
DEP_CPP_DRVQM=\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\drvi.h"\
	".\libdsk-1.1.5\lib\drvqm.h"\
	".\libdsk-1.1.5\lib\crctable.h"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\drv.h"\
	
NODEP_CPP_DRVQM=\
	".\libdsk-1.1.5\lib\linux\fd.h"\
	".\libdsk-1.1.5\lib\linux\fdreg.h"\
	

"$(INTDIR)\drvqm.obj" : $(SOURCE) $(DEP_CPP_DRVQM) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\drvposix.c"
DEP_CPP_DRVPO=\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\drvi.h"\
	".\libdsk-1.1.5\lib\drvposix.h"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\drv.h"\
	
NODEP_CPP_DRVPO=\
	".\libdsk-1.1.5\lib\linux\fd.h"\
	".\libdsk-1.1.5\lib\linux\fdreg.h"\
	

"$(INTDIR)\drvposix.obj" : $(SOURCE) $(DEP_CPP_DRVPO) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\drvnwasp.c"
DEP_CPP_DRVNW=\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\drvi.h"\
	".\libdsk-1.1.5\lib\drvnwasp.h"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\drv.h"\
	
NODEP_CPP_DRVNW=\
	".\libdsk-1.1.5\lib\linux\fd.h"\
	".\libdsk-1.1.5\lib\linux\fdreg.h"\
	

"$(INTDIR)\drvnwasp.obj" : $(SOURCE) $(DEP_CPP_DRVNW) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\drvntwdm.c"
DEP_CPP_DRVNT=\
	".\libdsk-1.1.5\lib\drvi.h"\
	".\libdsk-1.1.5\lib\drvntwdm.h"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\drv.h"\
	
NODEP_CPP_DRVNT=\
	".\libdsk-1.1.5\lib\linux\fd.h"\
	".\libdsk-1.1.5\lib\linux\fdreg.h"\
	

"$(INTDIR)\drvntwdm.obj" : $(SOURCE) $(DEP_CPP_DRVNT) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\drvmyz80.c"
DEP_CPP_DRVMY=\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\drvi.h"\
	".\libdsk-1.1.5\lib\drvmyz80.h"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\drv.h"\
	
NODEP_CPP_DRVMY=\
	".\libdsk-1.1.5\lib\linux\fd.h"\
	".\libdsk-1.1.5\lib\linux\fdreg.h"\
	

"$(INTDIR)\drvmyz80.obj" : $(SOURCE) $(DEP_CPP_DRVMY) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\drvlinux.c"
DEP_CPP_DRVLI=\
	".\libdsk-1.1.5\lib\drvi.h"\
	".\libdsk-1.1.5\lib\drvlinux.h"\
	{$(INCLUDE)}"\sys\STAT.H"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\drv.h"\
	{$(INCLUDE)}"\sys\TYPES.H"\
	
NODEP_CPP_DRVLI=\
	".\libdsk-1.1.5\lib\linux\fd.h"\
	".\libdsk-1.1.5\lib\linux\fdreg.h"\
	

"$(INTDIR)\drvlinux.obj" : $(SOURCE) $(DEP_CPP_DRVLI) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\drvdos32.c"
DEP_CPP_DRVDO=\
	".\libdsk-1.1.5\lib\drvi.h"\
	".\libdsk-1.1.5\lib\drvdos32.h"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\drv.h"\
	
NODEP_CPP_DRVDO=\
	".\libdsk-1.1.5\lib\linux\fd.h"\
	".\libdsk-1.1.5\lib\linux\fdreg.h"\
	

"$(INTDIR)\drvdos32.obj" : $(SOURCE) $(DEP_CPP_DRVDO) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\drvdos16.c"
DEP_CPP_DRVDOS=\
	".\libdsk-1.1.5\lib\drvi.h"\
	".\libdsk-1.1.5\lib\drvdos16.h"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\drv.h"\
	
NODEP_CPP_DRVDOS=\
	".\libdsk-1.1.5\lib\linux\fd.h"\
	".\libdsk-1.1.5\lib\linux\fdreg.h"\
	

"$(INTDIR)\drvdos16.obj" : $(SOURCE) $(DEP_CPP_DRVDOS) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\drvcpcem.c"
DEP_CPP_DRVCP=\
	".\libdsk-1.1.5\lib\drvi.h"\
	".\libdsk-1.1.5\lib\drvcpcem.h"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\drv.h"\
	
NODEP_CPP_DRVCP=\
	".\libdsk-1.1.5\lib\linux\fd.h"\
	".\libdsk-1.1.5\lib\linux\fdreg.h"\
	

"$(INTDIR)\drvcpcem.obj" : $(SOURCE) $(DEP_CPP_DRVCP) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\drvcfi.c"
DEP_CPP_DRVCF=\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\drvi.h"\
	".\libdsk-1.1.5\lib\drvcfi.h"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\drv.h"\
	
NODEP_CPP_DRVCF=\
	".\libdsk-1.1.5\lib\linux\fd.h"\
	".\libdsk-1.1.5\lib\linux\fdreg.h"\
	

"$(INTDIR)\drvcfi.obj" : $(SOURCE) $(DEP_CPP_DRVCF) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\drvadisk.c"
DEP_CPP_DRVAD=\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\drvi.h"\
	".\libdsk-1.1.5\lib\drvadisk.h"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\drv.h"\
	
NODEP_CPP_DRVAD=\
	".\libdsk-1.1.5\lib\linux\fd.h"\
	".\libdsk-1.1.5\lib\linux\fdreg.h"\
	

"$(INTDIR)\drvadisk.obj" : $(SOURCE) $(DEP_CPP_DRVAD) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\crctable.c"

"$(INTDIR)\crctable.obj" : $(SOURCE) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\crc16.c"
DEP_CPP_CRC16=\
	".\libdsk-1.1.5\lib\crc16.h"\
	

"$(INTDIR)\crc16.obj" : $(SOURCE) $(DEP_CPP_CRC16) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\compsq.c"
DEP_CPP_COMPS=\
	".\libdsk-1.1.5\lib\compi.h"\
	".\libdsk-1.1.5\lib\compsq.h"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\compress.h"\
	

"$(INTDIR)\compsq.obj" : $(SOURCE) $(DEP_CPP_COMPS) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\compress.c"
DEP_CPP_COMPR=\
	".\libdsk-1.1.5\lib\drvi.h"\
	".\libdsk-1.1.5\lib\compi.h"\
	".\libdsk-1.1.5\lib\comp.h"\
	{$(INCLUDE)}"\sys\STAT.H"\
	".\libdsk-1.1.5\lib\compress.inc"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\drv.h"\
	".\libdsk-1.1.5\lib\compress.h"\
	".\libdsk-1.1.5\lib\compsq.h"\
	".\libdsk-1.1.5\lib\compgz.h"\
	".\libdsk-1.1.5\lib\compbz2.h"\
	{$(INCLUDE)}"\sys\TYPES.H"\
	
NODEP_CPP_COMPR=\
	".\libdsk-1.1.5\lib\linux\fd.h"\
	".\libdsk-1.1.5\lib\linux\fdreg.h"\
	

"$(INTDIR)\compress.obj" : $(SOURCE) $(DEP_CPP_COMPR) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\compgz.c"
DEP_CPP_COMPG=\
	".\libdsk-1.1.5\lib\compi.h"\
	".\libdsk-1.1.5\lib\compgz.h"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\compress.h"\
	

"$(INTDIR)\compgz.obj" : $(SOURCE) $(DEP_CPP_COMPG) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\compbz2.c"
DEP_CPP_COMPB=\
	".\libdsk-1.1.5\lib\compi.h"\
	".\libdsk-1.1.5\lib\compbz2.h"\
	".\libdsk-1.1.5\lib\config.h"\
	".\libdsk-1.1.5\lib\libdsk.h"\
	".\libdsk-1.1.5\lib\compress.h"\
	

"$(INTDIR)\compbz2.obj" : $(SOURCE) $(DEP_CPP_COMPB) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=".\libdsk-1.1.5\lib\error.c"
DEP_CPP_ERROR=\
	".\libdsk-1.1.5\lib\765.h"\
	

"$(INTDIR)\error.obj" : $(SOURCE) $(DEP_CPP_ERROR) "$(INTDIR)"
   $(CPP) $(CPP_PROJ) $(SOURCE)


# End Source File
################################################################################
# Begin Source File

SOURCE=.\PaleSound.cpp
DEP_CPP_PALES=\
	{$(INCLUDE)}"\sys\TYPES.H"\
	{$(INCLUDE)}"\sys\STAT.H"\
	".\Z80.h"\
	".\libdsk.h"\
	".\Z80Dasm.h"\
	".\SoundServer.h"\
	".\palesound.h"\
	".\Paledisk.h"\
	".\PaleIO.h"\
	".\PaleMEM.h"\
	".\PaleUTILS.h"\
	".\Pale.h"\
	".\PaleVID.h"\
	".\PalePRINTER.h"\
	".\PaleTAPS.h"\
	".\PaleROM.h"\
	".\Z80IO.h"\
	

"$(INTDIR)\PaleSound.obj" : $(SOURCE) $(DEP_CPP_PALES) "$(INTDIR)"


# End Source File
################################################################################
# Begin Source File

SOURCE=.\Paledisk.cpp

!IF  "$(CFG)" == "paledll - Win32 Release"

DEP_CPP_PALED=\
	{$(INCLUDE)}"\sys\TYPES.H"\
	{$(INCLUDE)}"\sys\STAT.H"\
	".\Z80.h"\
	".\libdsk.h"\
	".\Z80Dasm.h"\
	".\palesound.h"\
	".\Paledisk.h"\
	".\PaleIO.h"\
	".\PaleMEM.h"\
	".\PaleUTILS.h"\
	".\Pale.h"\
	".\PaleVID.h"\
	".\PalePRINTER.h"\
	".\PaleTAPS.h"\
	".\PaleROM.h"\
	".\Z80IO.h"\
	
NODEP_CPP_PALED=\
	".\}"\
	".\DOUBLESTEP"\
	

"$(INTDIR)\Paledisk.obj" : $(SOURCE) $(DEP_CPP_PALED) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "paledll - Win32 Debug"

DEP_CPP_PALED=\
	{$(INCLUDE)}"\sys\TYPES.H"\
	{$(INCLUDE)}"\sys\STAT.H"\
	".\Z80.h"\
	".\libdsk.h"\
	".\Z80Dasm.h"\
	".\palesound.h"\
	".\Paledisk.h"\
	".\PaleIO.h"\
	".\PaleMEM.h"\
	".\PaleUTILS.h"\
	".\Pale.h"\
	".\PaleVID.h"\
	".\PalePRINTER.h"\
	".\PaleTAPS.h"\
	".\PaleROM.h"\
	".\Z80IO.h"\
	

"$(INTDIR)\Paledisk.obj" : $(SOURCE) $(DEP_CPP_PALED) "$(INTDIR)"


!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\PaleIO.cpp

!IF  "$(CFG)" == "paledll - Win32 Release"

DEP_CPP_PALEI=\
	{$(INCLUDE)}"\sys\TYPES.H"\
	{$(INCLUDE)}"\sys\STAT.H"\
	".\Z80.h"\
	".\libdsk.h"\
	".\Paledisk.h"\
	".\Pale.h"\
	".\PaleIO.h"\
	".\PaleVID.h"\
	".\PalePRINTER.h"\
	".\PaleMEM.h"\
	".\PaleTAPS.h"\
	".\PaleUTILS.h"\
	".\IOPort.h"\
	".\Z80IO.h"\
	
NODEP_CPP_PALEI=\
	".\}"\
	

"$(INTDIR)\PaleIO.obj" : $(SOURCE) $(DEP_CPP_PALEI) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "paledll - Win32 Debug"

DEP_CPP_PALEI=\
	{$(INCLUDE)}"\sys\TYPES.H"\
	{$(INCLUDE)}"\sys\STAT.H"\
	".\Z80.h"\
	".\libdsk.h"\
	".\Paledisk.h"\
	".\Pale.h"\
	".\PaleIO.h"\
	".\PaleVID.h"\
	".\PalePRINTER.h"\
	".\PaleMEM.h"\
	".\PaleTAPS.h"\
	".\PaleUTILS.h"\
	".\IOPort.h"\
	".\Z80IO.h"\
	

"$(INTDIR)\PaleIO.obj" : $(SOURCE) $(DEP_CPP_PALEI) "$(INTDIR)"


!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\PalePRINTER.cpp
DEP_CPP_PALEP=\
	{$(INCLUDE)}"\sys\TYPES.H"\
	{$(INCLUDE)}"\sys\STAT.H"\
	".\Z80.h"\
	".\libdsk.h"\
	".\Paledisk.h"\
	".\Pale.h"\
	".\PaleIO.h"\
	".\PaleVID.h"\
	".\PalePRINTER.h"\
	".\IOPort.h"\
	".\Z80IO.h"\
	

"$(INTDIR)\PalePRINTER.obj" : $(SOURCE) $(DEP_CPP_PALEP) "$(INTDIR)"


# End Source File
################################################################################
# Begin Source File

SOURCE=.\PaleVID.cpp

!IF  "$(CFG)" == "paledll - Win32 Release"

DEP_CPP_PALEV=\
	{$(INCLUDE)}"\sys\TYPES.H"\
	{$(INCLUDE)}"\sys\STAT.H"\
	".\Z80.h"\
	".\libdsk.h"\
	".\Z80Dasm.h"\
	".\palesound.h"\
	".\Paledisk.h"\
	".\PaleIO.h"\
	".\PaleMEM.h"\
	".\PaleUTILS.h"\
	".\Pale.h"\
	".\PaleVID.h"\
	".\PalePRINTER.h"\
	".\Z80IO.h"\
	
NODEP_CPP_PALEV=\
	".\start_im1_irq=0;"\
	

"$(INTDIR)\PaleVID.obj" : $(SOURCE) $(DEP_CPP_PALEV) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "paledll - Win32 Debug"

DEP_CPP_PALEV=\
	{$(INCLUDE)}"\sys\TYPES.H"\
	{$(INCLUDE)}"\sys\STAT.H"\
	".\Z80.h"\
	".\libdsk.h"\
	".\Z80Dasm.h"\
	".\palesound.h"\
	".\Paledisk.h"\
	".\PaleIO.h"\
	".\PaleMEM.h"\
	".\PaleUTILS.h"\
	".\Pale.h"\
	".\PaleVID.h"\
	".\PalePRINTER.h"\
	".\Z80IO.h"\
	

"$(INTDIR)\PaleVID.obj" : $(SOURCE) $(DEP_CPP_PALEV) "$(INTDIR)"


!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\PaleUTILS.cpp
DEP_CPP_PALEU=\
	{$(INCLUDE)}"\sys\TYPES.H"\
	{$(INCLUDE)}"\sys\STAT.H"\
	".\Z80.h"\
	".\libdsk.h"\
	".\Z80Dasm.h"\
	".\palesound.h"\
	".\Paledisk.h"\
	".\PaleIO.h"\
	".\PaleMEM.h"\
	".\PaleUTILS.h"\
	".\Pale.h"\
	".\PaleVID.h"\
	".\PalePRINTER.h"\
	".\PaleTAPS.h"\
	".\PaleROM.h"\
	".\Z80IO.h"\
	

"$(INTDIR)\PaleUTILS.obj" : $(SOURCE) $(DEP_CPP_PALEU) "$(INTDIR)"


# End Source File
################################################################################
# Begin Source File

SOURCE=.\PaleMEM.cpp

!IF  "$(CFG)" == "paledll - Win32 Release"

DEP_CPP_PALEM=\
	{$(INCLUDE)}"\sys\TYPES.H"\
	{$(INCLUDE)}"\sys\STAT.H"\
	".\Z80.h"\
	".\libdsk.h"\
	".\Paledisk.h"\
	".\Pale.h"\
	".\PaleIO.h"\
	".\PaleVID.h"\
	".\PalePRINTER.h"\
	".\PaleMEM.h"\
	".\Z80IO.h"\
	
NODEP_CPP_PALEM=\
	".\ byte vid_mem[262144];"\
	

"$(INTDIR)\PaleMEM.obj" : $(SOURCE) $(DEP_CPP_PALEM) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "paledll - Win32 Debug"

DEP_CPP_PALEM=\
	{$(INCLUDE)}"\sys\TYPES.H"\
	{$(INCLUDE)}"\sys\STAT.H"\
	".\Z80.h"\
	".\libdsk.h"\
	".\Paledisk.h"\
	".\Pale.h"\
	".\PaleIO.h"\
	".\PaleVID.h"\
	".\PalePRINTER.h"\
	".\PaleMEM.h"\
	".\Z80IO.h"\
	

"$(INTDIR)\PaleMEM.obj" : $(SOURCE) $(DEP_CPP_PALEM) "$(INTDIR)"


!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\PaleROM.cpp

!IF  "$(CFG)" == "paledll - Win32 Release"

DEP_CPP_PALER=\
	{$(INCLUDE)}"\sys\TYPES.H"\
	{$(INCLUDE)}"\sys\STAT.H"\
	".\Z80.h"\
	".\libdsk.h"\
	".\Z80Dasm.h"\
	".\palesound.h"\
	".\Paledisk.h"\
	".\PaleIO.h"\
	".\PaleMEM.h"\
	".\PaleUTILS.h"\
	".\Pale.h"\
	".\PaleVID.h"\
	".\PalePRINTER.h"\
	".\PaleTAPS.h"\
	".\PaleROM.h"\
	".\Z80IO.h"\
	
NODEP_CPP_PALER=\
	".\{"\
	".\else"\
	

"$(INTDIR)\PaleROM.obj" : $(SOURCE) $(DEP_CPP_PALER) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "paledll - Win32 Debug"

DEP_CPP_PALER=\
	{$(INCLUDE)}"\sys\TYPES.H"\
	{$(INCLUDE)}"\sys\STAT.H"\
	".\Z80.h"\
	".\libdsk.h"\
	".\Z80Dasm.h"\
	".\palesound.h"\
	".\Paledisk.h"\
	".\PaleIO.h"\
	".\PaleMEM.h"\
	".\PaleUTILS.h"\
	".\Pale.h"\
	".\PaleVID.h"\
	".\PalePRINTER.h"\
	".\PaleTAPS.h"\
	".\PaleROM.h"\
	".\Z80IO.h"\
	

"$(INTDIR)\PaleROM.obj" : $(SOURCE) $(DEP_CPP_PALER) "$(INTDIR)"


!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\PaleTAPS.cpp

!IF  "$(CFG)" == "paledll - Win32 Release"

DEP_CPP_PALET=\
	{$(INCLUDE)}"\sys\TYPES.H"\
	{$(INCLUDE)}"\sys\STAT.H"\
	".\Z80.h"\
	".\libdsk.h"\
	".\Z80Dasm.h"\
	".\palesound.h"\
	".\Paledisk.h"\
	".\PaleIO.h"\
	".\PaleMEM.h"\
	".\PaleUTILS.h"\
	".\Pale.h"\
	".\PaleVID.h"\
	".\PalePRINTER.h"\
	".\PaleTAPS.h"\
	".\PaleROM.h"\
	".\Z80IO.h"\
	
NODEP_CPP_PALET=\
	".\set_tape_spd_adjust"\
	

"$(INTDIR)\PaleTAPS.obj" : $(SOURCE) $(DEP_CPP_PALET) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "paledll - Win32 Debug"

DEP_CPP_PALET=\
	{$(INCLUDE)}"\sys\TYPES.H"\
	{$(INCLUDE)}"\sys\STAT.H"\
	".\Z80.h"\
	".\libdsk.h"\
	".\Z80Dasm.h"\
	".\palesound.h"\
	".\Paledisk.h"\
	".\PaleIO.h"\
	".\PaleMEM.h"\
	".\PaleUTILS.h"\
	".\Pale.h"\
	".\PaleVID.h"\
	".\PalePRINTER.h"\
	".\PaleTAPS.h"\
	".\PaleROM.h"\
	".\Z80IO.h"\
	

"$(INTDIR)\PaleTAPS.obj" : $(SOURCE) $(DEP_CPP_PALET) "$(INTDIR)"


!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\PaleKEYB.cpp

!IF  "$(CFG)" == "paledll - Win32 Release"

DEP_CPP_PALEK=\
	{$(INCLUDE)}"\sys\TYPES.H"\
	{$(INCLUDE)}"\sys\STAT.H"\
	".\Z80.h"\
	".\libdsk.h"\
	".\Z80Dasm.h"\
	".\palesound.h"\
	".\Paledisk.h"\
	".\PaleIO.h"\
	".\PaleMEM.h"\
	".\PaleUTILS.h"\
	".\Pale.h"\
	".\PaleVID.h"\
	".\PalePRINTER.h"\
	".\PaleTAPS.h"\
	".\PaleROM.h"\
	".\Z80IO.h"\
	
NODEP_CPP_PALEK=\
	".\;"\
	

"$(INTDIR)\PaleKEYB.obj" : $(SOURCE) $(DEP_CPP_PALEK) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "paledll - Win32 Debug"

DEP_CPP_PALEK=\
	{$(INCLUDE)}"\sys\TYPES.H"\
	{$(INCLUDE)}"\sys\STAT.H"\
	".\Z80.h"\
	".\libdsk.h"\
	".\Z80Dasm.h"\
	".\palesound.h"\
	".\Paledisk.h"\
	".\PaleIO.h"\
	".\PaleMEM.h"\
	".\PaleUTILS.h"\
	".\Pale.h"\
	".\PaleVID.h"\
	".\PalePRINTER.h"\
	".\PaleTAPS.h"\
	".\PaleROM.h"\
	".\Z80IO.h"\
	

"$(INTDIR)\PaleKEYB.obj" : $(SOURCE) $(DEP_CPP_PALEK) "$(INTDIR)"


!ENDIF 

# End Source File
################################################################################
# Begin Source File

SOURCE=.\IOPort.c

!IF  "$(CFG)" == "paledll - Win32 Release"

NODEP_CPP_IOPOR=\
	".\StartUpIoPorts(UINT PortToAccess, BOOL bShowMessageBox, HWND hParentWnd)"\
	

"$(INTDIR)\IOPort.obj" : $(SOURCE) "$(INTDIR)"


!ELSEIF  "$(CFG)" == "paledll - Win32 Debug"


"$(INTDIR)\IOPort.obj" : $(SOURCE) "$(INTDIR)"


!ENDIF 

# End Source File
# End Target
# End Project
################################################################################
