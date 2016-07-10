/* global require console */

/* Copyright 2014-2016 John de Murga - Licensed under the GPLv2 */

//
// Super rough and ready github markup renderer ...
// Renders things to look just like on GitHub including Emoji and code highlighting.
//

(function() {
    "use strict";

    var logger = console;
    var fs = require("fs");
    var marked = require("marked");
    var pageStatus = {};

    var myRenderer = new marked.Renderer();

    myRenderer.defaultCode = myRenderer.code;
    myRenderer.code = function( code, language ) {
        if ( language && language.match( /^mermaid/ ) ) {
            pageStatus.didMermaid = true;
            return '<div class="mermaid">' + code + "\n</div>\n";
        }
        pageStatus.didCode = true;
        return myRenderer.defaultCode( code, language );
    };

    marked.setOptions({
        renderer: myRenderer,
        gfm: true,
        tables: true,
        breaks: true,
        pedantic: false,
        sanitize: false,
        smartLists: true,
        smartypants: false,
        highlight: function( code, lang ) {
            return require("highlight.js").highlightAuto( code, [ lang ]).value;
        }
    });

    function renderMarkdown( baseFilename ) {

        var emojiUrlPrefix = "http://www.emoji-cheat-sheet.com/graphics/emojis/";
        var mermaidJs = "https://cdn.jsdelivr.net/mermaid/6.0.0/mermaid.min.js";
        var githubCss = "https://sindresorhus.com/github-markdown-css/github-markdown.css";
        var highlightCss = "http://cdn.jsdelivr.net/highlight.js/8.9.1/styles/github.min.css";
        var mermaidCss = "https://cdn.jsdelivr.net/mermaid/6.0.0/mermaid.forest.css";
        var fontAwesomeCss = "https://cdn.jsdelivr.net/fontawesome/4.6.3/css/font-awesome.min.css";

        var localCss = ".markdown-body" +
            "{min-width: 200px; max-width: 790px; margin: 0 auto; padding: 30px;}";

        fs.readFile( baseFilename + ".md", "utf8", function( readError, data ) {

            pageStatus.didCode = false;
            pageStatus.didEmojis = false;
            pageStatus.didAwesome = false;
            pageStatus.didMermaid = false;

            if ( readError ) {
                return logger.log( readError );
            }

            var htmlOutput = marked( data ).replace( /:[\w\-\+]+:/g, function myFunction( icon ) {
                var iconName = icon.slice( 1, -1 );

                if ( iconName.match( /^fa-/ ) ) {
                    pageStatus.didAwesome = true;
                    return ("<i class=\"fa " + iconName + "\"></i>");
                }

                pageStatus.didEmojis = true;
                return ("<img class=\"icon\" title=\":" + iconName + ":\" alt=\"" +
                    iconName + "\" src=\"" + emojiUrlPrefix +
                    iconName + ".png\" height=\"20\">");
            });

            var header = "<!DOCTYPE html>\n<html>\n" +
                "<style>" + localCss + "</style>\n" +
                "<link rel=\"stylesheet\" href=\"" + githubCss + "\">\n";

            if ( pageStatus.didCode ) {
                header += "<link rel=\"stylesheet\" href=\"" + highlightCss + "\">\n";
            }

            if ( pageStatus.didMermaid ) {
                header += "<link rel=\"stylesheet\" href=\"" + mermaidCss + "\">\n";
                header += "<script src=\"" + mermaidJs + "\"></script>\n";
            }

            if ( pageStatus.didEmojis ) {
                // Nothing for now
            }

            if ( pageStatus.didAwesome ) {
                header += "<link rel=\"stylesheet\" href=\"" + fontAwesomeCss + "\">\n";
            }

            header += "<body>\n<article class=\"markdown-body\">\n";

            htmlOutput = header + htmlOutput + "</article>\n</body>\n</html>\n";

            fs.writeFile( baseFilename + ".html", htmlOutput, function( writeError ) {
                if ( writeError ) {
                    return logger.log( writeError );
                }
            });
        });
    }

    logger.log("Rendering MarkDown files to HTML ...");
    renderMarkdown("README");
    renderMarkdown("template/help");
    logger.log("DONE");
})();
