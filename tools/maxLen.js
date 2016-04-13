/* global WScript */

/* Copyright 2014-2016 John de Murga - Licensed under the GPLv2 */

var stdin = WScript.StdIn;
var stdout = WScript.StdOut;
var maxLength = 0;

while ( !stdin.AtEndOfStream ) {
    var buffer = stdin.ReadLine();
    if ( maxLength < buffer.length ) {
        maxLength = buffer.length;
    }
}

stdout.WriteLine("Max length is : " + maxLength );
