_ = require 'prelude-ls'
ROT = require './lib/rot'

hero = (x, y) ->
  hero-x = x
  hero-y = y
  # seen-map = {}
  move: (dx, dy) ->
    # can-move = can-move x + dx, y + dy
    # if can-move
    hero-x += dx
    hero-y += dy
      # @see-from @x, @y
    true
  passable: (x, y) ->
    if hero-x != x and hero-y != y
      true
  light-passable: (x, y) ->
    if hero-x != x and hero-y != y
      true
  display: (x, y, visible, seen) ->
    if hero-x == x and hero-y == y
      char: '@-'
      fg: 253

module.exports = hero
