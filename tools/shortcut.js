/* global ActiveXObject WScript */

/* Copyright 2014-2016 John de Murga - Licensed under the GPLv2 */

function shortcut( source, destination, description ) {
    "use strict";

    var oWS = new ActiveXObject("WScript.Shell");

    var oLink = oWS.CreateShortcut( destination );
    oLink.TargetPath = source;
    // oLink.Arguments = "";
    oLink.Description = description;
    oLink.IconLocation = source + ", 0";
    oLink.WorkingDirectory = ".";
    oLink.Save();
}

WScript.StdOut.WriteLine("Creating shortcut for : " + WScript.Arguments( 0 ) );
shortcut( WScript.Arguments( 0 ), WScript.Arguments( 1 ), WScript.Arguments( 2 ) );
