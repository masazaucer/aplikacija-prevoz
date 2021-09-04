from re import I
import googlemaps
import json
import requests
import math
from datetime import date
import hashlib
import random

CO2_NA_KM_AVTO = 180 #g/km
CO2_NA_KM_BUS = 90 #g/km
CO2_NA_KM_VLAK = 45 #g/km
CENA_IZPUSTOV_VISOKA = 500 #€/t CO2
CENA_IZPUSTOV_SREDNJA = 270 #€/t CO2
CENA_IZPUSTOV_NIZKA = 156 #€/t CO2
CENA_CASA_VISOKA = 0.18 #€/min
CENA_CASA_SREDNJA = 0.09 #€/min
CENA_CASA_NIZKA = 0.06 #€/min
STROSEK_AVTOMOBILA_NA_KM = 0.15 #€/km
CENA_VLAK_NA_KM = 0.1 #€/km

API_KEY = 'AIzaSyCtY_U7vcBuZna2_j4TiCxl9tUuSKL_8mM'
SREDSTVA = ["walking", "bicycling", "driving", "train", "bus"]

map_client = googlemaps.Client(API_KEY)

zacetni_url = "https://maps.googleapis.com/maps/api/distancematrix/json?units=metric"

class Uporabnik:
    def __init__(self, uporabnisko_ime, zasifrirano_geslo, stanje, pomembnost_casa=None, pomembnost_onesnazevanja=None):
        self.uporabnisko_ime = uporabnisko_ime
        self.zasifrirano_geslo = zasifrirano_geslo
        self.stanje = stanje
        self.pomembnost_casa = pomembnost_casa
        self.pomembnost_onesnazevanja = pomembnost_onesnazevanja
    
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

    @staticmethod
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
            "pomembnost_casa": self.pomembnost_casa,
            "pomembnost_onesnazevanja": self.pomembnost_onesnazevanja
        }

    @staticmethod
    def iz_slovarja(slovar):
        uporabnisko_ime = slovar["uporabnisko_ime"]
        zasifrirano_geslo = slovar["zasifrirano_geslo"]
        pomembnost_casa = slovar["pomembnost_casa"]
        pomembnost_onesnazevanja = slovar["pomembnost_onesnazevanja"]
        stanje = Stanje.iz_slovarja(slovar["stanje"])
        return Uporabnik(uporabnisko_ime, zasifrirano_geslo, stanje, pomembnost_casa, pomembnost_onesnazevanja)


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
        else:
            self.pomembnost_casa = None

    def nastavi_pomembnost_onesnazevanja(self, vrednost):
        
        if vrednost == 'zelo':
            self.pomembnost_onesnazevanja = True
        elif vrednost == 'malo':
            self.pomembnost_onesnazevanja = False
        else:
            self.pomembnost_onesnazevanja = None





class Pot:
    def __init__(self, zacetek, konec, sredstvo, datum, razdalja=None, trajanje=None, cena=None, izpusti=None, optimalna=None, pomembnost_casa=None, pomembnost_onesnazevanja=None, rec=True):
        self.zacetek = zacetek
        self.konec = konec
        self.sredstvo = sredstvo
        self.datum = datum
        
        if razdalja:
            self.razdalja = razdalja
        elif self.izracunana_razdalja_in_trajanje():
            self.razdalja = self.izracunana_razdalja_in_trajanje()[0]
        else:
            raise ValueError('Ne najdem poti!')
            
        if trajanje:
            self.trajanje = trajanje
        else:
            self.trajanje = self.izracunana_razdalja_in_trajanje()[1]
        
        if cena:
            self.cena = cena
        else:
            self.cena = self.izracunana_cena()
        
        if izpusti:
            self.izpusti = izpusti
        else:
            self.izpusti = self.izracunani_izpusti()
        
        if optimalna != None:
            self.optimalna = optimalna
        elif rec:
            self.optimalna = self.optimalna_pot(pomembnost_casa, pomembnost_onesnazevanja)


    def __str__(self):
        return f'Pot({self.zacetek}, {self.konec}, {self.sredstvo}, {self.datum})'


    # prevede ime sredstva v slovenščino
    def sredstvo_slo(self):
        return prevedi(self.sredstvo)

        
    #sestavi url za klic distance matrice preko API
    def url(self):
        if self.sredstvo == 'train' or self.sredstvo == 'bus':
            u = zacetni_url + "&origins=" + self.zacetek + "&destinations=" + self.konec + "&mode=transit&transit_mode=" + self.sredstvo + "&key=" + API_KEY
            return u
        elif self.sredstvo == 'walking' or self.sredstvo == 'bicycling':
            u = zacetni_url + "&origins=" + self.zacetek + "&destinations=" + self.konec + "&mode=walking&key=" + API_KEY
            return u
        elif self.sredstvo == 'driving':
            u = zacetni_url + "&origins=" + self.zacetek + "&destinations=" + self.konec + "&mode=" + self.sredstvo + "&key=" + API_KEY
            return u
        else:
            raise ValueError("Prevozno sredstvo ne obstaja!")

    #izračuna prepotovano razdaljo med začetnim in končnim krajem z danim prevoznim sredstvom
    def izracunana_razdalja_in_trajanje(self):
        try:
            output = requests.get(self.url()).json()
            razdalja = output["rows"][0]["elements"][0]["distance"]["value"]
            kon = output['destination_addresses']
            zac = output['origin_addresses']
            if self.sredstvo == 'bicycling':
                trajanje = (output["rows"][0]["elements"][0]["duration"]["value"]) / 3 #povprečna hitrost mestne vožnje s kolesom je 15km/h hoje pa 5km/h
            else:
                trajanje = output["rows"][0]["elements"][0]["duration"]["value"]
            
            return (razdalja, trajanje)
        except KeyError or IndexError:
            raise ValueError("Ta pot ne obstaja! Preveri vnešene podatke.")


    #izračuna dejansko ceno poti(gorivo, stroški uporabe avtomobila, približna ocena cene vozovnic na kilometer prepotovane poti z vlakom/busom)
    #loči vlak in bus?
    def izracunana_cena(self):
        if self.sredstvo == 'driving':
            c = STROSEK_AVTOMOBILA_NA_KM * self.izracunana_razdalja_in_trajanje()[0] / 1000
        elif self.sredstvo == 'train' or self.sredstvo == 'bus':
            c = CENA_VLAK_NA_KM * self.izracunana_razdalja_in_trajanje()[0] / 1000
        else:
            c = 0
        
        return c

    #izračuna količino izpustov CO2, proizvedenih s potjo v tonah
    def izracunani_izpusti(self):
        if self.sredstvo == "driving":
            return self.izracunana_razdalja_in_trajanje()[0] * CO2_NA_KM_AVTO * 10 **(-9)
        elif self.sredstvo == "train":
            return self.izracunana_razdalja_in_trajanje()[0] * CO2_NA_KM_VLAK * 10 **(-9)
        elif self.sredstvo == "bus":
            return self.izracunana_razdalja_in_trajanje()[0] * CO2_NA_KM_BUS * 10 **(-9)
        else:
            return 0


    #določi optimalno prevozno sredstvo za dano začetno in končno točko
    #povezi z razredom uporabnik
    def optimalna_pot(self, preferenca_cas=None, preferenca_onesnazevanje=None):
        min = math.inf
        optimalna = ''

        for sredstvo in SREDSTVA:
            
            pot = Pot(self.zacetek, self.konec, sredstvo, self.datum, rec=False)
            print(pot)
            if not pot:
                continue
            else:
                i = indeks(pot.trajanje, pot.izpusti, pot.cena, preferenca_cas, preferenca_onesnazevanje)
                print(i)
                if i < min:
                    optimalna = pot
                    min = i
        return {'zacetek': optimalna.zacetek, 'konec': optimalna.konec, 'sredstvo': optimalna.sredstvo, 'datum': optimalna.datum, 'razdalja': optimalna.razdalja, 'trajanje': optimalna.trajanje, 'cena': optimalna.cena, 'izpusti': optimalna.izpusti}


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

def prevedi(ime):
    if ime == 'driving':
        return 'Avto'
    elif ime == 'walking':
        return 'Hoja'
    elif ime == 'bicycling':
        return 'Kolo'
    elif ime == 'train':
        return 'Vlak'
    elif ime == 'bus':
        return 'Bus'
    else:
        return None

class Prevozno_sredstvo:
    def __init__(self, ime, cena=0):
        self.ime = ime
        self.poti = []
        self.optimalne = []
        self.cena = cena

    def ime_slo(self):
        return prevedi(self.ime)

    def skupna_dolzina(self):
        d = 0
        for pot in self.poti:
            d += pot.razdalja
        return d
    
    def skupno_trajanje(self):
        t = 0
        for pot in self.poti:
            t += pot.trajanje
        return t
    
    def skupna_cena(self):
        c = 0
        for pot in self.poti:
            c += pot.cena
        return c

    def skupna_cena_sredstva(self):
        print(self.cena)
        cena_sredstva = self.cena
        cena_poti = self.skupna_cena()
        skupaj = cena_sredstva + cena_poti
        print(cena_sredstva, cena_poti, skupaj)
        return skupaj

    def izpusti_co2(self):
        izpusti = 0
        for pot in self.poti:
            izpusti += pot.izpusti
        return izpusti

    def dodaj_strosek(self, strosek):
        if ',' in strosek:
            raise ValueError('Prosimo, uporabite piko!')
        elif strosek.isnumeric() or ("." in strosek) or ("-" in strosek and strosek[1:].isnumeric()):
            if self.cena + float(strosek) < 0:
                raise ValueError("Stroški ne morejo biti negativni!")
            self.cena += float(strosek)

            return self.cena
        else:
            raise ValueError('Prosim vnesite število!')


    def dodaj_pot(self, pot):
        self.poti.append(pot)
        self.optimalne.append(pot.optimalna)

    def odstrani_pot(self, pot):
        self.poti.remove(pot)
        self.optimalne.remove(pot.optimalna)



class Stanje:
    def __init__(self):
        self.prevozna_sredstva = []
        self.poti = []
        self.optimalne = []
        self.prevozna_sredstva_po_imenih = {}
        self.poti_po_sredstvih = {None: []}
        self.optimalne_po_sredstvih = {None: []}

    def dodaj_sredstvo(self, ime, cena=0):
        if ime in self.prevozna_sredstva_po_imenih:
            raise ValueError(f'Prevozno sredstvo {ime} že obstaja!')
        nov = Prevozno_sredstvo(ime, cena)
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
            for optimalna in sredstvo.optimalne:
                self.optimalne_po_sredstvih[None].append(optimalna)
            self.prevozna_sredstva.remove(sredstvo)
            del self.poti_po_sredstvih[sredstvo]
            del self.optimalne_po_sredstvih[sredstvo]
            del self.prevozna_sredstva_po_imenih[ime]
        else:
            return None

    # treba je vključiti še preference
    def dodaj_pot(self, zacetek, konec, sredstvo, datum, razdalja=None, trajanje=None, cena=None, izpusti=None, optimalna=None, rec=True):
        if sredstvo in self.prevozna_sredstva_po_imenih:
            nova = Pot(zacetek, konec, sredstvo, datum, razdalja, trajanje, cena, izpusti, optimalna, rec)
            sredstvo = self.poisci_sredstvo(sredstvo)
            print("dodajam stanju")
            self.poti.append(nova)
            self.optimalne.append(nova.optimalna)
            self.poti_po_sredstvih[sredstvo].append(nova)
            self.optimalne_po_sredstvih[sredstvo].append(nova.optimalna)
            sredstvo.dodaj_pot(nova)
            return nova
        elif razdalja == None:
            raise ValueError(f'Izbranega prevoznega sredstva nimate med svojimi sredstvi!')
        else:
            nova = Pot(zacetek, konec, sredstvo, datum, razdalja, trajanje, cena, izpusti, optimalna, rec=False)
            self.poti.append(nova)
            self.optimalne.append(nova.optimalna)
            self.poti_po_sredstvih[None].append(nova)
            self.optimalne_po_sredstvih[None].append(nova.optimalna)
            return nova



    def odstrani_pot(self, pot):
        if pot in self.poti:
            if pot.sredstvo in self.prevozna_sredstva_po_imenih:
                sredstvo = self.poisci_sredstvo(pot.sredstvo)
                self.poti_po_sredstvih[sredstvo].remove(pot)
                self.optimalne_po_sredstvih[sredstvo].remove(pot.optimalna)     
                self.poti.remove(pot)
                self.optimalne.remove(pot.optimalna) 
                sredstvo.odstrani_pot(pot)
            else:
                self.poti_po_sredstvih[None].remove(pot)
                self.optimalne_po_sredstvih[None].remove(pot.optimalna)     
                self.poti.remove(pot)
                self.optimalne.remove(pot.optimalna) 
        else:
            print('napaka')
            return None


    def poisci_sredstvo(self, ime):
        if ime in self.prevozna_sredstva_po_imenih:
            return self.prevozna_sredstva_po_imenih[ime]
        else:
            raise KeyError(f'Izbranega prevoznega sredstva nimaš med svojimi sredstvi!')

    def poisci_pot(self, zacetek, konec, sredstvo, datum):
        for pot in self.poti:
            if pot.zacetek == zacetek and pot.konec == konec and pot.sredstvo == sredstvo and pot.datum == datum:
                return pot
        raise ValueError('Ta pot ne obstaja!')

    #dodaj k analizi?
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

    def skupna_dolzina_optimalno(self):
        d = 0
        for pot in self.optimalne:
            d += pot["razdalja"]
        return d

    def skupno_trajanje_optimalno(self):
        t = 0
        for pot in self.optimalne:
            t += pot["trajanje"]
        return t

    def skupna_cena_optimalno(self):
        c = 0
        for pot in self.optimalne:
            c += pot["cena"]
        return c

    def izpusti_co2_optimalno(self):
        izpusti = 0
        for pot in self.optimalne:
            izpusti += pot["izpusti"]
        return izpusti

    def v_slovar(self):
            print("dodajam v slovar")
            return {
                "prevozna sredstva": [
                    {
                        "ime": sredstvo.ime,
                        "cena": sredstvo.cena
                    }
                    for sredstvo in self.prevozna_sredstva
                ],
                "poti": [
                    {
                        "zacetek": pot.zacetek,
                        "konec": pot.konec,
                        "sredstvo": pot.sredstvo,
                        "datum": str(pot.datum),
                        "razdalja": pot.razdalja,
                        "trajanje": pot.trajanje,
                        "cena": pot.cena,
                        "izpusti": pot.izpusti,
                        "optimalna": pot.optimalna
                    }
                    for pot in self.poti
                ],
            }
    @staticmethod
    def iz_slovarja(slovar):
        stanje = Stanje()
        for sredstvo in slovar["prevozna sredstva"]:
            stanje.dodaj_sredstvo(sredstvo["ime"], sredstvo["cena"])

        for pot in slovar["poti"]:
            stanje.dodaj_pot(
                pot["zacetek"],
                pot["konec"],
                pot["sredstvo"],
                pot["datum"],
                pot["razdalja"],
                pot["trajanje"],
                pot["cena"],
                pot["izpusti"],
                pot["optimalna"],
                rec=False
            )
        print("iz_slovarja")
        return stanje
        
    def shrani_stanje(self, ime_datoteke):
        print("shranjujem stanje")
        with open(ime_datoteke, 'w') as dat:
            slovar = self.v_slovar()
            json.dump(slovar, dat)
    
    @staticmethod
    def nalozi_stanje(ime_datoteke):
        print("nalagam stanje")
        with open(ime_datoteke) as dat:
            slovar = json.load(dat)
            print(slovar)
            return Stanje.iz_slovarja(slovar)