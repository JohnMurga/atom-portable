#
# Copyright 2014-2016 John de Murga - Licensed under the GPLv2
# 

echo "Renaming if beta"
mv ./packages/atom/App/Atom/atom*.exe ./packages/atom/App/Atom/atom.exe

echo "Tweaking .vimrc markdown config"
cp ./downloads/.vimrc ./packages/_home/.vimrc
echo "" >> ./packages/_home/.vimrc
echo "let g:markdown_fenced_languages = ['css', 'javascript', 'js=javascript', 'json=javascript', 'xml']" >> ./packages/_home/.vimrc
echo ""

echo "Tweaking minttyrc for readability"
echo "Transparency=low" > ./packages/git/etc/minttyrc
echo "CursorType=block" >> ./packages/git/etc/minttyrc
echo ""

echo "Tweaking default profile"
cat ./scripts/profile-tweaks >> ./packages/git/etc/profile

echo "Deleting some of the larger unreferenced image files in packages"
cd packages/Atom/Data/AtomProfile
find . -name *.gif -size +10k -print | xargs -I '{}' sh -c 'echo "DEL {}"; rm {};'
find . -name *.jpg -size +80k -print | xargs -I '{}' sh -c 'echo "DEL {}"; rm {};'
find . -name screenshot.png -size +80k -print | xargs -I '{}' sh -c 'echo "DEL {}"; rm {};'
echo ""
