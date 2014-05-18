nc = require 'ncurses'
_ = require 'prelude-ls'
ROT = require './rot'

win = new nc.Window()

directions =
  h: [-2,  0]
  u: [-1, -1]
  k: [ 1, -1]
  l: [ 2,  0]
  j: [ 1,  1]
  n: [-1,  1]

create-map = (w, h) ->
  map = new ROT.Map.Cellular w, h, { born: [4, 5, 6], survive: [2, 3, 4, 5], topology: 6 }
  map.randomize 0.6
  for i from 49 to 0 by -1
    map.create()
  map

at = (x, y, c) ->
  win.addstr y, x, c

draw-map = (map) ->
  for cols, x in map._map
    for terrain, y in cols
      if _.even x + y
        if terrain == 0
          at x, y, '.'
        else
          at x, y, '#'

map = create-map 120, 50
draw-map(map)

redraw = ->
  nc.show-cursor = false
  win.refresh

x = 30
y = 30

move = (new-x, new-y) ->
  draw-map(map)
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
  nc.leave()
