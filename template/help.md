## Atom Portable for Windows
### Intro
Atom is great :heart_eyes:, unfortunately it has always had issues under Windows. The most obvious is the classic long paths issues that come with NPM (*npm 3.0 will be better* :clap:). Another issue is that it needs a Git installation for many many of the packages to install. And finally ... Even though it's got a lot better (*when ATOM_HOME was fixed*), it is not very portable in the full sense of the word (%APPDATA% traces, etc).

I do use Atom on many machines (some even Windows), and I wanted something more reliable than batch files and/or NTFS junction points.

### How it works
- Firstly I created a fairly basic launcher using the [PortableApps](http://portableapps.com) launcher creator. Their launcher itself is well tested and deals with relocating the Atom profile as cleanly as possible (*but does not like long filenames*).
- Then I tweaked the settings for a portable setup, and came up with a "template setup."
- Finally I added useful plugins along with basic tweaks and a way to flatten them so that they won't break the ancient MAX_PATH(*260*) limit.

This package is created with the associated [Atom-Portable](https://github.com/JohnMurga/atom-portable) project on GitHub, you can also find the latest binaries there.

### GIT / Python / Meld / ETC
Atom expects you to have Git installed and in your path. So this launcher supports running a portable install of Git alongside Atom.

It is not bundled in the core package as many will already have it.

To add it to the portable package just download the "Addons" archive from the release page, and extract to the same directory as Atom.

1. You will have the following structure :
```
    <your directory>
     + atom
     + git
     + meld
     ...
```
2. When you run Atom from Atom.exe it'll have Meld and Git integrated.
3. ConEmu-BASH.exe launcher, will give you a BASH shell with meld.

For python and GCC you just have to add the relevant directories at the same level :
```
    <your directory>
     + python
     + TDM-GCC-32
```
*Addon packs for this are coming.*


### Updating the Atom core without a rebuild
A lot of plugins will update without a problem though the editor itself, although some do require Git to be installed to do so, and others will break the MAX_PATH(*260*) limit if you try and delete or copy your installation.

The Atom core can be upgraded manually, to do so just extract to Atom Windows ZIP release files (https://github.com/atom/atom/releases) into the "App\Atom" directory.

### Caveats and Issues
Even though this package works well you should be aware of the following issues :

+ Performance (specially on startup)  
*The [PortableApps](http://portableapps.com) launcher syncs and removes some files in your Windows HOME and APPDATA directories. If you are running this from a USB drive or a slower drive it can be a bit slow to start (and shutdown), due to this and the fact that Atom is IO intensive.*

+ Size - Total size of Atom with add-ons over 500Mb  
*We can argue that it's an IDE, but it still seems kinda big*

+ Temp files - Atom and it's addons can be temp file happy.  
*The launcher tries to address this wiping it's files on exit.*

+ Non-Windows addons  
Some addons won't work or will exhibit strange behavior under Windows, I would suggest raising issues on the addon's tracker when this happens and hoping the issues get resolved.  
**All the bundled addons are tested under windows**

Despite all this Atom still rocks :stuck_out_tongue_winking_eye:

Anyway, enjoy :feelsgood:

:copyright: John de Murga 2016
