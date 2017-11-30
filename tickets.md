---
title: Research Requests
layout: default
permalink: /tickets/
---

> TODO: Setup CORS, assets, etc.

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

<script src="https://investigativedashboard.org/static/frontend/dist/assets/vendor.js"></script>
<script src="https://investigativedashboard.org/static/frontend/dist/assets/id.js"></script>
