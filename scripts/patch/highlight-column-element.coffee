{CompositeDisposable, Point, Range} = require 'atom'

class HighlightColumnView extends HTMLDivElement
  initialize: (@editor, @editorElement, @cursor)->
    @classList.add('highlight-column')
    @attachToLines()
    @handleEvents()
    @updateHighlight()
    this

  attachToLines: ->
    lines = @editorElement.querySelector?('.lines')
    lines?.appendChild(@)

  handleEvents: ->
    updateHighlightCallback = => @updateHighlight()

    subscriptions = new CompositeDisposable
    configSubscriptions = @handleConfigEvents()
    subscriptions.add atom.config.onDidChange 'editor.fontSize', ->
      # setTimeout because we need to wait for the editor measurement to happen
      setTimeout(updateHighlightCallback, 0)

    # FIXME: remove conditional as soon as the tiled editor is released.
    if @editorElement.hasTiledRendering
      subscriptions.add @editorElement.onDidChangeScrollLeft(updateHighlightCallback)

    cursorChanged = =>
      @updateHighlight()
    subscriptions.add @cursor.onDidChangePosition(cursorChanged)

    subscriptions.add @editorElement.onDidAttach =>
      @attachToLines()
      updateHighlightCallback()

    dispose = =>
      subscriptions.dispose()
      configSubscriptions.dispose()
      @remove()

    subscriptions.add @editor.onDidDestroy -> dispose()
    subscriptions.add @cursor.onDidDestroy -> dispose()

  handleConfigEvents: ->
    updateHighlightCallback = => @updateHighlight()
    subscriptions = new CompositeDisposable
    subscriptions.add atom.config.observe('highlight-column.opacity', updateHighlightCallback)
    subscriptions.add atom.config.observe('highlight-column.enabled', updateHighlightCallback)
    subscriptions.add atom.config.observe('highlight-column.lineMode', updateHighlightCallback)
    subscriptions

  updateHighlight: ->
    if @isEnabled()
      rect = @highlightRect()
      if rect
          width = rect.width
          width = 1 if @isLineMode()
          @style.left = "#{rect.left}px"
          @style.width = "#{width}px"
          @style.opacity = @opacity()
          @style.display = 'block'
    else
      @style.display = 'none'

  isEnabled: -> atom.config.get('highlight-column.enabled') ? true

  isLineMode: -> atom.config.get('highlight-column.lineMode')

  opacity: ->
    if @isLineMode()
      0.3
    else
      atom.config.get('highlight-column.opacity') ? 0.15

  highlightRect: ->
    rect = @_cursorPixelRect()
    if rect
        rect.width = @editor.getDefaultCharWidth() if !rect.width or rect.width is 0

        # FIXME: remove conditional as soon as the tiled editor is released.
        rect.left -= @editorElement.getScrollLeft() if @editorElement.hasTiledRendering
        rect

  _cursorPixelRect: ->
    {row, column} = @cursor.getScreenPosition()
    screenRange = new Range(new Point(row, column), new Point(row, column + 1))
    if  @editorElement.component != null
        try
            rect = @editorElement.pixelRectForScreenRange(screenRange)
            range = @editorElement.pixelRangeForScreenRange(screenRange)
        catch error
            # console.error error

        if !rect or !range
            rect = null
        else
            rect.left = range.start.left
            rect.right = range.end.left
    else
        rect = null
    rect

module.exports = document.registerElement('highlight-column',
  extends: 'div'
  prototype: HighlightColumnView.prototype
)
