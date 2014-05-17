nc = require 'ncurses'

win = new nc.Window()

directions =
  h: [-1,  0]
  u: [-1, -1]
  k: [ 0, -1]
  l: [ 1,  0]
  n: [ 1,  1]
  j: [ 0,  1]

x = 30
y = 30

translate = (x, y) ->
  row: y
  col: x * 2 - y

at = (x, y, c) ->
  coordinates = translate x, y
  win.addstr coordinates.row, coordinates.col, c

redraw = ->
  nc.show-cursor = false
  win.refresh

move = (new-x, new-y) ->
  at x, y, '.'
  x := new-x
  y := new-y
  at x, y, '@'
  redraw()

move x, y

win.on \inputChar, (c, i) ->
  if directions[c] != undefined
    shift = directions[c]
    move x + shift[0], y + shift[1]

process.addListener 'SIGINT', ->
  win.close()
