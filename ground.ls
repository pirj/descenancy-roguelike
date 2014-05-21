noise = require './noise'

ground = ->
  data = noise.gen()
  passable: (x, y) ->
    true
  light-passable: (x, y) ->
    true
  display: (x, y, visible, seen) ->
    if data(x, y) > 0
      char: '::'
    else
      char: ';;'

module.exports = ground
