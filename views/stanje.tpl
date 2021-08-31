% rebase('base.tpl', izbrani_zavihek='stanje')
% SREDSTVA = ["walking", "bicycling", "driving", "train", "bus"]

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
                      % if "driving" in stanje.prevozna_sredstva_po_imenih:
                      <input type="checkbox" id="chk-demo1" checked='checked' name="driving" value="True"/>
                      % else:
                      <input type="checkbox" id="chk-demo1" name="driving" value="True"/>
                      % end
                      <span><i class="material-icons">directions_car</i>  Avto</span>
                    </label>
                  </p>
                  <p>
                    <label for="chk-demo2">
                      % if "bicycling" in stanje.prevozna_sredstva_po_imenih:
                      <input type="checkbox" id="chk-demo2" checked='checked' name="bicycling"value="True"/>
                      % else:
                      <input type="checkbox" id="chk-demo2" name="bicycling"value="True"/>
                      %end
                      <span><i class="material-icons">directions_bike</i>  Kolo</span>
                    </label>
                  </p>
                  <p>
                    <label for="chk-demo3">
                      % if "train" in stanje.prevozna_sredstva_po_imenih:
                      <input type="checkbox" id="chk-demo3" checked='checked' name="train" value="True"/>
                      % else:
                      <input type="checkbox" id="chk-demo3" name="train" value="True"/>
                      %end
                      <span><i class="material-icons">directions_railway</i>  Vlak</span>
                    </label>
                  </p>
                  <p>
                    <label for="chk-demo4">
                      % if "bus" in stanje.prevozna_sredstva_po_imenih:
                      <input type="checkbox" id="chk-demo4" checked='checked' name="bus" value="True"/>
                      % else:
                      <input type="checkbox" id="chk-demo4" name="bus" value="True"/>
                      %end
                      <span><i class="material-icons">directions_bus</i>  Avtobus</span>
                    </label>
                  </p>
                  <p>
                    <label for="chk-demo5">
                      % if "walking" in stanje.prevozna_sredstva_po_imenih:
                      <input type="checkbox" id="chk-demo5" checked='checked' name="walking" value="True"/>
                      % else:
                      <input type="checkbox" id="chk-demo5" name="walking" value="True"/>
                      %end
                      <span><i class="material-icons">directions_walk</i>  Hoja</span>
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
                    
                    % if uporabnik.pomembnost_casa == True:
                    <option value="" disabled>Pomembnost časa</option>
                    <option value="zelo" selected>Zelo pomemben</option>
                    <option value="vseeno" >Srednje pomemben</option>
                    <option value="malo" >Manj pomemben</option>
                    % elif uporabnik.pomembnost_casa == False:
                    <option value="" disabled>Pomembnost časa</option>
                    <option value="zelo" >Zelo pomemben</option>
                    <option value="vseeno" >Srednje pomemben</option>
                    <option value="malo" selected>Manj pomemben</option>
                    % elif uporabnik.pomembnost_casa == None:
                    <option value="" disabled>Pomembnost časa</option>
                    <option value="zelo" >Zelo pomemben</option>
                    <option value="vseeno" selected>Srednje pomemben</option>
                    <option value="malo" >Manj pomemben</option>
                    % end
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
                  <select class="icons" name="pomembnost_onesnazevanja">
                    % if uporabnik.pomembnost_onesnazevanja == True:
                    <option value="" disabled>Pomembnost okolja</option>
                    <option value="zelo" selected>Veliko</option>
                    <option value="malo" >Malo</option>
                    <option value="srednje" >Vseeno</option>
                    % elif uporabnik.pomembnost_onesnazevanja == False:
                    <option value="" disabled>Pomembnost okolja</option>
                    <option value="zelo" >Veliko</option>
                    <option value="malo" selected>Malo</option>
                    <option value="srednje" >Vseeno</option>
                    % elif uporabnik.pomembnost_onesnazevanja == None:
                    <option value="" disabled>Pomembnost okolja</option>
                    <option value="zelo" >Veliko</option>
                    <option value="malo" >Malo</option>
                    <option value="srednje" selected>Vseeno</option>
                    %end
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
