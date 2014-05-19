until-stuck-condition = (could-move) ->
  if could-move
    until-stuck-condition

once-condition = (could-move) ->
  false

until-stuck-with-limit-condition = (repeats) ->
  (could-move) ->
    if repeats > 0 and could-move
      until-stuck-with-limit-condition(repeats - 1)

directions =
  h: {dx:-2, dy: 0}
  u: {dx:-1, dy:-1}
  k: {dx: 1, dy:-1}
  l: {dx: 2, dy: 0}
  j: {dx: 1, dy: 1}
  n: {dx:-1, dy: 1}

multipliers = { [repeats, until-stuck-with-limit-condition(repeats - 1)] for repeats in [1 to 9] }

move = (view, hero, direction, condition) ->
  while condition
    shift = directions[direction]
    could-move = hero.move shift.dx, shift.dy
    view.display()
    condition = condition(could-move)

input-listener = (hero, view) ->
  modifier = once-condition
  (c, key) ->
    if key == 'escape'
      modifier := once-condition
    else if c == 'g'
      modifier := until-stuck-condition
    else if multipliers[c]
      modifier := multipliers[c]
    else if directions[c]
      move view, hero, c, modifier
      modifier := once-condition

module.exports = input-listener
