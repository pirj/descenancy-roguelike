_ = require 'prelude-ls'

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
      true
    else
      false

  can-move: (x, y) ~>
    @world.passes x, y

  add-world: (world) ->
    @world = world

  see: (x, y) ~>
    @seen-map[x+','+y] = true

  seen: (x, y) ~>
    @seen-map[x+','+y]

  display: (at) ->
    at @x, @y, '@-', 253, false

module.exports = Hero
