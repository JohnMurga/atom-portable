// jscs:disable requireMultipleVarDecl
// jscs:disable requireVarDeclFirst
/* global require console */

/* Copyright 2014-2015 John de Murga - Licensed under the GPLv2 */

//
// Super rough and ready github markup renderer ...
// Renders things to look just like on GitHub including Emoji and code highlighting.
//

(function () {
    "use strict";

    var logger = console;
    var fs = require("fs");
    var marked = require("marked");

    marked.setOptions({
        renderer: new marked.Renderer(),
        gfm: true,
        tables: true,
        breaks: false,
        pedantic: false,
        sanitize: true,
        smartLists: true,
        smartypants: false,
        highlight: function (code, lang) {
            return require("highlight.js").highlightAuto(code, [lang]).value;
        }
    });

    function renderMarkdown(baseFilename) {
        var emojiUrlPrefix = "http://www.emoji-cheat-sheet.com/graphics/emojis/";
        var header = "<!DOCTYPE html>\n" +
                     "<link rel=\"stylesheet\" href=\"http://cdn.jsdelivr.net/highlight.js/8.9.1/styles/github.min.css\">\n" +
                     "<link rel=\"stylesheet\" href=\"https://sindresorhus.com/github-markdown-css/github-markdown.css\">\n" +
                     "<style>.markdown-body {min-width: 200px; max-width: 790px; margin: 0 auto; padding: 30px;}</style>\n" +
                     "<article class=\"markdown-body\">\n";

        fs.readFile(baseFilename + ".md", "utf8", function (readError, data) {

            if (readError) {
                return logger.log(readError);
            }

            var htmlOutput = header;
            htmlOutput += marked(data);
            htmlOutput += "</article>\n";

            var finalHtml = htmlOutput.replace(/:[\w\-\+]+:/g, function myFunction(emoji) {
                var emojiName = emoji.slice(1, -1);
                return ("<img class=\"emoji\" title=\":" + emojiName + ":\" alt=\"" +
                    emojiName + "\" src=\"" + emojiUrlPrefix +
                    emojiName + ".png\" height=\"20\">");
            });

            fs.writeFile(baseFilename + ".html", finalHtml, function (writeError) {
                if (writeError) {
                    return logger.log(writeError);
                }
            });
        });
    }

    logger.log("Rendering MarkDown files to HTML ...");
    renderMarkdown("README");
    renderMarkdown("template/help");
    logger.log("DONE");
})();
