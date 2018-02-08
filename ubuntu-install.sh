echo ""
echo "Cleaning existing profile"
echo ""

rm -rf ~/.atom
mkdir ~/.atom
cd ~/.atom

echo ""
echo "Downloading and installing Atom"
echo ""

wget https://github.com/atom/atom/releases/download/v1.24.0-beta3/atom-amd64.deb
sudo dpkg -i ./atom-amd64.deb
sudo apt-get -f install

echo ""
echo "Downloading and installing companion packages"
echo ""

wget https://raw.githubusercontent.com/JohnMurga/atom-portable/master/scripts/packages.txt

for packageName in $(cat packages.txt)
do
    echo -n "$packageName "
    apm install --color false $packageName > /dev/null
    if [ $? -ne 0 ]
    then
        apm install --color false $packageName > /dev/null
        if [ $? -ne 0 ]
        then
            apm install --color false $packageName > /dev/null
            if [ $? -ne 0 ]
            then
                echo "FAILED to install $packageName"
            fi
        fi
    fi
done

echo ""
echo "Downloading AtomPortable config"
echo ""

wget https://raw.githubusercontent.com/JohnMurga/atom-portable/master/template/Data/AtomProfile/config.cson
wget https://raw.githubusercontent.com/JohnMurga/atom-portable/master/template/Data/AtomProfile/init.coffee
wget https://raw.githubusercontent.com/JohnMurga/atom-portable/master/template/Data/AtomProfile/keymap.cson
wget https://raw.githubusercontent.com/JohnMurga/atom-portable/master/template/Data/AtomProfile/styles.less
wget https://raw.githubusercontent.com/JohnMurga/atom-portable/master/template/Data/AtomProfile/.eslintrc

echo ""
echo "Tweaking settings for Ubuntu"
echo ""

sed -i -- 's/Console\;exit//g' config.cson
sed -i -- 's/ConEmu.bat/gnome-terminal/g' config.cson
sed -i -- 's/\\\\\\\\/\//g' config.cson

echo ""
echo "All done !!"
echo ""
