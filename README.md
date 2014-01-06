# xnu-speedstep-air

xnu-speedstep-air is a kernel extension to keep my MacBook from overheating.

It's totally free and works with Mac OS X Maverics (10.9.3).
Compare to [CoolBook][] which doesn't since with Lion and costs $10.

It's basically [xnu-speedstep][] with bugfixes and preloaded voltage tables for the MacBook Air Rev. A.

## Why?

This is updated, and I use it on Macbook Unibody 2008 MacBook5,1 model. 

Since Maverics i noticed that the CPU/Voltage goes up very high when using average CPU-Tasks, 
Eg. Frequency is 1995Mhz and Voltage = 1,1V, but my T9350 (Core 2 Duo) can run it easily
in 1995/0.925V. Using AppleIntelCPUPowerManagement.kext it shows even lower in iStats Menu. 
but as soon as some CPU-Activity is there it goes up to full speed and heats up a lot. 

Fortunately, if you reduce the voltage to the processor, the system can
run much cooler without thermal protection events happening
(like kernel task emitting no-ops or core shutdown).

I was using Coolbook on Snow-Leopard (10.6) but after that it stopped working properly. 



HUGE THANKS to [Prashant Vaibhav][msq], [wbyung][], and Superhai for writing this code. I simply made a few changes to get it working on Lion and added voltage overrides for my MacBook Air Rev. A.

You've saved my sanity and tought me a tiny bit about hacking OS X.

This version is now updated for Maverics 10.9. There were some Problems to get it compiled for Target 10.9, but now it works. 
i had to remove some dependecies and use some older header files, but it compiles in x64 bit. 
no 32bit involved. 

maybe somebody has use for it, even just understanding whats going on with kernel-drivers. 

there is no GUI in the moment, but you can change parameters with the Info.plist in 
XCode or manually edit the Info.plist inside the kext-package. 

the voltages are optimized for my MacBook5,1.plist so you have to adjust them. 

if you rename the Attribute 
Info.plist > IOKitPersonalities > IntelEnhancedSpeedStep > PStateTable to 
Info.plist > IOKitPersonalities > IntelEnhancedSpeedStep > PStateTableOFF 

and load the kext it will show the available "vendor" Frequencies and Voltages in 
console.log (start console.app and filter by "IntelEnh" to find it easily. 

For me it does not work together with AppleIntelCPUPowerManagement * .kext
so i move them out of /S/L/E/. to a backup-location where i can restore the kext if i need to. 

i does work even with APICP.Management in place, but then the Voltage will be reset
by the AppleIntel * .kext all the time. 

The behavior is similar like you can make Coolbook work with 10.8 or 10.9.

you can watch the current status with (refresh every 10s, or you try --interval=0,1)

shell: 
watch --interval=10 "sysctl kern | grep kern.cputhrottle"

you can set all the listed parameters of kern.cputhrottle _ * 
with:  

sudo sysctl -w kern.cputhrottle_curfreq=0

to set the first PState. etc. 

I kept most stuff like in xnu-speedstep-air, because i was to lazy to rename functions, 
but it works also on MacBook5,1 and similar Core2Duo (arround 2006 to 2009 Macbooks). 

newer models are not supported. 



## Usage

**You should understand what this does: if you follow these instructions, you're undervolting your CPU to 892 - 940 mV.** I use it on my MacBook Air from 2008 without a problem.

If you're using a different computer, you need to change or remove the PStateTable entry in Info.plist.
I only tested it with the MacBook Air Rev. A., computers made after 2008 are very unlikely to work.
Failure to be careful may cause hardware instability, crashes, or possibly damage.

Read the LICENSE file. This code is provided AS-IS and at your own risk.

Build the Source using Xcode. You may need to change your build product location (see below).

Run deploy.sh, type your password.

Type: `sudo kextload /System/Library/Extensions/IntelEnhancedSpeedStep.kext`

Verify it worked: `sudo dmesg | grep IntelEnhancedSpeedStep`

## Xcode 5 and build products

In Preferences, select the Locations tab.

Click Advanced.

From the dropdown, select: Place build products in locations specified by targets

You'll now get the kext in build/.

it would be possible to create a gui for the sysctl parameters similar to 
Voodoomonitor _ SLandiCPUSL _ Src

Also check out "MSRDumper" which can show some CPU States, but it crashes easily with kernel-panic if you read the wrong registers. 

There is also a PDF of "OSXInternals.pdf" which explains how to build kernel-extensions. 


[Coolbook]: http://coolbook.se/
[xnu-speedstep]: http://code.google.com/p/xnu-speedstep/ => now working any more on 10.8+
[psm]: http://paulstamatiou.com/putting-an-end-to-macbook-air-core-shutdown
[msq]: http://www.mercurysquad.com/
[wbyung]: http://forums.macrumors.com/showthread.php?t=751657

