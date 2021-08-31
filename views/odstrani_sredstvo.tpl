% rebase('base.tpl')

<div class="center">
<p>
    Ali ste prepričani da želite odstraniti naslednja sredstva:
    % for sredstvo in sredstva:
    sredstvo
    To pomeni, da njihove poti ne bodo več v statistiki!
</p>

<div class="row">
    <p>
    <form action="/odstrani-sredstvo/" method="POST">
        % if "driving" in sredstva:
        <input type="hidden"  name="driving" value="True"/>
        % else:
        <input type="hidden"  name="driving" value="False"/>
        %end

        % if "walking" in sredstva:
        <input type="hidden"  name="walking" value="True"/>
        % else:
        <input type="hidden"  name="walking" value="False"/>
        %end

        % if "bicycling" in sredstva:
        <input type="hidden"  name="bicycling" value="True"/>
        % else:
        <input type="hidden"  name="bicycling" value="False"/>
        %end

        % if "train" in sredstva:
        <input type="hidden"  name="train" value="True"/>
        % else:
        <input type="hidden"  name="train" value="False"/>
        %end

        % if "bus" in sredstva:
        <input type="hidden"  name="bus" value="True"/>
        % else:
        <input type="hidden"  name="bus" value="False"/>
        %end
        
        <button class="btn waves-effect waves-light" type="submit" name="action">Odstrani</button>
    </form>
    </p>
    <p>
    <form action="/stanje/" method="GET">
        <button class="btn waves-effect waves-light" type="submit" name="action">Prekliči</button>
    </form>
    </p>
</div>
</div>