noise = require './noise'

liquid = ->
  data = noise.gen()
  passable: (x, y) ->
    true
  light-passable: (x, y) ->
    true
  display: (x, y, visible, seen) ->
    if data(x, y) > 0
      char: '~~'

module.exports = liquid
