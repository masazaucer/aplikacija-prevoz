% rebase('analiza.tpl')


<h1>{{sredstvo.ime}}</h1>

<ul class="collapsible">
    <li>
      <div class="collapsible-header"><i class="material-icons">ev_station</i>Poraba CO2</div>
      <div class="collapsible-body"><span>Proizvedel si {{sredstvo.izpusti_co2()}} gramov CO2.</span></div>
    </li>
    <li>
      <div class="collapsible-header"><i class="material-icons">euro_symbol</i>Cena  
        <form action="/dodaj-strosek.tpl/" method="POST"></form>
            <button class="btn waves-effect waves-light" type="submit" name="action">Dodaj strošek
            <i class="material-icons right">add</i>
            </button>
        </form>
       </div>
      <div class="collapsible-body"><span>Porabil si {{sredstvo.skupna_cena_sredstva()}} €.</span></div>
    </li>
    <li>
      <div class="collapsible-header"><i class="material-icons">access_time</i>Čas</div>
      <div class="collapsible-body"><span>Vozil si se {{sredstvo.skupno_trajanje() / 360}} ur.</span></div>
    </li>
    <li>
        <div class="collapsible-header"><i class="material-icons">directions</i><i class="material-icons">map</i>Skupna razdalja</div>
        <div class="collapsible-body"><span>Vozil si se {{sredstvo.skupna_dolzina() / 1000}} kilometrov.</span></div>
    </li>
  </ul>