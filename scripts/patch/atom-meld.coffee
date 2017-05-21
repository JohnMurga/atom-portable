#
# * atom-meld
# * https://github.com/SavageCore/atom-meld
# *
# * Copyright (c) 2016 SavageCore
# * Licensed under the MIT license.
#
AtomMeldExecutor = null
config = null
watcher = null
remote = null
dialog = null

module.exports = Atommeld =
  config:
    meldPath:
      title: 'Meld Path'
      description: 'Path to Meld executable'
      type: 'string'
      default: 'meld'
    meldArgs:
      title: 'Meld Arguments'
      description: 'Additional command-line options to pass to Meld'
      type: 'string'
      default: '--auto-compare'

  activate: (state) ->
    OpenTabSelectionView: null
    openTabSelectionView: null
    loadOpenFileSelectionView: null
    loadAtomMeldExecutor: null
    @loadRequiredModules(state)
    config.init()
    watcher.init()

    @commands = atom.commands.add 'atom-text-editor',
      'atom-meld:diff-from-file-file': =>
        @loadAtomMeldExecutor()
        @loadDialogModule()
        @diff_from_file_file()
      'atom-meld:diff-from-file-tab': =>
        @loadOpenTabSelectionView(state)
        @diff_from_file_tab()

    @commands.add atom.commands.add '.tab-bar',
      'atom-meld:diff-from-tab-active': =>
        @loadAtomMeldExecutor()
        @diff_from_tab_active()
      'atom-meld:diff-from-tab-file': =>
        @loadAtomMeldExecutor()
        @loadDialogModule()
        @diff_from_tab_file()
      'atom-meld:diff-from-tab-tab': =>
        @loadOpenTabSelectionView(state)
        @diff_from_tab_tab()

    @commands.add atom.commands.add '.tree-view',
      'atom-meld:diff-from-tree-active': =>
        @loadAtomMeldExecutor()
        @diff_from_tree_active()
      'atom-meld:diff-from-tree-file': =>
        @loadAtomMeldExecutor()
        @loadDialogModule()
        @diff_from_tree_file()
      'atom-meld:diff-from-tree-tab': =>
        @loadOpenTabSelectionView(state)
        @diff_from_tree_tab()

    @commands.add atom.commands.add '.tree-view.multi-select',
      'atom-meld:diff-from-tree-selected': =>
        @loadAtomMeldExecutor()
        @diff_from_tree_selected()

  diff_from_file_file: ->
    sourceFile = atom.workspace.getActiveTextEditor().getPath()
    targetFile = dialog.showOpenDialog({properties:['openFile'],defaultPath:atom.project.getPaths()[0]})
    return unless targetFile != undefined
    AtomMeldExecutor.runMeld(sourceFile, targetFile)

  diff_from_file_tab: ->
    sourceFile = atom.workspace.getActiveTextEditor().getPath()
    targetFile = @getSelectedTree()
    @openTabSelectionView.show(sourceFile, true)

  diff_from_tab_active: ->
    sourceFile = document.querySelector(".tab-bar .right-clicked .title").getAttribute('data-path')
    if (atom.workspace.getActiveTextEditor())
      targetFile = atom.workspace.getActiveTextEditor().getPath()
      AtomMeldExecutor.runMeld(sourceFile, targetFile)
    else
      atom.notifications.addWarning('No path to Active File',{detail:'Are you viewing the settings page per chance?\nA file must be opened and in view to use this function.';dismissable:true})

  diff_from_tab_file: ->
    sourceFile = document.querySelector(".tab-bar .right-clicked .title").getAttribute('data-path')
    targetFile = dialog.showOpenDialog({properties:['openFile'],defaultPath:atom.project.getPaths()[0]})
    return unless targetFile != undefined
    AtomMeldExecutor.runMeld(sourceFile, targetFile)

  diff_from_tab_tab: ->
    global.sourceFile = document.querySelector(".tab-bar .right-clicked .title").getAttribute('data-path')
    @openTabSelectionView.show(sourceFile, false, sourceFile)

  diff_from_tree_active: ->
    sourceFile = @getSelectedTree()
    if (atom.workspace.getActiveTextEditor())
      targetFile = atom.workspace.getActiveTextEditor().getPath()
      AtomMeldExecutor.runMeld(sourceFile, targetFile)
    else
      atom.notifications.addWarning('No path to Active File',{detail:'Are you viewing the settings page per chance?\nA file must be opened and in view to use this function.';dismissable:true})

  diff_from_tree_file: ->
    sourceFile = @getSelectedTree()
    targetFile = dialog.showOpenDialog({properties:['openFile'],defaultPath:atom.project.getPaths()[0]})
    return unless targetFile != undefined
    AtomMeldExecutor.runMeld(sourceFile, targetFile)

  diff_from_tree_selected: ->
    selectedFilePaths = null
    treeViewPackage = atom.packages.getActivePackage('tree-view')
    if (treeViewPackage)
      selectedFilePaths = treeViewPackage.mainModule.treeView.selectedPaths()
      if (selectedFilePaths.length != 2)
        atom.notifications.addWarning 'Atom Meld: You must select 2 files to compare in the tree view'
        return true
    AtomMeldExecutor.runMeld(selectedFilePaths[0], selectedFilePaths[1])

  diff_from_tree_tab: ->
    global.sourceFile = @getSelectedTree()
    @openTabSelectionView.show(sourceFile, false, sourceFile)

  getSelectedTree: ->
    treeViewObj = null
    if atom.packages.isPackageLoaded('tree-view') == true
      treeView = atom.packages.getLoadedPackage('tree-view')
      treeView = require(treeView.mainModulePath).getTreeViewInstance()
      treeViewObj = treeView.serialize()
    if typeof treeViewObj != 'undefined' && treeViewObj != null
      if treeViewObj.selectedPath
        sourceFile = treeViewObj.selectedPath
    return sourceFile

  deactivate: ->
    @openTabSelectionView = null
    @commands.dispose()
    AtomMeldExecutor = null
    config = null
    watcher = null
    remote = null
    dialog = null

  serialize: ->
    openTabSelectionViewState: @openTabSelectionView?.serialize()

  loadRequiredModules: (state) ->
    config ?= require './config'
    watcher ?= require './watcher'

  loadDialogModule: ->
    remote ?= require "remote"
    dialog ?= remote?.dialog

  loadAtomMeldExecutor: ->
    AtomMeldExecutor ?= require './executor'

  loadOpenTabSelectionView: (state) ->
    unless @openTabSelectionView?
      OpenTabSelectionView = require './views/open-tab-selection'
      @openTabSelectionView = new OpenTabSelectionView(state.openTabSelectionView)
    @openTabSelectionView
