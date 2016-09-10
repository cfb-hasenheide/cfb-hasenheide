fussballDeWidget =
  tableCFBI: ->
    new fussballdeWidgetAPI()
      .showWidget('fussballDeTableCFBI', '01QM1V8174000000VS541L4HVTCBDGUL')

  tableCFBII: ->
    new fussballdeWidgetAPI()
      .showWidget('fussballDeTableCFBII', '01QM1UNBN4000000VS541L4GVVM3DHU5')

  matchScheduleCFBI: ->
    new fussballdeWidgetAPI()
      .showWidget('fussballDeMatchScheduleCFBI', '01R2PCLE9O000000VS541L4IVUIUK64H')

  matchScheduleCFBII: ->
    new fussballdeWidgetAPI()
      .showWidget('fussballDeMatchScheduleCFBII', '01R2OPR4PK000000VS541L4GVTUQ91SG')

$ ->
  return unless fussballdeWidgetAPI?

  if $('#fussballDeTableCFBI').length > 0
    fussballDeWidget.tableCFBI()

  if $('#fussballDeTableCFBII').length > 0
    fussballDeWidget.tableCFBII()

  if $('#fussballDeMatchScheduleCFBI').length > 0
    fussballDeWidget.matchScheduleCFBI()

  if $('#fussballDeMatchScheduleCFBII').length > 0
    fussballDeWidget.matchScheduleCFBII()
