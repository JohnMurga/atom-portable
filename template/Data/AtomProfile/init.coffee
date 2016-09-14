# Your init script
#
# Atom will evaluate this file each time a new window is opened. It is run
# after packages are loaded/activated and after the previous editor state
# has been restored.
#
# An example hack to make opened Markdown files always be soft wrapped:
#
# path = require 'path'
#
# atom.workspaceView.eachEditorView (editorView) ->
#   editor = editorView.getEditor()
#   if path.extname(editor.getPath()) is '.md'
#     editor.setSoftWrap(true)

# No need to zoom anymore ?
`
function setWinDpi( callback ) {
    var exec = require("child_process" ).exec;
    var cmd = "wmic desktopmonitor get PixelsPerXLogicalInch";

    exec( cmd, function( error, stdout, stderr ) {
        var dpi = 96;
        var lines = stdout.split("\n");

        for ( var i = 0; i < lines.length; i++ ) {
            if ( !isNaN( lines[ i ].trim() ) ) {
                dpi = lines[ i ].trim();
                break;
            }
        }


        callback( dpi );
    });
}

if ( /^win32/.test( process.platform ) ) {
    setWinDpi(function( dpi ) {
        if ( dpi > 108 && window.devicePixelRatio == 1 ) {
            require("web-frame" ).setZoomFactor( dpi * 0.9 / 96 );
        }
    });
}
`
