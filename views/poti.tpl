% rebase('base.tpl')

<form action='/dodaj-pot/' method="POST">
  <div class='row'></div>
  <div class="row">
    <div class="input-field col s6">
        <i class="material-icons prefix">keyboard_arrow_right</i>
        <input id="zacetek" type="text" class="validate" name="zacetek">
        <label for="zacetek">Začetek</label>
    </div>
    <div class="input-field col s6">
        <i class="material-icons prefix">keyboard_arrow_left</i>
        <input id="konec" type="text" class="validate" name="konec">
        <label for="konec">Konec</label>
    </div>
  </div>
  <div class="row">
    <div class="input-field col s6">
        <i class="material-icons prefix">today</i>
        <input type="text" class="datepicker" id='date' name="datum" defaultDate='date.today()' setDefaultDate='True'>
        <label for="date">Datum</label>
    </div>
    
      <div class="input-field col s6">
        <i class="material-icons prefix">directions_car</i>
        
        <select name="sredstvo">
          <option value="" disabled selected>Sredstvo</option>
          <option value="driving">Avto</option>
          <option value="walking">Hoja</option>
          <option value="train">Javni prevoz</option>
          <option value="bicycling">Kolo</option>
     
        </select>
        
        

        
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
 </div>

  <div class="row">
    <div class="input-field col s12">
        <div class='center'>
            <button class="btn waves-effect waves-light" type="submit" name="action">Dodaj
                <i class="material-icons right">add</i>
            </button>
        </div>
    </div>
  </div>
</form>


<table class="striped">
    <h2><strong>Tvoje poti:</strong></h2>
    <thead>
      <tr>
          <th>Začetek</th>
          <th>Konec</th>
          <th>Sredstvo</th>
          <th>Datum</th>
          <th>Razdalja</th>
          <th>Trajanje</th>
          <th>Cena</th>
          <th>Izpusti</th>
      </tr>
    </thead>

    <tbody>
    % for pot in stanje.poti:
      <tr>
        <td>{{pot.zacetek}}</td>
        <td>{{pot.konec}}</td>
        <td>{{stanje.poisci_sredstvo(pot.sredstvo).ime_slo()}}</td>
        <td>{{pot.datum}}</td>
        <td>{{pot.razdalja()["razdalja"]}}</td>
        <td>{{pot.trajanje()}}</td>
        <td>{{pot.cena()}}</td>
        <td>{{pot.izpusti()}}</td>
      </tr>
      <tr>
        <td></td>
        <td></td>
        <td>{{pot.optimalna_pot().sredstvo}}</td>
        <td></td>
        <td>{{pot.optimalna_pot().razdalja()["razdalja"]}}</td>
        <td>{{pot.optimalna_pot().trajanje()}}</td>
        <td>{{pot.optimalna_pot().cena()}}</td>
        <td>{{pot.optimalna_pot().izpusti()}}</td>
      </tr>
    % end
    </tbody>
  </table>