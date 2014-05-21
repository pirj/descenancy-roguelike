World = require './world'
View = require './view'
input-listener = require './input'

world = World()
view = new View(world)

view.add-input-listener input-listener(world.hero(), view)

view.display()

process.add-listener 'SIGINT', ->
  view.cleanup()
