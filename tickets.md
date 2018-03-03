---
title: Research Requests
layout: default
permalink: /tickets/
---
<script>
  var ajax = new XMLHttpRequest();
  ajax.open('GET', 'https://investigativedashboard.org/static/frontend/dist/assets/symbols.svg', true);
  ajax.send();
  ajax.onload = function(e) {
    if (this.status === 404) {
      return;
    }
    var div = document.createElement('div');
    div.innerHTML = ajax.responseText;
    document.body.insertBefore(div, document.body.childNodes[0]);
  };
</script>

<article class="page w-100 mid-gray">
  <div class="w-90 center">
    <div id="ember-app"></div>
  </div>
</article>

<link rel="stylesheet" href="/frontend/assets/vendor.css"/>
<link rel="stylesheet" href="/frontend/assets/id.css"/>
<script src="/frontend/assets/vendor.js"></script>
<script src="/frontend/assets/id.js"></script>
<script src="/frontend/assets/id.js"></script>
