fussballDeWidget =
  tableCFB: ->
    new fussballdeWidgetAPI()
      .showWidget('tableCFB', '021MCNLGJG000000VS541L4FVT19MEPC')

  scheduleCFB: ->
    new fussballdeWidgetAPI()
      .showWidget('scheduleCFB', '01TB9LVHDC000000VS541L4KVVNO4Q6P')

$ ->
  if $('#tableCFB').length > 0
    fussballDeWidget.tableCFB()

  if $('#scheduleCFB').length > 0
    fussballDeWidget.scheduleCFB()
