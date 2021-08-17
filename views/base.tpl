<!DOCTYPE html>
<html>
    <head>
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
      <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
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
              <a href="#" class="brand-logo right">Logo</a>
              <ul id="nav-mobile" class="left hide-on-med-and-down">
                <li><a href="/stanje/">Domov</a><i class="medium material-icons">home</i></li>
                <li><a href="/poti/">Poti</a><i class="medium material-icons">history</i></li>
                <li><a href="/analiza/">Analiza</a><i class="medium material-icons">analytics</i></li>
                <li><a href="/pomoc/">Pomoč</a><i class="medium material-icons">help_outline</i></li>
              </ul>
            </div>
          </nav>

          <section class="section">
            {{!base}}
          </section>
      
      <script type="text/javascript" src="js/materialize.min.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
      <script>    $(document).ready(function(){
        $('select').formSelect();
      });</script>
      <script>   document.addEventListener('DOMContentLoaded', function() {
        var elems = document.querySelectorAll('.datepicker');
        var instances = M.Datepicker.init(elems, options);
      });</script>
            <script>   document.addEventListener('DOMContentLoaded', function() {
        var elems = document.querySelectorAll('.datepicker');
        var instances = M.Datepicker.init(elems, options);
      });</script>
      <script>  document.addEventListener('DOMContentLoaded', function() {
        var elems = document.querySelectorAll('.collapsible');
        var instances = M.Collapsible.init(elems, options);
      });</script>

    </body>
  </html>
