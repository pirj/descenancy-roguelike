nc = require 'ncurses'

win = new nc.Window()

x = 20
y = 30

mv = (nx, ny) ->
  nc.showCursor = false
  win.delch x, y
  x := nx
  y := ny
  win.addstr nx, ny, '@'
  win.chgat nx, ny, nc.attrs.REVERSE, nc.maxColorPairs-3
  win.refresh

mv x + 1, y + 1

win.on \inputChar, (c, i) ->
  if c == 'k'
    mv x - 1, y
  else if c == 'j'
    mv x + 1, y
  else if c == 'h'
    mv x, y - 1
  else if c == 'l'
    mv x, y + 1

process.addListener 'SIGINT', ->
  win.close()
