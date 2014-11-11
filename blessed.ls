blessed = require('blessed')
screen = blessed.screen()

box = blessed.box {
  top: 'center'
  left: 'center'
  width: '100%'
  height: '100%'
}

wall = (bg, fg, rl, rt) ->
  left: rl*10
  top: rt
  height: 1
  width: 7
  content: ''+fg
  fg: fg
  bg: bg

confs = [ wall('#000000', '#'+fg+fg+fg, fg, 0) for fg in [10 to 20] ]
els = for conf, i in confs
  el = blessed.element conf
  box.append el
  el.c = i+10
  el

screen.append box

screen.key ['escape', 'q', 'C-c'], (ch, key) ->
  process.exit(0);

screen.render();
