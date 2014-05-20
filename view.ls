nc = require('ncurses')

class View
  (@displayables) ->
    @win = new nc.Window()

  add-input-listener: (listener) ->
    @win.on \inputChar, listener

  cleanup: ->
    @win.close()
    nc.leave()

  at: (x, y, char, color) ~>
    nc.color-pair color, 232, color
    @win.attrset nc.color-pair color
    @win.addstr y, x, char

  redraw: ~>
    nc.show-cursor = false
    @win.refresh

  display: ~>
    for displayable in @displayables
      displayable.display @at
    @redraw()

module.exports = View
