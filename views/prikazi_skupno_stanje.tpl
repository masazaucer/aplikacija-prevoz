% rebase('analiza.tpl')

<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0-alpha.4/css/materialize.min.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

  <script type = "text/javascript" src = "https://code.jquery.com/jquery-2.1.1.min.js"></script>           
  <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0-alpha.4/js/materialize.min.js"></script>

</head>

<body>
<div class="container">
<h5>Aktualni prikaz skupne porabe za vsa sredstva</h5>
<ul class="collapsible">
    <li>
        <div class="collapsible-header"><i class="material-icons">ev_station</i>Poraba CO2</div>
        <div class="collapsible-body"><span>Proizvedel si {{round(stanje.skupni_izpusti(), 2)}} gramov CO2.</span></div>
    </li>
    <li>
        <div class="collapsible-header"><i class="material-icons">euro_symbol</i>Cena</div>
        <div class="collapsible-body"><span>Porabil si {{round(stanje.skupna_cena(), 2)}} €.</span></div>
    </li>
    <li>
        <div class="collapsible-header"><i class="material-icons">access_time</i>Čas</div>
        <div class="collapsible-body"><span>Vozil si se {{round(stanje.skupno_trajanje() / 360, 2)}} ur.</span></div>
    </li>
        <li>
        <div class="collapsible-header"><i class="material-icons">directions</i><i class="material-icons">map</i>Skupna razdalja</div>
        <div class="collapsible-body"><span>Vozil si se {{round(stanje.skupna_razdalja() / 1000, 2)}} kilometrov.</span></div>
    </li>
</ul>
</div>

<script>
    $(document).ready(function(){
       $('.collapsible').collapsible();
     });
</script>
</body>  