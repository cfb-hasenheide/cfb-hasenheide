fussballDeWidget =
  cfbI: ->
    new fussballdeWidgetAPI()
      .showWidget('cfbIFussballDeWidget', '01QM1V8174000000VS541L4HVTCBDGUL')

  cfbII: ->
    new fussballdeWidgetAPI()
      .showWidget('cfbIIFussballDeWidget', '01QM1UNBN4000000VS541L4GVVM3DHU5')

$ ->
  if $('#cfbIFussballDeWidget').length > 0
    fussballDeWidget.cfbI()
  if $('#cfbIIFussballDeWidget').length > 0
    fussballDeWidget.cfbII()
