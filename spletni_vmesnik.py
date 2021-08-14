import bottle
from model import Stanje, Uporabnik, Prevozno_sredstvo, Pot

DATOTEKA_S_STANJEM = "stanje.json"

try:
    stanje = Stanje.nalozi_stanje(DATOTEKA_S_STANJEM)
except FileNotFoundError:
    stanje = Stanje()

@bottle.get("/")
def osnovna_stran():
    return bottle.template('osnovna_stran.tpl', sredstva=stanje.prevozna_sredstva, poti=stanje.poti)

bottle.run(reloader=True, debug=True)