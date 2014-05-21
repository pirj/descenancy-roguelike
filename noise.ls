ROT = require './lib/rot'

noise =
  gen: ->
    noise = new ROT.Noise.Simplex()
    (x, y) ->
      noise.get(x / 50, y / 50)
  gen-positive: ->
    noise = new ROT.Noise.Simplex()
    (x, y) ->
      (noise.get(x / 50, y / 50) + 1) / 2

module.exports = noise
