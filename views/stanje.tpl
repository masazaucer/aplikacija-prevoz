% rebase('base.tpl')
<div id="index-banner" class="parallax-container">
  <div class="parallax"><img src="https://www.jagriti.org/sea/media/front/assets/img/bg/background1.jpg"></div>
    <div class="section no-pad-bot">
      <div class="container">
        <br><br>
        <h1 class="header center teal-text text-lighten-2">Zeleni voznik</h1>
        <div class="row center">
          <h5 class="header col s12 light"></h5>
        </div>
        <div class="row center">
              <form action="/poti/" method="GET">
            <button class="btn waves-effect waves-light" type="submit" name="action">Dodaj pot
              <i class="material-icons right">add</i>
          </button>
        </form>
          </div>
        </div>

        </div>
        <br><br>

      </div>
    </div>
   
  </div>


  <div class="container">
    <div class="section">

      <!--   Icon Section   -->
      <div class="row">
        <div class="col s12 m4">
          <div class="icon-block">
            <h2 class="center brown-text"><i class="material-icons">fingerprint</i></h2>
            <h5 class="center">Vaša prevozna sredstva</h5>

              <div class="row">
              <form action="/dodaj-sredstvo/" method="POST">
             
                  <p>
                    <label for="chk-demo1">
                      <input type="checkbox" class="filled-in" id="chk-demo1" name="driving"/>
                      <span>Avto <i class="material-icons">directions_car</i></span>
                    </label>
                  </p>
                  <p>
                    <label for="chk-demo2">
                      <input type="checkbox"  class="filled-in" id="chk-demo2" checked="checked" name="bicycling"/>
                      <span>Kolo <i class="material-icons">directions_bike</i></span>
                    </label>
                  </p>
                  <p>
                    <label for="chk-demo3">
                      <input type="checkbox" class="filled-in" id="chk-demo3" checked="checked" name="train"/>
                      <span>Javni prevoz <i class="material-icons">directions_transit</i></span>
                    </label>
                  </p>
                  
                  <p>
                    <label for="chk-demo4">
                      <input type="checkbox" class="filled-in" id="chk-demo4" name="walking"/>
                      <span>Hoja <i class="material-icons">directions_walk</i></span>
                    </label>
                  </p>        
                  <div class="input-field col s12">
                    <button class="btn waves-effect waves-light" type="submit" name="action">DODAJ</button>
                  </div>
                </form>
              </div>  
            </div>
          </div>

        <div class="col s12 m4">
          <div class="icon-block">
            <h2 class="center brown-text"><i class="material-icons">access_time</i></h2>
            <h5 class="center">Koliko je pomemben vas čas?</h5>
              <div class="container">
                <div class="input-field col s12 m12">
                <form action="/pomembnost-casa/" method="POST">
                  <select class="icons" name="pomembnost_casa">
                    <option value="" disabled selected>Pomembnost časa</option>
                    <option value="zelo" >Zelo pomemben</option>
                    <option value="vseeno" >Srednje pomemben</option>
                    <option value="malo" >Manj pomemben</option>
                  </select>
                  <div class="input-field col s12">
                    <button class="btn waves-effect waves-light" type="submit" name="action">IZBERI</button>
                </div>
                </form>
                </div>
              </div>
          </div>
        </div>

        <div class="col s12 m4">
          <div class="icon-block">
            <h2 class="center brown-text"><i class="material-icons">filter_vintage</i></h2>
            <h5 class="center">Vam je mar za okolje?</h5>
              <div class="container">
                <div class="input-field col s12 m12">
                  <form action="/pomembnost-onesnazevanja/" method="POST">
                  <select class="icons">
                    <option value="" disabled selected>Pomembnost okolja</option>
                    <option value="1" >Veliko</option>
                    <option value="2" >Malo</option>
                    <option value="3" >Vseeno</option>
                  </select>
                  <div class="input-field col s2">
                    <button class="btn waves-effect waves-light" type="submit" name="action">IZBERI</button>
                  </div>
                  </form>
                </div>
              </div>
            
          </div>
        </div>
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

      <script>
      
  $(document).ready(function(){
    $('.parallax').parallax();
  });
  </script>
