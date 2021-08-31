import bottle
from model import Stanje, Uporabnik, Prevozno_sredstvo, Pot
from datetime import date
from model import Uporabnik

PISKOTEK_UPORABNISKO_IME = "uporabnisko_ime"
SKRIVNOST = "to je ena skrivnost"
SREDSTVA = ["walking", "bicycling", "driving", "train", "bus"]


def poisci_sredstvo(stanje, ime_polja):
    try:
        ime_sredstva = bottle.request.forms.getunicode(ime_polja)
        return stanje.poisci_sredstvo(ime_sredstva)
    except KeyError:
        return None

def shrani_stanje(uporabnik):
    uporabnik.v_datoteko()


def trenutni_uporabnik():
    uporabnisko_ime = bottle.request.get_cookie(
        PISKOTEK_UPORABNISKO_IME, secret=SKRIVNOST
    )
    if uporabnisko_ime:
        return podatki_uporabnika(uporabnisko_ime)
    else:
        bottle.redirect("/prijava/")


def podatki_uporabnika(uporabnisko_ime):
    return Uporabnik.iz_datoteke(uporabnisko_ime)


@bottle.get("/registracija/")
def registracija_get():
    return bottle.template("registracija.tpl", napaka=None, uporabnik=None)


@bottle.post("/registracija/")
def registracija_post():
    username = bottle.request.forms.getunicode("username")
    password = bottle.request.forms.getunicode("password")
    if not username:
        return bottle.template("registracija.tpl", napaka="Vnesi uporabniško ime!", uporabnik=None)
    try:
        Uporabnik.registracija(username, password)
        bottle.response.set_cookie(
            PISKOTEK_UPORABNISKO_IME, username, path="/", secret=SKRIVNOST
        )
        bottle.redirect("/")
    except ValueError as e:
        return bottle.template("registracija.tpl", napaka=e.args[0], uporabnik=None)


@bottle.get("/prijava/")
def prijava_get():
    return bottle.template("prijava.tpl", napaka=None, uporabnik=None)

@bottle.post("/prijava/")
def prijava_post():
    username = bottle.request.forms.getunicode("username")
    password = bottle.request.forms.getunicode("password")
    if not username:
        return bottle.template("prijava.tpl", napaka="Vnesi uporabniško ime!", uporabnik=None)
    try:
        Uporabnik.prijava(username, password)
        bottle.response.set_cookie(
            PISKOTEK_UPORABNISKO_IME, username, path="/", secret=SKRIVNOST
        )
        bottle.redirect("/")
    except ValueError as e:
        return bottle.template("prijava.tpl", napaka=e.args[0], uporabnik=None)


@bottle.get("/odjava/")
def odjava_get():
    uporabnik=trenutni_uporabnik()
    return bottle.template('odjava.tpl', uporabnik=uporabnik)


@bottle.post('/odjava/')
def odjava_post():
    uporabnik=trenutni_uporabnik()
    bottle.response.delete_cookie(PISKOTEK_UPORABNISKO_IME, path="/")
    bottle.redirect("/")




@bottle.get("/")
def osnovna_stran():
    bottle.redirect("/stanje/")

@bottle.get("/stanje/")
def nacrtovanje_stanja():
    uporabnik = trenutni_uporabnik()
    return bottle.template("stanje.tpl", uporabnik=uporabnik, stanje=uporabnik.stanje, poti=uporabnik.stanje.poti, sredstva=uporabnik.stanje.prevozna_sredstva)

@bottle.get("/poti/")
def poti():
    uporabnik = trenutni_uporabnik()
    return bottle.template("poti.tpl", uporabnik=uporabnik, stanje=uporabnik.stanje, napaka=None)

@bottle.get("/analiza/")
def analiza():
    return bottle.redirect("/analiza/skupno/")

@bottle.get("/pomoc/")
def pomoc():
    uporabnisko_ime = bottle.request.get_cookie(
    PISKOTEK_UPORABNISKO_IME, secret=SKRIVNOST
    )
    if uporabnisko_ime:
        uporabnik = trenutni_uporabnik()
        return bottle.template("pomoc.tpl", uporabnik=uporabnik)
    else:
        return bottle.template("pomoc.tpl", uporabnik=None)

@bottle.post("/dodaj-sredstvo/")
def dodaj_sredstvo():
    uporabnik = trenutni_uporabnik()
    for sredstvo in SREDSTVA:
        if bottle.request.forms.getunicode(sredstvo) == 'True' and (sredstvo not in uporabnik.stanje.prevozna_sredstva_po_imenih):
            uporabnik.stanje.dodaj_sredstvo(sredstvo)
    shrani_stanje(uporabnik)
    sez = []
    for sredstvo in SREDSTVA:
        if bottle.request.forms.getunicode(sredstvo) != 'True' and (sredstvo in uporabnik.stanje.prevozna_sredstva_po_imenih):
            sez.append(sredstvo)
    if sez:
        return bottle.template('odstrani_sredstvo.tpl', uporabnik=uporabnik, sredstva=sez)
    else:
        bottle.redirect("/")


@bottle.post('/odstrani-sredstvo/')
def odstrani_sredstvo_post():
    uporabnik=trenutni_uporabnik()
    for sredstvo in SREDSTVA:
        print(sredstvo)
        if bottle.request.forms.getunicode(sredstvo) == 'True':
            print('odstranjujem')
            uporabnik.stanje.odstrani_sredstvo(sredstvo)
    shrani_stanje(uporabnik)
    bottle.redirect("/")

@bottle.post("/dodaj-pot/")
def dodaj_pot():
    uporabnik = trenutni_uporabnik()
    try:
        zacetek = bottle.request.forms.getunicode("zacetek")
        konec = bottle.request.forms.getunicode("konec")
        datum = bottle.request.forms.getunicode("datum")
        ime_sredstva = bottle.request.forms.getunicode("sredstvo")
        uporabnik.stanje.dodaj_pot(zacetek, konec, ime_sredstva, datum)
        shrani_stanje(uporabnik)
        bottle.redirect("/poti/")
    except ValueError as e:
        return bottle.template('poti.tpl', napaka=e.args[0], uporabnik=uporabnik, stanje=uporabnik.stanje)

@bottle.get('/analiza/<ime_sredstva>/')
def prikazi_sredstvo(ime_sredstva):
    uporabnik = trenutni_uporabnik()
    if ime_sredstva == 'skupno':
        return bottle.template('prikazi_skupno_stanje.tpl', uporabnik=uporabnik, stanje=uporabnik.stanje, sredstva=uporabnik.stanje.prevozna_sredstva)
    try:
        sredstvo = uporabnik.stanje.poisci_sredstvo(ime_sredstva)
        return bottle.template('prikazi_sredstvo.tpl',  napaka=None, napaka_znesek=None, uporabnik=uporabnik, sredstvo=sredstvo, sredstva=uporabnik.stanje.prevozna_sredstva)
    except KeyError as e:
        return bottle.template('prikazi_sredstvo.tpl',  napaka=e.args[0], napaka_znesek=None, uporabnik=uporabnik, sredstva=uporabnik.stanje.prevozna_sredstva)


@bottle.post('/dodaj-strosek/')
def dodaj_strosek():
    uporabnik = trenutni_uporabnik()
    ime_sredstva = bottle.request.forms.getunicode("sredstvo")
    sredstvo = poisci_sredstvo(uporabnik.stanje, 'sredstvo')
    znesek = bottle.request.forms.getunicode("znesek")
    print(ime_sredstva, sredstvo, znesek)
    try:
        sredstvo.dodaj_strosek(znesek)
        shrani_stanje(uporabnik)
        bottle.redirect(f"/analiza/{ime_sredstva}/")
    except ValueError as e:
        return bottle.template('prikazi_sredstvo.tpl', napaka=None, napaka_znesek=e.args[0], uporabnik=uporabnik, sredstvo = sredstvo, sredstva=uporabnik.stanje.prevozna_sredstva)

    
@bottle.post("/odstrani-pot/")
def odstrani_pot():
    uporabnik = trenutni_uporabnik()



    

@bottle.post("/pomembnost-casa/")
def pomembnost_casa():
    uporabnik = trenutni_uporabnik()
    pomembnost = bottle.request.forms.getunicode("pomembnost_casa")
    uporabnik.nastavi_pomembnost_casa(pomembnost)
    shrani_stanje(uporabnik)
    bottle.redirect("/")

@bottle.post("/pomembnost-onesnazevanja/")
def pomembnost_onesnazevanja():
    uporabnik = trenutni_uporabnik()
    pomembnost = bottle.request.forms.getunicode("pomembnost_onesnazevanja")
    print(pomembnost)
    uporabnik.nastavi_pomembnost_onesnazevanja(pomembnost)
    shrani_stanje(uporabnik)
    bottle.redirect("/")


bottle.run(reloader=True, debug=True)