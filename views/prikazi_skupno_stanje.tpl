% rebase('analiza.tpl')

<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0-alpha.4/css/materialize.min.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

  <script type = "text/javascript" src = "https://code.jquery.com/jquery-2.1.1.min.js"></script>           
  <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0-alpha.4/js/materialize.min.js"></script>

    <script src="https://www.gstatic.com/charts/loader.js"></script>
      <script>
        google.charts.load('current', {packages: ['corechart', 'Bar']});


        google.charts.setOnLoadCallback(risi_sredstva_cena);

      
        google.charts.setOnLoadCallback(risi_skupno_cena);
  
        
        function risi_sredstva_cena() {
  
          
          var data = new google.visualization.DataTable();
          data.addColumn('string', 'Sredstvo');
          data.addColumn('number', '€');
          data.addRows([
            ['Avto', {{stanje.poisci_sredstvo("driving").skupna_cena_sredstva() if "driving" in stanje.prevozna_sredstva_po_imenih else 0}}],
            ['Hoja', {{stanje.poisci_sredstvo("walking").skupna_cena_sredstva() if "walking" in stanje.prevozna_sredstva_po_imenih else 0}}],
            ['Kolo', {{stanje.poisci_sredstvo("bicycling").skupna_cena_sredstva() if "bicycling" in stanje.prevozna_sredstva_po_imenih else 0}}],
            ['Bus', {{stanje.poisci_sredstvo("bus").skupna_cena_sredstva() if "bus" in stanje.prevozna_sredstva_po_imenih else 0}}],
            ['Vlak', {{stanje.poisci_sredstvo("train").skupna_cena_sredstva() if "train" in stanje.prevozna_sredstva_po_imenih else 0}}]
      
          ]);
  
          var options = {title:'Prikaz cene po sredstvih',
                         colors: ["pink"],
                         width:500,
                         height:200};
  
           var chart = new google.charts.Bar(document.getElementById("cena_sredstva"));
  
          chart.draw(data, google.charts.Bar.convertOptions(options));
        }



        function risi_skupno_cena() {


          var data = new google.visualization.DataTable();
          data.addColumn('string', 'Primerjava cene');
          data.addColumn('number', '€');
          data.addRows([
            ['Tvoji stroski', {{stanje.skupna_cena()}}],
            ['Optimalni stroski', {{stanje.skupna_cena_optimalno()}}]
  
          ]);
  
          
          var options = {title:'Prikaz cene',
                        colors: ['pink'],
                         width:500,
                         height:200};
  
          
           var chart = new google.charts.Bar(document.getElementById('cena_skupno'));
  
          chart.draw(data, google.charts.Bar.convertOptions(options));
        }



        google.charts.setOnLoadCallback(risi_sredstva_razdalja);

      
        google.charts.setOnLoadCallback(risi_skupno_razdalja);
  
        
        function risi_sredstva_razdalja() {
  
          
          var data = new google.visualization.DataTable();
          data.addColumn('string', 'Sredstvo');
          data.addColumn('number', 'km');
          data.addRows([
            ['Avto', {{(stanje.poisci_sredstvo("driving").skupna_dolzina()/1000) if "driving" in stanje.prevozna_sredstva_po_imenih else 0}}],
            ['Hoja', {{stanje.poisci_sredstvo("walking").skupna_dolzina()/1000 if "walking" in stanje.prevozna_sredstva_po_imenih else 0}}],
            ['Kolo', {{stanje.poisci_sredstvo("bicycling").skupna_dolzina()/1000 if "bicycling" in stanje.prevozna_sredstva_po_imenih else 0}}],
            ['Bus', {{stanje.poisci_sredstvo("bus").skupna_dolzina()/1000 if "bus" in stanje.prevozna_sredstva_po_imenih else 0}}],
            ['Vlak', {{stanje.poisci_sredstvo("train").skupna_dolzina()/1000 if "train" in stanje.prevozna_sredstva_po_imenih else 0}}]
      
          ]);
  
          var options = {title:'Prikaz razdalje poti po sredstvih',
                         colors: ["purple"],
                         width:500,
                         height:200};
  
           var chart = new google.charts.Bar(document.getElementById("razdalja_sredstva"));
  
          chart.draw(data, google.charts.Bar.convertOptions(options));
        }



        function risi_skupno_razdalja() {


          var data = new google.visualization.DataTable();
          data.addColumn('string', 'Primerjava razdalje');
          data.addColumn('number', 'km');
          data.addRows([
            ['Dolzina tvojih poti', {{stanje.skupna_razdalja() / 1000}}],
            ['Dolzina optimalnih poti', {{stanje.skupna_dolzina_optimalno() / 1000}}]
  
          ]);
  
          // Set options for Anthony's pie chart.
          var options = {title:'Prikaz razdalje',
                        colors: ['purple'],
                         width:500,
                         height:200};
  
          // Instantiate and draw the chart for Anthony's pizza.
           var chart = new google.charts.Bar(document.getElementById('razdalja_skupno'));
  
          chart.draw(data, google.charts.Bar.convertOptions(options));
        }







        google.charts.setOnLoadCallback(risi_sredstva_trajanje);

      
        google.charts.setOnLoadCallback(risi_skupno_trajanje);
  
        
        function risi_sredstva_trajanje() {
  
          
          var data = new google.visualization.DataTable();
          data.addColumn('string', 'Sredstvo');
          data.addColumn('number', 'h');
          data.addRows([
            ['Avto', {{stanje.poisci_sredstvo("driving").skupno_trajanje() / 3600 if "driving" in stanje.prevozna_sredstva_po_imenih else 0}}],
            ['Hoja', {{stanje.poisci_sredstvo("walking").skupno_trajanje() / 3600 if "walking" in stanje.prevozna_sredstva_po_imenih else 0}}],
            ['Kolo', {{stanje.poisci_sredstvo("bicycling").skupno_trajanje() / 3600 if "bicycling" in stanje.prevozna_sredstva_po_imenih else 0}}],
            ['Bus', {{stanje.poisci_sredstvo("bus").skupno_trajanje() / 3600 if "bus" in stanje.prevozna_sredstva_po_imenih else 0}}],
            ['Vlak', {{stanje.poisci_sredstvo("train").skupno_trajanje() / 3600 if "train" in stanje.prevozna_sredstva_po_imenih else 0}}]
      
          ]);
  
          var options = {title:'Prikaz trajanja poti po sredstvih',
                         colors: ["lightblue"],
                         width:500,
                         height:200};
  
           var chart = new google.charts.Bar(document.getElementById("trajanje_sredstva"));
  
          chart.draw(data, google.charts.Bar.convertOptions(options));
        }



        function risi_skupno_trajanje() {


          var data = new google.visualization.DataTable();
          data.addColumn('string', 'Primerjava trajanja');
          data.addColumn('number', 'h');
          data.addRows([
            ['Trajanje tvojih poti', {{stanje.skupno_trajanje() / 3600}}],
            ['Trajanje optimalnih poti', {{stanje.skupno_trajanje_optimalno() / 3600}}]
  
          ]);
  
          
          var options = {title:'Prikaz trajanja poti',
                        colors: ['lightblue'],
                         width:500,
                         height:200};
  
          
           var chart = new google.charts.Bar(document.getElementById('trajanje_skupno'));
  
          chart.draw(data, google.charts.Bar.convertOptions(options));
        }        
        

      
      google.charts.setOnLoadCallback(risi_sredstva);

      
      google.charts.setOnLoadCallback(risi_skupno);

      
      function risi_sredstva() {

        
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Sredstvo');
        data.addColumn('number', 'g CO2');
        data.addRows([
          ['Avto', {{stanje.poisci_sredstvo("driving").izpusti_co2() if "driving" in stanje.prevozna_sredstva_po_imenih else 0}}],
          ['Hoja', {{stanje.poisci_sredstvo("walking").izpusti_co2() if "walking" in stanje.prevozna_sredstva_po_imenih else 0}}],
          ['Kolo', {{stanje.poisci_sredstvo("bicycling").izpusti_co2() if "bicycling" in stanje.prevozna_sredstva_po_imenih else 0}}],
          ['Bus', {{stanje.poisci_sredstvo("bus").izpusti_co2() if "bus" in stanje.prevozna_sredstva_po_imenih else 0}}],
          ['Vlak', {{stanje.poisci_sredstvo("train").izpusti_co2() if "train" in stanje.prevozna_sredstva_po_imenih else 0}}]
    
        ]);

        var options = {title:'Prikaz izpustov CO2 po sredstvih',
                       colors: ["green"],
                       width:500,
                       height:200};

         var chart = new google.charts.Bar(document.getElementById("co2_sredstva"));

        chart.draw(data, google.charts.Bar.convertOptions(options));
      }


      function risi_skupno() {


        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Primerjava izpustov');
        data.addColumn('number', 'g CO2');
        data.addRows([
          ['Tvoji izpusti', {{stanje.skupni_izpusti()}}],
          ['Optimalni izpusti', {{stanje.izpusti_co2_optimalno()}}]

        ]);

        // Set options for Anthony's pie chart.
        var options = {title:'Prikaz vaših izpustov CO2',
                      colors: ['Green'],
                       width:500,
                       height:200};

        // Instantiate and draw the chart for Anthony's pizza.
         var chart = new google.charts.Bar(document.getElementById('co2_skupno'));

        chart.draw(data, google.charts.Bar.convertOptions(options));
      }
    </script>

</head>

<body>
<div class="container">
<h5>Aktualni prikaz skupne porabe za vsa sredstva</h5>
<ul class="collapsible">
    <li>
        <div class="collapsible-header"><i class="material-icons">ev_station</i>Poraba CO2</div>
        <div class="collapsible-body"><span>Proizvedel si {{round(stanje.skupni_izpusti(),2)}} gramov CO2.</span></div>
    </li>
    <li>
        <div class="collapsible-header"><i class="material-icons">euro_symbol</i>Cena</div>
        <div class="collapsible-body"><span>Porabil si {{round(stanje.skupna_cena(),2)}} €.</span></div>
    </li>
    <li>
        <div class="collapsible-header"><i class="material-icons">access_time</i>Čas</div>
        <div class="collapsible-body"><span>Vozil si se {{round(stanje.skupno_trajanje() / 3600,2)}} ur.</span></div>
    </li>
        <li>
        <div class="collapsible-header"><i class="material-icons">directions</i><i class="material-icons">map</i>Skupna razdalja</div>
        <div class="collapsible-body"><span>Vozil si se {{round(stanje.skupna_razdalja() / 1000,2)}} kilometrov.</span></div>
    </li>
</ul>
</div>

<div class="container">
  <div class="carousel carousel-slider center">
      <div class="carousel-item green lighten-2 white-text" href="#one!">
      <h2><i class="material-icons">ev_station</i>Izpusti CO2</h2>
      <p class="white-text">neki neki</p>
       
       <table class="colum">
          <tr>
            <td><div id="co2_skupno"></div></td>
            <td><div id="co2_sredstva"></div></td>
            
          </tr>
        </table>
        
        </div>

      <div class="carousel-item pink lighten-2 white-text" href="#two!">
      <h2><i class="material-icons">euro_symbol</i>Cena</h2>
      <p class="white-text">neki z ceno</p>
      <table class="colum">
        <tr>
          <td><div id="cena_skupno"></div></td>
          <td><div id="cena_sredstva"></div></td>
          
        </tr>
      </table>
    </div>
    
    <div class="carousel-item teal lighten-2 white-text" href="#three!">
      <h2><i class="material-icons">access_time</i>Trajanje</h2>
      <p class="white-text">neki neki</p>
       
       <table class="colum">
          <tr>
            <td><div id="trajanje_skupno"></div></td>
            <td><div id="trajanje_sredstva"></div></td>
            
          </tr>
        </table>
        
        </div>

        <div class="carousel-item purple lighten-2 white-text" href="#three!">
          <h2><i class="material-icons">access_time</i>Razdalja</h2>
          <p class="white-text">neki neki</p>
           
           <table class="colum">
              <tr>
                <td><div id="razdalja_skupno"></div></td>
                <td><div id="razdalja_sredstva"></div></td>
                
              </tr>
            </table>
            
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