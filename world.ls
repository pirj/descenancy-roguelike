Map = require './map'
ROT = require './lib/rot'
_ = require 'prelude-ls'

class World
  width: 120
  height: 50

  (@hero) ->
    @terrain = new Map @width, @height
    @hero.add-world this

  passes: (x, y) ->
    @terrain.passes x, y

  # TODO: switch to Recursive shadowcasting with direction and viewing angle
  omniscience-field-of-view: (x, y, r, passes, callback) ~>
    fov = new ROT.FOV.PreciseShadowcasting passes, { topology: 6 }
    fov.compute x, y, r, callback

  display: (at) ->
    for x to @width
      for y to @height
        if _.even x + y
          if @hero.seen x, y
            if @passes x, y
              at x, y, '-', 236
            else
              at x, y, '#', 234
    @omniscience-field-of-view @hero.x, @hero.y, 6, @hero.can-move, (x, y, r, vis) ~>
      if _.even x + y
        @hero.see x, y
        if @passes x, y
          at x, y, '.', 244
        else
          at x, y, '#', 242

module.exports = World
