// jscs:disable requireMultipleVarDecl
// jscs:disable requireVarDeclFirst
/* eslint new-cap:0 */
/* global ActiveXObject WScript */

/* Copyright 2014-2016 John de Murga - Licensed under the GPLv2 */

function download( source, destination ) {
    "use strict";

    var WinHttpReq = new ActiveXObject("WinHttp.WinHttpRequest.5.1");

    WinHttpReq.Open("GET", source, /*async=*/false );
    WinHttpReq.Send();
    // WScript.Echo(WinHttpReq.ResponseText);

    var BinStream = new ActiveXObject("ADODB.Stream");
    BinStream.Type = 1;
    BinStream.Open();
    BinStream.Write( WinHttpReq.ResponseBody );
    BinStream.SaveToFile( destination );

    BinStream = WinHttpReq = null;
}

WScript.StdOut.WriteLine("Downloading : " + WScript.Arguments( 0 ) );
download( WScript.Arguments( 0 ), WScript.Arguments( 1 ) );
