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
        return self.cena