Map = require './map'
ROT = require './lib/rot'
_ = require 'prelude-ls'

class World
  width: 120
  height: 50

  noise-gen = ->
    noise = new ROT.Noise.Simplex()
    (x, y) ->
      noise.get(x / 50, y / 50)

  noise-gen-positive = ->
    noise = new ROT.Noise.Simplex()
    (x, y) ->
      (noise.get(x / 50, y / 50) + 1) / 2

  (@hero) ->
    @relief = new Map @width, @height
    @ground = noise-gen()
    @liquid = noise-gen()
    @garbage = noise-gen()
    @garbage = noise-gen()
    @atmosphere = noise-gen-positive()
    @radiance = noise-gen-positive()
    @heat = noise-gen-positive()
    @hero.add-world this

  char-at: (x, y, visible = false) ->
    if @relief.passes x, y
      r = 0
      g = 0
      b = 0
      if @liquid(x, y) > 0
        char = ';;'
        b = 2 + visible * 1
      else
        char = '::'
        r = 1 + visible * 1
        g = 1 + visible * 1
        b = 1 + visible * 1
      color = 16 + r*36 + g*6 + b
    else
      char = '##'
      color = 236 + visible * 4
    { char: char, color: color }

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
            char = @char-at x, y
            at x, y, char.char, char.color
    @omniscience-field-of-view @hero.x, @hero.y, 6, @hero.can-move, (x, y, r, vis) ~>
      if _.even x + y
        # @hero.see x, y
        char = @char-at x, y, true
        at x, y, char.char, char.color

module.exports = World
