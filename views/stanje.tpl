% rebase('base.tpl')

<div class="row">
    <div class="col s12 m5">
      <div class="card-panel teal">
        <form action="/dodaj-sredstvo/" method="POST">
            <div class="input-field col s12">
                <select>
                <option value="" disabled selected>Choose your option</option>
                <option value="1">Option 1</option>
                <option value="2">Option 2</option>
                <option value="3">Option 3</option>
                </select>
                <label>Materialize Select</label>
            </div>
        </form>
      </div>
    </div>
  </div>


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
    </div>

    <div class="col s12 m5">
      <div class="card-panel teal">
        <form action='/pomembnost-casa/' method="POST">
          <input type="checkbox" name="pomembnost_casa">
          <p>
            <label>
              <input class="with-gap" name="group1" type="radio" />
              <span>Zelo</span>
            </label>
          </p>
          <p>
            <label>
              <input class="with-gap" name="group1" type="radio" />
              <span>Srednje</span>
            </label>
          </p>
          <p>
            <label>
              <input class="with-gap" name="group1" type="radio"  />
              <span>Malo</span>
            </label>
          </p>
          </input>
          <input type="submit" value="ok"/>
      </form>
      </div>
    </div>
  </div>
        <form action="/poti/" method="GET">
          <button class="btn waves-effect waves-light" type="submit" name="action">Dodaj pot
            <i class="material-icons right">add</i>
          </button>
        </form>

        