// jscs:disable requireMultipleVarDecl
// jscs:disable requireVarDeclFirst
/* eslint new-cap:0 */
/* global WScript */

/* Copyright 2014-2015 John de Murga - Licensed under the GPLv2 */

var stdin = WScript.StdIn;
var stdout = WScript.StdOut;
var maxLength = 0;

while (!stdin.AtEndOfStream) {
    var buffer = stdin.ReadLine();
    if (maxLength < buffer.length) {
        maxLength = buffer.length;
    }
}

stdout.WriteLine("Max length is : " + maxLength);
