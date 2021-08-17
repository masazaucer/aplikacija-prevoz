% rebase('base.tpl')

<form action="/registracija/" method="POST">
    <div class="row">
        <div class="input-field col s12">
          <input id="username" type="text" class="validate" name="username">
          <label for="username">Uporabniško ime</label>
        </div>
    </div>

    <div class="row">
        <div class="input-field col s12">
          <input id="password" type="password" class="validate" name="password">
          <label for="password">Password</label>
        </div>
    </div>

    <div class="row">
        <div class="input-field col s12">
            <div class='center'>
                <button class="btn waves-effect waves-light" type="submit" name="action">Registracija
                </button>
            </div>
        </div>
    </div> 
</form>