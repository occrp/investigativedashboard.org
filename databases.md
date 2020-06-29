---
title: Catalogue of Research Databases
layout: page
permalink: /databases/
---
{% assign countries = '' | split: ',' %}
{% assign regions = '' | split: ',' %}
{% assign merged_regions = 'Oceania' | split: ',' %}
{% assign types = '' | split: ',' %}

{% for resource in site.data.databases %}
  {% assign countries = countries | push: resource.Country | uniq | compact | sort_natural %}

  {% assign type = resource['public records'] | downcase | replace: ', ', ',' | split: ',' %}
  {% assign types = types | push: type | flatten | uniq | compact | sort_natural %}
  {% assign country = site.data.countries | where: 'alpha-2', resource.Country | first %}

  {% if country and merged_regions contains country['region'] %}
    {% assign regions = regions | push: country['region'] | uniq | sort_natural %}
  {% elsif country %}
    {% assign regions = regions | push: country['sub-region'] | uniq | sort_natural %}
  {% else %}
    {% assign regions = regions | push: resource.Country | uniq | sort_natural %}
  {% endif %}
{% endfor %}

<p>
  Below is a collection of public data sources compiled by our researchers that
  are the most useful for investigative reporting.
</p>
<p>
  This page information is publicly available and can be updated. If you find
  errors or would like to suggest more sources to add to our ever growing
  library, <a class="mid-gray dim"
  href="{{ site.repository_url }}/issues">please report them</a> or
  <a class="mid-gray dim" href="mailto:{{ site.email }}">email us</a>.
</p>

<div class="mb5 mt4">
  <p class="pb2 lh-copy gray ma0">
    Please select one of the following filters to limit the results.
  </p>

  <select data-filter="region" class="db db-m di-ns">
    <option value=""> - All Regions - </option>
    {% for region in regions %}
      <option value="{{region | slugify}}">{{region}}</option>
    {% endfor %}
  </select>

  <select class="mh0 mh0-m mv2 mv2-m mv0-ns mh3-ns db db-m di-ns w-third-ns" data-filter="country">
    <option value=""> - All Countries - </option>
    {% for code in countries %}
      {% assign country = site.data.countries | where: 'alpha-2', code | first %}
      {% if country %}
        <option value="{{code | slugify}}">{{country.name}}</option>
      {% endif %}
    {% endfor %}
  </select>

  <select class="db db-m di-ns w-third-ns" data-filter="type">
    <option value=""> - All Types - </option>
    {% for type in types %}
      <option value="{{type | slugify}}">{{type | capitalize}}</option>
    {% endfor %}
  </select>
</div>

<script>
  document.addEventListener('input', function (event) {
    var selects = document.querySelectorAll('select');
    var filters = {};

    selects.forEach(function(sel) {
      filters[sel.dataset.filter] = sel.options[sel.selectedIndex].value;
    });

    var regionFilter = filters['region'];
    var countryFilter = filters['country'];
    var typeFilter = filters['type'];

    // Analytics
    if (_paq && !!filters[event.target.dataset.filter]) {
      _paq.push([
        'trackEvent',
        'Databases',
        event.target.dataset.filter.toUpperCase(),
        filters[event.target.dataset.filter]
      ]);
    }

    document.querySelectorAll('.country').forEach(function(el) {
      var matches = true;

      if (!!!regionFilter && !!!countryFilter && !!!typeFilter) {
        el.classList.remove('dn');
        return;
      }

      // Hide all first
      el.classList.add('dn');

      if (!!regionFilter && regionFilter !== el.dataset.region) {
        matches = false;
      }

      if (!!countryFilter && countryFilter !== el.dataset.country) {
        matches = false;
      }

      if (!!typeFilter && el.dataset.type.toString().indexOf(typeFilter) < 0) {
        matches = false;
      }

      if (matches) {
        el.classList.remove('dn');
      }
    });

    // Hide any region which show no countries
    document.querySelectorAll('.region').forEach(function(el) {
      var allCountries = el.querySelectorAll('.country').length;
      var hiddenCountries = el.querySelectorAll('.country.dn').length;

      if (allCountries === hiddenCountries) {
        el.classList.add('dn');
      } else {
        el.classList.remove('dn');
      }
    });
  }, false);
</script>

{% assign by_countries = site.data.databases | group_by_exp: 'item', 'item.Country' %}

{% for by_country in by_countries %}
  {% assign country = site.data.countries | where: 'alpha-2', by_country.name | first %}

  {% if country and merged_regions contains country['region'] %}
    {% assign region = country['region'] | slugify %}
  {% elsif country %}
    {% assign region = country['sub-region'] | slugify %}
  {% else %}
    {% assign region = by_country.name | slugify %}
  {% endif %}

  {% if country %}
    {% assign country = country.name %}
  {% else %}
    {% assign country = region %}
  {% endif %}

  <div class="mb5 region" id="{{ country | slugify }}" data-region="{{ region }}">
    <h2 class="normal ttu bb">
      {% if country %}
        <a class="link mid-gray" href="#{{ country | slugify }}">{{ country}}</a>
      {% else %}
        N/A
      {% endif %}
      <span class="normal tt light-silver">&mdash; {{ by_country.items.size }}</span>
    </h2>

    <div class="flex-ns flex-wrap-ns">
    {% for source in by_country.items %}
      <div class="w-30-ns mr4-ns country"
        data-type="{{source['public records'] | slugify}}"
        data-country="{{by_country.name | slugify}}"
        data-region="{{ region }}"
      >
        <h4 class="ttu bw3 pv4 bg-near-white bl bw2 b--light-gray pl2">
          <a class="link mid-gray dim" href="{{ source.Website }}" target="_blank">
            {{ source.Title }}
          </a>
        </h4>
        <p class="f7">
          <span class="ttu silver code bg-near-white pv1 ph1">{{ source['public records'] }}</span>

          {% if source.Governmental == 'TRUE' %}
            <span class="ml2 pointer code silver bg-near-white pv1 ph1" title="Governmental">🏛&#xFE0E;</span>
          {% endif %}

          {% if source.Paid == 'TRUE' %}
            <span class="ml2 pointer code silver bg-near-white pv1 ph1" title="Paid database">💳&#xFE0E;</span>
          {% endif %}

          {% if source['Registration required'] == 'TRUE' %}
            <span class="ml2 pointer code silver bg-near-white pv1 ph1" title="Registration required">🔐&#xFE0E;</span>
          {% endif %}
        </p>
        {% if source.Description %}
          <p class="lh-copy">
            {{ source.Description }}
          </p>
        {% endif %}
      </div>
    {% endfor %}
    </div>
  </div>
{% endfor %}
