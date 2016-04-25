#
# Copyright 2014-2016 John de Murga - Licensed under the GPLv2
# 
# Tweaks the scripts installed from Gem files so that they are portable
# 

rubyPath=$(which ruby.exe | sed 's/ruby\.exe//g')
rubyWindowsPath=$(cygpath.exe -w $rubyPath | sed 's/\\/\//g' | sed -e 's/[^a-zA-Z0-9]/\\&/g; 1{$s/^$/""/}; 1!s/^/"/; $!s/$/"/')

echo "$rubyPath - $rubyWindowsPath"

for scriptName in $(find $rubyPath -name *.bat)
do
    fileName=${scriptName%.*}
    echo "Deleting $scriptName and fixing $fileName"
    
    rm $scriptName
    sed -i "s/$rubyWindowsPath//g" $fileName
done
