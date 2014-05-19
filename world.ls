Map = require './map'
ROT = require './lib/rot'
_ = require 'prelude-ls'

class World
  width: 120
  height: 50

  (@hero) ->
    @relief = new Map @width, @height
    @liquid = new Map @width, @height
    @hero.add-world this

  passes: (x, y) ->
    @relief.passes x, y

  # TODO: switch to Recursive shadowcasting with direction and viewing angle
  omniscience-field-of-view: (x, y, r, passes, callback) ~>
    fov = new ROT.FOV.PreciseShadowcasting passes, { topology: 6 }
    fov.compute x, y, r, callback

  display: (at) ->
    for x to @width
      for y to @height
        if _.even x + y
          if @hero.seen x, y
            r = 1
            g = 1
            b = 1
            if @relief.passes x, y
              char = ':'
              r = r + 1
              if @liquid.passes x, y
                b = 6
                r = 0
                g = 0
            else
              char = '#'
              g = g + 1
            color = r * 36 + g * 6 + b + 16
            at x, y, char, color
    @omniscience-field-of-view @hero.x, @hero.y, 6, @hero.can-move, (x, y, r, vis) ~>
      if _.even x + y
        @hero.see x, y
        r = 2
        g = 2
        b = 2
        if @relief.passes x, y
          char = ':'
          r = r + 2
          if @liquid.passes x, y
            b = 6
            g = 1
            r = 1
        else
          char = '#'
          g = g + 2
        color = r * 36 + g * 6 + b + 16
        at x, y, char, color

module.exports = World
