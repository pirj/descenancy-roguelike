layer-merge = (lower, higher) ->
  lazy-higher = lazy-layer higher
  if lower
    char: lowechar || higher.char
  else
    higher

lazy-layer = (layer) ->
  calculated = null
  (x, y, visible, seen) ->
    calculated || calculated := layer x, y, visible, seen

  char-at: (x, y, visible = false) ->
    if @relief.passes x, y
      r = 0
      g = 0
      b = 0
      if @liquid(x, y) > 0
        char = ';;'
        b = 2 + visible * 1
      else
        char = '::'
        r = 1 + visible * 1
        g = 1 + visible * 1
        b = 1 + visible * 1
      color = 16 + r*36 + g*6 + b
    else
      char = '##'
      color = 236 + visible * 4
    { char: char, color: color }


hero:

  can-move: (x, y) ~>
    @world.passes x, y

  omniscience-field-of-view: (x, y, r, passes, callback) ~>
    fov = new ROT.FOV.PreciseShadowcasting passes, { topology: 6 }
    fov.compute x, y, r, callback

  see-from: (x, y) ~>
    @omniscience-field-of-view x, y, 6, @can-move, (x, y, r, vis) ~>
      if _.even x + y
        @see x, y

  see: (x, y) ~>
    @seen-map[x+','+y] = true

  seen: (x, y) ~>
    @seen-map[x+','+y]


world:
  @omniscience-field-of-view @hero.x, @hero.y, 6, @hero.can-move, (x, y, r, vis) ~>
    if _.even x + y
      # @hero.see x, y
      char = @char-at x, y, true
      at x, y, char.char, char.color
