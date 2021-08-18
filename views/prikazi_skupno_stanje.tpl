% rebase('analiza.tpl')

<h1>Skupno<h1>

<ul class="collapsible">
    <li>
        <div class="collapsible-header"><i class="material-icons">ev_station</i>Poraba CO2</div>
        <div class="collapsible-body"><span>Proizvedel si {{stanje.skupi_izpusti()}} gramov CO2.</span></div>
    </li>
    <li>
        <div class="collapsible-header"><i class="material-icons">euro_symbol</i>Cena</div>
        <div class="collapsible-body"><span>Porabil si {{stanje.skupna_cena()}} €.</span></div>
    </li>
    <li>
        <div class="collapsible-header"><i class="material-icons">access_time</i>Čas</div>
        <div class="collapsible-body"><span>Vozil si se {{stanje.skupno_trajanje() / 360}} ur.</span></div>
    </li>
        <li>
        <div class="collapsible-header"><i class="material-icons">directions</i><i class="material-icons">map</i>Skupna razdalja</div>
        <div class="collapsible-body"><span>Vozil si se {{stanje.skupna_razdalja() / 1000}} kilometrov.</span></div>
    </li>
</ul>