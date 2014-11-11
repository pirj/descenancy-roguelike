Hero = require './hero'
Relief = require './relief'
Ground = require './ground'
Liquid = require './liquid'
Smoke = require './smoke'
_ = require 'prelude-ls'

world = ->
  width = 120
  height = 50
  relief = Relief(width, height)
  ground = Ground()
  liquid = Liquid()
  smoke = Smoke()
  hero = Hero(30, 30)
  chain = (fun, args) ->
    if args.length == 2
      fun args[0], args[1]
    else
      fun args.pop(), chain(args)
  layer-merge = (lower, higher) ->
    if lower
      { char: lowechar } || higher.char
    else
      higher
  lazy-layer = (layer, x, y, visible, seen) ->
    calculated = null
    ->
      calculated || calculated := layer x, y, visible, seen
  display: (at) ->
    for x to width
      for y to height
        if _.even x + y
          visible = true
          seen = true
          # layers = [ lazy-layer(layer, x, y, visible, seen) for layer in [hero, relief, ground, liquid, smoke] ]
          layers = [hero, relief, ground, liquid, smoke]
          # c = chain layer-merge, layers
          char = hero.display(x, y, visible, seen) || relief.display(x,y,visible,seen) || smoke.display(x, y, visible, seen) || liquid.display(x, y, visible, seen) || ground.display(x, y, visible, seen)
          if char
            at x, y, char.char, char.fg || 242
  move-hero: (dx, dy) ->
    hero.move dx, dy

module.exports = world
