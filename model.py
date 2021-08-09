from re import I
import googlemaps
import json
import requests
import math

CENA_NA_KM = 8*1.268/100
CO2_NA_KM = 180 #g/km
CENA_GORIVA = 1.268
API_KEY = 'AIzaSyCtY_U7vcBuZna2_j4TiCxl9tUuSKL_8mM'
SREDSTVA = ["walking", "bicycling", "driving", "train", "bus"]

map_client = googlemaps.Client(API_KEY)

zacetni_url = "https://maps.googleapis.com/maps/api/distancematrix/json?units=metric"

class Uporabnik:
    def __init__(self, ime):
        self.ime = ime
        self.pomembnost_casa = None
        self.pomembnost_onesnazevanja = None
    

    def nastavi_pomembnost_casa(self, vrednost):
        if vrednost == 'zelo':
            self.pomembnost_casa = True
        elif vrednost == 'malo':
            self.pomembnost_casa = False

    def nastavi_pomembnost_onesnazevanja(self, vrednost):
        if vrednost == 'zelo':
            self.pomembnost_onesnazevanja = True
        elif vrednost == 'malo':
            self.pomembnost_onesnazevanja = False

class Pot:
    def __init__(self, zacetek, konec, sredstvo, cena):
        self.zacetek = zacetek
        self.konec = konec
        self.sredstvo = sredstvo
        self.cena = cena

    def __str__(self):
        return f'Pot({self.zacetek}, {self.konec}, {self.sredstvo}, {self.cena}$)'

    def url(self):
        if self.sredstvo == 'train' or self.sredstvo == 'bus':
            u = zacetni_url + "&origins=" + self.zacetek + "&destinations=" + self.konec + "&mode=transiting&transit_mode=" + self.sredstvo + "&key=" + API_KEY
            return u
        else:
            u = zacetni_url + "&origins=" + self.zacetek + "&destinations=" + self.konec + "&mode=" + self.sredstvo + "&key=" + API_KEY
            return u
    #sestavi url za klic distance matrice preko API


    def razdalja(self):
        output = requests.get(self.url).json()
        return output["rows"][0]["elements"][0]["distance"]["value"]

    def trajanje(self):
        output = requests.get(self.url).json()
        return output["rows"][0]["elements"][0]["duration"]["value"]

    def izracunana_cena(self):
        if self.sredstvo == 'driving':
            self.cena += CENA_NA_KM * self.razdalja()
        else:
            self.cena = 0

    def izracunaj_izpuste(self):
        self.izpusti = self.razdalja() * CO2_NA_KM


def indeks(razdalja, trajanje, izpusti, sredstvo):
    pass

    def optimalna_pot(self):
        min = math.inf
        optimalno = ''
        for sredstvo in SREDSTVA:
            i = indeks(self.razdalja(), self.trajanje(), self.izracunaj_izpuste(), sredstvo)
            if i < min:
                optimalno = sredstvo
                min = i
        return Pot(self.zacetek, self.konec, optimalno, self.cena)



class Prevozno_sredstvo:
    def __init__(self, ime, poraba):
        self.ime = ime
        self.poraba = poraba
        self.poti = []
        self.cena = CENA_GORIVA * poraba
        self.cena = 0
        self.izpusti = 0

    def skupna_dolzina(self):
        d = 0
        for pot in self.poti:
            d += pot.razdalja()
        return d
    
    def skupno_trajanje(self):
        t = 0
        for pot in self.poti:
            t += pot.trajanje()
        return t
    
    def stevilo_poti(self):
        return len(self.poti)

    def dodaj_strosek(self, strosek):
        self.cena += strosek
        return self.cena

    def izpusti_co2(self):
        for pot in self.poti:
            self.izpusti += pot.izpusti()
        return self.izpusti

    def dodaj_pot(self, pot):
        self.poti.append(pot)

    def odstrani_pot(self, pot):
        self.poti.remove(pot)

    def podvoji_pot(self, pot):
        self.poti.append(pot)


class Stanje:
    def __init__(self):
        self.prevozna_sredstva = []
        self.aktualno_sredstvo = None
        self.skupna_razdalja = 0
        self.cena = 0
        self.trajanje = 0

    def dodaj_sredstvo(self, sredstvo):
        self.prevozna_sredstva.append(sredstvo)

    def zamenjaj_sredstvo(self, sredstvo):
        self.aktualno_sredstvo = sredstvo

    def dodaj_pot(self, pot):
        self.aktualno_sredstvo.dodaj_pot(pot)

    def izbrisi_pot(self, pot):
        self.aktualno_sredstvo.pobrisi_pot(pot)


    def skupna_razdalja(self):
        d = 0
        for sredstvo in self.prevozna_sredstva:
            d += sredstvo.skupna_dolzina()
        return d

    def skupno_trajanje(self):
        t = 0
        for sredstvo in self.prevozna_sredstva:
            t += sredstvo.skupno_trajanje()
        return t      

    def skupna_cena(self):
        c = 0
        for sredstvo in self.prevozna_sredstva:
            c += sredstvo.cena
        return c

    def stevilo_poti(self):
        st = 0
        for sredstvo in self.prevozna_sredstva:
            st += sredstvo.stevilo_poti()
        return st