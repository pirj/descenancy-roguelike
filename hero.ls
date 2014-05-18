ROT = require './lib/rot'
_ = require 'prelude-ls'

class Hero
  (@world) ->
    @x = 30
    @y = 30
    @seen-map = {}

  move: (dx, dy) ->
    can-move = @can-move @x + dx, @y + dy
    if can-move
      @x += dx
      @y += dy
      true
    else
      false

  can-move: (x, y) ~>
    @world.passes x, y

  seen: (x, y) ->
    @seen-map[x+','+y]

  # TODO: switch to Recursive shadowcasting with direction and viewing angle
  omniscience-field-of-view: (x, y, r, passes, callback) ~>
    fov = new ROT.FOV.PreciseShadowcasting passes, { topology: 6 }
    fov.compute x, y, r, callback

  display: (at) ->

    for x to @world.width
      for y to @world.height
        if _.even x + y
          if @seen x, y
            if @world.passes x, y
              at x, y, '-', 236
            else
              at x, y, '#', 234

    @omniscience-field-of-view @x, @y, 6, @can-move, (x, y, r, vis) ~>
      if _.even x + y
        @seen-map[x+','+y] = true
        if @world.passes x, y
          at x, y, '.', 244
        else
          at x, y, '#', 242
    at @x, @y, '@-', 246, false

module.exports = Hero
