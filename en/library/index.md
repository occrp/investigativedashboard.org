---
layout: default
title: Library
---

{% for collection in site.data.aleph.results %}
  <p>
    <a href="{{collection.links.ui}}">{{collection.label}}</a>
  </p>
{% endfor %}