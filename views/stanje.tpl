% rebase('base.tpl')

<div class="row">
  <form action="#">
  <h3>Izberi prevozno sredstvo</h3>
      <p>
        <label for="chk-demo1">
          <input type="checkbox" class="filled-in" id="chk-demo1"/>
          <span>AVTO<i class="material-icons">directions_car</i></span>
        </label>
      </p>
      <p>
        <label for="chk-demo2">
          <input type="checkbox"  class="filled-in" id="chk-demo2" checked="checked" />
          <span>KOLO<i class="material-icons">directions_bike</i></span>
        </label>
      </p>
      <p>
        <label for="chk-demo3">
          <input type="checkbox" class="filled-in" id="chk-demo3" checked="checked" />
          <span>JAVNI PREVOZ<i class="material-icons">directions_transit</i></span>
        </label>
      </p>
      
      <p>
        <label for="chk-demo4">
          <input type="checkbox" class="filled-in" id="chk-demo4" />
          <span>HOJA<i class="material-icons">directions_walk</i></span>
        </label>
      </p>        
  
    </form>
  </div>  

<!-- 
<div class="row">
    <div class="col s12 m5">
      <div class="card-panel teal">
        <h2>Tvoja sredstva:</h2>
        <ul>
            % for sredstvo in sredstva:
            <li>sredstvo: {{ sredstvo.ime }}</li>
            % end
        </ul>
        <form action="/dodaj-sredstvo/" method="POST">
            <input type="text" name='ime'>
            <input type='submit' value="dodaj">
        </form>
      </div>
    </div> -->

  
      <div class="container">
        <div class="input-field col s6 m6">
          <select class="icons">
            <option value="" disabled selected>Pomembnost časa</option>
            <option value="1" >vseeno</option>
            <option value="2" >malo</option>
            <option value="3" >zelo</option>
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

        <form action="/poti/" method="GET">
          <button class="btn waves-effect waves-light" type="submit" name="action">Dodaj pot
            <i class="material-icons right">add</i>
          </button>
        </form>

        