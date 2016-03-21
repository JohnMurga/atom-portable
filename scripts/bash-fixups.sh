echo ""
echo "Deleting some of the larger unreferenced image files in packages"
cd packages/Atom/Data/AtomProfile
find . -name *.gif -size +10k -print | xargs -I '{}' sh -c 'echo "DEL {}"; rm {};'
find . -name *.jpg -size +80k -print | xargs -I '{}' sh -c 'echo "DEL {}"; rm {};'
find . -name screenshot.png -size +80k -print | xargs -I '{}' sh -c 'echo "DEL {}"; rm {};'
echo ""
