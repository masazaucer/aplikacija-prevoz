% rebase('base.tpl', izbrani_zavihek='analiza')


<div class="row">
    <div class="col s12">
      <ul class="tabs">
        <li class="tab col s2"><a href="../skupno/"/>Skupno</a></li>
        % for sredstvo in sredstva:
        <li class="tab col s2"><a href="../{{sredstvo.ime}}/">{{sredstvo.ime_slo()}}</a></li>
        % end
      </ul>
    </div>
    <div id="skupno" class="col s12"></div>
    <div id="walking" class="col s12"></div>
    <div id="driving" class="col s12"></div>
    <div id="bicycling" class="col s12"></div>
    <div id="train" class="col s12"></div>
    <div id="bus" class="col s12"></div>
</div>

<script>
  document.addEventListener("DOMContentLoaded",function(){
    const variableName = document.querySelector('.tabs');
      M.Tabs.init(variableName,{
        swipeable:true,
        duration:300
      });
</script>


<section class="section">
  {{!base}}
</section>
