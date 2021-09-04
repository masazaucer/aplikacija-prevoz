% rebase('base.tpl', izbrani_zavihek='pomoc')
<body>

% if not uporabnik:
<div class = "center">
    <h4>
        Pozdravljen!
        Tu lahko spremljaš svoje navade glede uporabe prevoznih sredstev in vidiš, kaj bi lahko izboljšal za varovanje našega planeta.
    </h4>
        <br>
    <h5> 
        Če že imaš profil, se za ogled in dodajanje svojih poti prijavi tukaj:
    </h5>
    <p>
        <form action="/prijava/" method="GET">
            <button class="btn waves-effect waves-light" type="submit" name="action">Prijava</button>
        </form>
        <br>
    </p>
    <h5>
        Če pa profila še nimaš, se najprej registriraj:
    </h5>
    <p>
        <form action="/registracija/" method="GET">
            <button class="btn waves-effect waves-light" type="submit" name="action">Registracija</button>
        </form>
    </p>
    <br>
</div>



% else:
<div class="center">
    <h4>Pozdravljen, dobrodošel v svojem profilu Zeleni voznik!</h4>
</div>


<div class="row">

    <div class="col s4">
        <form action="/stanje/" method="GET">
            <button class="btn waves-effect waves-light" type="submit" name="action">Dodaj sredstva
                <i class="material-icons right">add</i>
            </button>
        </form>
        <p>
            Preden začneš z dodajanjem prepotovanih poti, izberi prevozna sredstva, ki jih imaš na razpolago.
            Na isti strani lahko tudi izbereš, kako dragocen ti je čas, ki ga porabiš za pot in kako pomembno ti je varovanje okolja.
            Ta podatek nam bo koristil pri iskanju optimalnega sredstva za tvoje prepotovane poti.
        </p>
    </div>

    <div class="col s4">
        <form action="/poti/" method="GET">
            <button class="btn waves-effect waves-light" type="submit" name="action">Dodaj pot
                <i class="material-icons right">add</i>
            </button>
        </form>
        <p>
            Svoje poti lahko dodajaš tukaj:
            V tabeli boš nato videl vse podatke o svoji poti (trajanje, prepotovano razdaljo, ceno in izpuste CO2) pa tudi katero sredstvo bi bilo optimalno in kakšni podatki bi bili v primeru, če bi le tega izbral za svojo pot.
            Optimalno sredstvo je določeno na podlagi indeksa, v katerem se trajanje potovanja in vrednost izpustov CO2 izrazi v evrih. Sredstvo z najmanjšim indeksom (najnižjo skupno ceno) je optimalno.
        </p>    
    </div>

    <div class="col s4">
        <form action="/analiza/" method="GET">
            <button class="btn waves-effect waves-light" type="submit" name="action">Analiza</button>
        </form>
        <p>
            Če te zanima, kakšni so tvoji rezultati, pa si lahko ogledaš analizo tvojih potovalnih navad:
        </p>
    </div>

</div>









% end

</body>
