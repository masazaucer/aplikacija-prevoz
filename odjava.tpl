%rebase('base.tpl')

<div class="center">
<h3>Ali ste prepričani da se želite odjaviti?</h3>

<div class="row">
    <p>
    <form action="/odjava/" method="POST">
        <button class="btn waves-effect waves-light" type="submit" name="action">Odjavi</button>
    </form>
    </p>
    <p>
    <form action="/stanje/" method="GET">
        <button class="btn waves-effect waves-light" type="submit" name="action">Prekliči</button>
    </form>
    </p>
</div>
</div>