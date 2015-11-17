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

It is not bundled it as many will already have it or may not use it.

To add it to the portable package follow these instructions :

1. Create a new directory with the following structure :
```
    <new directory>
     + atom
     + git
```
2. Extract the latest PortableGit files into "git"  
*(Download from : https://github.com/git-for-windows/git/releases)*

3. Install my portable package to "atom".

4. Run Atom from "atom\Atom.Portable.exe"

For Python and Meld its easiest to download  :  
http://sourceforge.net/projects/meld-installer/files/meld-1.8.6.0.zip/download

And extract in same way as before so that you have :
```
    <new directory>
     + atom
     + meld
     + python
```


### Updating the Atom core without a rebuild
A lot of plugins will update without a problem though the editor itself, although some do require Git to be installed to do so, and others will break the MAX_PATH(*260*) limit if you try and delete or copy your installation.

The Atom core can be upgraded manually, to do so just extract to Atom Windows ZIP release files (https://github.com/atom/atom/releases) into the "App\Atom" directory.

### Caveats and Issues
Even though this package works well you should be aware of the following issues :

+ Performance (specially on startup)  
*The [PortableApps](http://portableapps.com) syncs and removes the Atom profile in your Windows HOME and APPDATA directories. If the launcher resides on the same drive then it's very fast (files are moved). However, if you are running this from a USB drive or a slower drive it can be a bit slow to start (and shutdown).*

+ Size - Total size of Atom with add-ons almost 500Mb  
*We can argue that it's an IDE, but it still seems kinda big*

+ Temp files - Atom and it's addons can be temp file happy.  
*The launcher tries to address this wiping it's files on exit.*

+ Non-Windows addons  
Some addons won't work or will exhibit strange behavior under Windows, I would suggest raising issues on the addon's tracker when this happens and hoping the issues get resolved.  
**All the bundled addons are tested under windows**

Despite all this Atom rocks :stuck_out_tongue_winking_eye:

Anyway, enjoy :feelsgood:

:copyright: John de Murga 2015
