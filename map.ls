ROT = require './lib/rot'

class Map
  (w, h) ->
    data = {}
    map = new ROT.Map.Cellular w, h, { born: [4, 5, 6], survive: [3, 4, 5, 6], topology: 6 }
    map.randomize 0.48
    map.create (x, y, value) ->
      data[x+","+y] = value
    @data = data

  passes: (x, y) ~>
    @data[x+","+y] == 0

  path-to: (x, y, callback) ->
    dijkstra = new ROT.Path.Dijkstra x, y, @passes, { topology: 6 }
    dijkstra.compute 30, 30, callback

module.exports = Map
