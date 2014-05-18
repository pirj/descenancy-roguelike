Map = require './map'
_ = require 'prelude-ls'

class World
  width: 120
  height: 50

  ->
    @terrain = new Map @width, @height

  passes: (x, y) ->
    @terrain.passes x, y

  display: (at) ->
    # Nothing special to display yet

module.exports = World
