import bottle
from model import Stanje, Uporabnik, Prevozno_sredstvo, Pot

DATOTEKA_S_STANJEM = "stanje.json"

try:
    stanje = Stanje.nalozi_stanje(DATOTEKA_S_STANJEM)
except FileNotFoundError:
    stanje = Stanje()

@bottle.get("/")
def osnovna_stran():
    bottle.redirect("/stanje/")

@bottle.get("/stanje/")
def nacrtovanje_stanja():
    stanje = Stanje()
    return bottle.template("stanje.tpl", sredstva=stanje.prevozna_sredstva, poti=stanje.poti)

@bottle.get("/poti/")
def poti():
    return bottle.template("poti.tpl")

@bottle.get("/analiza/")
def analiza():
    return bottle.template("analiza.tpl")

@bottle.get("/pomoc/")
def pomoc():
    return bottle.template("pomoc.tpl")


bottle.run(reloader=True, debug=True)