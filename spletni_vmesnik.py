from sys import path
import bottle
from model import Stanje, Uporabnik, Prevozno_sredstvo, Pot
from datetime import date
from model import Uporabnik

DATOTEKA_S_STANJEM = "stanje.json"
PISKOTEK_UPORABNISKO_IME = "uporabnisko_ime"
SKRIVNOST = "to je ena skrivnost"
SREDSTVA = ["walking", "bicycling", "driving", "train", "bus"]

try:
    stanje = Stanje.nalozi_stanje(DATOTEKA_S_STANJEM)
except FileNotFoundError:
    stanje = Stanje()

uporabnik = Uporabnik('masa', '123', stanje)

def poisci_sredstvo(stanje, ime_polja):
    try:
        ime_sredstva = bottle.request.forms.getunicode(ime_polja)
        return stanje.poisci_sredstvo(ime_sredstva)
    except KeyError:
        return None

def preveri_prijavo():
    prijavljen = bottle.request.get_cookie(PISKOTEK_UPORABNISKO_IME)
    if prijavljen != 'da':
        bottle.redirect('/prijava/')
    else:
        bottle.redirect('/stanje/')

@bottle.get("/registracija/")
def registracija_get():
    return bottle.template("registracija.tpl", napaka=None)

@bottle.post("/registracija/")
def registracija_post():
    username = bottle.request.forms.getunicode("username")
    password = bottle.request.forms.getunicode("password")
    print("uspesno")
    bottle.redirect("/")

@bottle.get("/prijava/")
def prijava_get():
    return bottle.template("prijava.tpl", napaka=None)

@bottle.post("/prijava/")
def prijava_post():
    username = bottle.request.forms.getunicode("username")
    password = bottle.request.forms.getunicode("password")
    if password == '123':
        bottle.response.set_cookie(PISKOTEK_UPORABNISKO_IME, 'da', path='/', secret=SKRIVNOST)
        bottle.redirect('/')
    else:
        return bottle.template("prijava.tpl", napaka='Geslo je napačno')

@bottle.get("/")
def osnovna_stran():
    preveri_prijavo()
    bottle.redirect("/stanje/")

@bottle.get("/stanje/")
def nacrtovanje_stanja():
    return bottle.template("stanje.tpl", stanje=stanje, poti=stanje.poti, sredstva=stanje.prevozna_sredstva)

@bottle.get("/poti/")
def poti():
    return bottle.template("poti.tpl", stanje=stanje)

@bottle.get("/analiza/")
def analiza():
    preveri_prijavo()
    return bottle.redirect("/analiza/skupno/")

@bottle.get("/pomoc/")
def pomoc():
    return bottle.template("pomoc.tpl")

@bottle.post("/dodaj-sredstvo/")
def dodaj_sredstvo():
    for sredstvo in SREDSTVA:
        if bottle.request.forms.getunicode(sredstvo) == 'True' and (sredstvo not in stanje.prevozna_sredstva_po_imenih):
            stanje.dodaj_sredstvo(sredstvo)
        elif bottle.request.forms.getunicode(sredstvo) != 'True' and (sredstvo not in stanje.prevozna_sredstva_po_imenih):
            stanje.odstrani_sredstvo(sredstvo)
    stanje.shrani_stanje(DATOTEKA_S_STANJEM)
    bottle.redirect("/")

@bottle.post("/dodaj-pot/")
def dodaj_pot():
    zacetek = bottle.request.forms.getunicode("zacetek")
    konec = bottle.request.forms.getunicode("konec")
    datum = bottle.request.forms.getunicode("datum")
    ime_sredstva = bottle.request.forms.getunicode("sredstvo")
    stanje.dodaj_pot(zacetek, konec, ime_sredstva, datum)
    stanje.shrani_stanje(DATOTEKA_S_STANJEM)
    bottle.redirect("/poti/")
     

@bottle.get('/analiza/<ime_sredstva>/')
def prikazi_sredstvo(ime_sredstva):
    if ime_sredstva == 'skupno':
        return bottle.template('prikazi_skupno_stanje.tpl', stanje=stanje, sredstva=stanje.prevozna_sredstva)
    else:
        sredstvo = stanje.poisci_sredstvo(ime_sredstva)
        return bottle.template('prikazi_sredstvo.tpl', sredstvo=sredstvo, sredstva=stanje.prevozna_sredstva)


#uredi definicijo spremenljivke uporabnik
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


bottle.run(reloader=True, debug=True)