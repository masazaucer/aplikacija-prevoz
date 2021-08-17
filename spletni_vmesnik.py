import bottle
from model import Stanje, Uporabnik, Prevozno_sredstvo, Pot
from datetime import date

DATOTEKA_S_STANJEM = "stanje.json"

try:
    stanje = Stanje.nalozi_stanje(DATOTEKA_S_STANJEM)
except FileNotFoundError:
    stanje = Stanje()

def poisci_sredstvo(stanje, ime_polja):
    try:
        ime_sredstva = bottle.request.forms.getunicode(ime_polja)
        return stanje.poisci_sredstvo(ime_sredstva)
    except KeyError:
        return None

@bottle.get("/")
def osnovna_stran():
    bottle.redirect("/stanje/")

@bottle.get("/stanje/")
def nacrtovanje_stanja():
    return bottle.template("stanje.tpl", sredstva=stanje.prevozna_sredstva, poti=stanje.poti)

@bottle.get("/poti/")
def poti():
    return bottle.template("poti.tpl", stanje=stanje)

@bottle.get("/analiza/")
def analiza():
    return bottle.redirect("/analiza/skupno/")

@bottle.get("/pomoc/")
def pomoc():
    return bottle.template("pomoc.tpl")

@bottle.post("/dodaj-sredstvo/")
def dodaj_sredstvo():
    stanje.dodaj_sredstvo(bottle.request.forms.getunicode("ime"))
#    shrani_stanje()
    bottle.redirect("/")

@bottle.post("/dodaj-pot/")
def dodaj_pot():
    zacetek = bottle.request.forms.getunicode("zacetek")
    konec = bottle.request.forms.getunicode("konec")
    datum = bottle.request.forms.getunicode("datum")
    ime_sredstva = bottle.request.forms.getunicode("sredstvo")
    sredstvo = poisci_sredstvo(stanje, "sredstvo")
    stanje.dodaj_pot(zacetek, konec, ime_sredstva, datum)
#    shrani_stanje()
    bottle.redirect("/poti/")


@bottle.get('/analiza/<ime_sredstva>/')
def prikazi_sredstvo(ime_sredstva):
    if ime_sredstva == 'skupno':
        return bottle.template('prikazi_skupno_stanje.tpl')
    else:
        sredstvo = stanje.poisci_sredstvo(ime_sredstva)
        return bottle.template('prikazi_sredstvo.tpl', sredstvo=sredstvo)

"""
@bottle.post("/pomembnost-casa/")
def pomembnost_casa():
    pomembnost = bottle.request.forms.getunicode("pomembnost_casa")
    uporabnik.nastavi_pomembnost_casa(pomembnost)
    bottle.redirect("/")

@bottle.post("/pomembnost-onesnazevanja/")
def pomembnost_onesnazevanja():
    pomembnost = bottle.request.forms.getunicode("pomembnost_onesnazevanja")
    uporabnik.nastavi_pomembnost_onesnazevanja(pomembnost)
    bottle.redirect("/")
"""


bottle.run(reloader=True, debug=True)