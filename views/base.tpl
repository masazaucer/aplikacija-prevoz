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
                <p class="grey-text text-lighten-4">
                  Projekt je nastal v okviru predmeta uvod v programiranje. 
                  Želja je spodbuditi ljudi k uporabi prevoznih sredstev, ki manj onesnažujejo okolje.
                </p>
              </div>
              <div class="col l4 offset-l2 s12">
                <h5 class="white-text">Viri</h5>
                <ul>
                  <li><a class="grey-text text-lighten-3" href="https://www.statista.com/statistics/1185559/carbon-footprint-of-travel-per-kilometer-by-mode-of-transport/">Carbon footprint of select modes of transport per kilometer of travel in 2018</a></li>
                  <li><a class="grey-text text-lighten-3" href="https://op.europa.eu/en/publication-detail/-/publication/9781f65f-8448-11ea-bf12-01aa75ed71a1">Handbook on the external costs of transport</a></li>
                  <li><a class="grey-text text-lighten-3" href="https://ourworldindata.org/travel-carbon-footprint">Which form of transport has the smallest carbon footprint?</a></li>
                  <li><a class="grey-text text-lighten-3" href="https://www.sptm.si/application/files/3116/1648/8282/2017_MZI_P_R_-_Smernice_za_vzpostavitev_sistema_P_R__parkiraj_in_presedi__in_umescanje_vozlisc_P_R_v_urbanih_naseljih_V1.pdf">Smernice za vzpostavitev sistema P+R</a></li>
                  <li><a class="grey-text text-lighten-3" href="https://www.sptm.si/application/files/3116/1648/8282/2017_MZI_P_R_-https://en.wikipedia.org/wiki/Value_of_time#:~:text=In%20transport%20economics%2C%20the%20value,as%20compensation%20for%20lost%20time.pdf">Vrednost časa</a></li>
                </ul>
              </div>
            </div>
          </div>
          <div class="footer-copyright">
            <div class="container">
            © 2021 Copyright Text
            </div>
          </div>
    </footer>
  </html>