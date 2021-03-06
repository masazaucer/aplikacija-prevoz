% rebase('base.tpl', izbrani_zavihek='poti')
% from model import prevedi

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
          <option value="train">Vlak</option>
          <option value="bus">Bus</option>
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

<div class="center ">
% if napaka:
<h4>{{napaka}}</h4>
% end
</div>



<table class="highlight">
  <h2 class = "col s12"><strong>Tvoje poti</strong></h2>
    <thead>
      <tr>
          <th bgcolor="#e0e0e0">Začetek</th>
          <th bgcolor="#e0e0e0">Konec</th>
          <th bgcolor="#e0e0e0">Sredstvo</th>
          <th bgcolor="#e0e0e0">Datum</th>
          <th bgcolor="#e0e0e0">Razdalja[km]</th>
          <th bgcolor="#e0e0e0">Trajanje[h]</th>
          <th bgcolor="#e0e0e0"><a class="btn tooltipped" data-position="top" data-tooltip="Cena celotne poti (tudi gorivo in vozovnica)">Cena[€]</a></th>
          <th bgcolor="#e0e0e0"><a class="btn tooltipped" data-position="top" data-tooltip="Količina izpustov CO2 na potnika">Izpusti[g]</a></th>
          <th bgcolor="#e0e0e0">Odstrani</th>

      </tr>
    </thead>


    
    % for pot in stanje.poti:
    <tr>
      % if pot.sredstvo == pot.optimalna["sredstvo"]:
      <td bgcolor="#c8e6c9 ">{{pot.zacetek}}</td>
      <td bgcolor="#c8e6c9 ">{{pot.konec}}</td>
      <td bgcolor="#c8e6c9 ">{{pot.sredstvo_slo()}}</td>
      <td bgcolor="#c8e6c9 ">{{pot.datum}}</td>
      <td bgcolor="#c8e6c9 ">{{round(pot.razdalja / 1000, 2)}}</td>
      <td bgcolor="#c8e6c9 ">{{round(pot.trajanje / 3600, 2)}}</td>
      <td bgcolor="#c8e6c9 ">{{round(pot.cena, 2)}}</td>
      <td bgcolor="#c8e6c9 ">{{round(pot.izpusti, 4)}}</td>
      <td bgcolor="#c8e6c9 ">
        <form action='/odstrani-pot/' method="POST">
          <input type="hidden" name="zacetek" value="{{pot.zacetek}}">
          <input type="hidden" name="konec" value="{{pot.konec}}">
          <input type="hidden" name="sredstvo" value="{{pot.sredstvo}}">
          <input type="hidden" name="datum" value="{{pot.datum}}">
          <button class="btn waves-effect waves-light" type="submit" name="action">
            <i class="material-icons">delete</i>
          </button>
        </form>
      </td>
    
      % else:
      <td bgcolor="#ff8a80 ">{{pot.zacetek}}</td>
      <td bgcolor="#ff8a80 ">{{pot.konec}}</td>
      <td bgcolor="#ff8a80 ">{{pot.sredstvo_slo()}}</td>
      <td bgcolor="#ff8a80 ">{{pot.datum}}</td>
      <td bgcolor="#ff8a80 ">{{round(pot.razdalja / 1000, 2)}}</td>
      <td bgcolor="#ff8a80 ">{{round(pot.trajanje / 3600, 2)}}</td>
      <td bgcolor="#ff8a80 ">{{round(pot.cena, 2)}}</td>
      <td bgcolor="#ff8a80 ">{{round(pot.izpusti)}}</td>
      <td bgcolor="#ff8a80 ">
        <form action='/odstrani-pot/' method="POST">
          <input type="hidden" name="zacetek" value="{{pot.zacetek}}">
          <input type="hidden" name="konec" value="{{pot.konec}}">
          <input type="hidden" name="sredstvo" value="{{pot.sredstvo}}">
          <input type="hidden" name="datum" value="{{pot.datum}}">
          <button class="btn waves-effect waves-light" type="submit" name="action">
            <i class="material-icons">delete</i>
          </button>
        </form>
      </td>
      % end
    </tr>

    <tr>
      <td><a class="btn tooltipped" data-position="right" data-tooltip="Sredstvo z najboljšim razmerjem med časom, ceno in izpusti CO2"><b>Optimalna izbira</b></a></td>
      <td></td>
      <td>{{prevedi(pot.optimalna["sredstvo"])}}</td>
      <td></td>
      <td>{{round(pot.optimalna["razdalja"] / 1000, 2)}}</td>
      <td>{{round(pot.optimalna["trajanje"] / 3600, 2)}}</td>
      <td>{{round(pot.optimalna["cena"], 2)}}</td>
      <td>{{round(pot.optimalna["izpusti"])}}</td>
    </tr>
    % end
</table>

<script>
$(document).ready(function(){
  $('.tooltipped').tooltip();
});
</script>