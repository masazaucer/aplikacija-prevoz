% rebase('base.tpl')


<div class="row">
    <div class="col s12">
      <ul class="tabs">
        <li class="tab col s2"><a href="../skupno/">Skupno</a></li>
        % for sredstvo in sredstva:
        <li class="tab col s2"><a href="../{{sredstvo.ime}}/">{{sredstvo.ime_slo()}}</a></li>
        % end
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