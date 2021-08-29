% oznaka_zavihka = {
%     'stanje': 'Domov',
%     'analiza': 'Analiza',
%     'pomoc': 'Pomoč',
%     'poti': 'Poti',
%     'prijava': 'Prijava',
%     'registracija': 'Registracija',
%     'analiza_skupno': 'Analiza skupne porabe',
%     'analiza_sredstvo': 'Analiza sredstva',
%     'odjava': 'Odjava'
% }

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
                <p class="grey-text text-lighten-4">Projekt je nastal s pomočjo sofinanciranja Evropske unije za trajnostni razvoj. Želja je ozavestiti vsakega posameznika o izpustih na podlagi prepotovanih poti. Takšen način ozaveščanja je pozitivnejši, saj lahko vsak vidi kako bi lahko spremenil način transporta</p>
              </div>
              <div class="col l4 offset-l2 s12">
                <h5 class="white-text">Links</h5>
                <ul>
                  <li><a class="grey-text text-lighten-3" href="#!">Link do izpustov</a></li>
                  <li><a class="grey-text text-lighten-3" href="#!">Link do dolgorocnih posledic</a></li>
                  <li><a class="grey-text text-lighten-3" href="#!">Link 3</a></li>
                  <li><a class="grey-text text-lighten-3" href="#!">Link 4</a></li>
                </ul>
              </div>
            </div>
          </div>
          <div class="footer-copyright">
            <div class="container">
            © 2021 Copyright Text
            <a class="grey-text text-lighten-4 right" href="#!">Moje informacije</a>
            </div>
          </div>
    </footer>
  </html>