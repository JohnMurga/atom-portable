/* global WScript */

/* Copyright 2014-2016 John de Murga - Licensed under the GPLv2 */

var stdin = WScript.StdIn;
var stdout = WScript.StdOut;
var stderr = WScript.StdErr;

// Allow for escaping of chars from the command line
var srcString = eval("\"" + WScript.Arguments( 0 ) + "\"");
var tgtString = eval("\"" + WScript.Arguments( 1 ) + "\"");
stderr.WriteLine("Changing (" + srcString + ") to (" + tgtString + ") in stream");


while ( !stdin.AtEndOfStream ) {
    var buffer = stdin.ReadLine();
    stdout.WriteLine( buffer.replace( srcString, tgtString ) );
}
