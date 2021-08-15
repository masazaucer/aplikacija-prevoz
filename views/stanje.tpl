<!DOCTYPE html>
<html lang="sl">
<head>
    <meta charset="utf-8">
    <title>osnovna_stran</title>
</head>

<body>
    <h1>Prevozi</h1>
    <h2>Tvoja prevozna sredstva:</h2>
    <ul>
        % for sredstvo in sredstva:
        <li>{{ sredstvo.ime }}</li>
        % end
    </ul>

    <form action="/dodaj-sredstvo/" method="POST">
        <input type="text" name='dodaj_sredstvo'>
        <input type='submit' value="dodaj">
    </form>

    <h2>Tvoje poti:</h2>
    <ul>
        % for pot in poti:
        <li>začetek: {{ pot.zacetek }}, konec: {{ pot.konec }}, zardalja: {{ pot.razdalja() }}, trajanje: {{ pot.trajanje() }}</li>
        % end
    </ul>

    <form action="/dodaj-pot/" method="POST">
        <input type="text" name='dodaj_pot'>
        <input type='submit' value="dodaj">
    </form>

    <form action="/analiza/" method="GET">
        <input type="button" name='analiza'>
    </form>

    <form action="/pomoc/" method="GET">
        <input type="button" name='pomoc'>
    </form>
</body>
</html>