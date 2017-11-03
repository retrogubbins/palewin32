

P A L E

Pete's Lynx Emulator

22 July 2005

*** NEW ***

1. Lynx 96 & 128 LynxDOS Modes - YaaaaaaaaaYYY!!!
2. Provisional Printer Support
3. Improved Timing Routines
4. Autorun TAPs by clicking
5. PaleTape Tape Converter now in the GUI, with new Autosense routines
6. Even Better Bank switching accuracy
7. More haXx0r options for singlestepping, trace dump etc.
9. Improved speed (upto 40% faster) due to better video routines
10. Built-in ROM builder for managing different ROM setups



Loading
=======

To load just normal basic or machine code programs use the LOAD
and MLOAD buttons, they actually type the LOAD"" at the prompt
so you don't have to type it in - cool.

If you need to load in a program (or binary file) directly
(for example as part of a multiple load program such as the demo
programs which already type the LOAD"" for you - use the small
buttons marked 'S' to the left of the main LOAD MLOAD buttons.
These buttons don't type the command.


Keyboard
========

I left the keyboard mapping as per the original(ish),
in the future I'll probably put an option in to give a more
meaningful layout. Still to be done. Gnnaaarr, brackets on the 8
key... tricky...


Sound
=====

Sound is probably the weakest part of the emu so far. I've messed
about with it a lot but due to the way the top level stuff works
its a bit problematic getting anything decent. Next version
should be a lot better. *UPDATE* a slight improvement in the
sound for this revision, in particular there's an option to play
actual Lynx sounds in the background. I saw the effect on the brilliant
emulator 'Vector Dreams' and had to put it in. In between the 
hash of programs on my old tapes there were the sounds of the Lynx
in 'idle' mode, with that characteristic 'snickety-snick' sound
when any video updates were done. I fiddled about with the recordings
until I got a sample that looped, some of the 'video' sound is mixed
in (badly) whenever there's video writes. 

And hey presto... instant grins :)


AutoSpeed
=========

Is NO MORE - I got rid of the whole sorry mess, and in its place is a
locked z80 clock which brings much smoother action all round,
and improves the sound as a side effect :)


Instructions for loading Level 9 Adventures
===========================================

Loading the Level9 adventures are a bit tricky. Basically they consist
of 5 tape files:-

1 Basic welcome screen which loads up
2 The MC Binary loader which loads the next three files and transfers
them to the screen banks (have a look in the memory map window!)
3, 4 & 5  The adventure data (headerless tape blocks)

As the last three blocks are headerless I wrote a special
loader for these adventures.

To load the level9 adventure:

Reset the Emulator (48k or 96k it won't work on the 128)
Click on LOAD BASIC
Choose 'ADVENT'
(It should load the first Welcome Screen BASIC program)

*  at this point the lynx is waiting for the next tape block,
*  as it's effectively already started the load you should
*  NOT use the LOAD or MLOAD buttons as they type the command.

Click on the 'S' MLOAD BINARY  (the little button) 
Choose 'ADVENT2'

(this loads the adventure loader - you wont notice anything happening)

*  again, at this point it's waiting for the first of the data files
*  rather than have you load each of them individually I've lumped 
*  all three loads together into the one button, aren't I nice.

Click on LOAD LEVEL9
Choose 'ADVENT'

(the special loader will automatically load the ADVENT3, 4 & 5 files)

it should start running now, the new bank switch emulation
is given a good test here due to the wierd memory layout. The screen
shows the adventure code while its 'thinking' and clears when
its waiting for input.

Getting this game to run was a right ******


Known issues
============

1. Sound support needs more work - just smoother would do

2. Saving only works from the actual lynx SAVE"FILENAME" command
saving BINARY data is not supported yet. As a workaround you
can use the memory dump option and then rip the required Binary
directly from the RAM/ROM banks. You could then use the Z80->TAP
converter within Pale to recreate a usuable .TAP image

3. Fullscreen needs tweaking - there's still a silly bug in there

4. 'Background Z80 Noise' missing - heh, not any more...

5. 6845 registers not implemented (fully) (still) - no shaking
ground in 'Air Raid'
*UPDATE* that ground is now shaking.  aaaarrrrgghhhhh!!!!!!!
**UPDATE** and STAR ROVER is now scrolling beautifully, it's
a much more playable game at 400% speed.


Unknown Issues
=============

Any bug reports, hints, suggestions, will be gratefully received.

<plead>
If you use the tape reading program and get some
progs back then send me a copy of the TAP file.
This emulator was written without the
benefit of having a Lynx, with only Camsofts 'Power Blaster'
and the Level 9 'Dungeon Adventure', the DEMO
tape courtesy of Paul Robson's CamLynx and some 
homegrown stuff of my own off some very cruddy tapes (the
level 9 game seems to have picked up some wonderful
phrases in the read off the tape).

In order to test and improve this emulator I need MORE
software. Any help here would be much appreciated, go on
I've even included a tape reader and email is cheap :))
</plead>

*UPDATE*

Received with many thanks PENGO and COMPAS ASSEMBLER
from Martyn Smith :)

And from John Roberts a treasure trove of software, including
all the Level 9s and (thanks to some hard work by John) some scans of
all the literature.

You can email me the raw recording if you want and I'll convert them
here.



Legal
=====

I've included the ROMs and software for this computer
because I can't think of anywhere else you'd get them
and to be honest I hope the people that originally wrote this
stuff are okay with it, any feedback from them is
welcome, if anybody has a problem with the stuff
being here then of course I'll apologise and remove it.

Personal Note
=============

My special thanks to everyone concerned with bringing
us the Lynx, it's a strange micro but one which
enjoys a certain cult status in UK micro history.

It was, for me, the perfect move from the ZX81, where the
smoothies went off onto the spectrum scene, the hXxr0s
stayed on the '81 and went deeper into its innards
than anyone in 1981 would have dreamed possible.

The Lynx had without a doubt the most impressive graphics
available for an 8-bit in 1984. I took one look at the
piss poor 2!!! colour graphics on the spectrum and thought
there's no way you could ever come up with anything 
seriously decent looking using systems like that.

The lynx is a breeze graphically, a nice set of graphics
methods and a powerful bank switched architecture
which allowed a variety of h4x.

The one problem which of course everyone noticed straight
away was the speed. It... was... slooooooowwwww....
There are multiple bank reads/writes required to access
all of the screen memory and the lynx doesn't have any
'cycle stealing' like on the Beeb. As a result anything
requiring screen access takes forever. The Beeb has one
of the fastest screens (and BASICs) on any 8-bit, but
its 3-bit colour modes look like something off an Atari from
the 70's. With the Lynx you get just the one screen mode...
but it's a good un'

For non-Lynx people I should say that there are a few
things that can be done to speed up the display. For
a start writing to fewer colour banks speeds things up 
and the lynx allows you to mask off the banks that you don't want
updated. In the TEXT mode only one bank (green) is written to
and there is a 3 fold increase in the listing speed.
(A standard test on the Lynx is to enter the monitor with MON
and then type H (return) to list out the memory dump of the 
ROM. J (return) exits back to the BASIC prompt.
As far as I'm aware the monitor in the Lynx is the last in
any home microcomputer, and possibly the last built in
to any computer sold since.

The provision of the monitor, and floating point line numbers
are two of the oddities about the Lynx which make it unique
among the soulless wedges that were coming out at the time.

I've come across several schemes for 'fast display modes', 
most of which use interrupts to write bytes to the video ram
in the blanking intervals, by using the native 6845 modes
the speed increase is dramatic. Back in '85 I managed to combine
one of these modes with a 64 column character set modification
and scroll routine. It made using the Lynx a lot easier.

And listing programs in it looks like 'tHe mAtRiX'  :)

To get an idea, boot up 128 mode and use the FTEXT mode
which has significantly more speed. The character set on the 
Lynx is quite distinctive, and very retro.

The Camputers Lynx was a unique computer.


Cheers,

Pete

heraclion@btopenworld.com

