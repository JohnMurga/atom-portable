echo "Cleaning existing profile"
rm -rf ~/.atom
mkdir ~/.atom
cd ~/.atom
echo "Downloading and installing Atom 1.2"
wget https://github.com/atom/atom/releases/download/v1.2.0/atom-amd64.deb
sudo dpkg -i ./atom-amd64.deb
echo "Downloading and installing companion packages"
wget https://raw.githubusercontent.com/JohnMurga/atom-portable/master/scripts/packages.txt
apm install `cat packages.txt`
echo "Downloading a version of linter-eslint which works"
apm install linter-eslint@3.1.1
sed -i -- 's/"version"\: "3.1.1"/"version"\: "5.1.0"/g' packages/linter-eslint/package.json
echo "Downloading AtomPortable config"
wget https://raw.githubusercontent.com/JohnMurga/atom-portable/master/template/Data/AtomProfile/config.cson
wget https://raw.githubusercontent.com/JohnMurga/atom-portable/master/template/Data/AtomProfile/init.coffee
wget https://raw.githubusercontent.com/JohnMurga/atom-portable/master/template/Data/AtomProfile/keymap.cson
wget https://raw.githubusercontent.com/JohnMurga/atom-portable/master/template/Data/AtomProfile/styles.less
echo "Tweaking settings for Ubuntu"
sed -i -- 's/Console\;exit//g' config.cson
sed -i -- 's/ConEmu.bat/gnome-terminal/g' config.cson
echo "All done !!"
