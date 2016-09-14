fussballDeWidget =
  tableCFB: ->
    new fussballdeWidgetAPI()
      .showWidget('tableCFB', '01TB9KHR74000000VS541L4QVTSA3RAV')

  scheduleCFB: ->
    new fussballdeWidgetAPI()
      .showWidget('scheduleCFB', '01TB9LVHDC000000VS541L4KVVNO4Q6P')

$ ->
  if $('#tableCFB').length > 0
    fussballDeWidget.tableCFB()

  if $('#scheduleCFB').length > 0
    fussballDeWidget.scheduleCFB()
