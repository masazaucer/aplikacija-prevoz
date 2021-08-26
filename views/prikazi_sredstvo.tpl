% rebase('analiza.tpl', izbrani_zavihek='analiza_sredstvo')
<head>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0-alpha.4/css/materialize.min.css">
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  
    <script type = "text/javascript" src = "https://code.jquery.com/jquery-2.1.1.min.js"></script>           
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0-alpha.4/js/materialize.min.js"></script>
  
</head>

<body>
% if sredstvo:
<div class="container">
<h1>{{sredstvo.ime_slo()}}</h1>
<ul class="collapsible">
    <li>
      <div class="collapsible-header"><i class="material-icons">ev_station</i>Poraba CO2</div>
      <div class="collapsible-body"><span>Proizvedel si {{round(sredstvo.izpusti_co2(), 2)}} gramov CO2.</span></div>
    </li>
    <li>
      <div class="collapsible-header"><i class="material-icons">euro_symbol</i>Cena  
        <form action="/dodaj-strosek.tpl/" method="POST"></form>
            <button class="btn waves-effect waves-light" type="submit" name="action">Dodaj strošek
            <i class="material-icons right">add</i>
            </button>
        </form>
       </div>
      <div class="collapsible-body"><span>Porabil si {{round(sredstvo.skupna_cena_sredstva(), 2)}} €.</span></div>
    </li>
    <li>
      <div class="collapsible-header"><i class="material-icons">access_time</i>Čas</div>
      <div class="collapsible-body"><span>Vozil si se {{round(sredstvo.skupno_trajanje() / 360, 2)}} ur.</span></div>
    </li>
    <li>
        <div class="collapsible-header"><i class="material-icons">directions</i><i class="material-icons">map</i>Skupna razdalja</div>
        <div class="collapsible-body"><span>Vozil si se {{round(sredstvo.skupna_dolzina() / 1000, 2)}} kilometrov.</span></div>
    </li>
  </ul>
  </div>

  <script>
    $(document).ready(function(){
      $('.collapsible').collapsible();
    });
  </script>
% else:
<h3>Tega prevoznega sredstva nimaš med svojimi sredstvi!</h3>
% end
</body>