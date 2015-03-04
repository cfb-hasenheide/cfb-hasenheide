fussballDeWidget =
  cfbI: ->
    ue32FreizeitLandesligaKf = new fussballdeAPI();
    ue32FreizeitLandesligaKf.setzeWettbewerb('01KT3RIK80000001VV0AG812VV4M9N0A-G');
    ue32FreizeitLandesligaKf.setzeMandant('01');
    ue32FreizeitLandesligaKf.zeigeTabelle('cfbIFussballDeWidget');

  cfbII: ->
    herrenFreizeitLandesSt1Kf = new fussballdeAPI();
    herrenFreizeitLandesSt1Kf.setzeWettbewerb('01KT3QHBKG000000VV0AG812VV4M9N0A-G');
    herrenFreizeitLandesSt1Kf.setzeMandant('01');
    herrenFreizeitLandesSt1Kf.zeigeTabelle('cfbIIFussballDeWidget');

$ ->
  if $('#cfbIFussballDeWidget').length > 0
    fussballDeWidget.cfbI()
  if $('#cfbIIFussballDeWidget').length > 0
    fussballDeWidget.cfbII()
