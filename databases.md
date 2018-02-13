---
title: Catalogue of Research Databases
layout: page
permalink: /databases/
---

<script>
  document.addEventListener('DOMContentLoaded', function(event) {
    document.querySelectorAll('.toggler').forEach(function(toggler) {
      toggler.onclick = function(event) {
        var list_elem = document.getElementById(
          this.getAttribute('href').replace('#', '')
        );
        if (list_elem) {
          list_elem.classList.toggle('dn');
        };
        return true;
      };
    });
  });
</script>

<p class="lh-copy measure">
  Below is a collection of the most useful public data sources for investigative
  reporting compiled by our researchers.
</p>

<p class="lh-copy measure">
  This page information is publicly available and can be updated. If you find
  errors, please report them
  <a href="https://github.com/occrp/investigativedashboard.org/issues">on github</a>.
</p>

{% assign datasets = site.data | sort  %}

{% for dataset in datasets %}

  <h2 class="lh-title fw1">
    {{ dataset[0] | upcase | replace: '_', ' '  }}
    &mdash;
    <a href="#{{ dataset[0] }}-list" class="toggler link pointer fade gray">
      &#10607; Show/Hide {{ dataset[1].size }} sources
    </a>
  </h2>

  {% assign by_countries = dataset[1] | group_by_exp: 'item', 'item.country' %}

  {% if dataset[0] contains 'global' %}
  <div id="{{ dataset[0] }}-list" class="cf">
  {% else %}
  <div id="{{ dataset[0] }}-list" class="cf dn">
  {% endif %}

    {% for by_country in by_countries %}
    <div class="w-100 cf">
      <div class="w-30-ns fl-ns">
        {% assign anchor = by_country.name | downcase | replace: ' ', '-' %}
        <h3 class="fw1 mb0 pb1 bb bw2 b--red-id" id="{{ anchor }}">
        {{ by_country.name }}
        {% if by_country.name %}
          <a href="#{{ anchor }}" class="link">&para;</a>
        {% endif %}
        </h3>
        <p class="lh-copy gray mt1">
          There are {{ by_country.items.size }} sources.
        </p>
      </div>
      <div class="w-70-ns fl-ns bl-ns b--near-white">
        <ul class="list pl3-ns pl0">
        {% for source in by_country.items %}
          <li>
            <h4 class="lh-title mb0">
              <a href="{{ source.url }}" class="link red-id">
                {{ source.agency }}
              </a>
            </h4>
            <p class="lh-copy gray mt0 gray f6">
              &#128450; {{ source.type }}
              &nbsp;
              {% if source.paid == 't' %}
                &#128184; Paid
                &nbsp;
              {% endif %}
              {% if source.needs_registration == 't' %}
                &#128274; Needs registration
                &nbsp;
              {% endif %}
              {% if source.governmental == 't' %}
                &#127963; Governmental
              {% endif %}
              <br/>
              {% if source.notes %}
              &#9888; {{ source.notes }}
              {% endif %}
            </p>
          </li>
        {% endfor %}
        </ul>
      </div>
    </div>
    {% endfor %}
  </div>

{% endfor %}
