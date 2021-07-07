CENA_GORIVA = 1,20

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
    def __init__(self, zacetek, konec, cena):
        self.zacetek = zacetek
        self.konec = konec
        self.cena = cena

    def razdalja(self):
        return self.konec - self.zacetek

    def trajanje(self):
        return None

    def izracunaj_ceno(self):
        self.cena += cena_na_km * self.razdalja()

    def izracunaj_izpuste(self):
        self.izpusti = self.razdalja() * CO2_NA_KM

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
