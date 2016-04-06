// jscs:disable requireMultipleVarDecl
// jscs:disable requireVarDeclFirst
/* eslint new-cap:0 */
/* global ActiveXObject WScript */

/* Copyright 2014-2016 John de Murga - Licensed under the GPLv2 */

function extractZip( source, destination ) {
    "use strict";
    // If the extraction location does not exist create it.
    var fso = new ActiveXObject("Scripting.FileSystemObject");
    source = fso.GetAbsolutePathName( source );
    destination = fso.GetAbsolutePathName( destination );
    if ( fso.FolderExists( destination ) ) {
        fso.DeleteFolder( destination );
    }
    fso.CreateFolder( destination );

    // Extract the contants of the zip file.
    var objShell = new ActiveXObject("Shell.Application");
    var FilesInZip = objShell.NameSpace( source ).Items();
    objShell.NameSpace( destination ).CopyHere( FilesInZip );
    fso = objShell = null;
}

extractZip( WScript.Arguments( 0 ), WScript.Arguments( 1 ) );
