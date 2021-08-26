% rebase('base.tpl', izbrani_zavihek='pomoc')

<p>
    Pozdravljen, dobrodošel v svojem profilu Zeleni voznik!
    Tu lahko spremljaš svoje navade glede uporabe prevoznih sredstev in vidiš, kaj bi lahko izboljšal za varovanje našega planeta.

</p>

<p>
    Preden začneš z dodajanjem prepotovanih poti, izberi prevozna sredstva, ki jih imaš na razpolago. To lahko storiš tukaj:
    <form action="/stanje/" method="GET">
        <button class="btn waves-effect waves-light" type="submit" name="action">Dodaj sredstva
          <i class="material-icons right">add</i>
      </button>
    </form>
</p>

<p>
    Na isti strani lahko tudi izbereš, kako dragocen ti je čas, ki ga porabiš za pot in kako pomembno ti je varovanje okolja.
    Ta podatek nam bo koristil pri iskanju optimalnega sredstva za tvoje prepotovane poti.
</p>

<p>
    Svoje poti lahko dodajaš tukaj:
    <form action="/poti/" method="GET">
        <button class="btn waves-effect waves-light" type="submit" name="action">Dodaj pot
          <i class="material-icons right">add</i>
      </button>
    </form>
    Ko vneseš pot, počakaj, da program pridobi vse ustrezne podatke, kar lahko traja nekaj trenutkov.
    V tabeli boš nato videl vse podatke o svoji poti (trajanje, prepotovano razdaljo, ceno in izpuste CO2) pa tudi katero sredstvo bi bilo optimalno in kakšni podatki bi bili v primeru, če bi le tega izbral za svojo pot.
    Optimalno sredstvo je določeno na podlagi indeksa, v katerem se trajanje potovanja in vrednost izpustov CO2 izrazi v evrih. Sredstvo z najmanjšim indeksom (najnižjo skupno ceno) je optimalno. 
</p>

<p>
    
</p>
