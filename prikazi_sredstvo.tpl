% rebase('analiza.tpl')


<h1>{{sredstvo.ime}}</h1>

<ul class="collapsible">
    <li>
      <div class="collapsible-header"><i class="material-icons">filter_drama</i>Poraba CO2</div>
      <div class="collapsible-body"><span>Proizvedel si {{sredstvo.izpusti_co2()}} CO2.</span></div>
    </li>
    <li>
      <div class="collapsible-header"><i class="material-icons">place</i>Cena  
        <form action="/dodaj-strosek.tpl/" method="POST"></form>
            <button class="btn waves-effect waves-light" type="submit" name="action">Dodaj strošek
            <i class="material-icons right">add</i>
            </button>
        </form>
       </div>
      <div class="collapsible-body"><span>Porabil si {{sredstvo.skupna_cena_sredstva()}} €.</span></div>
    </li>
    <li>
      <div class="collapsible-header"><i class="material-icons">whatshot</i>Čas</div>
      <div class="collapsible-body"><span>Vozil si se {{sredstvo.skupno_trajanje()}} sekund.</span></div>
    </li>
  </ul>