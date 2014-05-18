World = require './world'
View = require './view'
Hero = require './hero'

directions =
  h: {dx:-2, dy: 0}
  u: {dx:-1, dy:-1}
  k: {dx: 1, dy:-1}
  l: {dx: 2, dy: 0}
  j: {dx: 1, dy: 1}
  n: {dx:-1, dy: 1}

world = new World
hero = new Hero world
view = new View world, hero

view.add-input-listener (c, i) ->
    if directions[c] != undefined
      shift = directions[c]
      hero.move shift.dx, shift.dy
      view.display()

view.display()

process.add-listener 'SIGINT', ->
  view.cleanup()
