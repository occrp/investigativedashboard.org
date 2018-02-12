---
title: Databases
layout: page
permalink: /databases/
---

{% assign africa_by_country = site.data.africa | group_by_exp: 'item', 'item.country' %}
{% assign asia_by_country = site.data.asia | group_by_exp: 'item', 'item.country' %}

<h2 class="lh-title">Global ({{ site.data.global.size }})</h2>

<ul>
{% for entry in site.data.global %}
  <li>
    {{ entry.agency }}
  </li>
{% endfor %}
</ul>

<h2 class="lh-title">Africa ({{ site.data.africa.size }})</h2>

<ul>
{% for country in africa_by_country %}
  <li>
    {{ country.name }}
    {{ country.items.size }}
  </li>
{% endfor %}
</ul>

<h2 class="lh-title">Asia ({{ site.data.asia.size }})</h2>

<ul>
{% for country in asia_by_country %}
  <li>
    {{ country.name }}
    {{ country.items.size }}
  </li>
{% endfor %}
</ul>
