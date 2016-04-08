## Atom Portable for Windows
### Intro
Environment to build an Atom Portable distribution from scratch.

This means taking care of long path issues and other annoyances.  
For terminal goodness ConEmu use the **CTRL+ALT+SHIFT+T** key binding.

I have bundled my favorite MIT/GPL licensed packages ...  
*I would have loved to bundle [FoldingText for Atom](https://atom.io/packages/foldingtext-for-atom), but I can't as it's commercial software.*

### How it works
You can download and extract the pre-built 7z archive for every release ...  
That is the easy and faster way to do it :smirk:

Or you can download the source ZIP file and build from scratch ...  
Which take a long time, but is hopefully as easy as (0!), 1, 2, 3 ...

The build system is an experiment in automating a build with nothing but old fashioned vanilla Windows components (*not having to worry about PowerShell versions or the like*).

Download the source ZIP file (*no Git required* :stuck_out_tongue_winking_eye:), extract it somewhere ...  
Then open a CMD window, go to the directory you extracted to and try :

- To download the packages   
```
0-download-archives.bat
```
- To then create the portable package and install plugins to it  
```
1-extract-and-layout.bat & 2-install-atom-packages.bat
```
- And as a final step, if you want to create an archive  
```
3-package-binaries.bat
```

If you take a peek into the newly created "packages" directory, you will find a full build of my portable distribution, including the latest Atom, Git, Meld, NodeJs LTS and ConEmu ... And then all you have to do is enjoy :bomb:

The build and package process should work on Windows 7 and above (like Atom itself)  
*Tested on Windows7/8/10*

### Plans

Still a little tidying up to do ...  
And I have to document the hidden features :scream:  

As I use this myself there will be new features now and then.

And there are some items on the todo list :
- Easier updating
- A VS Code sister to this project

Anyway ... 
Enjoy :thumbsup:
