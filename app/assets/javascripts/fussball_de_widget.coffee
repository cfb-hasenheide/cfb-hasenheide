fussballDeWidget =
  init: ->
    wettbewerb1 = new fussballdeAPI();
    wettbewerb1.setzeWettbewerb('01HATI4674000000VV0AG813VS4TGVBL-G');
    wettbewerb1.setzeMandant('66');
    wettbewerb1.zeigeTabelle('fussballDeWidget');

$ ->
  if $('#fussballDeWidget').length > 0
    fussballDeWidget.init()
