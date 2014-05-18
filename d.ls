World = require './world'
View = require './view'
Hero = require './hero'
input-listener = require './input'

world = new World
hero = new Hero world
view = new View world, hero

view.add-input-listener input-listener(hero, view)

view.display()

process.add-listener 'SIGINT', ->
  view.cleanup()
