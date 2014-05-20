_ = require 'prelude-ls'
ROT = require './lib/rot'

class Hero
  ->
    @x = 30
    @y = 30
    @seen-map = {}

  move: (dx, dy) ->
    can-move = @can-move @x + dx, @y + dy
    if can-move
      @x += dx
      @y += dy
      @see-from @x, @y
      true

  can-move: (x, y) ~>
    @world.passes x, y

  add-world: (world) ->
    @world = world

  omniscience-field-of-view: (x, y, r, passes, callback) ~>
    fov = new ROT.FOV.PreciseShadowcasting passes, { topology: 6 }
    fov.compute x, y, r, callback

  see-from: (x, y) ~>
    @omniscience-field-of-view x, y, 6, @can-move, (x, y, r, vis) ~>
      if _.even x + y
        @see x, y

  see: (x, y) ~>
    @seen-map[x+','+y] = true

  seen: (x, y) ~>
    @seen-map[x+','+y]

  display: (at) ->
    at @x, @y, '@-', 253

module.exports = Hero
