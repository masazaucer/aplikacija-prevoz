% rebase('base.tpl')
<!-- 
<div class="row">
  <form action="/dodaj-sredstvo/" name="ime" method="POST">
  <h3>Izberi prevozno sredstvo</h3>
      <p>
        <label for="chk-demo1">
          <input type="checkbox" class="filled-in" id="chk-demo1" value="driving"/>
          <span>AVTO<i class="material-icons">directions_car</i></span>
        </label>
      </p>
      <p>
        <label for="chk-demo2">
          <input type="checkbox"  class="filled-in" id="chk-demo2" checked="checked" value="bicycling"/>
          <span>KOLO<i class="material-icons">directions_bike</i></span>
        </label>
      </p>
      <p>
        <label for="chk-demo3">
          <input type="checkbox" class="filled-in" id="chk-demo3" checked="checked" value="train"/>
          <span>JAVNI PREVOZ<i class="material-icons">directions_transit</i></span>
        </label>
      </p>
      
      <p>
        <label for="chk-demo4">
          <input type="checkbox" class="filled-in" id="chk-demo4" value="walking"/>
          <span>HOJA<i class="material-icons">directions_walk</i></span>
        </label>
      </p>      


    </form>
  </div>  -->


<div class="row">
  <div class="col s6">
    <div class="card-panel teal">
      <h2>Tvoja sredstva:</h2>
      <ul>
          % for sredstvo in sredstva:
          <li>sredstvo: {{ sredstvo.ime_slo() }}</li>
          % end
      </ul>
    </div>
    <div class="row">
      <form action="/dodaj-sredstvo/" method="POST">
        <div class="container">
          <div class="input-field col s6 m6">
            <select class="icons" name="ime">
              <option value="" disabled selected>Dodaj sredstvo</option>
              <option value="driving" >Avto</option>
              <option value="walking" >Hoja</option>
              <option value="train" >Javni prevoz</option>
              <option value="bicycling" >Kolo</option>
            </select>
            <label>IZBERI</label>
          </div>
        </div>
      
        <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
          <!-- Compiled and minified JavaScript -->
            <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0-alpha.4/js/materialize.min.js"></script>
                
        <script>
        (function($){
          $(function(){
            // Plugin initialization
            $('select').not('.disabled').formSelect();
          }); 
        })(jQuery); // end of jQuery name space
        </script>

        <div class="input-field col s12">
                <button class="btn waves-effect waves-light" type="submit" name="action">Dodaj
                    <i class="material-icons right">add</i>
                </button>
        </div>

      </form>
    </div>
  </div>
</div>





<div class="col s6">
<form action="/pomembnost-casa/" method="POST">
  <div class="container">
    <div class="input-field col s6 m6">
      <select class="icons" name="pomembnost_casa">
        <option value="" disabled selected>Pomembnost časa</option>
        <option value="vseeno" >vseeno</option>
        <option value="malo" >malo</option>
        <option value="zelo" >zelo</option>
      </select>
      <label>kako pomemben ti je čas?</label>
    </div>
  </div>
  <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
      <!-- Compiled and minified JavaScript -->
      <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0-alpha.4/js/materialize.min.js"></script>

  <script>
  (function($){
    $(function(){
      // Plugin initialization
      $('select').not('.disabled').formSelect();
    }); 
  })(jQuery); // end of jQuery name space
  </script>
          <div class="row">
            <div class="input-field col s12">
                    <button class="btn waves-effect waves-light" type="submit" name="action">IZBERI</button>
            </div>
          </div>
</form>

<form action="/pomembnost-onesnazevanja/" method="POST">
  <div class="container">
    <div class="input-field col s4">
      <select class="icons" name="pomembnost_onesnazevanja">
        <option value="" disabled selected>Pomembnost varovanja okolja</option>
        <option value="vseeno" >vseeno</option>
        <option value="malo" >malo</option>
        <option value="zelo" >zelo</option>
      </select>
      <label>Kako pomembno ti je varovanje okolja?</label>
    </div>
  </div>
  <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
      <!-- Compiled and minified JavaScript -->
      <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0-alpha.4/js/materialize.min.js"></script>

  <script>
  (function($){
    $(function(){
      // Plugin initialization
      $('select').not('.disabled').formSelect();
    }); 
  })(jQuery); // end of jQuery name space
  </script>

  <div class="row">
    <div class="input-field col s2">
            <button class="btn waves-effect waves-light" type="submit" name="action">IZBERI</button>
    </div>
  </div>

</form>
</div>



<div class="center">
<form action="/poti/" method="GET">
  <button class="btn waves-effect waves-light" type="submit" name="action">Dodaj pot
    <i class="material-icons right">add</i>
  </button>
</form>
</div>

        