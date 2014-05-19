nc = require 'ncurses'

class View
  (@displayables) ->
    @win = new nc.Window()

  add-input-listener: (listener) ->
    @win.on \inputChar, listener

  cleanup: ->
    @win.close()
    nc.leave()

  at: (x, y, char, color, double = true) ~>
    nc.color-pair color, color, 232
    @win.attrset nc.color-pair color
    @win.addstr y, x, char
    if double
      @win.addstr y, x + 1, char

  redraw: ~>
    for r to 5
      for g to 5
        for b to 5
          color = r * 36 + g * 6 + b + 16
          @at 100 + r * 8 + g, b, '.', color
          @at 100 + g * 8 + r, 10 + b, '.', color
          @at 100 + b * 8 + g, 20 + r, '.', color
    nc.show-cursor = false
    @win.refresh

  display: ~>
    for displayable in @displayables
      displayable.display @at
    @redraw()

module.exports = View
