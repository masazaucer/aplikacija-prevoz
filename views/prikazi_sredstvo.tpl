% rebase('analiza.tpl', izbrani_zavihek='analiza_sredstvo')
<head>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0-alpha.4/css/materialize.min.css">
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  
  <script type = "text/javascript" src = "https://code.jquery.com/jquery-2.1.1.min.js"></script>           
  <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0-alpha.4/js/materialize.min.js"></script>
  
</head>

<body>
  <div class="container">
    <h2>{{sredstvo.ime_slo()}}</h2>
    % if napaka_znesek:
    <div class="center">
      <h4>{{napaka_znesek}}<h4>
    </div>
    % end
    <ul class="collapsible">
      <li>
        <div class="collapsible-header"><i class="material-icons">ev_station</i>Poraba CO2</div>
        <div class="collapsible-body"><span>Proizvedel si {{round(sredstvo.izpusti_co2())}} gramov CO2.</span></div>
      </li>
      <li>
        <div class="collapsible-header"><i class="material-icons">euro_symbol</i>Cena</div>
        <div class="collapsible-body">
          <span>Porabil si {{round(sredstvo.skupna_cena_sredstva(), 2)}} €.</span>
          <div class="row"> 
            <form action="/dodaj-strosek/" method="POST">
              <div class="input-field col s4">
                <input id="znesek" type="text" class="validate" name="znesek">
                <label for="znesek">Znesek</label>
              </div>
              % if sredstvo.ime == "driving":
              <input type="hidden" name="sredstvo" value="driving">
              % elif sredstvo.ime == "walking":
              <input type="hidden" name="sredstvo" value="walking">
              % elif sredstvo.ime == "bicycling":
              <input type="hidden" name="sredstvo" value="bicycling">
              % elif sredstvo.ime == "train":
              <input type="hidden" name="sredstvo" value="train">
              % elif sredstvo.ime == "bus":
              <input type="hidden" name="sredstvo" value="bus">
              % end
              <div class="input-field col s4">
                <button class="btn waves-effect waves-light" type="submit" name="action">Dodaj strošek
                <i class="material-icons right">add</i>
                </button>
              </div>
            </form>
          </div>
        </div>
      </li>
      <li>
        <div class="collapsible-header"><i class="material-icons">access_time</i>Čas</div>
        <div class="collapsible-body"><span>Porabil si {{round(sredstvo.skupno_trajanje() / 3600,2)}} ur.</span></div>
      </li>
      <li>
        <div class="collapsible-header"><i class="material-icons">map</i>Skupna razdalja</div>
        <div class="collapsible-body"><span>Opravil si {{round(sredstvo.skupna_dolzina() / 1000,2)}} kilometrov.</span></div>
      </li>
    </ul>
  </div>

  <script>
    $(document).ready(function(){
      $('.collapsible').collapsible();
    });
  </script>

</body>