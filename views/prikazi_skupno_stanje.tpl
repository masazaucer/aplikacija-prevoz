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

<div class="container">
    <div class="carousel carousel-slider center">
        <div class="carousel-item green white-text" href="#one!">
        <h2><i class="material-icons">folder</i>Skupna analiza</h2>
         <div> 
         <table class="colum">
            <tr>
              <td><div id="Sarah_chart_div"></div></td>
              <td><div id="Anthony_chart_div"></div></td>
            </tr>
          </table>
          </div>
          </div>
        <div class="carousel-item green white-text" href="#one!">
        <h2><i class="material-icons">ev_station</i>Poraba CO2</h2>
        <p class="white-text">Delež porabe CO2 po sredstvih</p>
        <div id="myPieChart"></div>
      </div>
      <div class="carousel-item amber white-text" href="#two!">
        <h2><i class="material-icons">euro_symbol</i>Cena</h2>
        <p class="white-text">Stroški vožnje po datumih</p>
        <div id="myPie2Chart"></div>
        
      </div>
      <div class="carousel-item blue white-text" href="#three!">
        <h2><i class="material-icons">access_time</i>Čas</h2>
        <p class="white-text">Poraba časa na sredstvo</p>
        <div id="myPie3Chart"/></div>
        
      </div>
      <div class="carousel-item red white-text" href="#four!">
        <h2><i class="material-icons">map</i>Skupna razdalja</h2>
        <p class="white-text">Delež prepotovane razdalje na sredstvo</p>
        <div id="myPie4Chart"/></div>
      </div>
    </div>
     </div>
  
    
  <script>
  
    $('.carousel.carousel-slider').carousel({
      fullWidth: true,
      indicators: true
    });
  </script>
  
<script>
    $(document).ready(function(){
       $('.collapsible').collapsible();
     });
</script>
</body>  