nc = require 'ncurses'

class View
  (@world, @hero) ->
    @win = new nc.Window()

  add-input-listener: (listener) ->
    @win.on \inputChar, listener

  cleanup: ->
    @win.close()
    nc.leave()

  at: (x, y, char, color, double = true) ~>
    # rgb = ROT.Color.hsl2rgb([0.333, 0.333, 0.3])
    nc.color-pair color, 233, color
    @win.attrset nc.color-pair color
    @win.addstr y, x, char
    if double
      @win.addstr y, x + 1, char

  redraw: ~>
    nc.show-cursor = false
    @win.refresh

  display: ~>
    @world.display @at
    @hero.display @at
    @redraw()

module.exports = View
