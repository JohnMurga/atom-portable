echo "Cleaning existing profile"
rm -rf ~/.atom
mkdir ~/.atom
cd ~/.atom
echo "Downloading and installing Atom 1.2.3"
wget https://github.com/atom/atom/releases/download/v1.2.3/atom-amd64.deb
sudo dpkg -i ./atom-amd64.deb
echo "Downloading and installing companion packages"
wget https://raw.githubusercontent.com/JohnMurga/atom-portable/master/scripts/packages.txt
apm install `cat packages.txt`
echo "Downloading AtomPortable config"
wget https://raw.githubusercontent.com/JohnMurga/atom-portable/master/template/Data/AtomProfile/config.cson
wget https://raw.githubusercontent.com/JohnMurga/atom-portable/master/template/Data/AtomProfile/init.coffee
wget https://raw.githubusercontent.com/JohnMurga/atom-portable/master/template/Data/AtomProfile/keymap.cson
wget https://raw.githubusercontent.com/JohnMurga/atom-portable/master/template/Data/AtomProfile/styles.less
wget https://raw.githubusercontent.com/JohnMurga/atom-portable/master/template/Data/AtomProfile/.eslintrc
echo "Tweaking settings for Ubuntu"
sed -i -- 's/Console\;exit//g' config.cson
sed -i -- 's/ConEmu.bat/gnome-terminal/g' config.cson
echo "All done !!"
