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


<table class="highlight">
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
        <td>{{round(pot.razdalja()["razdalja"], 2)}}</td>
        <td>{{round(pot.trajanje(), 2)}}</td>
        <td>{{round(pot.cena(), 2)}}</td>
        <td>{{round(pot.izpusti(), 2)}}</td>
      </tr>
      <tr>
        <td><b>Optimalna izbira</b></td>
        <td></td>
        <td>{{stanje.poisci_sredstvo(pot.optimalna_pot().sredstvo).ime_slo()}}</td>
        <td></td>
        <td>{{round(pot.optimalna_pot().razdalja()["razdalja"], 2)}}</td>
        <td>{{round(pot.optimalna_pot().trajanje(), 2)}}</td>
        <td>{{round(pot.optimalna_pot().cena(), 2)}}</td>
        <td>{{round(pot.optimalna_pot().izpusti(), 2)}}</td>
      </tr>
    % end
    </tbody>
  </table>