% rebase('analiza.tpl')

<h1>Skupno<h1>

<ul class="collapsible">
    <li>
        <div class="collapsible-header"><i class="material-icons">filter_drama</i>Poraba CO2</div>
        <div class="collapsible-body"><span>Proizvedel si {{stanje.skupi_izpusti()}} CO2.</span></div>
    </li>
    <li>
        <div class="collapsible-header"><i class="material-icons">place</i>Cena</div>
        <div class="collapsible-body"><span>Porabil si {{stanje.skupna_cena()}} €.</span></div>
    </li>
    <li>
        <div class="collapsible-header"><i class="material-icons">whatshot</i>Čas</div>
        <div class="collapsible-body"><span>Vozil si se {{stanje.skupno_trajanje()}} sekund.</span></div>
    </li>
</ul>