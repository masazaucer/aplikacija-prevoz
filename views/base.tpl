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
                <li><a href="/prijava/">Prijava</a></li>
                <li><a href="/registracija/">Registracija</a></li>
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
  </html>