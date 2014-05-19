World = require './world'
View = require './view'
Hero = require './hero'
input-listener = require './input'

hero = new Hero
world = new World hero
view = new View([world, hero])

view.add-input-listener input-listener(hero, view)

view.display()

process.add-listener 'SIGINT', ->
  view.cleanup()
