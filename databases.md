---
title: Catalogue of Research Databases
permalink: /databases/
---

<div class="copy">
  <p>Below is a collection of the most useful public data sources for investigative reporting compiled by our researchers.</p>
  <p>This page information is publicly available and can be updated. If you find errors, please report them <a href="https://github.com/occrp/investigativedashboard.org/issues">on github</a>.</p>
</div>

{% assign datasets = site.data | sort  %}

<div class="grid grid--regions pt-5">
  {% for dataset in datasets %}

  <div class="grid-unit">
    <a href="{{dataset[0] | replace: '_global', 'global'}}" class="region t-sm">
      <h3>{{ dataset[0] | replace: '_', ' ' | titlecase }}</h3>
      <p>{{ dataset[1].size }} sources</p>
    </a>
  </div>

  {% endfor %}
</div>

