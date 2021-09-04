% rebase('base.tpl', izbrani_zavihek='prijava')

<h1>Prijava</h1>

<form action="/prijava/" method="POST">
    % if napaka:
        <h3>{{ napaka }}</h3>
    % end
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
            <button class="btn waves-effect waves-light" type="submit" name="action">Prijava</button>
        </div>
    </div> 
</form>

<div class="center">
    <strong>
        <p>
            Še nimate računa?
            Tukaj se lahko registrirate:
        </p>
        <form action="/registracija/" method="GET">
            <button class="btn waves-effect waves-light" type="submit" name="action">Registracija</button>
        </form>
    </strong>
</div>