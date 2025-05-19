# Beta 2.0 features:

## Boot selector

### Support for up to 12 devices

Any folder placed at the root with a name from this list:

hdd
hdd1
hdd2
hdd3

usb
usb1
usb2
usb3

fdd
fdd1
fdd2
fdd3

## Easy-to-configure device data system

### Two files, osinf.txt and deviceinfo.txt are all you need to configure a drive.

If You need a bootable drive, simply insert this into osinf.txt:

`enabled=1`
`bootdir=%_root%\%bootdev%`
`bootfile=start.bat`

And just insert `exit /b` into start.bat at the root of Your drive.

The important file is deviceinfo.txt. It contains at the very least:

`DEVNAME *Device name with quotes*`
`DEVTYPE *Device category without spaces in it*`
`DEVNUM *The number of the device from 1-12*` - We will automate this in Beta 2.
`DEVLIB *The directory relative to the root at which the device is located*` - We will automate this too.

And You can insert more device-specific information that will all be set as environment variables by the BIOS.

## Graphical, but keyboard-controlled BIOS

### Packed full window-style error messages to warn you, if You've done something wrong.

ANSI escape sequences make it much easier to create multi-color graphical interfaces.

## Easy-to-use disk manager, DU

### Although we do not offer a file manager, since this is not an "OS imitator", we can only offer a worse fdisk.

Scream loud to get help! (Or read me.)

## Various launch options, including launch time selection of a boot device!

As stated above, you can boot from a drive without ever booting into the bios, and the boot manager.
This will, though, skip all the crucial variables a regular system would perhaps need.

The launch options are:

### /verbose

Print on screen the informations of the boot process.
USING /VERBOSE WILL DISABLE ALL GRAPHICAL FEATURES IN THE BIOS!!!

### /bootfrom [Name of the folder to boot from, with quotes if it contains whitespace]

You can run the boot command with this switch to boot a system unattended.*
Note, that the folder name given here is NOT limited to those selectable in the boot manager.

*: Unattended booting may not be supported depending on the booted system's reliance on
   BIOS-defined variables.

### /nofilecheck

The BIOS, by default checks all crucial BIOS elements in it's first stage.
Using /nofilecheck disables this function.

### /nologo

Disable the display of a system logo upon boot.
The system logo is to be stored on the device's root, in bootlogo.txt.
The bios supports images in 100 columns by 40 lines, plain-text, with ANSI escape sequences.
The images must contain an ANSI "reset" sequence at the end. ([][0m)

### /nobootmenu

Disable the graphical boot menu.
This option will trigger the use of a text-mode boot selector.
The boot selector will require the press of the numbers corresponding to listed devices (NOT a string input).
The "deviceinfo.txt" variables will still be defined.

### /bios

The arguments to be provided to the BIOS, aside from the other switches, which are also provided, automatically.
This may be useful, if You want to modify the BIOS in any way that requires additional launch options.

## Pure batch construction

# Note: This software was only tested to run on Windows 10/11.
# Earlier Windows consoles do not support ANSI escape sequences, which are critical for this software to work properly.
# For this exact reason, the software does not support the "Use legacy console" option.
