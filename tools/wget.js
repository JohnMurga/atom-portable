/* global ActiveXObject WScript */

/* Copyright 2014-2016 John de Murga - Licensed under the GPLv2 */

function download( source, destination ) {
    "use strict";

    var winHttpReq = new ActiveXObject("WinHttp.WinHttpRequest.5.1");

    winHttpReq.Open("GET", source, /*async=*/false );
    winHttpReq.Send();
    // WScript.Echo(WinHttpReq.ResponseText);

    var binStream = new ActiveXObject("ADODB.Stream");
    binStream.Type = 1;
    binStream.Open();
    binStream.Write( winHttpReq.ResponseBody );
    binStream.SaveToFile( destination );

    binStream = winHttpReq = null;
}

WScript.StdOut.WriteLine("Downloading : " + WScript.Arguments( 0 ) );
download( WScript.Arguments( 0 ), WScript.Arguments( 1 ) );
