# logkeys - a GNU/Linux keylogger

logkeys is a linux keylogger.  It is no more advanced than other available linux
keyloggers, notably lkl and uberkey, but is a bit newer, more up to date, it
doesn't unreliably repeat keys and it shouldn't crash your X. All in all, it
just seems to work. It relies on event interface of the Linux input subsystem. 
Once completely set, it logs all common character and function keys, while also
being fully aware of Shift and AltGr key modifiers.


## Installation

Provided your GNU/Linux distribution doesn't include logkeys package in its
repositories, manual installation of logkeys from source is as easy as:

    $ tar xvzf logkeys-0.1.1.tar.gz      # to extract the logkeys archive
 
    $ cd logkeys-0.1.1/build     # move to build directory to build there
    $ ../configure               # invoke configure from parent directory
    $ make                       # make compiles what it needs to compile
    ( become superuser now )     # you need root to install in system dir
    # make install               # installs binaries, manuals and scripts

That's it.

To ever uninstall logkeys, remove accompanying scripts and manuals, issue

    # make uninstall    # in the same logkeys-0.1.1/build dir from before

A copy of these instructions is in the accompanying INSTALL file.


## Usage how-to

logkeys is simple. You can either invoke it directly, by typing full command 
line, or use the provided scripts. There are two helper programs in this 
package:

- bin/llk, which is intended to start the logkeys daemon, and
- bin/llkk, which is intended to kill it.
 
bin/llk runs etc/logkeys-start.sh, and bin/llkk runs etc/logkeys-kill.sh.

You can use these two setuid root programs (llk and llkk) for starting and
stopping the keylogger quickly and covertly. You can modify the .sh scripts as
you like. As the two programs are installed with setuid bit set, the root
password need not be provided at their runtime.

Default log file is `/var/log/logkeys.log` and is not readable by others.

I suggest you first test the program manually with

    $ touch test.log
    $ logkeys --start --output test.log

and in the other terminal follow it with

    $ tail --follow test.log

and see if the pressed keys match to those noted. If you use a US keyboard
layout, use -u switch. Make sure your terminal character locale is set to UTF-8

    $ locale
    LANG=xx_YY.UTF-8
    LC_CTYPE="xx_YY.UTF-8"
    ...

or alternatively, you need en_US.UTF-8 locale available on your system

    $ locale -a
    ...
    en_US.UTF-8
    ...

otherwise you may only see odd characters (like ꑶ etc.) when pressing character
keys.

logkeys acts as a daemon, and you stop the running logger process with
`$ logkeys --kill`, or use the `bin/llkk` script.

For more information about logkeys log file format, logkeys keymap
format, and command line arguments, read the application manual, `$
man logkeys`, or see the wiki at project website:
http://code.google.com/p/logkeys/

Abuse the output of this software wisely.


## Troubleshooting

### empty log file or 'Error opening input event device'

After you run logkeys successfully, if you open the log file and see only the
'Logging started...' and 'Logging stopped...' tag without any keypress
"contents," it is very likely that logkeys got your device id wrong.

This may also apply if you get the following error: `Error opening
input event device '/dev/input/event-1'`

The solution is to determine the correct event device id, and then run 
logkeys with --device (-d) switch, specifying that device manually.

The procedure for manually learning the device id to use is as follows:

As root, for each existing device eventX in /dev/input/, where X is a number
between 0 and 31 inclusively, write:

    $ cat /dev/input/eventX

then type some arbitrary characters. If you see any output, that is the device
to be used. If you don't see any output, press Ctrl+C and continue with the
next device.

If this happened to be your issue, *please* submit a bug report, attaching
your `/proc/bus/input/devices` file as well as and specifying which was the
correct id.


### logkeys outputs wrong characters

It is very likely that you will see only some characters recognized, without
any hope for Shift and AltGr working even slightly correct, especially when
starting logkeys in X. In that case it is better to switch to virtual 
terminal, e.g. tty4 (Ctrl+Alt+F4), and there execute:

    $ logkeys --export-keymap my_lang.keymap

Then open my_lang.keymap in UTF-8 enabled text editor and manually repair any
missing or incorrectly determined mappings. From then on, execute logkeys by

    $ logkeys --start --keymap my_lang.keymap

Again, see if it now works correctly (character keys appear correct when you
are viewing the log file in editor), and opt to modify bin/llk starter script.

If you create full and completely valid keymap for your particular language,
please upload it to website or send it to me by e-mail. Thanks.


## Further information

Read the man page. Please read the whole man page. Thanks. :-)

Refer to troubleshooting and FAQ sections on the project website,
http://code.google.com/p/logkeys/, for currently known issues, ways to
resolve them, and any other information.

Report any bugs and request reasonable features on the issues list
page http://code.google.com/p/logkeys/issues.  When opening new
issues, always provide descriptively keyworded summary and
description.

You are more than welcome to implement unreasonable features yourself, as well
as hack the program to your liking.

If you are a pr0, please answer the few questions commented in the source.
Thanks.

## Licence

logkeys is dual licensed under the terms of either GNU GPLv3 or later, or
WTFPLv2 or later. It is entirely your choice! See COPYING for further
information about licensing.
