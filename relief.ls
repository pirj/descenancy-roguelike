ROT = require './lib/rot'

relief = (w, h) ->
  data = {}
  map = new ROT.Map.Cellular w, h, { born: [4, 5, 6], survive: [3, 4, 5, 6], topology: 6 }
  map.randomize 0.43
  map.create (x, y, value) ->
    data[x+':'+y] = value
  passable: (x, y) ->
    data[x+':'+y]
  light-passable: (x, y) ->
    data[x+':'+y]
  display: (x, y, visible, seen) ->
    if data[x+':'+y]
      char: '##'

module.exports = relief
