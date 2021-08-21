from re import I
import googlemaps
import json
import requests
import math
from datetime import date
import hashlib
import random

CENA_NA_KM = 8*1.268/100 #€/l
CO2_NA_KM_AVTO = 180 #g/km
CO2_NA_KM_BUS = 90 #g/km
CO2_NA_KM_VLAK = 45 #g/km
CENA_GORIVA = 1.268 #€/l
CENA_IZPUSTOV_VISOKA = 500 #€/t CO2
CENA_IZPUSTOV_SREDNJA = 270 #€/t CO2
CENA_IZPUSTOV_NIZKA = 156 #€/t CO2
CENA_CASA_VISOKA = 0.14 #€/min
CENA_CASA_SREDNJA = 0.08 #€/min
CENA_CASA_NIZKA = 0.02 #€/min
STROSEK_AVTOMOBILA_NA_KM = 0.15 #€/km
CENA_VLAK_NA_KM = 0.1 #€/km

API_KEY = 'AIzaSyCtY_U7vcBuZna2_j4TiCxl9tUuSKL_8mM'
SREDSTVA = ["walking", "bicycling", "driving", "train", "bus"]

map_client = googlemaps.Client(API_KEY)

zacetni_url = "https://maps.googleapis.com/maps/api/distancematrix/json?units=metric"

class Uporabnik:
    def __init__(self, uporabnisko_ime, zasifrirano_geslo, stanje):
        self.uporabnisko_ime = uporabnisko_ime
        self.zasifrirano_geslo = zasifrirano_geslo
        self.stanje = stanje
        self.pomembnost_casa = None
        self.pomembnost_onesnazevanja = None
    
    @staticmethod
    def ime_uporabnikove_datoteke(uporabnisko_ime):
        return f"{uporabnisko_ime}.json"


    @staticmethod
    def prijava(uporabnisko_ime, geslo_v_cistopisu):
        uporabnik = Uporabnik.iz_datoteke(uporabnisko_ime)
        if uporabnik is None:
            raise ValueError("Uporabniško ime ne obstaja!")
        elif uporabnik.preveri_geslo(geslo_v_cistopisu):
            return uporabnik        
        else:
            raise ValueError("Geslo je napačno")

    @staticmethod
    def registracija(uporabnisko_ime, geslo_v_cistopisu):
        if Uporabnik.iz_datoteke(uporabnisko_ime) is not None:
            raise ValueError("Uporabniško ime že obstaja")
        else:
            zasifrirano_geslo = Uporabnik._zasifriraj_geslo(geslo_v_cistopisu)
            uporabnik = Uporabnik(uporabnisko_ime, zasifrirano_geslo, Stanje())
            uporabnik.v_datoteko()
            return uporabnik

    def _zasifriraj_geslo(geslo_v_cistopisu, sol=None):
        if sol is None:
            sol = str(random.getrandbits(32))
        posoljeno_geslo = sol + geslo_v_cistopisu
        h = hashlib.blake2b()
        h.update(posoljeno_geslo.encode(encoding="utf-8"))
        return f"{sol}${h.hexdigest()}"

    def preveri_geslo(self, geslo_v_cistopisu):
        sol, _ = self.zasifrirano_geslo.split("$")
        return self.zasifrirano_geslo == Uporabnik._zasifriraj_geslo(geslo_v_cistopisu, sol)


    def v_slovar(self):
        return {
            "uporabnisko_ime": self.uporabnisko_ime,
            "zasifrirano_geslo": self.zasifrirano_geslo,
            "stanje": self.stanje.v_slovar(),
        }

    @staticmethod
    def iz_slovarja(slovar):
        uporabnisko_ime = slovar["uporabnisko_ime"]
        zasifrirano_geslo = slovar["zasifrirano_geslo"]
        stanje = Stanje.iz_slovarja(slovar["stanje"])
        return Uporabnik(uporabnisko_ime, zasifrirano_geslo, stanje)


    def v_datoteko(self):
        with open(
            Uporabnik.ime_uporabnikove_datoteke(self.uporabnisko_ime), "w") as datoteka:
            json.dump(self.v_slovar(), datoteka, ensure_ascii=False, indent=4)

    @staticmethod
    def iz_datoteke(uporabnisko_ime):
        try:
            with open(Uporabnik.ime_uporabnikove_datoteke(uporabnisko_ime)) as datoteka:
                slovar = json.load(datoteka)
                return Uporabnik.iz_slovarja(slovar)
        except FileNotFoundError:
            return None


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


#izračuna vrednost časa, ki ga porabiš za pot
def cena_casa(trajanje, preferenca_cas):
    if preferenca_cas:
        cena = CENA_CASA_VISOKA / 60 * trajanje
    elif preferenca_cas == None:
        cena = CENA_CASA_SREDNJA / 60 * trajanje
    else:
        cena = CENA_CASA_NIZKA / 60 * trajanje
    return cena

#izračuna vrednost izpustov CO2, ki jih proizvedeš s potjo
def cena_izpustov(izpusti, preferenca_onesnazevanje):
    if preferenca_onesnazevanje:
        cena = CENA_IZPUSTOV_VISOKA * izpusti
    elif preferenca_onesnazevanje == None:
        cena = CENA_IZPUSTOV_SREDNJA * izpusti
    else:
        cena = CENA_IZPUSTOV_NIZKA * izpusti
    return cena

#izračuna celotno ceno poti skupaj z navideznimi stroški časa in izpustov CO2
def indeks(trajanje, izpusti, cena, preferenca_cas=None, preferenca_onesnazevanje=None):
    return cena + cena_casa(trajanje, preferenca_cas) + cena_izpustov(izpusti, preferenca_onesnazevanje)


class Pot:
    def __init__(self, zacetek, konec, sredstvo, datum):
        self.zacetek = zacetek
        self.konec = konec
        self.sredstvo = sredstvo
        self.datum = datum

    def __str__(self):
        return f'Pot({self.zacetek}, {self.konec}, {self.sredstvo}, {self.datum})'

            
    #sestavi url za klic distance matrice preko API
    def url(self):
        if self.sredstvo == 'train' or self.sredstvo == 'bus':
            u = zacetni_url + "&origins=" + self.zacetek + "&destinations=" + self.konec + "&mode=transiting&transit_mode=" + self.sredstvo + "&key=" + API_KEY
            return u
        elif self.sredstvo == 'walking' or self.sredstvo == 'bicycling':
            u = zacetni_url + "&origins=" + self.zacetek + "&destinations=" + self.konec + "&mode=walking&key=" + API_KEY
            return u
        else:
            u = zacetni_url + "&origins=" + self.zacetek + "&destinations=" + self.konec + "&mode=" + self.sredstvo + "&key=" + API_KEY
            return u

    #izračuna prepotovano razdaljo med začetnim in končnim krajem z danim prevoznim sredstvom
    def razdalja(self):
        try:
            output = requests.get(self.url()).json()
            razd = output["rows"][0]["elements"][0]["distance"]["value"]
            kon = output['destination_addresses']
            zac = output['origin_addresses']
            
            return {"razdalja": razd, "zacetek": zac, "konec": kon}
        except KeyError:
            return None

    #izračuna čas, potreben za pot z danim prevoznim sredstvom
    def trajanje(self):
        try:
            output = requests.get(self.url()).json()
            if self.sredstvo == 'bicycling':
                return (output["rows"][0]["elements"][0]["duration"]["value"]) / 5
            else:
                return output["rows"][0]["elements"][0]["duration"]["value"]
        except KeyError:
            return None

    #izračuna dejansko ceno poti(gorivo, stroški uporabe avtomobila, približna ocena cene vozovnic na kilometer prepotovane poti z vlakom/busom)
    #loči vlak in bus?
    def cena(self):
        if self.sredstvo == 'driving':
            c = STROSEK_AVTOMOBILA_NA_KM * self.razdalja()["razdalja"] / 1000
        elif self.sredstvo == 'bus' or self.sredstvo == 'train':
            c = CENA_VLAK_NA_KM * self.razdalja()["razdalja"] / 1000
        else:
            c = 0
        
        return c

    #izračuna količino izpustov CO2, proizvedenih s potjo v tonah
    def izpusti(self):
        if self.sredstvo == "driving":
            return self.razdalja()["razdalja"] * CO2_NA_KM_AVTO * 10 **(-9)
        elif self.sredstvo == "train":
            return self.razdalja()["razdalja"] * CO2_NA_KM_VLAK * 10 **(-9)
        elif self.sredstvo == "bus":
            return self.razdalja()["razdalja"] * CO2_NA_KM_BUS * 10 **(-9)
        else:
            return 0


    #določi optimalno prevozno sredstvo za dano začetno in končno točko
    #povezi z razredom uporabnik
    def optimalna_pot(self, preferenca_cas=None, preferenca_onesnazevanje=None):
        min = math.inf
        optimalna = self
        for sredstvo in SREDSTVA:
            
            pot = Pot(self.zacetek, self.konec, sredstvo, self.datum)
            if not pot:
                continue
            else:
                i = indeks(pot.trajanje(), pot.izpusti(), pot.cena(), preferenca_cas, preferenca_onesnazevanje)
                print(i)
                if i < min:
                    optimalna = pot
                    min = i
        return optimalna

#odstrani?
    def spremeni_datum(self, dan, mesec, leto):
        self.datum = date(leto, mesec, dan)


class Prevozno_sredstvo:
    def __init__(self, ime):
        self.ime = ime
        self.poti = []
        self.optimalne = []
        self.cena = 0

    def ime_slo(self):
        if self.ime == 'driving':
            return 'Avto'
        elif self.ime == 'walking':
            return 'Hoja'
        elif self.ime == 'bicycling':
            return 'Kolo'
        elif self.ime == 'train':
            return 'Vlak'
        else:
            return 'Bus'

    def skupna_dolzina(self):
        d = 0
        for pot in self.poti:
            d += pot.razdalja()['razdalja']
        return d
    
    def skupno_trajanje(self):
        t = 0
        for pot in self.poti:
            t += pot.trajanje()
        return t
    
    def skupna_cena(self):
        c = 0
        for pot in self.poti:
            c += pot.cena()
        return c

    def skupna_cena_sredstva(self):
        cena_sredstva = self.cena
        cena_poti = self.skupna_cena()
        return cena_sredstva + cena_poti

    def izpusti_co2(self):
        izpusti = 0
        for pot in self.poti:
            izpusti += pot.izpusti()
        return izpusti
    
    def stevilo_poti(self):
        return len(self.poti)

    def dodaj_strosek(self, strosek):
        self.cena += strosek
        return self.cena

    def skupna_dolzina_optimalno(self):
        d = 0
        for pot in self.optimalne:
            d += pot.razdalja()['razdalja']
        return d

    def skupno_trajanje_optimalno(self):
        t = 0
        for pot in self.optimalne:
            t += pot.trajanje()
        return t

    def skupna_cena_optimalno(self):
        c = 0
        for pot in self.optimalne:
            c += pot.cena()
        return c

    def izpusti_co2_optimalno(self):
        izpusti = 0
        for pot in self.optimalne:
            izpusti += pot.izpusti()
        return izpusti

#dodaj preferenco
    def dodaj_pot(self, pot):
        self.poti.append(pot)
        self.optimalne.append(pot.optimalna_pot())

    def odstrani_pot(self, pot):
        self.poti.remove(pot)

    def podvoji_pot(self, pot):
        self.poti.append(pot)


class Stanje:
    def __init__(self):
        self.prevozna_sredstva = []
        self.poti = []
        self.optimalne = []
        self.prevozna_sredstva_po_imenih = {}
        self.poti_po_sredstvih = {}
        self.optimalne_po_sredstvih = {}

    def dodaj_sredstvo(self, ime):
        if ime in self.prevozna_sredstva_po_imenih:
            raise ValueError(f'Prevozno sredstvo {ime} že obstaja!')
        nov = Prevozno_sredstvo(ime)
        self.prevozna_sredstva.append(nov)
        self.prevozna_sredstva_po_imenih[ime] = nov
        self.poti_po_sredstvih[nov] = []
        self.optimalne_po_sredstvih[nov] = []
        return nov

    def odstrani_sredstvo(self, ime):
        if ime in self.prevozna_sredstva_po_imenih:
            sredstvo = self.prevozna_sredstva_po_imenih[ime]
            for pot in sredstvo.poti:
                self.poti_po_sredstvih[None].append(pot)
            self.prevozna_sredstva.remove(sredstvo)
            del self.poti_po_sredstvih[sredstvo]
            del self.optimalne_po_sredstvih[sredstvo]
            del self.prevozna_sredstva_po_imenih[ime]
        else:
            return None

# treba je vključiti še preference
    def dodaj_pot(self, zacetek, konec, sredstvo, datum):
        if sredstvo in self.prevozna_sredstva_po_imenih:
            nova = Pot(zacetek, konec, sredstvo, datum)
            self.poti.append(nova)
            self.optimalne.append(nova.optimalna_pot())
            self.poti_po_sredstvih[self.prevozna_sredstva_po_imenih[sredstvo]].append(nova)
            self.optimalne_po_sredstvih[self.prevozna_sredstva_po_imenih[sredstvo]].append(nova.optimalna_pot())
            self.prevozna_sredstva_po_imenih[sredstvo].dodaj_pot(nova)
            return nova
        else:
            raise ValueError(f'Prevozno sredstvo "{sredstvo}" ne obstaja')


    def poisci_sredstvo(self, ime):
        return self.prevozna_sredstva_po_imenih[ime]

    def poti_sredstva(self, ime):
        yield from self.poti_po_sredstvih[self.poisci_sredstvo(ime)]

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
            c += sredstvo.skupna_cena_sredstva()
        return c

    def skupni_izpusti(self):
        c = 0
        for sredstvo in self.prevozna_sredstva:
            c += sredstvo.izpusti_co2()
        return c

    def stevilo_poti(self):
        st = 0
        for sredstvo in self.prevozna_sredstva:
            st += sredstvo.stevilo_poti()
        return st

    # def optimalne_poti(self):
    #     optimalne = []
    #     for pot in self.poti:
    #         optimalne.append(pot.optimalna_pot(uporabnik.preferenca_cas, uporabnik.preferenca_onesnazevanje))



    def v_slovar(self):
            return {
                "prevozna sredstva": [
                    {
                        "ime": sredstvo.ime,
                    }
                    for sredstvo in self.prevozna_sredstva
                ],
                "poti": [
                    {
                        "začetek": pot.zacetek,
                        "konec": pot.konec,
                        "sredstvo": pot.sredstvo,
                        "datum": str(pot.datum),
                    }
                    for pot in self.poti
                ],
            }
    @staticmethod
    def iz_slovarja(cls, slovar):
        stanje = cls()
        for sredstvo in slovar["prevozna sredstva"]:
            stanje.dodaj_sredstvo(sredstvo["ime"])

        for pot in slovar["poti"]:
            stanje.dodaj_pot(
                pot["začetek"],
                pot["konec"],
                pot["sredstvo"],
                pot["datum"]
            )
        return stanje
        

    def shrani_stanje(self, ime_datoteke):
        with open(ime_datoteke, "w") as datoteka:
            json.dump(self.v_slovar(), datoteka, ensure_ascii=False, indent=4)

    @classmethod
    def nalozi_stanje(cls, ime_datoteke):
        with open(ime_datoteke) as datoteka:
            slovar_s_stanjem = json.load(datoteka)
        return cls.iz_slovarja(slovar_s_stanjem)