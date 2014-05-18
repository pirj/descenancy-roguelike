Map = require './map'
_ = require 'prelude-ls'

class World
  w = 120
  h = 50
  ->
    @terrain = new Map w, h

  passes: (x, y) ->
    @terrain.passes x, y

  display: (at) ->
    for x to w
      for y to h
        if _.even x + y
          if @terrain.passes x, y
            at x, y, '-', 234
          else
            at x, y, '#', 232

module.exports = World
