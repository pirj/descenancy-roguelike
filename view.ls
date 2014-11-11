nc = require('ncurses')

class View
  (@world) ->
    @win = new nc.Window()
    @win.on \inputChar, world.input

  cleanup: ->
    @win.close()
    nc.leave()

  at: (x, y, char, fg, bg = 232) ~>
    nc.color-pair fg, fg, bg
    @win.attrset nc.color-pair fg
    @win.addstr y, x, char

  redraw: ~>
    nc.show-cursor = false
    @win.refresh

  display: ~>
    @world.display @at
    @redraw()

module.exports = View
