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

w = 120
h = 50

data = {}

create-map = (w, h) ->
  map = new ROT.Map.Cellular w, h, { born: [4, 5, 6], survive: [3, 4, 5, 6], topology: 6 }
  map.randomize(0.48)
  map.create (x, y, value) ->
    data[x+","+y] = value
  map

at = (x, y, char, color, double = true) ->
  # rgb = ROT.Color.hsl2rgb([0.333, 0.333, 0.3])
  nc.colorPair color, 233, color
  win.attrset nc.colorPair color
  win.addstr y, x, char
  if double
    win.addstr y, x + 1, char

map = create-map 120, 50

redraw = ->
  nc.show-cursor = false
  win.refresh

draw-map = (map) ->
  for cols, x in map._map
    for terrain, y in cols
      if _.even x + y
        if terrain == 0
          at x, y, '-', 234
        else
          at x, y, '#', 232

x = 30
y = 30

light-passes = (x, y) ->
  data[x+","+y] == 0

draw-field-of-view = (x, y, r, vis) ->
  if _.even x + y
    if data[x+','+y] == 0
      at x, y, '.', 244
    else
      at x, y, '#', 242

move = (new-x, new-y) ->
  pair = 22
  draw-map map
  x := new-x
  y := new-y
  # TODO: switch to Recursive shadowcasting with direction and viewing angle
  fov = new ROT.FOV.PreciseShadowcasting light-passes, { topology: 6 }
  fov.compute x, y, 6, draw-field-of-view
  # Path finding
  dijkstra = new ROT.Path.Dijkstra x, y, light-passes, { topology: 6 }
  dijkstra.compute 30, 30, (x, y) ->
    at x, y, '~', 20, false
  at x, y, '@-', 246, false
  redraw()

move x, y

win.on \inputChar, (c, i) ->
  if directions[c] != undefined
    shift = directions[c]
    move x + shift[0], y + shift[1]

process.addListener 'SIGINT', ->
  win.close()
  nc.leave()
