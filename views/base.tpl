<!DOCTYPE html>
<html>
    <head>
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
      <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
      % if defined('izbrani_zavihek'):
      <title>Prevoz – {{oznaka_zavihka[izbrani_zavihek]}}</title>
      % else:
      <title>Prevoz</title>
      % end
      
      <script src="https://www.gstatic.com/charts/loader.js"></script>
      <script>
        google.charts.load('current', {packages: ['corechart']});
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {
          // Define the chart to be drawn.
          var data = new google.visualization.DataTable();
          data.addColumn('string', 'Element');
          data.addColumn('number', 'Percentage');
          data.addRows([
            ['Avto', round((stanje.poisci_sredstvo('driving').skupna_cena()) / stanje.skupna_cena(), 1)],
            ['Kolo', 1 - round((stanje.poisci_sredstvo('driving').skupna_cena()) / stanje.skupna_cena(), 1)],
            ['Hoja', 0.]
            
          ]);

          // Instantiate and draw the chart.
          var chart = new google.visualization.PieChart(document.getElementById('myPieChart'));
          chart.draw(data, null);
        }

        
      </script>
            <script>
        google.charts.load('current', {packages: ['corechart']});
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {
          // Define the chart to be drawn.
          var data = new google.visualization.DataTable();
          data.addColumn('string', 'Element');
          data.addColumn('number', 'Percentage');
          data.addRows([
            ['Avto', 0.78],
            ['Kolo', 0.21],
            ['Javni prevoz', 0.01]
            
          ]);

          // Instantiate and draw the chart.
          var chart = new google.visualization.PieChart(document.getElementById('myPie2Chart'));
          chart.draw(data, null);
        }

        
      </script>
        </script>
            <script>
        google.charts.load('current', {packages: ['corechart']});
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {
          // Define the chart to be drawn.
          var data = new google.visualization.DataTable();
          data.addColumn('string', 'Element');
          data.addColumn('number', 'Percentage');
          data.addRows([
            ['Avto', 0.78],
            ['Kolo', 0.21],
            ['Javni prevoz', 0.01]
            
          ]);

          // Instantiate and draw the chart.
          var chart = new google.visualization.PieChart(document.getElementById('myPie3Chart'));
          chart.draw(data, null);
        }

        
      </script>
          </script>
            <script>
        google.charts.load('current', {packages: ['corechart']});
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {
          // Define the chart to be drawn.
          var data = new google.visualization.DataTable();
          data.addColumn('string', 'Element');
          data.addColumn('number', 'Percentage');
          data.addRows([
            ['Avto', 0.78],
            ['Kolo', 0.21],
            ['Javni prevoz', 0.01]
            
          ]);

          // Instantiate and draw the chart.
          var chart = new google.visualization.PieChart(document.getElementById('myPie4Chart'));
          chart.draw(data, null);
        }

        
      </script>
      <script>
     // Load Charts and the corechart package.
      google.charts.load('current', {'packages':['Bar']});

      // Draw the pie chart for Sarah's pizza when Charts is loaded.
      google.charts.setOnLoadCallback(drawSarahChart);

      // Draw the pie chart for the Anthony's pizza when Charts is loaded.
      google.charts.setOnLoadCallback(drawAnthonyChart);

      // Callback that draws the pie chart for Sarah's pizza.
      function drawSarahChart() {

        // Create the data table for Sarah's pizza.
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Izbira sredstva');
        data.addColumn('number', '€');
        data.addRows([
          ['Tvoji stroški', stanje.skupna_cena()],
          ['Optimalni stroški', stanje.skupna_cena_optimalno()],
    
        ]);

        // Set options for Sarah's pie chart.
        var options = {title:'Prikaz vaše porabe denarja',
                       colors: ["black"],
                       width:500,
                       height:200};

        // Instantiate and draw the chart for Sarah's pizza.
         var chart = new google.charts.Bar(document.getElementById('Sarah_chart_div'));

        chart.draw(data, google.charts.Bar.convertOptions(options));
      }

      // Callback that draws the pie chart for Anthony's pizza.
      function drawAnthonyChart() {

        // Create the data table for Anthony's pizza.
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Izbira sredstva');
        data.addColumn('number', 'g CO2');
        data.addRows([
          ['Tvoja poraba', stanje.skupni_izpusti()],
          ['Optimalna poraba', stanje.izpusti_co2_optimalno()]

        ]);

        // Set options for Anthony's pie chart.
        var options = {title:'Prikaz vaše porabe CO2',
                      colors: ['Green'],
                       width:500,
                       height:200};

        // Instantiate and draw the chart for Anthony's pizza.
         var chart = new google.charts.Bar(document.getElementById('Anthony_chart_div'));

        chart.draw(data, google.charts.Bar.convertOptions(options));
      }
    </script>
    </head>
    
    <body>
        <nav>
            <div class="nav-wrapper">
              <ul id="nav-mobile" class="left hide-on-med-and-down">
                <li><a href="/stanje/">Domov</a></li>
                <li><a href="/poti/">Poti</a></li>
                <li><a href="/analiza/">Analiza</a></li>
                <li><a href="/pomoc/">Pomoč</a></li>
              </ul>
              <ul id="nav-mobile" class="right hide-on-med-and-down">
                % if uporabnik:
                <li>{{uporabnik.uporabnisko_ime}}</li>
                % end
                <li><a href="/prijava/">Prijava</a></li>
                <li><a href="/registracija/">Registracija</a></li>
                <li><a href="/odjava/">Odjava</a></li>
              </ul>
            </div>
          </nav>

          <script type="text/javascript" src="js/materialize.min.js"></script>
          <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
          <script type = "text/javascript" src = "https://code.jquery.com/jquery-2.1.1.min.js"></script>
          <script type = "text/javascript" src = "./select.js"></script>
         
          <section class="section">
            {{!base}}
          </section>
      
          <script>    $(document).ready(function(){
            $('select').formSelect();
          });
          </script>
          <script>
          
      $(document).ready(function(){
        $('.datepicker').datepicker();
      });
          </script>
    
          <script>
            $(document).ready(function(){
              $('select').formSelect();
            });
          </script>

        

    </body>
    <footer class="page-footer">
      <div class="container">
        <div class="row">
          <div class="col l6 s12">
            <h5 class="white-text">O projektu</h5>
            <p class="grey-text text-lighten-4">Projekt je nastal na pobudo Maše Žaucer pod okriljem očeta in šefa Tadeja ter žučnega psa neli</p>
          </div>
          <div class="col l4 offset-l2 s12">
            <h5 class="white-text">Links</h5>
            <ul>
              <li><a class="grey-text text-lighten-3" href="#!">Link 1</a></li>
              <li><a class="grey-text text-lighten-3" href="#!">Link 2</a></li>
              <li><a class="grey-text text-lighten-3" href="#!">Link 3</a></li>
              <li><a class="grey-text text-lighten-3" href="#!">Link 4</a></li>
            </ul>
          </div>
        </div>
      </div>
      <div class="footer-copyright">
        <div class="container">
        © 2014 Copyright Text
        <a class="grey-text text-lighten-4 right" href="#!">More Links</a>
        </div>
      </div>
    </footer>
  </html>