---
layout: page
title: Data library
---


## OCCRP Data Library

* Aleph search box
* Breakdown by country
* Breakdown by category
* Source data releases
* Blog


{% for collection in site.data.collections.results %}
  <h5>
    <a href="{{collection.links.ui}}">{{collection.label}}</a>
    {{collection.count | intcomma}}
  </h5>
  <p>
    {{collection.summary}}
  </p>
{% endfor %}