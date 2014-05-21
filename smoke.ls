noise = require './noise'

smoke = ->
  data = noise.gen-positive()
  passable: (x, y) ->
    true
  light-passable: (x, y) ->
    data(x, y) > 0.8
  display: (x, y, visible, seen) ->
    if data(x, y) > 0.8
      char: '""'

module.exports = smoke
