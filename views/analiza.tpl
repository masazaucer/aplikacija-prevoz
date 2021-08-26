% rebase('base.tpl', izbrani_zavihek='analiza')


<div class="row">
    <div class="col s12">
      <ul class="tabs">
        <li class="tab col s2"><a href="../skupno/">Skupno</a></li>
        <li class="tab col s2"><a href="../driving/">Avto</a></li>
        <li class="tab col s2"><a href="../walking/">Hoja</a></li>
        <li class="tab col s2"><a href="../bicycling/">Kolo</a></li>
        <li class="tab col s2"><a href="../train/">Vlak</a></li>
        <li class="tab col s2"><a href="../bus/">Bus</a></li>
      </ul>
    </div>
</div>

<section class="section">
  {{!base}}
</section>

<script>

$(document).ready(function(){
  $('.tabs').tabs();
});
</script>