from re import I
import googlemaps
import json
import requests
import math

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
    def __init__(self, zacetek, konec, sredstvo):
        self.zacetek = zacetek
        self.konec = konec
        self.sredstvo = sredstvo

    def __str__(self):
        return f'Pot({self.zacetek}, {self.konec}, {self.sredstvo}, {self.cena}€)'

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
    def cena(self):
        if self.sredstvo == 'driving':
            c = STROSEK_AVTOMOBILA_NA_KM * self.razdalja()["razdalja"] / 1000
        elif self.sredstvo == 'bus' or self.sredstvo == 'train':
            c = CENA_VLAK_NA_KM * self.razdalja()["razdalja"] / 1000
        else:
            c = 0
        
        return c

    #izračuna količino izpustov CO2, proizvedenih s potjo v tonah
    def izracunaj_izpuste(self):
        if self.sredstvo == "driving":
            return self.razdalja()["razdalja"] * CO2_NA_KM_AVTO * 10 **(-9)
        elif self.sredstvo == "train":
            return self.razdalja()["razdalja"] * CO2_NA_KM_VLAK * 10 **(-9)
        elif self.sredstvo == "bus":
            return self.razdalja()["razdalja"] * CO2_NA_KM_BUS * 10 **(-9)
        else:
            return 0


    #določi optimalno prevozno sredstvo za dano začetno in končno točko
    def optimalna_pot(self, preferenca_cas=None, preferenca_onesnazevanje=None):
        min = math.inf
        for sredstvo in SREDSTVA:
            
            pot = Pot(self.zacetek, self.konec, sredstvo)
            if not pot:
                continue
            else:
                i = indeks(pot.trajanje(), pot.izracunaj_izpuste(), pot.cena(), preferenca_cas, preferenca_onesnazevanje)
                print(i)
                if i < min:
                    optimalna = pot
                    min = i
        return optimalna



class Prevozno_sredstvo:
    def __init__(self, ime, poraba=0):
        self.ime = ime
        self.poraba = poraba
        self.poti = []
        self.cena = 0

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

    def skupna_cena_sredstva(self):
        cena = self.cena
        for pot in self.poti:
            cena += pot.cena()
        return cena
    
    def stevilo_poti(self):
        return len(self.poti)

    def dodaj_strosek(self, strosek):
        self.cena += strosek
        return self.cena

    def izpusti_co2(self):
        izpusti = 0
        for pot in self.poti:
            izpusti += pot.izpusti()
        return izpusti

    def dodaj_pot(self, pot):
        self.poti.append(pot)

    def odstrani_pot(self, pot):
        self.poti.remove(pot)

    def podvoji_pot(self, pot):
        self.poti.append(pot)


class Stanje:
    def __init__(self):
        self.prevozna_sredstva = []
        self.poti = []
        self.aktualno_sredstvo = None
        self.prevozna_sredstva_po_imenih = {}
        self.poti_po_sredstvih = {}

    def dodaj_sredstvo(self, ime):
        if ime in self.prevozna_sredstva_po_imenih:
            raise ValueError('Prevozno sredstvo s tem imenom že obstaja!')
        nov = Prevozno_sredstvo(ime)
        self.prevozna_sredstva.append(nov)
        self.prevozna_sredstva_po_imenih[ime] = nov
        self.poti_po_sredstvih[nov] = []
        return nov

    def izberi_sredstvo(self, sredstvo):
        for i in self.prevozna_sredstva:
            if i.ime == sredstvo:
                self.aktualno_sredstvo = i
                return i
        print('To sredstvo ne obstaja!')

    def odstrani_sredstvo(self, sredstvo):
        self.preveri_sredstvo(sredstvo)
        for pot in sredstvo.poti():
            self.poti_po_sredstvih[None].append(pot)
        self.prevozna_sredstva.remove(sredstvo)
        del self.poti_po_sredstvih[sredstvo]

    def dodaj_pot(self, zacetek, konec, sredstvo):
        self.preveri_sredstvo(sredstvo)
        nova = Pot(zacetek, konec, sredstvo)
        self.poti.append(nova)
        self.poti_po_sredstvih[sredstvo].append(nova)
        return nova


    def poisci_sredstvo(self, ime):
        return self.sredstva_po_imenih[ime]

    def poti_sredstva(self, sredstvo):
        yield from self.poti_po_sredstvih[sredstvo]

    def preveri_sredstvo(self, sredstvo):
        if sredstvo not in self.prevozna_sredstva:
            raise ValueError(f'Prevozno sredstvo "{sredstvo.ime}" ne obstaja')

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

    def stevilo_poti(self):
        st = 0
        for sredstvo in self.prevozna_sredstva:
            st += sredstvo.stevilo_poti()
        return st


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

    def iz_slovarja(cls, slovar):
        stanje = cls()
        for sredstvo in slovar["prevozna sredstva"]:
            novo_sredstvo = stanje.dodaj_sredstvo(sredstvo["ime"])

        for pot in slovar["poti"]:
            stanje.dodaj_pot(
                pot["začetek"],
                pot["konec"],
                pot["sredstvo"],
            )
        return stanje


    def shrani_stanje(self, ime_dat):
        with open(ime_dat, "w") as dat:
            json.dump(self.slovar_s_stanjem(), dat, ensure_ascii=False, indent=4)


    def nalozi_stanje(cls, ime_dat):
        with open(ime_dat) as dat:
            slovar_s_stanjem = json.load(dat)
        return cls.iz_slovarja(slovar_s_stanjem)