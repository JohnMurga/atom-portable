// jscs:disable requireMultipleVarDecl
// jscs:disable requireVarDeclFirst
/* eslint new-cap:0 */
/* global WScript */

/* Copyright 2014-2015 John de Murga - Licensed under the GPLv2 */

var stdin = WScript.StdIn;
var stdout = WScript.StdOut;

while (!stdin.AtEndOfStream) {
    var buffer = stdin.ReadLine();
    stdout.WriteLine(buffer.replace(WScript.Arguments(0), WScript.Arguments(1)));
}
