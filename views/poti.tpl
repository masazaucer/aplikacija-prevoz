% rebase('base.tpl')
%from datetime import date

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
        <input class="validate" id='sredstvo' name='sredstvo'>
        <select>
            <option value="" disabled selected>Choose your option</option>
            <option value="1">Option 1</option>
            <option value="2">Option 2</option>
            <option value="3">Option 3</option>
        </select>
        <label for="sredstvo">Sredstvo</label>
    </div>
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
        <td>{{pot.sredstvo}}</td>
        <td>{{pot.datum}}</td>
        <td>{{pot.razdalja()["razdalja"]}}</td>
        <td>{{pot.trajanje()}}</td>
        <td>{{pot.cena()}}</td>
        <td>{{pot.izracunaj_izpuste()}}</td>
      </tr>
    % end
    </tbody>
  </table>